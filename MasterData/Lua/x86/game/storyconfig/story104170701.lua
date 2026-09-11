return {
	Play417071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417071001
		arg_1_1.duration_ = 9.53

		local var_1_0 = {
			zh = 9.53300000000001,
			ja = 8.399999999999
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
				arg_1_0:Play417071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11r == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11r")
				var_4_0.name = "I11r"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11r = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11r

				arg_1_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11r" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 5.40000000000102

			if 5.40000000000102 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = "10111"

			if arg_1_1.actors_["10111"] == nil then
				local var_4_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10111")

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

			local var_4_8 = arg_1_1.actors_["10111"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.actorSpriteComps10111 == nil then
				arg_1_1.var_.actorSpriteComps10111 = var_4_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_9 = 0.2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_9 and not isNil(var_4_8) then
				if arg_1_1.var_.actorSpriteComps10111 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10111:ToTable()) do
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

			if arg_1_1.time_ >= 0 + var_4_9 and arg_1_1.time_ < 0 + var_4_9 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.actorSpriteComps10111 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10111 = nil
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_16 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

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

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11r")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501023).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501024).content)

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

			local var_4_22 = 4.20000000000001

			if 4.20000000000001 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
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

			arg_1_1.isInRecall_ = false

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(false)

				for iter_4_8, iter_4_9 in pairs(arg_1_1.actors_) do
					for iter_4_10, iter_4_11 in ipairs((iter_4_9:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_4_11.color = iter_4_11.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_4_31 = 0.100000000000001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_30) / var_4_31)
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 0
			end

			local var_4_32 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_32 + 3 and arg_1_1.time_ < var_4_32 + 3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 5.40000000000001
			local var_4_34 = 0.475

			if 5.40000000000001 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_3")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_36 = arg_1_1:GetWordFromCfg(417071001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 19 <= 0 and var_4_34 or var_4_34 * (utf8.len(var_4_37) / 19)

				if (19 <= 0 and var_4_34 or var_4_34 * (utf8.len(var_4_37) / 19)) > 0 and var_4_34 < var_4_39 then
					arg_1_1.talkMaxDuration = var_4_39
					var_4_33 = var_4_33 + 0.3

					if var_4_39 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_37
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071001", "story_v_out_417071.awb") ~= 0 then
					local var_4_40 = manager.audio:GetVoiceLength("story_v_out_417071", "417071001", "story_v_out_417071.awb") / 1000

					if var_4_40 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_33
					end

					if var_4_36.prefab_name ~= "" and arg_1_1.actors_[var_4_36.prefab_name] ~= nil then
						local var_4_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_36.prefab_name].transform, "story_v_out_417071", "417071001", "story_v_out_417071.awb")

						arg_1_1:RecordAudio("417071001", var_4_41)
						arg_1_1:RecordAudio("417071001", var_4_41)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417071", "417071001", "story_v_out_417071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417071", "417071001", "story_v_out_417071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_33 + 0.3
			local var_4_43 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_33 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
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
	Play417071002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417071002
		arg_10_1.duration_ = 7.93

		local var_10_0 = {
			zh = 5.9,
			ja = 7.933
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
				arg_10_0:Play417071003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0.825

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, true)
				arg_10_1.iconController_:SetSelectedState("hero")

				arg_10_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_3")

				arg_10_1.callingController_:SetSelectedState("normal")

				arg_10_1.keyicon_.color = Color.New(1, 1, 1)
				arg_10_1.icon_.color = Color.New(1, 1, 1)

				local var_13_1 = arg_10_1:GetWordFromCfg(417071002)
				local var_13_2 = arg_10_1:FormatText(var_13_1.content)

				arg_10_1.text_.text = var_13_2

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_4 = 33 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 33)

				if (33 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 33)) > 0 and var_13_0 < var_13_4 then
					arg_10_1.talkMaxDuration = var_13_4

					if var_13_4 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_4 + 0
					end
				end

				arg_10_1.text_.text = var_13_2
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071002", "story_v_out_417071.awb") ~= 0 then
					local var_13_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071002", "story_v_out_417071.awb") / 1000

					if var_13_5 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_5 + 0
					end

					if var_13_1.prefab_name ~= "" and arg_10_1.actors_[var_13_1.prefab_name] ~= nil then
						local var_13_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_1.prefab_name].transform, "story_v_out_417071", "417071002", "story_v_out_417071.awb")

						arg_10_1:RecordAudio("417071002", var_13_6)
						arg_10_1:RecordAudio("417071002", var_13_6)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_417071", "417071002", "story_v_out_417071.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_417071", "417071002", "story_v_out_417071.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_7 = math.max(var_13_0, arg_10_1.talkMaxDuration)

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_7 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - 0) / var_13_7

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= 0 + var_13_7 and arg_10_1.time_ < 0 + var_13_7 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417071003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417071003
		arg_14_1.duration_ = 11.93

		local var_14_0 = {
			zh = 7.966,
			ja = 11.933
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
				arg_14_0:Play417071004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0.975

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_3")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_1 = arg_14_1:GetWordFromCfg(417071003)
				local var_17_2 = arg_14_1:FormatText(var_17_1.content)

				arg_14_1.text_.text = var_17_2

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 39 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 39)

				if (39 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 39)) > 0 and var_17_0 < var_17_4 then
					arg_14_1.talkMaxDuration = var_17_4

					if var_17_4 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_4 + 0
					end
				end

				arg_14_1.text_.text = var_17_2
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071003", "story_v_out_417071.awb") ~= 0 then
					local var_17_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071003", "story_v_out_417071.awb") / 1000

					if var_17_5 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_5 + 0
					end

					if var_17_1.prefab_name ~= "" and arg_14_1.actors_[var_17_1.prefab_name] ~= nil then
						local var_17_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_1.prefab_name].transform, "story_v_out_417071", "417071003", "story_v_out_417071.awb")

						arg_14_1:RecordAudio("417071003", var_17_6)
						arg_14_1:RecordAudio("417071003", var_17_6)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417071", "417071003", "story_v_out_417071.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417071", "417071003", "story_v_out_417071.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_7 and arg_14_1.time_ < 0 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417071004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417071004
		arg_18_1.duration_ = 10.03

		local var_18_0 = {
			zh = 6.966,
			ja = 10.033
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
				arg_18_0:Play417071005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 1

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_3")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_1 = arg_18_1:GetWordFromCfg(417071004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 40 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 40)

				if (40 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 40)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071004", "story_v_out_417071.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071004", "story_v_out_417071.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_417071", "417071004", "story_v_out_417071.awb")

						arg_18_1:RecordAudio("417071004", var_21_6)
						arg_18_1:RecordAudio("417071004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417071", "417071004", "story_v_out_417071.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417071", "417071004", "story_v_out_417071.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_0, arg_18_1.talkMaxDuration)

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - 0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= 0 + var_21_7 and arg_18_1.time_ < 0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417071005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417071005
		arg_22_1.duration_ = 9.67

		local var_22_0 = {
			zh = 9.666,
			ja = 6.4
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
				arg_22_0:Play417071006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 1.2

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_3")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_1 = arg_22_1:GetWordFromCfg(417071005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 48 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 48)

				if (48 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 48)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071005", "story_v_out_417071.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071005", "story_v_out_417071.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_417071", "417071005", "story_v_out_417071.awb")

						arg_22_1:RecordAudio("417071005", var_25_6)
						arg_22_1:RecordAudio("417071005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417071", "417071005", "story_v_out_417071.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417071", "417071005", "story_v_out_417071.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_7 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_7 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_7

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_7 and arg_22_1.time_ < 0 + var_25_7 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play417071006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417071006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417071007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["10111"]) and arg_26_1.var_.actorSpriteComps10111 == nil then
				arg_26_1.var_.actorSpriteComps10111 = arg_26_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_0 = 0.2

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["10111"]) then
				if arg_26_1.var_.actorSpriteComps10111 then
					for iter_29_0, iter_29_1 in pairs(arg_26_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_29_1 then
							if arg_26_1.isInRecall_ then
								iter_29_1.color = Color.New(Mathf.Lerp(iter_29_1.color.r, arg_26_1.hightColor2.r, (arg_26_1.time_ - 0) / var_29_0), Mathf.Lerp(iter_29_1.color.g, arg_26_1.hightColor2.g, (arg_26_1.time_ - 0) / var_29_0), (Mathf.Lerp(iter_29_1.color.b, arg_26_1.hightColor2.b, (arg_26_1.time_ - 0) / var_29_0)))
							else
								local var_29_1 = Mathf.Lerp(iter_29_1.color.r, 0.5, (arg_26_1.time_ - 0) / var_29_0)

								iter_29_1.color = Color.New(var_29_1, var_29_1, var_29_1)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["10111"]) and arg_26_1.var_.actorSpriteComps10111 then
				for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_29_3 then
						iter_29_3.color = arg_26_1.isInRecall_ and (arg_26_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_26_1.var_.actorSpriteComps10111 = nil
			end

			if 0.2 < arg_26_1.time_ and arg_26_1.time_ <= 0.2 + arg_29_0 then
				arg_26_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_cardoor03", "")
			end

			local var_29_3 = 0
			local var_29_4 = 0.925

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_3 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_5 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(417071006).content)

				arg_26_1.text_.text = var_29_5

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_7 = 37 <= 0 and var_29_4 or var_29_4 * (utf8.len(var_29_5) / 37)

				if (37 <= 0 and var_29_4 or var_29_4 * (utf8.len(var_29_5) / 37)) > 0 and var_29_4 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_3 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_3
					end
				end

				arg_26_1.text_.text = var_29_5
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_8 = math.max(var_29_4, arg_26_1.talkMaxDuration)

			if var_29_3 <= arg_26_1.time_ and arg_26_1.time_ < var_29_3 + var_29_8 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_3) / var_29_8

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_3 + var_29_8 and arg_26_1.time_ < var_29_3 + var_29_8 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417071007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417071007
		arg_30_1.duration_ = 8.87

		local var_30_0 = {
			zh = 7.366,
			ja = 8.866
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
				arg_30_0:Play417071008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["10111"]) and arg_30_1.var_.actorSpriteComps10111 == nil then
				arg_30_1.var_.actorSpriteComps10111 = arg_30_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["10111"]) then
				if arg_30_1.var_.actorSpriteComps10111 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_33_1 then
							if arg_30_1.isInRecall_ then
								iter_33_1.color = Color.New(Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor1.r, (arg_30_1.time_ - 0) / var_33_0), Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor1.g, (arg_30_1.time_ - 0) / var_33_0), (Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor1.b, (arg_30_1.time_ - 0) / var_33_0)))
							else
								local var_33_1 = Mathf.Lerp(iter_33_1.color.r, 1, (arg_30_1.time_ - 0) / var_33_0)

								iter_33_1.color = Color.New(var_33_1, var_33_1, var_33_1)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["10111"]) and arg_30_1.var_.actorSpriteComps10111 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_30_1.var_.actorSpriteComps10111 = nil
			end

			local var_33_2 = arg_30_1.actors_["10111"].transform

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos10111 = var_33_2.localPosition
				var_33_2.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("10111", 3)

				for iter_33_4 = 0, var_33_2.childCount - 1 do
					local var_33_3 = var_33_2:GetChild(iter_33_4)

					if var_33_3.name == "split_3" or not string.find(var_33_3.name, "split") then
						var_33_3.gameObject:SetActive(true)
					else
						var_33_3.gameObject:SetActive(false)
					end
				end
			end

			local var_33_4 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				var_33_2.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10111, Vector3.New(0, -361.1, -274.6), (arg_30_1.time_ - 0) / var_33_4)
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				var_33_2.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_33_5 = 0
			local var_33_6 = 0.85

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_7 = arg_30_1:GetWordFromCfg(417071007)
				local var_33_8 = arg_30_1:FormatText(var_33_7.content)

				arg_30_1.text_.text = var_33_8

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_10 = 34 <= 0 and var_33_6 or var_33_6 * (utf8.len(var_33_8) / 34)

				if (34 <= 0 and var_33_6 or var_33_6 * (utf8.len(var_33_8) / 34)) > 0 and var_33_6 < var_33_10 then
					arg_30_1.talkMaxDuration = var_33_10

					if var_33_10 + var_33_5 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_5
					end
				end

				arg_30_1.text_.text = var_33_8
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071007", "story_v_out_417071.awb") ~= 0 then
					local var_33_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071007", "story_v_out_417071.awb") / 1000

					if var_33_11 + var_33_5 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_11 + var_33_5
					end

					if var_33_7.prefab_name ~= "" and arg_30_1.actors_[var_33_7.prefab_name] ~= nil then
						local var_33_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_7.prefab_name].transform, "story_v_out_417071", "417071007", "story_v_out_417071.awb")

						arg_30_1:RecordAudio("417071007", var_33_12)
						arg_30_1:RecordAudio("417071007", var_33_12)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417071", "417071007", "story_v_out_417071.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417071", "417071007", "story_v_out_417071.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_13 = math.max(var_33_6, arg_30_1.talkMaxDuration)

			if var_33_5 <= arg_30_1.time_ and arg_30_1.time_ < var_33_5 + var_33_13 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_5) / var_33_13

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_5 + var_33_13 and arg_30_1.time_ < var_33_5 + var_33_13 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play417071008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417071008
		arg_34_1.duration_ = 4.5

		local var_34_0 = {
			zh = 3.633,
			ja = 4.5
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
				arg_34_0:Play417071009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.475

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_1 = arg_34_1:GetWordFromCfg(417071008)
				local var_37_2 = arg_34_1:FormatText(var_37_1.content)

				arg_34_1.text_.text = var_37_2

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_4 = 19 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 19)

				if (19 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 19)) > 0 and var_37_0 < var_37_4 then
					arg_34_1.talkMaxDuration = var_37_4

					if var_37_4 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_4 + 0
					end
				end

				arg_34_1.text_.text = var_37_2
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071008", "story_v_out_417071.awb") ~= 0 then
					local var_37_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071008", "story_v_out_417071.awb") / 1000

					if var_37_5 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_5 + 0
					end

					if var_37_1.prefab_name ~= "" and arg_34_1.actors_[var_37_1.prefab_name] ~= nil then
						local var_37_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_1.prefab_name].transform, "story_v_out_417071", "417071008", "story_v_out_417071.awb")

						arg_34_1:RecordAudio("417071008", var_37_6)
						arg_34_1:RecordAudio("417071008", var_37_6)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417071", "417071008", "story_v_out_417071.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417071", "417071008", "story_v_out_417071.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_7 and arg_34_1.time_ < 0 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417071009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417071009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play417071010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["10111"]) and arg_38_1.var_.actorSpriteComps10111 == nil then
				arg_38_1.var_.actorSpriteComps10111 = arg_38_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["10111"]) then
				if arg_38_1.var_.actorSpriteComps10111 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								iter_41_1.color = Color.New(Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor2.r, (arg_38_1.time_ - 0) / var_41_0), Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor2.g, (arg_38_1.time_ - 0) / var_41_0), (Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor2.b, (arg_38_1.time_ - 0) / var_41_0)))
							else
								local var_41_1 = Mathf.Lerp(iter_41_1.color.r, 0.5, (arg_38_1.time_ - 0) / var_41_0)

								iter_41_1.color = Color.New(var_41_1, var_41_1, var_41_1)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["10111"]) and arg_38_1.var_.actorSpriteComps10111 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_41_3 then
						iter_41_3.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_38_1.var_.actorSpriteComps10111 = nil
			end

			local var_41_2 = arg_38_1.actors_["10111"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos10111 = var_41_2.localPosition
				var_41_2.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("10111", 7)

				for iter_41_4 = 0, var_41_2.childCount - 1 do
					local var_41_3 = var_41_2:GetChild(iter_41_4)

					if var_41_3.name == "" or not string.find(var_41_3.name, "split") then
						var_41_3.gameObject:SetActive(true)
					else
						var_41_3.gameObject:SetActive(false)
					end
				end
			end

			local var_41_4 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 then
				var_41_2.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10111, Vector3.New(0, -2000, 0), (arg_38_1.time_ - 0) / var_41_4)
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 then
				var_41_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_41_5 = 0
			local var_41_6 = 0.975

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_7 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(417071009).content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 39 <= 0 and var_41_6 or var_41_6 * (utf8.len(var_41_7) / 39)

				if (39 <= 0 and var_41_6 or var_41_6 * (utf8.len(var_41_7) / 39)) > 0 and var_41_6 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_5 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_5
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_6, arg_38_1.talkMaxDuration)

			if var_41_5 <= arg_38_1.time_ and arg_38_1.time_ < var_41_5 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_5) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_5 + var_41_10 and arg_38_1.time_ < var_41_5 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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
	Play417071010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417071010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play417071011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.55

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_1 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(417071010).content)

				arg_42_1.text_.text = var_45_1

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_3 = 22 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 22)

				if (22 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 22)) > 0 and var_45_0 < var_45_3 then
					arg_42_1.talkMaxDuration = var_45_3

					if var_45_3 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_3 + 0
					end
				end

				arg_42_1.text_.text = var_45_1
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_4 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_4

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play417071011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417071011
		arg_46_1.duration_ = 11.7

		local var_46_0 = {
			zh = 5.3,
			ja = 11.7
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
				arg_46_0:Play417071012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["10111"]) and arg_46_1.var_.actorSpriteComps10111 == nil then
				arg_46_1.var_.actorSpriteComps10111 = arg_46_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["10111"]) then
				if arg_46_1.var_.actorSpriteComps10111 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								iter_49_1.color = Color.New(Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor1.r, (arg_46_1.time_ - 0) / var_49_0), Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor1.g, (arg_46_1.time_ - 0) / var_49_0), (Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor1.b, (arg_46_1.time_ - 0) / var_49_0)))
							else
								local var_49_1 = Mathf.Lerp(iter_49_1.color.r, 1, (arg_46_1.time_ - 0) / var_49_0)

								iter_49_1.color = Color.New(var_49_1, var_49_1, var_49_1)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["10111"]) and arg_46_1.var_.actorSpriteComps10111 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_49_3 then
						iter_49_3.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_46_1.var_.actorSpriteComps10111 = nil
			end

			local var_49_2 = arg_46_1.actors_["10111"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos10111 = var_49_2.localPosition
				var_49_2.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("10111", 3)

				for iter_49_4 = 0, var_49_2.childCount - 1 do
					local var_49_3 = var_49_2:GetChild(iter_49_4)

					if var_49_3.name == "split_6" or not string.find(var_49_3.name, "split") then
						var_49_3.gameObject:SetActive(true)
					else
						var_49_3.gameObject:SetActive(false)
					end
				end
			end

			local var_49_4 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				var_49_2.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos10111, Vector3.New(0, -361.1, -274.6), (arg_46_1.time_ - 0) / var_49_4)
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				var_49_2.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_49_5 = 0
			local var_49_6 = 0.625

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_7 = arg_46_1:GetWordFromCfg(417071011)
				local var_49_8 = arg_46_1:FormatText(var_49_7.content)

				arg_46_1.text_.text = var_49_8

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_10 = 25 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_8) / 25)

				if (25 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_8) / 25)) > 0 and var_49_6 < var_49_10 then
					arg_46_1.talkMaxDuration = var_49_10

					if var_49_10 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_10 + var_49_5
					end
				end

				arg_46_1.text_.text = var_49_8
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071011", "story_v_out_417071.awb") ~= 0 then
					local var_49_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071011", "story_v_out_417071.awb") / 1000

					if var_49_11 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_11 + var_49_5
					end

					if var_49_7.prefab_name ~= "" and arg_46_1.actors_[var_49_7.prefab_name] ~= nil then
						local var_49_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_7.prefab_name].transform, "story_v_out_417071", "417071011", "story_v_out_417071.awb")

						arg_46_1:RecordAudio("417071011", var_49_12)
						arg_46_1:RecordAudio("417071011", var_49_12)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417071", "417071011", "story_v_out_417071.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417071", "417071011", "story_v_out_417071.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_13 = math.max(var_49_6, arg_46_1.talkMaxDuration)

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_13 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_5) / var_49_13

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_5 + var_49_13 and arg_46_1.time_ < var_49_5 + var_49_13 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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
	Play417071012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417071012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play417071013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["10111"]) and arg_50_1.var_.actorSpriteComps10111 == nil then
				arg_50_1.var_.actorSpriteComps10111 = arg_50_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["10111"]) then
				if arg_50_1.var_.actorSpriteComps10111 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_53_1 then
							if arg_50_1.isInRecall_ then
								iter_53_1.color = Color.New(Mathf.Lerp(iter_53_1.color.r, arg_50_1.hightColor2.r, (arg_50_1.time_ - 0) / var_53_0), Mathf.Lerp(iter_53_1.color.g, arg_50_1.hightColor2.g, (arg_50_1.time_ - 0) / var_53_0), (Mathf.Lerp(iter_53_1.color.b, arg_50_1.hightColor2.b, (arg_50_1.time_ - 0) / var_53_0)))
							else
								local var_53_1 = Mathf.Lerp(iter_53_1.color.r, 0.5, (arg_50_1.time_ - 0) / var_53_0)

								iter_53_1.color = Color.New(var_53_1, var_53_1, var_53_1)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["10111"]) and arg_50_1.var_.actorSpriteComps10111 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_53_3 then
						iter_53_3.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_50_1.var_.actorSpriteComps10111 = nil
			end

			local var_53_2 = 0
			local var_53_3 = 1.4

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_2 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_4 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(417071012).content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_6 = 56 <= 0 and var_53_3 or var_53_3 * (utf8.len(var_53_4) / 56)

				if (56 <= 0 and var_53_3 or var_53_3 * (utf8.len(var_53_4) / 56)) > 0 and var_53_3 < var_53_6 then
					arg_50_1.talkMaxDuration = var_53_6

					if var_53_6 + var_53_2 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_6 + var_53_2
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_3, arg_50_1.talkMaxDuration)

			if var_53_2 <= arg_50_1.time_ and arg_50_1.time_ < var_53_2 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_2) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_2 + var_53_7 and arg_50_1.time_ < var_53_2 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play417071013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417071013
		arg_54_1.duration_ = 3.13

		local var_54_0 = {
			zh = 1.3,
			ja = 3.133
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
				arg_54_0:Play417071014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["10111"]) and arg_54_1.var_.actorSpriteComps10111 == nil then
				arg_54_1.var_.actorSpriteComps10111 = arg_54_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_0 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["10111"]) then
				if arg_54_1.var_.actorSpriteComps10111 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_57_1 then
							if arg_54_1.isInRecall_ then
								iter_57_1.color = Color.New(Mathf.Lerp(iter_57_1.color.r, arg_54_1.hightColor1.r, (arg_54_1.time_ - 0) / var_57_0), Mathf.Lerp(iter_57_1.color.g, arg_54_1.hightColor1.g, (arg_54_1.time_ - 0) / var_57_0), (Mathf.Lerp(iter_57_1.color.b, arg_54_1.hightColor1.b, (arg_54_1.time_ - 0) / var_57_0)))
							else
								local var_57_1 = Mathf.Lerp(iter_57_1.color.r, 1, (arg_54_1.time_ - 0) / var_57_0)

								iter_57_1.color = Color.New(var_57_1, var_57_1, var_57_1)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["10111"]) and arg_54_1.var_.actorSpriteComps10111 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_57_3 then
						iter_57_3.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_54_1.var_.actorSpriteComps10111 = nil
			end

			local var_57_2 = 0
			local var_57_3 = 0.125

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_4 = arg_54_1:GetWordFromCfg(417071013)
				local var_57_5 = arg_54_1:FormatText(var_57_4.content)

				arg_54_1.text_.text = var_57_5

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_7 = 5 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 5)

				if (5 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 5)) > 0 and var_57_3 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_2
					end
				end

				arg_54_1.text_.text = var_57_5
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071013", "story_v_out_417071.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071013", "story_v_out_417071.awb") / 1000

					if var_57_8 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_2
					end

					if var_57_4.prefab_name ~= "" and arg_54_1.actors_[var_57_4.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_4.prefab_name].transform, "story_v_out_417071", "417071013", "story_v_out_417071.awb")

						arg_54_1:RecordAudio("417071013", var_57_9)
						arg_54_1:RecordAudio("417071013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417071", "417071013", "story_v_out_417071.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417071", "417071013", "story_v_out_417071.awb")
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
	Play417071014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417071014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play417071015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["10111"]) and arg_58_1.var_.actorSpriteComps10111 == nil then
				arg_58_1.var_.actorSpriteComps10111 = arg_58_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["10111"]) then
				if arg_58_1.var_.actorSpriteComps10111 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								iter_61_1.color = Color.New(Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor2.r, (arg_58_1.time_ - 0) / var_61_0), Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor2.g, (arg_58_1.time_ - 0) / var_61_0), (Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor2.b, (arg_58_1.time_ - 0) / var_61_0)))
							else
								local var_61_1 = Mathf.Lerp(iter_61_1.color.r, 0.5, (arg_58_1.time_ - 0) / var_61_0)

								iter_61_1.color = Color.New(var_61_1, var_61_1, var_61_1)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["10111"]) and arg_58_1.var_.actorSpriteComps10111 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps10111 = nil
			end

			local var_61_2 = arg_58_1.actors_["10111"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10111 = var_61_2.localPosition
				var_61_2.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("10111", 7)

				for iter_61_4 = 0, var_61_2.childCount - 1 do
					local var_61_3 = var_61_2:GetChild(iter_61_4)

					if var_61_3.name == "" or not string.find(var_61_3.name, "split") then
						var_61_3.gameObject:SetActive(true)
					else
						var_61_3.gameObject:SetActive(false)
					end
				end
			end

			local var_61_4 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 then
				var_61_2.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10111, Vector3.New(0, -2000, 0), (arg_58_1.time_ - 0) / var_61_4)
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 then
				var_61_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.05 < arg_58_1.time_ and arg_58_1.time_ <= 0.05 + arg_61_0 then
				arg_58_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_horn", "")
			end

			if 1.05 < arg_58_1.time_ and arg_58_1.time_ <= 1.05 + arg_61_0 then
				arg_58_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_rocket", "")
			end

			local var_61_7 = 0
			local var_61_8 = 1.7

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_7 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_9 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(417071014).content)

				arg_58_1.text_.text = var_61_9

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 68 <= 0 and var_61_8 or var_61_8 * (utf8.len(var_61_9) / 68)

				if (68 <= 0 and var_61_8 or var_61_8 * (utf8.len(var_61_9) / 68)) > 0 and var_61_8 < var_61_11 then
					arg_58_1.talkMaxDuration = var_61_11

					if var_61_11 + var_61_7 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_11 + var_61_7
					end
				end

				arg_58_1.text_.text = var_61_9
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_12 = math.max(var_61_8, arg_58_1.talkMaxDuration)

			if var_61_7 <= arg_58_1.time_ and arg_58_1.time_ < var_61_7 + var_61_12 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_7) / var_61_12

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_7 + var_61_12 and arg_58_1.time_ < var_61_7 + var_61_12 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play417071015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417071015
		arg_62_1.duration_ = 4.7

		local var_62_0 = {
			zh = 1.966,
			ja = 4.7
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
				arg_62_0:Play417071016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.2

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_3")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_1 = arg_62_1:GetWordFromCfg(417071015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 8 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 8)

				if (8 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 8)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071015", "story_v_out_417071.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071015", "story_v_out_417071.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_417071", "417071015", "story_v_out_417071.awb")

						arg_62_1:RecordAudio("417071015", var_65_6)
						arg_62_1:RecordAudio("417071015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417071", "417071015", "story_v_out_417071.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417071", "417071015", "story_v_out_417071.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play417071016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417071016
		arg_66_1.duration_ = 6

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play417071017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["10111"]) and arg_66_1.var_.actorSpriteComps10111 == nil then
				arg_66_1.var_.actorSpriteComps10111 = arg_66_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["10111"]) then
				if arg_66_1.var_.actorSpriteComps10111 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps10111:ToTable()) do
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

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["10111"]) and arg_66_1.var_.actorSpriteComps10111 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_69_3 then
						iter_69_3.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_66_1.var_.actorSpriteComps10111 = nil
			end

			local var_69_2 = 0.166666666666667

			if 0.166666666666667 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_3 = 0.266666666666667

			if var_69_2 <= arg_66_1.time_ and arg_66_1.time_ < var_69_2 + var_69_3 then
				local var_69_4 = Color.New(1, 1, 1)

				var_69_4.a = Mathf.Lerp(1, 0, (arg_66_1.time_ - var_69_2) / var_69_3)
				arg_66_1.mask_.color = var_69_4
			end

			if arg_66_1.time_ >= var_69_2 + var_69_3 and arg_66_1.time_ < var_69_2 + var_69_3 + arg_69_0 then
				local var_69_5 = Color.New(1, 1, 1)

				arg_66_1.mask_.enabled = false
				var_69_5.a = 0
				arg_66_1.mask_.color = var_69_5
			end

			local var_69_6 = 0.433333333333333

			if 0.433333333333333 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_7 = 0.266666666666667

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_7 then
				local var_69_8 = Color.New(1, 1, 1)

				var_69_8.a = Mathf.Lerp(1, 0, (arg_66_1.time_ - var_69_6) / var_69_7)
				arg_66_1.mask_.color = var_69_8
			end

			if arg_66_1.time_ >= var_69_6 + var_69_7 and arg_66_1.time_ < var_69_6 + var_69_7 + arg_69_0 then
				local var_69_9 = Color.New(1, 1, 1)

				arg_66_1.mask_.enabled = false
				var_69_9.a = 0
				arg_66_1.mask_.color = var_69_9
			end

			local var_69_10 = manager.ui.mainCamera.transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.shakeOldPos = var_69_10.localPosition
			end

			local var_69_11 = 0.999999999999

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_11 then
				local var_69_12, var_69_13 = math.modf((arg_66_1.time_ - 0) / 0.066)

				var_69_10.localPosition = Vector3.New(var_69_13 * 0.13, var_69_13 * 0.13, var_69_13 * 0.13) + arg_66_1.var_.shakeOldPos
			end

			if arg_66_1.time_ >= 0 + var_69_11 and arg_66_1.time_ < 0 + var_69_11 + arg_69_0 then
				var_69_10.localPosition = arg_66_1.var_.shakeOldPos
			end

			if 0.166666666666667 < arg_66_1.time_ and arg_66_1.time_ <= 0.166666666666667 + arg_69_0 then
				arg_66_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_explosion", "")
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_15 = 0.999999999999
			local var_69_16 = 1.8

			if 0.999999999999 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_17 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_17:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_18 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(417071016).content)

				arg_66_1.text_.text = var_69_18

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_20 = 72 <= 0 and var_69_16 or var_69_16 * (utf8.len(var_69_18) / 72)

				if (72 <= 0 and var_69_16 or var_69_16 * (utf8.len(var_69_18) / 72)) > 0 and var_69_16 < var_69_20 then
					arg_66_1.talkMaxDuration = var_69_20
					var_69_15 = var_69_15 + 0.3

					if var_69_20 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_20 + var_69_15
					end
				end

				arg_66_1.text_.text = var_69_18
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_21 = var_69_15 + 0.3
			local var_69_22 = math.max(var_69_16, arg_66_1.talkMaxDuration)

			if var_69_15 + 0.3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_21 + var_69_22 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_21) / var_69_22

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_21 + var_69_22 and arg_66_1.time_ < var_69_21 + var_69_22 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play417071017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 417071017
		arg_72_1.duration_ = 7.87

		local var_72_0 = {
			zh = 7.29933333333333,
			ja = 7.86633333333333
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play417071018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 3.4 < arg_72_1.time_ and arg_72_1.time_ <= 3.4 + arg_75_0 then
				local var_75_0 = arg_72_1.bgs_.I11r

				arg_72_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_75_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_1 = var_75_0:GetComponent("SpriteRenderer")

				if var_75_1 and var_75_1.sprite then
					local var_75_2 = 2 * (var_75_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_75_0.transform.localScale = Vector3.New(var_75_2 / var_75_1.sprite.bounds.size.y < var_75_2 * manager.ui.mainCameraCom_.aspect / var_75_1.sprite.bounds.size.x and var_75_2 * manager.ui.mainCameraCom_.aspect / var_75_1.sprite.bounds.size.x or var_75_2 / var_75_1.sprite.bounds.size.y, var_75_2 / var_75_1.sprite.bounds.size.y < var_75_2 * manager.ui.mainCameraCom_.aspect / var_75_1.sprite.bounds.size.x and var_75_2 * manager.ui.mainCameraCom_.aspect / var_75_1.sprite.bounds.size.x or var_75_2 / var_75_1.sprite.bounds.size.y, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "I11r" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_3 = 0

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_3 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			if arg_72_1.time_ >= var_75_3 + 0.3 and arg_72_1.time_ < var_75_3 + 0.3 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			local var_75_4 = 0

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_5 = 3.4

			if var_75_4 <= arg_72_1.time_ and arg_72_1.time_ < var_75_4 + var_75_5 then
				local var_75_6 = Color.New(0, 0, 0)

				var_75_6.a = Mathf.Lerp(0, 1, (arg_72_1.time_ - var_75_4) / var_75_5)
				arg_72_1.mask_.color = var_75_6
			end

			if arg_72_1.time_ >= var_75_4 + var_75_5 and arg_72_1.time_ < var_75_4 + var_75_5 + arg_75_0 then
				local var_75_7 = Color.New(0, 0, 0)

				var_75_7.a = 1
				arg_72_1.mask_.color = var_75_7
			end

			local var_75_8 = 3.4

			if 3.4 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_9 = 2.53333333333333

			if var_75_8 <= arg_72_1.time_ and arg_72_1.time_ < var_75_8 + var_75_9 then
				local var_75_10 = Color.New(0, 0, 0)

				var_75_10.a = Mathf.Lerp(1, 0, (arg_72_1.time_ - var_75_8) / var_75_9)
				arg_72_1.mask_.color = var_75_10
			end

			if arg_72_1.time_ >= var_75_8 + var_75_9 and arg_72_1.time_ < var_75_8 + var_75_9 + arg_75_0 then
				local var_75_11 = Color.New(0, 0, 0)

				arg_72_1.mask_.enabled = false
				var_75_11.a = 0
				arg_72_1.mask_.color = var_75_11
			end

			local var_75_12 = "10128"

			if arg_72_1.actors_["10128"] == nil then
				local var_75_13 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_75_13) then
					local var_75_14 = Object.Instantiate(var_75_13, arg_72_1.canvasGo_.transform)

					var_75_14.transform:SetSiblingIndex(1)

					var_75_14.name = var_75_12
					var_75_14.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_72_1.actors_[var_75_12] = var_75_14

					if arg_72_1.isInRecall_ then
						for iter_75_2, iter_75_3 in ipairs((var_75_14:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_75_3.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_75_15 = arg_72_1.actors_["10128"]

			if 5.63333333333333 < arg_72_1.time_ and arg_72_1.time_ <= 5.63333333333333 + arg_75_0 and not isNil(var_75_15) and arg_72_1.var_.actorSpriteComps10128 == nil then
				arg_72_1.var_.actorSpriteComps10128 = var_75_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_16 = 0.2

			if 5.63333333333333 <= arg_72_1.time_ and arg_72_1.time_ < 5.63333333333333 + var_75_16 and not isNil(var_75_15) then
				if arg_72_1.var_.actorSpriteComps10128 then
					for iter_75_4, iter_75_5 in pairs(arg_72_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_75_5 then
							if arg_72_1.isInRecall_ then
								iter_75_5.color = Color.New(Mathf.Lerp(iter_75_5.color.r, arg_72_1.hightColor1.r, (arg_72_1.time_ - 5.63333333333333) / var_75_16), Mathf.Lerp(iter_75_5.color.g, arg_72_1.hightColor1.g, (arg_72_1.time_ - 5.63333333333333) / var_75_16), (Mathf.Lerp(iter_75_5.color.b, arg_72_1.hightColor1.b, (arg_72_1.time_ - 5.63333333333333) / var_75_16)))
							else
								local var_75_17 = Mathf.Lerp(iter_75_5.color.r, 1, (arg_72_1.time_ - 5.63333333333333) / var_75_16)

								iter_75_5.color = Color.New(var_75_17, var_75_17, var_75_17)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 5.63333333333333 + var_75_16 and arg_72_1.time_ < 5.63333333333333 + var_75_16 + arg_75_0 and not isNil(var_75_15) and arg_72_1.var_.actorSpriteComps10128 then
				for iter_75_6, iter_75_7 in pairs(arg_72_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_75_7 then
						iter_75_7.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_72_1.var_.actorSpriteComps10128 = nil
			end

			local var_75_18 = arg_72_1.actors_["10128"].transform

			if 5.63333333333333 < arg_72_1.time_ and arg_72_1.time_ <= 5.63333333333333 + arg_75_0 then
				arg_72_1.var_.moveOldPos10128 = var_75_18.localPosition
				var_75_18.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10128", 3)

				for iter_75_8 = 0, var_75_18.childCount - 1 do
					local var_75_19 = var_75_18:GetChild(iter_75_8)

					if var_75_19.name == "split_3" or not string.find(var_75_19.name, "split") then
						var_75_19.gameObject:SetActive(true)
					else
						var_75_19.gameObject:SetActive(false)
					end
				end
			end

			local var_75_20 = 0.001

			if 5.63333333333333 <= arg_72_1.time_ and arg_72_1.time_ < 5.63333333333333 + var_75_20 then
				var_75_18.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_72_1.time_ - 5.63333333333333) / var_75_20)
			end

			if arg_72_1.time_ >= 5.63333333333333 + var_75_20 and arg_72_1.time_ < 5.63333333333333 + var_75_20 + arg_75_0 then
				var_75_18.localPosition = Vector3.New(0, -347, -300)
			end

			if 5.63333333333333 < arg_72_1.time_ and arg_72_1.time_ <= 5.63333333333333 + arg_75_0 then
				local var_75_21 = arg_72_1.actors_["10128"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_75_21 then
					arg_72_1.var_.alphaOldValue10128 = var_75_21.alpha
					arg_72_1.var_.characterEffect10128 = var_75_21
				end

				arg_72_1.var_.alphaOldValue10128 = 0
			end

			local var_75_22 = 0.2

			if 5.63333333333333 <= arg_72_1.time_ and arg_72_1.time_ < 5.63333333333333 + var_75_22 then
				if arg_72_1.var_.characterEffect10128 then
					arg_72_1.var_.characterEffect10128.alpha = Mathf.Lerp(arg_72_1.var_.alphaOldValue10128, 1, (arg_72_1.time_ - 5.63333333333333) / var_75_22)
				end
			end

			if arg_72_1.time_ >= 5.63333333333333 + var_75_22 and arg_72_1.time_ < 5.63333333333333 + var_75_22 + arg_75_0 and arg_72_1.var_.characterEffect10128 then
				arg_72_1.var_.characterEffect10128.alpha = 1
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_23 = 5.93333333333333
			local var_75_24 = 0.125

			if 5.93333333333333 < arg_72_1.time_ and arg_72_1.time_ <= var_75_23 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_25 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_25:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_26 = arg_72_1:GetWordFromCfg(417071017)
				local var_75_27 = arg_72_1:FormatText(var_75_26.content)

				arg_72_1.text_.text = var_75_27

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_29 = 5 <= 0 and var_75_24 or var_75_24 * (utf8.len(var_75_27) / 5)

				if (5 <= 0 and var_75_24 or var_75_24 * (utf8.len(var_75_27) / 5)) > 0 and var_75_24 < var_75_29 then
					arg_72_1.talkMaxDuration = var_75_29
					var_75_23 = var_75_23 + 0.3

					if var_75_29 + var_75_23 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_29 + var_75_23
					end
				end

				arg_72_1.text_.text = var_75_27
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071017", "story_v_out_417071.awb") ~= 0 then
					local var_75_30 = manager.audio:GetVoiceLength("story_v_out_417071", "417071017", "story_v_out_417071.awb") / 1000

					if var_75_30 + var_75_23 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_30 + var_75_23
					end

					if var_75_26.prefab_name ~= "" and arg_72_1.actors_[var_75_26.prefab_name] ~= nil then
						local var_75_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_26.prefab_name].transform, "story_v_out_417071", "417071017", "story_v_out_417071.awb")

						arg_72_1:RecordAudio("417071017", var_75_31)
						arg_72_1:RecordAudio("417071017", var_75_31)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_417071", "417071017", "story_v_out_417071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_417071", "417071017", "story_v_out_417071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_32 = var_75_23 + 0.3
			local var_75_33 = math.max(var_75_24, arg_72_1.talkMaxDuration)

			if var_75_23 + 0.3 <= arg_72_1.time_ and arg_72_1.time_ < var_75_32 + var_75_33 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_32) / var_75_33

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_32 + var_75_33 and arg_72_1.time_ < var_75_32 + var_75_33 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play417071018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417071018
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play417071019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["10128"]) and arg_78_1.var_.actorSpriteComps10128 == nil then
				arg_78_1.var_.actorSpriteComps10128 = arg_78_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_0 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["10128"]) then
				if arg_78_1.var_.actorSpriteComps10128 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["10128"]) and arg_78_1.var_.actorSpriteComps10128 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_81_3 then
						iter_81_3.color = arg_78_1.isInRecall_ and (arg_78_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_78_1.var_.actorSpriteComps10128 = nil
			end

			local var_81_2 = arg_78_1.actors_["10128"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos10128 = var_81_2.localPosition
				var_81_2.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("10128", 7)

				for iter_81_4 = 0, var_81_2.childCount - 1 do
					local var_81_3 = var_81_2:GetChild(iter_81_4)

					if var_81_3.name == "split_3" or not string.find(var_81_3.name, "split") then
						var_81_3.gameObject:SetActive(true)
					else
						var_81_3.gameObject:SetActive(false)
					end
				end
			end

			local var_81_4 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				var_81_2.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_78_1.time_ - 0) / var_81_4)
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				var_81_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_81_5 = 0
			local var_81_6 = 1.05

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_7 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(417071018).content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 42 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_7) / 42)

				if (42 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_7) / 42)) > 0 and var_81_6 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_5
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_6, arg_78_1.talkMaxDuration)

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_5) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_5 + var_81_10 and arg_78_1.time_ < var_81_5 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
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

		arg_78_1:InitPlayNodeList()
	end,
	Play417071019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417071019
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play417071020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 1.4

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

				local var_85_1 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(417071019).content)

				arg_82_1.text_.text = var_85_1

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_3 = 56 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 56)

				if (56 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 56)) > 0 and var_85_0 < var_85_3 then
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
	Play417071020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417071020
		arg_86_1.duration_ = 10.9

		local var_86_0 = {
			zh = 7.466,
			ja = 10.9
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
				arg_86_0:Play417071021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 1.075

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_1 = arg_86_1:GetWordFromCfg(417071020)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 43 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 43)

				if (43 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 43)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071020", "story_v_out_417071.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071020", "story_v_out_417071.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_417071", "417071020", "story_v_out_417071.awb")

						arg_86_1:RecordAudio("417071020", var_89_6)
						arg_86_1:RecordAudio("417071020", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_417071", "417071020", "story_v_out_417071.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_417071", "417071020", "story_v_out_417071.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play417071021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417071021
		arg_90_1.duration_ = 7.9

		local var_90_0 = {
			zh = 5.1,
			ja = 7.9
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
				arg_90_0:Play417071022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.675

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_1 = arg_90_1:GetWordFromCfg(417071021)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 27 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 27)

				if (27 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 27)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071021", "story_v_out_417071.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071021", "story_v_out_417071.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_417071", "417071021", "story_v_out_417071.awb")

						arg_90_1:RecordAudio("417071021", var_93_6)
						arg_90_1:RecordAudio("417071021", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417071", "417071021", "story_v_out_417071.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417071", "417071021", "story_v_out_417071.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play417071022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417071022
		arg_94_1.duration_ = 2.73

		local var_94_0 = {
			zh = 2.733,
			ja = 1.9
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
				arg_94_0:Play417071023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["10128"]) and arg_94_1.var_.actorSpriteComps10128 == nil then
				arg_94_1.var_.actorSpriteComps10128 = arg_94_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["10128"]) then
				if arg_94_1.var_.actorSpriteComps10128 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["10128"]) and arg_94_1.var_.actorSpriteComps10128 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_94_1.var_.actorSpriteComps10128 = nil
			end

			local var_97_2 = arg_94_1.actors_["10128"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos10128 = var_97_2.localPosition
				var_97_2.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("10128", 3)

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
				var_97_2.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_94_1.time_ - 0) / var_97_4)
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				var_97_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_97_5 = 0
			local var_97_6 = 0.325

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_7 = arg_94_1:GetWordFromCfg(417071022)
				local var_97_8 = arg_94_1:FormatText(var_97_7.content)

				arg_94_1.text_.text = var_97_8

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_10 = 13 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_8) / 13)

				if (13 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_8) / 13)) > 0 and var_97_6 < var_97_10 then
					arg_94_1.talkMaxDuration = var_97_10

					if var_97_10 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_5
					end
				end

				arg_94_1.text_.text = var_97_8
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071022", "story_v_out_417071.awb") ~= 0 then
					local var_97_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071022", "story_v_out_417071.awb") / 1000

					if var_97_11 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_11 + var_97_5
					end

					if var_97_7.prefab_name ~= "" and arg_94_1.actors_[var_97_7.prefab_name] ~= nil then
						local var_97_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_7.prefab_name].transform, "story_v_out_417071", "417071022", "story_v_out_417071.awb")

						arg_94_1:RecordAudio("417071022", var_97_12)
						arg_94_1:RecordAudio("417071022", var_97_12)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417071", "417071022", "story_v_out_417071.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417071", "417071022", "story_v_out_417071.awb")
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
				actorName = "10128",
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
	Play417071023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417071023
		arg_98_1.duration_ = 6.77

		local var_98_0 = {
			zh = 6.5,
			ja = 6.766
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
				arg_98_0:Play417071024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["10128"]) and arg_98_1.var_.actorSpriteComps10128 == nil then
				arg_98_1.var_.actorSpriteComps10128 = arg_98_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_0 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["10128"]) then
				if arg_98_1.var_.actorSpriteComps10128 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_101_1 then
							if arg_98_1.isInRecall_ then
								iter_101_1.color = Color.New(Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor2.r, (arg_98_1.time_ - 0) / var_101_0), Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor2.g, (arg_98_1.time_ - 0) / var_101_0), (Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor2.b, (arg_98_1.time_ - 0) / var_101_0)))
							else
								local var_101_1 = Mathf.Lerp(iter_101_1.color.r, 0.5, (arg_98_1.time_ - 0) / var_101_0)

								iter_101_1.color = Color.New(var_101_1, var_101_1, var_101_1)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["10128"]) and arg_98_1.var_.actorSpriteComps10128 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_101_3 then
						iter_101_3.color = arg_98_1.isInRecall_ and (arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_98_1.var_.actorSpriteComps10128 = nil
			end

			local var_101_2 = 0
			local var_101_3 = 0.875

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_4 = arg_98_1:GetWordFromCfg(417071023)
				local var_101_5 = arg_98_1:FormatText(var_101_4.content)

				arg_98_1.text_.text = var_101_5

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_7 = 35 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_5) / 35)

				if (35 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_5) / 35)) > 0 and var_101_3 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_2
					end
				end

				arg_98_1.text_.text = var_101_5
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071023", "story_v_out_417071.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071023", "story_v_out_417071.awb") / 1000

					if var_101_8 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_2
					end

					if var_101_4.prefab_name ~= "" and arg_98_1.actors_[var_101_4.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_4.prefab_name].transform, "story_v_out_417071", "417071023", "story_v_out_417071.awb")

						arg_98_1:RecordAudio("417071023", var_101_9)
						arg_98_1:RecordAudio("417071023", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_417071", "417071023", "story_v_out_417071.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_417071", "417071023", "story_v_out_417071.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_3, arg_98_1.talkMaxDuration)

			if var_101_2 <= arg_98_1.time_ and arg_98_1.time_ < var_101_2 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_2) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_2 + var_101_10 and arg_98_1.time_ < var_101_2 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play417071024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417071024
		arg_102_1.duration_ = 3.13

		local var_102_0 = {
			zh = 1.4,
			ja = 3.133
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
				arg_102_0:Play417071025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10128"]) and arg_102_1.var_.actorSpriteComps10128 == nil then
				arg_102_1.var_.actorSpriteComps10128 = arg_102_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10128"]) then
				if arg_102_1.var_.actorSpriteComps10128 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								iter_105_1.color = Color.New(Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor1.r, (arg_102_1.time_ - 0) / var_105_0), Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor1.g, (arg_102_1.time_ - 0) / var_105_0), (Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor1.b, (arg_102_1.time_ - 0) / var_105_0)))
							else
								local var_105_1 = Mathf.Lerp(iter_105_1.color.r, 1, (arg_102_1.time_ - 0) / var_105_0)

								iter_105_1.color = Color.New(var_105_1, var_105_1, var_105_1)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10128"]) and arg_102_1.var_.actorSpriteComps10128 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_105_3 then
						iter_105_3.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_102_1.var_.actorSpriteComps10128 = nil
			end

			local var_105_2 = arg_102_1.actors_["10128"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos10128 = var_105_2.localPosition
				var_105_2.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("10128", 3)

				for iter_105_4 = 0, var_105_2.childCount - 1 do
					local var_105_3 = var_105_2:GetChild(iter_105_4)

					if var_105_3.name == "" or not string.find(var_105_3.name, "split") then
						var_105_3.gameObject:SetActive(true)
					else
						var_105_3.gameObject:SetActive(false)
					end
				end
			end

			local var_105_4 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 then
				var_105_2.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_102_1.time_ - 0) / var_105_4)
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 then
				var_105_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_105_5 = 0
			local var_105_6 = 0.175

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_7 = arg_102_1:GetWordFromCfg(417071024)
				local var_105_8 = arg_102_1:FormatText(var_105_7.content)

				arg_102_1.text_.text = var_105_8

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_10 = 7 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_8) / 7)

				if (7 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_8) / 7)) > 0 and var_105_6 < var_105_10 then
					arg_102_1.talkMaxDuration = var_105_10

					if var_105_10 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_5
					end
				end

				arg_102_1.text_.text = var_105_8
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071024", "story_v_out_417071.awb") ~= 0 then
					local var_105_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071024", "story_v_out_417071.awb") / 1000

					if var_105_11 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_11 + var_105_5
					end

					if var_105_7.prefab_name ~= "" and arg_102_1.actors_[var_105_7.prefab_name] ~= nil then
						local var_105_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_7.prefab_name].transform, "story_v_out_417071", "417071024", "story_v_out_417071.awb")

						arg_102_1:RecordAudio("417071024", var_105_12)
						arg_102_1:RecordAudio("417071024", var_105_12)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_417071", "417071024", "story_v_out_417071.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_417071", "417071024", "story_v_out_417071.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_13 = math.max(var_105_6, arg_102_1.talkMaxDuration)

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_13 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_5) / var_105_13

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_5 + var_105_13 and arg_102_1.time_ < var_105_5 + var_105_13 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play417071025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417071025
		arg_106_1.duration_ = 6.13

		local var_106_0 = {
			zh = 3.666,
			ja = 6.133
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
				arg_106_0:Play417071026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["10128"]) and arg_106_1.var_.actorSpriteComps10128 == nil then
				arg_106_1.var_.actorSpriteComps10128 = arg_106_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_0 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["10128"]) then
				if arg_106_1.var_.actorSpriteComps10128 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								iter_109_1.color = Color.New(Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor2.r, (arg_106_1.time_ - 0) / var_109_0), Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor2.g, (arg_106_1.time_ - 0) / var_109_0), (Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor2.b, (arg_106_1.time_ - 0) / var_109_0)))
							else
								local var_109_1 = Mathf.Lerp(iter_109_1.color.r, 0.5, (arg_106_1.time_ - 0) / var_109_0)

								iter_109_1.color = Color.New(var_109_1, var_109_1, var_109_1)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["10128"]) and arg_106_1.var_.actorSpriteComps10128 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_109_3 then
						iter_109_3.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_106_1.var_.actorSpriteComps10128 = nil
			end

			local var_109_2 = 0
			local var_109_3 = 0.525

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_4 = arg_106_1:GetWordFromCfg(417071025)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 21 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 21)

				if (21 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 21)) > 0 and var_109_3 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071025", "story_v_out_417071.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071025", "story_v_out_417071.awb") / 1000

					if var_109_8 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_2
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_out_417071", "417071025", "story_v_out_417071.awb")

						arg_106_1:RecordAudio("417071025", var_109_9)
						arg_106_1:RecordAudio("417071025", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_417071", "417071025", "story_v_out_417071.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_417071", "417071025", "story_v_out_417071.awb")
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
	Play417071026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 417071026
		arg_110_1.duration_ = 7.4

		local var_110_0 = {
			zh = 5.466,
			ja = 7.4
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
				arg_110_0:Play417071027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["10128"]) and arg_110_1.var_.actorSpriteComps10128 == nil then
				arg_110_1.var_.actorSpriteComps10128 = arg_110_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_0 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["10128"]) then
				if arg_110_1.var_.actorSpriteComps10128 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_113_1 then
							if arg_110_1.isInRecall_ then
								iter_113_1.color = Color.New(Mathf.Lerp(iter_113_1.color.r, arg_110_1.hightColor1.r, (arg_110_1.time_ - 0) / var_113_0), Mathf.Lerp(iter_113_1.color.g, arg_110_1.hightColor1.g, (arg_110_1.time_ - 0) / var_113_0), (Mathf.Lerp(iter_113_1.color.b, arg_110_1.hightColor1.b, (arg_110_1.time_ - 0) / var_113_0)))
							else
								local var_113_1 = Mathf.Lerp(iter_113_1.color.r, 1, (arg_110_1.time_ - 0) / var_113_0)

								iter_113_1.color = Color.New(var_113_1, var_113_1, var_113_1)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["10128"]) and arg_110_1.var_.actorSpriteComps10128 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_113_3 then
						iter_113_3.color = arg_110_1.isInRecall_ and (arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_110_1.var_.actorSpriteComps10128 = nil
			end

			local var_113_2 = arg_110_1.actors_["10128"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos10128 = var_113_2.localPosition
				var_113_2.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("10128", 3)

				for iter_113_4 = 0, var_113_2.childCount - 1 do
					local var_113_3 = var_113_2:GetChild(iter_113_4)

					if var_113_3.name == "" or not string.find(var_113_3.name, "split") then
						var_113_3.gameObject:SetActive(true)
					else
						var_113_3.gameObject:SetActive(false)
					end
				end
			end

			local var_113_4 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				var_113_2.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_110_1.time_ - 0) / var_113_4)
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				var_113_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_113_5 = 0
			local var_113_6 = 0.55

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_7 = arg_110_1:GetWordFromCfg(417071026)
				local var_113_8 = arg_110_1:FormatText(var_113_7.content)

				arg_110_1.text_.text = var_113_8

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_10 = 22 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_8) / 22)

				if (22 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_8) / 22)) > 0 and var_113_6 < var_113_10 then
					arg_110_1.talkMaxDuration = var_113_10

					if var_113_10 + var_113_5 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_5
					end
				end

				arg_110_1.text_.text = var_113_8
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071026", "story_v_out_417071.awb") ~= 0 then
					local var_113_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071026", "story_v_out_417071.awb") / 1000

					if var_113_11 + var_113_5 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_11 + var_113_5
					end

					if var_113_7.prefab_name ~= "" and arg_110_1.actors_[var_113_7.prefab_name] ~= nil then
						local var_113_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_7.prefab_name].transform, "story_v_out_417071", "417071026", "story_v_out_417071.awb")

						arg_110_1:RecordAudio("417071026", var_113_12)
						arg_110_1:RecordAudio("417071026", var_113_12)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_417071", "417071026", "story_v_out_417071.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_417071", "417071026", "story_v_out_417071.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_13 = math.max(var_113_6, arg_110_1.talkMaxDuration)

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_13 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_5) / var_113_13

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_5 + var_113_13 and arg_110_1.time_ < var_113_5 + var_113_13 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
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

		arg_110_1:InitPlayNodeList()
	end,
	Play417071027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 417071027
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play417071028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["10128"]) and arg_114_1.var_.actorSpriteComps10128 == nil then
				arg_114_1.var_.actorSpriteComps10128 = arg_114_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_0 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["10128"]) then
				if arg_114_1.var_.actorSpriteComps10128 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_117_1 then
							if arg_114_1.isInRecall_ then
								iter_117_1.color = Color.New(Mathf.Lerp(iter_117_1.color.r, arg_114_1.hightColor2.r, (arg_114_1.time_ - 0) / var_117_0), Mathf.Lerp(iter_117_1.color.g, arg_114_1.hightColor2.g, (arg_114_1.time_ - 0) / var_117_0), (Mathf.Lerp(iter_117_1.color.b, arg_114_1.hightColor2.b, (arg_114_1.time_ - 0) / var_117_0)))
							else
								local var_117_1 = Mathf.Lerp(iter_117_1.color.r, 0.5, (arg_114_1.time_ - 0) / var_117_0)

								iter_117_1.color = Color.New(var_117_1, var_117_1, var_117_1)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["10128"]) and arg_114_1.var_.actorSpriteComps10128 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_117_3 then
						iter_117_3.color = arg_114_1.isInRecall_ and (arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_114_1.var_.actorSpriteComps10128 = nil
			end

			local var_117_2 = arg_114_1.actors_["10128"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos10128 = var_117_2.localPosition
				var_117_2.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("10128", 7)

				for iter_117_4 = 0, var_117_2.childCount - 1 do
					local var_117_3 = var_117_2:GetChild(iter_117_4)

					if var_117_3.name == "" or not string.find(var_117_3.name, "split") then
						var_117_3.gameObject:SetActive(true)
					else
						var_117_3.gameObject:SetActive(false)
					end
				end
			end

			local var_117_4 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				var_117_2.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_114_1.time_ - 0) / var_117_4)
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				var_117_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_117_5 = 0
			local var_117_6 = 1.325

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_7 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(417071027).content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 53 <= 0 and var_117_6 or var_117_6 * (utf8.len(var_117_7) / 53)

				if (53 <= 0 and var_117_6 or var_117_6 * (utf8.len(var_117_7) / 53)) > 0 and var_117_6 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_5 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_5
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_6, arg_114_1.talkMaxDuration)

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_5) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_5 + var_117_10 and arg_114_1.time_ < var_117_5 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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

		arg_114_1:InitPlayNodeList()
	end,
	Play417071028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 417071028
		arg_118_1.duration_ = 2.6

		local var_118_0 = {
			zh = 1.8,
			ja = 2.6
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
				arg_118_0:Play417071029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.175

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_1 = arg_118_1:GetWordFromCfg(417071028)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 7 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 7)

				if (7 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 7)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071028", "story_v_out_417071.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071028", "story_v_out_417071.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_417071", "417071028", "story_v_out_417071.awb")

						arg_118_1:RecordAudio("417071028", var_121_6)
						arg_118_1:RecordAudio("417071028", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_417071", "417071028", "story_v_out_417071.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_417071", "417071028", "story_v_out_417071.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play417071029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 417071029
		arg_122_1.duration_ = 7.3

		local var_122_0 = {
			zh = 7.3,
			ja = 6.366
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
				arg_122_0:Play417071030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["10128"]) and arg_122_1.var_.actorSpriteComps10128 == nil then
				arg_122_1.var_.actorSpriteComps10128 = arg_122_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["10128"]) then
				if arg_122_1.var_.actorSpriteComps10128 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["10128"]) and arg_122_1.var_.actorSpriteComps10128 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_125_3 then
						iter_125_3.color = arg_122_1.isInRecall_ and (arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_122_1.var_.actorSpriteComps10128 = nil
			end

			local var_125_2 = arg_122_1.actors_["10128"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos10128 = var_125_2.localPosition
				var_125_2.localScale = Vector3.New(1, 1, 1)

				arg_122_1:CheckSpriteTmpPos("10128", 3)

				for iter_125_4 = 0, var_125_2.childCount - 1 do
					local var_125_3 = var_125_2:GetChild(iter_125_4)

					if var_125_3.name == "split_6" or not string.find(var_125_3.name, "split") then
						var_125_3.gameObject:SetActive(true)
					else
						var_125_3.gameObject:SetActive(false)
					end
				end
			end

			local var_125_4 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				var_125_2.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_122_1.time_ - 0) / var_125_4)
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				var_125_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_125_5 = 0
			local var_125_6 = 0.75

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_7 = arg_122_1:GetWordFromCfg(417071029)
				local var_125_8 = arg_122_1:FormatText(var_125_7.content)

				arg_122_1.text_.text = var_125_8

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_10 = 30 <= 0 and var_125_6 or var_125_6 * (utf8.len(var_125_8) / 30)

				if (30 <= 0 and var_125_6 or var_125_6 * (utf8.len(var_125_8) / 30)) > 0 and var_125_6 < var_125_10 then
					arg_122_1.talkMaxDuration = var_125_10

					if var_125_10 + var_125_5 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_5
					end
				end

				arg_122_1.text_.text = var_125_8
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071029", "story_v_out_417071.awb") ~= 0 then
					local var_125_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071029", "story_v_out_417071.awb") / 1000

					if var_125_11 + var_125_5 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_11 + var_125_5
					end

					if var_125_7.prefab_name ~= "" and arg_122_1.actors_[var_125_7.prefab_name] ~= nil then
						local var_125_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_7.prefab_name].transform, "story_v_out_417071", "417071029", "story_v_out_417071.awb")

						arg_122_1:RecordAudio("417071029", var_125_12)
						arg_122_1:RecordAudio("417071029", var_125_12)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_417071", "417071029", "story_v_out_417071.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_417071", "417071029", "story_v_out_417071.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_13 = math.max(var_125_6, arg_122_1.talkMaxDuration)

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_13 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_5) / var_125_13

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_5 + var_125_13 and arg_122_1.time_ < var_125_5 + var_125_13 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
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

		arg_122_1:InitPlayNodeList()
	end,
	Play417071030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 417071030
		arg_126_1.duration_ = 5.7

		local var_126_0 = {
			zh = 5.233,
			ja = 5.7
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
				arg_126_0:Play417071031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["10128"]) and arg_126_1.var_.actorSpriteComps10128 == nil then
				arg_126_1.var_.actorSpriteComps10128 = arg_126_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_0 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["10128"]) then
				if arg_126_1.var_.actorSpriteComps10128 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_129_1 then
							if arg_126_1.isInRecall_ then
								iter_129_1.color = Color.New(Mathf.Lerp(iter_129_1.color.r, arg_126_1.hightColor2.r, (arg_126_1.time_ - 0) / var_129_0), Mathf.Lerp(iter_129_1.color.g, arg_126_1.hightColor2.g, (arg_126_1.time_ - 0) / var_129_0), (Mathf.Lerp(iter_129_1.color.b, arg_126_1.hightColor2.b, (arg_126_1.time_ - 0) / var_129_0)))
							else
								local var_129_1 = Mathf.Lerp(iter_129_1.color.r, 0.5, (arg_126_1.time_ - 0) / var_129_0)

								iter_129_1.color = Color.New(var_129_1, var_129_1, var_129_1)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["10128"]) and arg_126_1.var_.actorSpriteComps10128 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_129_3 then
						iter_129_3.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_126_1.var_.actorSpriteComps10128 = nil
			end

			local var_129_2 = 0
			local var_129_3 = 0.625

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_2 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_4 = arg_126_1:GetWordFromCfg(417071030)
				local var_129_5 = arg_126_1:FormatText(var_129_4.content)

				arg_126_1.text_.text = var_129_5

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_7 = 25 <= 0 and var_129_3 or var_129_3 * (utf8.len(var_129_5) / 25)

				if (25 <= 0 and var_129_3 or var_129_3 * (utf8.len(var_129_5) / 25)) > 0 and var_129_3 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_2 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_2
					end
				end

				arg_126_1.text_.text = var_129_5
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071030", "story_v_out_417071.awb") ~= 0 then
					local var_129_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071030", "story_v_out_417071.awb") / 1000

					if var_129_8 + var_129_2 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_8 + var_129_2
					end

					if var_129_4.prefab_name ~= "" and arg_126_1.actors_[var_129_4.prefab_name] ~= nil then
						local var_129_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_4.prefab_name].transform, "story_v_out_417071", "417071030", "story_v_out_417071.awb")

						arg_126_1:RecordAudio("417071030", var_129_9)
						arg_126_1:RecordAudio("417071030", var_129_9)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_417071", "417071030", "story_v_out_417071.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_417071", "417071030", "story_v_out_417071.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = math.max(var_129_3, arg_126_1.talkMaxDuration)

			if var_129_2 <= arg_126_1.time_ and arg_126_1.time_ < var_129_2 + var_129_10 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_2) / var_129_10

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_2 + var_129_10 and arg_126_1.time_ < var_129_2 + var_129_10 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play417071031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 417071031
		arg_130_1.duration_ = 8.3

		local var_130_0 = {
			zh = 4.033,
			ja = 8.3
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
				arg_130_0:Play417071032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["10128"]) and arg_130_1.var_.actorSpriteComps10128 == nil then
				arg_130_1.var_.actorSpriteComps10128 = arg_130_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_0 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["10128"]) then
				if arg_130_1.var_.actorSpriteComps10128 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								iter_133_1.color = Color.New(Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor1.r, (arg_130_1.time_ - 0) / var_133_0), Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor1.g, (arg_130_1.time_ - 0) / var_133_0), (Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor1.b, (arg_130_1.time_ - 0) / var_133_0)))
							else
								local var_133_1 = Mathf.Lerp(iter_133_1.color.r, 1, (arg_130_1.time_ - 0) / var_133_0)

								iter_133_1.color = Color.New(var_133_1, var_133_1, var_133_1)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["10128"]) and arg_130_1.var_.actorSpriteComps10128 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_133_3 then
						iter_133_3.color = arg_130_1.isInRecall_ and (arg_130_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_130_1.var_.actorSpriteComps10128 = nil
			end

			local var_133_2 = arg_130_1.actors_["10128"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos10128 = var_133_2.localPosition
				var_133_2.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("10128", 3)

				for iter_133_4 = 0, var_133_2.childCount - 1 do
					local var_133_3 = var_133_2:GetChild(iter_133_4)

					if var_133_3.name == "split_6" or not string.find(var_133_3.name, "split") then
						var_133_3.gameObject:SetActive(true)
					else
						var_133_3.gameObject:SetActive(false)
					end
				end
			end

			local var_133_4 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				var_133_2.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_130_1.time_ - 0) / var_133_4)
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				var_133_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_133_5 = 0
			local var_133_6 = 0.6

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_7 = arg_130_1:GetWordFromCfg(417071031)
				local var_133_8 = arg_130_1:FormatText(var_133_7.content)

				arg_130_1.text_.text = var_133_8

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_10 = 24 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_8) / 24)

				if (24 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_8) / 24)) > 0 and var_133_6 < var_133_10 then
					arg_130_1.talkMaxDuration = var_133_10

					if var_133_10 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_5
					end
				end

				arg_130_1.text_.text = var_133_8
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071031", "story_v_out_417071.awb") ~= 0 then
					local var_133_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071031", "story_v_out_417071.awb") / 1000

					if var_133_11 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_5
					end

					if var_133_7.prefab_name ~= "" and arg_130_1.actors_[var_133_7.prefab_name] ~= nil then
						local var_133_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_7.prefab_name].transform, "story_v_out_417071", "417071031", "story_v_out_417071.awb")

						arg_130_1:RecordAudio("417071031", var_133_12)
						arg_130_1:RecordAudio("417071031", var_133_12)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_417071", "417071031", "story_v_out_417071.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_417071", "417071031", "story_v_out_417071.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_13 = math.max(var_133_6, arg_130_1.talkMaxDuration)

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_13 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_5) / var_133_13

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_5 + var_133_13 and arg_130_1.time_ < var_133_5 + var_133_13 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play417071032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 417071032
		arg_134_1.duration_ = 10

		local var_134_0 = {
			zh = 6.8,
			ja = 10
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
				arg_134_0:Play417071033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0.85

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_1 = arg_134_1:GetWordFromCfg(417071032)
				local var_137_2 = arg_134_1:FormatText(var_137_1.content)

				arg_134_1.text_.text = var_137_2

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 34 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 34)

				if (34 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 34)) > 0 and var_137_0 < var_137_4 then
					arg_134_1.talkMaxDuration = var_137_4

					if var_137_4 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_4 + 0
					end
				end

				arg_134_1.text_.text = var_137_2
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071032", "story_v_out_417071.awb") ~= 0 then
					local var_137_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071032", "story_v_out_417071.awb") / 1000

					if var_137_5 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + 0
					end

					if var_137_1.prefab_name ~= "" and arg_134_1.actors_[var_137_1.prefab_name] ~= nil then
						local var_137_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_1.prefab_name].transform, "story_v_out_417071", "417071032", "story_v_out_417071.awb")

						arg_134_1:RecordAudio("417071032", var_137_6)
						arg_134_1:RecordAudio("417071032", var_137_6)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_417071", "417071032", "story_v_out_417071.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_417071", "417071032", "story_v_out_417071.awb")
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
	Play417071033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 417071033
		arg_138_1.duration_ = 5.3

		local var_138_0 = {
			zh = 3.133,
			ja = 5.3
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
				arg_138_0:Play417071034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0.5

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_1 = arg_138_1:GetWordFromCfg(417071033)
				local var_141_2 = arg_138_1:FormatText(var_141_1.content)

				arg_138_1.text_.text = var_141_2

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 20 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 20)

				if (20 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 20)) > 0 and var_141_0 < var_141_4 then
					arg_138_1.talkMaxDuration = var_141_4

					if var_141_4 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_4 + 0
					end
				end

				arg_138_1.text_.text = var_141_2
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071033", "story_v_out_417071.awb") ~= 0 then
					local var_141_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071033", "story_v_out_417071.awb") / 1000

					if var_141_5 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + 0
					end

					if var_141_1.prefab_name ~= "" and arg_138_1.actors_[var_141_1.prefab_name] ~= nil then
						local var_141_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_1.prefab_name].transform, "story_v_out_417071", "417071033", "story_v_out_417071.awb")

						arg_138_1:RecordAudio("417071033", var_141_6)
						arg_138_1:RecordAudio("417071033", var_141_6)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_417071", "417071033", "story_v_out_417071.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_417071", "417071033", "story_v_out_417071.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_7 = math.max(var_141_0, arg_138_1.talkMaxDuration)

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_7 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - 0) / var_141_7

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= 0 + var_141_7 and arg_138_1.time_ < 0 + var_141_7 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play417071034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 417071034
		arg_142_1.duration_ = 17.33

		local var_142_0 = {
			zh = 14.6326666666667,
			ja = 17.3326666666667
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
				arg_142_0:Play417071035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if arg_142_1.bgs_.ST73 == nil then
				local var_145_0 = Object.Instantiate(arg_142_1.paintGo_)

				var_145_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST73")
				var_145_0.name = "ST73"
				var_145_0.transform.parent = arg_142_1.stage_.transform
				var_145_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_142_1.bgs_.ST73 = var_145_0
			end

			if 1.999999999999 < arg_142_1.time_ and arg_142_1.time_ <= 1.999999999999 + arg_145_0 then
				local var_145_1 = arg_142_1.bgs_.ST73

				arg_142_1.bgs_.ST73.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_145_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_145_2 = var_145_1:GetComponent("SpriteRenderer")

				if var_145_2 and var_145_2.sprite then
					local var_145_3 = 2 * (var_145_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_145_1.transform.localScale = Vector3.New(var_145_3 / var_145_2.sprite.bounds.size.y < var_145_3 * manager.ui.mainCameraCom_.aspect / var_145_2.sprite.bounds.size.x and var_145_3 * manager.ui.mainCameraCom_.aspect / var_145_2.sprite.bounds.size.x or var_145_3 / var_145_2.sprite.bounds.size.y, var_145_3 / var_145_2.sprite.bounds.size.y < var_145_3 * manager.ui.mainCameraCom_.aspect / var_145_2.sprite.bounds.size.x and var_145_3 * manager.ui.mainCameraCom_.aspect / var_145_2.sprite.bounds.size.x or var_145_3 / var_145_2.sprite.bounds.size.y, 0)
				end

				for iter_145_0, iter_145_1 in pairs(arg_142_1.bgs_) do
					if iter_145_0 ~= "ST73" then
						iter_145_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_145_4 = 7.76666666666668

			if 7.76666666666668 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.allBtn_.enabled = false
			end

			if arg_142_1.time_ >= var_145_4 + 0.3 and arg_142_1.time_ < var_145_4 + 0.3 + arg_145_0 then
				arg_142_1.allBtn_.enabled = true
			end

			local var_145_5 = 0

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1.mask_.enabled = true
				arg_142_1.mask_.raycastTarget = true

				arg_142_1:SetGaussion(false)
			end

			local var_145_6 = 1.999999999999

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_6 then
				local var_145_7 = Color.New(0, 0, 0)

				var_145_7.a = Mathf.Lerp(0, 1, (arg_142_1.time_ - var_145_5) / var_145_6)
				arg_142_1.mask_.color = var_145_7
			end

			if arg_142_1.time_ >= var_145_5 + var_145_6 and arg_142_1.time_ < var_145_5 + var_145_6 + arg_145_0 then
				local var_145_8 = Color.New(0, 0, 0)

				var_145_8.a = 1
				arg_142_1.mask_.color = var_145_8
			end

			local var_145_9 = "1034"

			if arg_142_1.actors_["1034"] == nil then
				local var_145_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_145_10) then
					local var_145_11 = Object.Instantiate(var_145_10, arg_142_1.canvasGo_.transform)

					var_145_11.transform:SetSiblingIndex(1)

					var_145_11.name = var_145_9
					var_145_11.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_142_1.actors_[var_145_9] = var_145_11

					if arg_142_1.isInRecall_ then
						for iter_145_2, iter_145_3 in ipairs((var_145_11:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_145_3.color = arg_142_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_145_12 = arg_142_1.actors_["1034"]

			if 7.40000000000001 < arg_142_1.time_ and arg_142_1.time_ <= 7.40000000000001 + arg_145_0 and not isNil(var_145_12) and arg_142_1.var_.actorSpriteComps1034 == nil then
				arg_142_1.var_.actorSpriteComps1034 = var_145_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_13 = 0.2

			if 7.40000000000001 <= arg_142_1.time_ and arg_142_1.time_ < 7.40000000000001 + var_145_13 and not isNil(var_145_12) then
				if arg_142_1.var_.actorSpriteComps1034 then
					for iter_145_4, iter_145_5 in pairs(arg_142_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_145_5 then
							if arg_142_1.isInRecall_ then
								iter_145_5.color = Color.New(Mathf.Lerp(iter_145_5.color.r, arg_142_1.hightColor1.r, (arg_142_1.time_ - 7.40000000000001) / var_145_13), Mathf.Lerp(iter_145_5.color.g, arg_142_1.hightColor1.g, (arg_142_1.time_ - 7.40000000000001) / var_145_13), (Mathf.Lerp(iter_145_5.color.b, arg_142_1.hightColor1.b, (arg_142_1.time_ - 7.40000000000001) / var_145_13)))
							else
								local var_145_14 = Mathf.Lerp(iter_145_5.color.r, 1, (arg_142_1.time_ - 7.40000000000001) / var_145_13)

								iter_145_5.color = Color.New(var_145_14, var_145_14, var_145_14)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= 7.40000000000001 + var_145_13 and arg_142_1.time_ < 7.40000000000001 + var_145_13 + arg_145_0 and not isNil(var_145_12) and arg_142_1.var_.actorSpriteComps1034 then
				for iter_145_6, iter_145_7 in pairs(arg_142_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_145_7 then
						iter_145_7.color = arg_142_1.isInRecall_ and (arg_142_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_142_1.var_.actorSpriteComps1034 = nil
			end

			local var_145_15 = arg_142_1.actors_["10128"].transform

			if 1.965999999999 < arg_142_1.time_ and arg_142_1.time_ <= 1.965999999999 + arg_145_0 then
				arg_142_1.var_.moveOldPos10128 = var_145_15.localPosition
				var_145_15.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("10128", 7)

				for iter_145_8 = 0, var_145_15.childCount - 1 do
					local var_145_16 = var_145_15:GetChild(iter_145_8)

					if var_145_16.name == "" or not string.find(var_145_16.name, "split") then
						var_145_16.gameObject:SetActive(true)
					else
						var_145_16.gameObject:SetActive(false)
					end
				end
			end

			local var_145_17 = 0.001

			if 1.965999999999 <= arg_142_1.time_ and arg_142_1.time_ < 1.965999999999 + var_145_17 then
				var_145_15.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_142_1.time_ - 1.965999999999) / var_145_17)
			end

			if arg_142_1.time_ >= 1.965999999999 + var_145_17 and arg_142_1.time_ < 1.965999999999 + var_145_17 + arg_145_0 then
				var_145_15.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_145_18 = arg_142_1.actors_["1034"].transform

			if 7.40000000000001 < arg_142_1.time_ and arg_142_1.time_ <= 7.40000000000001 + arg_145_0 then
				arg_142_1.var_.moveOldPos1034 = var_145_18.localPosition
				var_145_18.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("1034", 2)

				for iter_145_9 = 0, var_145_18.childCount - 1 do
					local var_145_19 = var_145_18:GetChild(iter_145_9)

					if var_145_19.name == "split_4" or not string.find(var_145_19.name, "split") then
						var_145_19.gameObject:SetActive(true)
					else
						var_145_19.gameObject:SetActive(false)
					end
				end
			end

			local var_145_20 = 0.001

			if 7.40000000000001 <= arg_142_1.time_ and arg_142_1.time_ < 7.40000000000001 + var_145_20 then
				var_145_18.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_142_1.time_ - 7.40000000000001) / var_145_20)
			end

			if arg_142_1.time_ >= 7.40000000000001 + var_145_20 and arg_142_1.time_ < 7.40000000000001 + var_145_20 + arg_145_0 then
				var_145_18.localPosition = Vector3.New(-390, -331.9, -324)
			end

			if 7.40000000000001 < arg_142_1.time_ and arg_142_1.time_ <= 7.40000000000001 + arg_145_0 then
				local var_145_21 = arg_142_1.actors_["1034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_145_21 then
					arg_142_1.var_.alphaOldValue1034 = var_145_21.alpha
					arg_142_1.var_.characterEffect1034 = var_145_21
				end

				arg_142_1.var_.alphaOldValue1034 = 0
			end

			local var_145_22 = 0.2

			if 7.40000000000001 <= arg_142_1.time_ and arg_142_1.time_ < 7.40000000000001 + var_145_22 then
				if arg_142_1.var_.characterEffect1034 then
					arg_142_1.var_.characterEffect1034.alpha = Mathf.Lerp(arg_142_1.var_.alphaOldValue1034, 1, (arg_142_1.time_ - 7.40000000000001) / var_145_22)
				end
			end

			if arg_142_1.time_ >= 7.40000000000001 + var_145_22 and arg_142_1.time_ < 7.40000000000001 + var_145_22 + arg_145_0 and arg_142_1.var_.characterEffect1034 then
				arg_142_1.var_.characterEffect1034.alpha = 1
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_145_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_142_1.bgmTxt_.text ~= var_145_25 and arg_142_1.bgmTxt_.text ~= "" then
						if arg_142_1.bgmTxt2_.text ~= "" then
							arg_142_1.bgmTxt_.text = arg_142_1.bgmTxt2_.text
						end

						arg_142_1.bgmTxt2_.text = var_145_25

						arg_142_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_142_1.bgmTxt_.text = var_145_25
						arg_142_1.bgmTxt2_.text = var_145_25
					end

					if arg_142_1.bgmTimer then
						arg_142_1.bgmTimer:Stop()

						arg_142_1.bgmTimer = nil
					end

					if arg_142_1.settingData.show_music_name == 1 then
						arg_142_1.musicController:SetSelectedState("show")
						arg_142_1.musicAnimator_:Play("open", 0, 0)

						if arg_142_1.settingData.music_time ~= 0 then
							arg_142_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_142_1.settingData.music_time), function()
								if arg_142_1 == nil or isNil(arg_142_1.bgmTxt_) then
									return
								end

								arg_142_1.musicController:SetSelectedState("hide")
								arg_142_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.63333333333333 < arg_142_1.time_ and arg_142_1.time_ <= 1.63333333333333 + arg_145_0 then
				arg_142_1:AudioAction("play", "music", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_145_28 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

				if "" ~= "" then
					if arg_142_1.bgmTxt_.text ~= var_145_28 and arg_142_1.bgmTxt_.text ~= "" then
						if arg_142_1.bgmTxt2_.text ~= "" then
							arg_142_1.bgmTxt_.text = arg_142_1.bgmTxt2_.text
						end

						arg_142_1.bgmTxt2_.text = var_145_28

						arg_142_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_142_1.bgmTxt_.text = var_145_28
						arg_142_1.bgmTxt2_.text = var_145_28
					end

					if arg_142_1.bgmTimer then
						arg_142_1.bgmTimer:Stop()

						arg_142_1.bgmTimer = nil
					end

					if arg_142_1.settingData.show_music_name == 1 then
						arg_142_1.musicController:SetSelectedState("show")
						arg_142_1.musicAnimator_:Play("open", 0, 0)

						if arg_142_1.settingData.music_time ~= 0 then
							arg_142_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_142_1.settingData.music_time), function()
								if arg_142_1 == nil or isNil(arg_142_1.bgmTxt_) then
									return
								end

								arg_142_1.musicController:SetSelectedState("hide")
								arg_142_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_145_29 = 2

			if 2 < arg_142_1.time_ and arg_142_1.time_ <= var_145_29 + arg_145_0 then
				arg_142_1.timestampController_:SetSelectedState("show")
				arg_142_1.timestampAni_:Play("in")

				arg_142_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST73")

				arg_142_1.timestampColorController_:SetSelectedState("cold")
				arg_142_1.timeColdImg_:SetAlpha(0.031)

				arg_142_1.text_timeText_.text = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(501025).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_timeText_)

				arg_142_1.text_siteText_.text = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(501026).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_siteText_)
			end

			if arg_142_1.time_ >= var_145_29 + 3 and arg_142_1.time_ < var_145_29 + 3 + arg_145_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_142_1.timestampAni_, "out", function()
					arg_142_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_145_30 = 5

			if 5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_30 + arg_145_0 then
				arg_142_1.mask_.enabled = true
				arg_142_1.mask_.raycastTarget = true

				arg_142_1:SetGaussion(false)
			end

			local var_145_31 = 1.2

			if var_145_30 <= arg_142_1.time_ and arg_142_1.time_ < var_145_30 + var_145_31 then
				local var_145_32 = Color.New(0, 0, 0)

				var_145_32.a = Mathf.Lerp(0, 1, (arg_142_1.time_ - var_145_30) / var_145_31)
				arg_142_1.mask_.color = var_145_32
			end

			if arg_142_1.time_ >= var_145_30 + var_145_31 and arg_142_1.time_ < var_145_30 + var_145_31 + arg_145_0 then
				local var_145_33 = Color.New(0, 0, 0)

				var_145_33.a = 1
				arg_142_1.mask_.color = var_145_33
			end

			local var_145_34 = 6.20000000000001

			if 6.20000000000001 < arg_142_1.time_ and arg_142_1.time_ <= var_145_34 + arg_145_0 then
				arg_142_1.mask_.enabled = true
				arg_142_1.mask_.raycastTarget = true

				arg_142_1:SetGaussion(false)
			end

			local var_145_35 = 1.2

			if var_145_34 <= arg_142_1.time_ and arg_142_1.time_ < var_145_34 + var_145_35 then
				local var_145_36 = Color.New(0, 0, 0)

				var_145_36.a = Mathf.Lerp(1, 0, (arg_142_1.time_ - var_145_34) / var_145_35)
				arg_142_1.mask_.color = var_145_36
			end

			if arg_142_1.time_ >= var_145_34 + var_145_35 and arg_142_1.time_ < var_145_34 + var_145_35 + arg_145_0 then
				local var_145_37 = Color.New(0, 0, 0)

				arg_142_1.mask_.enabled = false
				var_145_37.a = 0
				arg_142_1.mask_.color = var_145_37
			end

			local var_145_38 = 2

			if 2 < arg_142_1.time_ and arg_142_1.time_ <= var_145_38 + arg_145_0 then
				arg_142_1.mask_.enabled = true
				arg_142_1.mask_.raycastTarget = false

				arg_142_1:SetGaussion(false)
			end

			local var_145_39 = 1

			if var_145_38 <= arg_142_1.time_ and arg_142_1.time_ < var_145_38 + var_145_39 then
				local var_145_40 = Color.New(0, 0, 0)

				var_145_40.a = Mathf.Lerp(1, 0, (arg_142_1.time_ - var_145_38) / var_145_39)
				arg_142_1.mask_.color = var_145_40
			end

			if arg_142_1.time_ >= var_145_38 + var_145_39 and arg_142_1.time_ < var_145_38 + var_145_39 + arg_145_0 then
				local var_145_41 = Color.New(0, 0, 0)

				arg_142_1.mask_.enabled = false
				var_145_41.a = 0
				arg_142_1.mask_.color = var_145_41
			end

			local var_145_42 = 2

			arg_142_1.isInRecall_ = false

			if var_145_42 < arg_142_1.time_ and arg_142_1.time_ <= var_145_42 + arg_145_0 then
				arg_142_1.screenFilterGo_:SetActive(false)

				for iter_145_10, iter_145_11 in pairs(arg_142_1.actors_) do
					for iter_145_12, iter_145_13 in ipairs((iter_145_11:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_145_13.color = iter_145_13.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_145_43 = 0.166666666666667

			if var_145_42 <= arg_142_1.time_ and arg_142_1.time_ < var_145_42 + var_145_43 then
				arg_142_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_142_1.time_ - var_145_42) / var_145_43)
			end

			if arg_142_1.time_ >= var_145_42 + var_145_43 and arg_142_1.time_ < var_145_42 + var_145_43 + arg_145_0 then
				arg_142_1.screenFilterEffect_.weight = 0
			end

			local var_145_44 = 1.999999999999

			if 1.999999999999 < arg_142_1.time_ and arg_142_1.time_ <= var_145_44 + arg_145_0 then
				arg_142_1.allBtn_.enabled = false
			end

			if arg_142_1.time_ >= var_145_44 + 3 and arg_142_1.time_ < var_145_44 + 3 + arg_145_0 then
				arg_142_1.allBtn_.enabled = true
			end

			if arg_142_1.frameCnt_ <= 1 then
				arg_142_1.dialog_:SetActive(false)
			end

			local var_145_45 = 7.76666666666668
			local var_145_46 = 0.85

			if 7.76666666666668 < arg_142_1.time_ and arg_142_1.time_ <= var_145_45 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0

				arg_142_1.dialog_:SetActive(true)

				arg_142_1.dialogCg_.alpha = 0

				local var_145_47 = LeanTween.value(arg_142_1.dialog_, 0, 1, 0.3)

				var_145_47:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_142_1.dialogCg_.alpha = arg_149_0
				end))
				var_145_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_142_1.dialog_)
					var_145_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_142_1.duration_ = arg_142_1.duration_ + 0.3

				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_48 = arg_142_1:GetWordFromCfg(417071034)
				local var_145_49 = arg_142_1:FormatText(var_145_48.content)

				arg_142_1.text_.text = var_145_49

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_51 = 34 <= 0 and var_145_46 or var_145_46 * (utf8.len(var_145_49) / 34)

				if (34 <= 0 and var_145_46 or var_145_46 * (utf8.len(var_145_49) / 34)) > 0 and var_145_46 < var_145_51 then
					arg_142_1.talkMaxDuration = var_145_51
					var_145_45 = var_145_45 + 0.3

					if var_145_51 + var_145_45 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_51 + var_145_45
					end
				end

				arg_142_1.text_.text = var_145_49
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071034", "story_v_out_417071.awb") ~= 0 then
					local var_145_52 = manager.audio:GetVoiceLength("story_v_out_417071", "417071034", "story_v_out_417071.awb") / 1000

					if var_145_52 + var_145_45 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_52 + var_145_45
					end

					if var_145_48.prefab_name ~= "" and arg_142_1.actors_[var_145_48.prefab_name] ~= nil then
						local var_145_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_48.prefab_name].transform, "story_v_out_417071", "417071034", "story_v_out_417071.awb")

						arg_142_1:RecordAudio("417071034", var_145_53)
						arg_142_1:RecordAudio("417071034", var_145_53)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_417071", "417071034", "story_v_out_417071.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_417071", "417071034", "story_v_out_417071.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_54 = var_145_45 + 0.3
			local var_145_55 = math.max(var_145_46, arg_142_1.talkMaxDuration)

			if var_145_45 + 0.3 <= arg_142_1.time_ and arg_142_1.time_ < var_145_54 + var_145_55 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_54) / var_145_55

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_54 + var_145_55 and arg_142_1.time_ < var_145_54 + var_145_55 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.965999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 7.40000000000001,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play417071035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 417071035
		arg_151_1.duration_ = 9.77

		local var_151_0 = {
			zh = 7.8,
			ja = 9.766
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
				arg_151_0:Play417071036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10128"]) and arg_151_1.var_.actorSpriteComps10128 == nil then
				arg_151_1.var_.actorSpriteComps10128 = arg_151_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10128"]) then
				if arg_151_1.var_.actorSpriteComps10128 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 1, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10128"]) and arg_151_1.var_.actorSpriteComps10128 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps10128 = nil
			end

			local var_154_2 = arg_151_1.actors_["1034"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps1034 == nil then
				arg_151_1.var_.actorSpriteComps1034 = var_154_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_3 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.actorSpriteComps1034 then
					for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_154_5 then
							if arg_151_1.isInRecall_ then
								iter_154_5.color = Color.New(Mathf.Lerp(iter_154_5.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_3), Mathf.Lerp(iter_154_5.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_3), (Mathf.Lerp(iter_154_5.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_3)))
							else
								local var_154_4 = Mathf.Lerp(iter_154_5.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_3)

								iter_154_5.color = Color.New(var_154_4, var_154_4, var_154_4)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps1034 then
				for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_154_7 then
						iter_154_7.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps1034 = nil
			end

			local var_154_5 = arg_151_1.actors_["10128"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10128 = var_154_5.localPosition
				var_154_5.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10128", 4)

				for iter_154_8 = 0, var_154_5.childCount - 1 do
					local var_154_6 = var_154_5:GetChild(iter_154_8)

					if var_154_6.name == "" or not string.find(var_154_6.name, "split") then
						var_154_6.gameObject:SetActive(true)
					else
						var_154_6.gameObject:SetActive(false)
					end
				end
			end

			local var_154_7 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				var_154_5.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_151_1.time_ - 0) / var_154_7)
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				var_154_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_154_8 = 0
			local var_154_9 = 1.175

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_10 = arg_151_1:GetWordFromCfg(417071035)
				local var_154_11 = arg_151_1:FormatText(var_154_10.content)

				arg_151_1.text_.text = var_154_11

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 47 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 47)

				if (47 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 47)) > 0 and var_154_9 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_11
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071035", "story_v_out_417071.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_417071", "417071035", "story_v_out_417071.awb") / 1000

					if var_154_14 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_8
					end

					if var_154_10.prefab_name ~= "" and arg_151_1.actors_[var_154_10.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_10.prefab_name].transform, "story_v_out_417071", "417071035", "story_v_out_417071.awb")

						arg_151_1:RecordAudio("417071035", var_154_15)
						arg_151_1:RecordAudio("417071035", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_417071", "417071035", "story_v_out_417071.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_417071", "417071035", "story_v_out_417071.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_16 = math.max(var_154_9, arg_151_1.talkMaxDuration)

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_8) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_8 + var_154_16 and arg_151_1.time_ < var_154_8 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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

		arg_151_1:InitPlayNodeList()
	end,
	Play417071036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 417071036
		arg_155_1.duration_ = 10.67

		local var_155_0 = {
			zh = 3.2,
			ja = 10.666
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
				arg_155_0:Play417071037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1034"]) and arg_155_1.var_.actorSpriteComps1034 == nil then
				arg_155_1.var_.actorSpriteComps1034 = arg_155_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_0 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1034"]) then
				if arg_155_1.var_.actorSpriteComps1034 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								iter_158_1.color = Color.New(Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_0), Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_0), (Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_0)))
							else
								local var_158_1 = Mathf.Lerp(iter_158_1.color.r, 1, (arg_155_1.time_ - 0) / var_158_0)

								iter_158_1.color = Color.New(var_158_1, var_158_1, var_158_1)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1034"]) and arg_155_1.var_.actorSpriteComps1034 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_158_3 then
						iter_158_3.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps1034 = nil
			end

			local var_158_2 = arg_155_1.actors_["10128"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10128 == nil then
				arg_155_1.var_.actorSpriteComps10128 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps10128 then
					for iter_158_4, iter_158_5 in pairs(arg_155_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_158_5 then
							if arg_155_1.isInRecall_ then
								iter_158_5.color = Color.New(Mathf.Lerp(iter_158_5.color.r, arg_155_1.hightColor2.r, (arg_155_1.time_ - 0) / var_158_3), Mathf.Lerp(iter_158_5.color.g, arg_155_1.hightColor2.g, (arg_155_1.time_ - 0) / var_158_3), (Mathf.Lerp(iter_158_5.color.b, arg_155_1.hightColor2.b, (arg_155_1.time_ - 0) / var_158_3)))
							else
								local var_158_4 = Mathf.Lerp(iter_158_5.color.r, 0.5, (arg_155_1.time_ - 0) / var_158_3)

								iter_158_5.color = Color.New(var_158_4, var_158_4, var_158_4)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10128 then
				for iter_158_6, iter_158_7 in pairs(arg_155_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_158_7 then
						iter_158_7.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_155_1.var_.actorSpriteComps10128 = nil
			end

			local var_158_5 = arg_155_1.actors_["1034"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1034 = var_158_5.localPosition
				var_158_5.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1034", 2)

				for iter_158_8 = 0, var_158_5.childCount - 1 do
					local var_158_6 = var_158_5:GetChild(iter_158_8)

					if var_158_6.name == "split_1" or not string.find(var_158_6.name, "split") then
						var_158_6.gameObject:SetActive(true)
					else
						var_158_6.gameObject:SetActive(false)
					end
				end
			end

			local var_158_7 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				var_158_5.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_155_1.time_ - 0) / var_158_7)
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				var_158_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_158_8 = 0
			local var_158_9 = 0.425

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_10 = arg_155_1:GetWordFromCfg(417071036)
				local var_158_11 = arg_155_1:FormatText(var_158_10.content)

				arg_155_1.text_.text = var_158_11

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_13 = 17 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 17)

				if (17 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 17)) > 0 and var_158_9 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_8
					end
				end

				arg_155_1.text_.text = var_158_11
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071036", "story_v_out_417071.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_out_417071", "417071036", "story_v_out_417071.awb") / 1000

					if var_158_14 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_8
					end

					if var_158_10.prefab_name ~= "" and arg_155_1.actors_[var_158_10.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_10.prefab_name].transform, "story_v_out_417071", "417071036", "story_v_out_417071.awb")

						arg_155_1:RecordAudio("417071036", var_158_15)
						arg_155_1:RecordAudio("417071036", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_417071", "417071036", "story_v_out_417071.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_417071", "417071036", "story_v_out_417071.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_9, arg_155_1.talkMaxDuration)

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_8) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_8 + var_158_16 and arg_155_1.time_ < var_158_8 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play417071037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 417071037
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play417071038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1034"]) and arg_159_1.var_.actorSpriteComps1034 == nil then
				arg_159_1.var_.actorSpriteComps1034 = arg_159_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1034"]) then
				if arg_159_1.var_.actorSpriteComps1034 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								iter_162_1.color = Color.New(Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor2.r, (arg_159_1.time_ - 0) / var_162_0), Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor2.g, (arg_159_1.time_ - 0) / var_162_0), (Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor2.b, (arg_159_1.time_ - 0) / var_162_0)))
							else
								local var_162_1 = Mathf.Lerp(iter_162_1.color.r, 0.5, (arg_159_1.time_ - 0) / var_162_0)

								iter_162_1.color = Color.New(var_162_1, var_162_1, var_162_1)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1034"]) and arg_159_1.var_.actorSpriteComps1034 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps1034 = nil
			end

			if 0.2 < arg_159_1.time_ and arg_159_1.time_ <= 0.2 + arg_162_0 then
				arg_159_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_pad", "")
			end

			local var_162_3 = 0
			local var_162_4 = 1.65

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_3 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_5 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(417071037).content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 66 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_5) / 66)

				if (66 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_5) / 66)) > 0 and var_162_4 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_3
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_4, arg_159_1.talkMaxDuration)

			if var_162_3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_3 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_3) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_3 + var_162_8 and arg_159_1.time_ < var_162_3 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play417071038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 417071038
		arg_163_1.duration_ = 6.1

		local var_163_0 = {
			zh = 2.9,
			ja = 6.1
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
				arg_163_0:Play417071039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10128"]) and arg_163_1.var_.actorSpriteComps10128 == nil then
				arg_163_1.var_.actorSpriteComps10128 = arg_163_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10128"]) then
				if arg_163_1.var_.actorSpriteComps10128 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_0), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_0), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_0)))
							else
								local var_166_1 = Mathf.Lerp(iter_166_1.color.r, 1, (arg_163_1.time_ - 0) / var_166_0)

								iter_166_1.color = Color.New(var_166_1, var_166_1, var_166_1)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10128"]) and arg_163_1.var_.actorSpriteComps10128 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps10128 = nil
			end

			local var_166_2 = arg_163_1.actors_["10128"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10128 = var_166_2.localPosition
				var_166_2.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10128", 4)

				for iter_166_4 = 0, var_166_2.childCount - 1 do
					local var_166_3 = var_166_2:GetChild(iter_166_4)

					if var_166_3.name == "split_2" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				var_166_2.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_163_1.time_ - 0) / var_166_4)
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				var_166_2.localPosition = Vector3.New(390, -347, -300)
			end

			local var_166_5 = 0
			local var_166_6 = 0.3

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_7 = arg_163_1:GetWordFromCfg(417071038)
				local var_166_8 = arg_163_1:FormatText(var_166_7.content)

				arg_163_1.text_.text = var_166_8

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 12 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 12)

				if (12 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 12)) > 0 and var_166_6 < var_166_10 then
					arg_163_1.talkMaxDuration = var_166_10

					if var_166_10 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_8
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071038", "story_v_out_417071.awb") ~= 0 then
					local var_166_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071038", "story_v_out_417071.awb") / 1000

					if var_166_11 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_5
					end

					if var_166_7.prefab_name ~= "" and arg_163_1.actors_[var_166_7.prefab_name] ~= nil then
						local var_166_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_7.prefab_name].transform, "story_v_out_417071", "417071038", "story_v_out_417071.awb")

						arg_163_1:RecordAudio("417071038", var_166_12)
						arg_163_1:RecordAudio("417071038", var_166_12)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_417071", "417071038", "story_v_out_417071.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_417071", "417071038", "story_v_out_417071.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_13 = math.max(var_166_6, arg_163_1.talkMaxDuration)

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_13 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_5) / var_166_13

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_5 + var_166_13 and arg_163_1.time_ < var_166_5 + var_166_13 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play417071039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 417071039
		arg_167_1.duration_ = 5.23

		local var_167_0 = {
			zh = 2.033,
			ja = 5.233
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play417071040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1034"]) and arg_167_1.var_.actorSpriteComps1034 == nil then
				arg_167_1.var_.actorSpriteComps1034 = arg_167_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1034"]) then
				if arg_167_1.var_.actorSpriteComps1034 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								iter_170_1.color = Color.New(Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_0), Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_0), (Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_0)))
							else
								local var_170_1 = Mathf.Lerp(iter_170_1.color.r, 1, (arg_167_1.time_ - 0) / var_170_0)

								iter_170_1.color = Color.New(var_170_1, var_170_1, var_170_1)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1034"]) and arg_167_1.var_.actorSpriteComps1034 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps1034 = nil
			end

			local var_170_2 = arg_167_1.actors_["10128"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10128 == nil then
				arg_167_1.var_.actorSpriteComps10128 = var_170_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_3 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.actorSpriteComps10128 then
					for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_170_5 then
							if arg_167_1.isInRecall_ then
								iter_170_5.color = Color.New(Mathf.Lerp(iter_170_5.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_3), Mathf.Lerp(iter_170_5.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_3), (Mathf.Lerp(iter_170_5.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_3)))
							else
								local var_170_4 = Mathf.Lerp(iter_170_5.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_3)

								iter_170_5.color = Color.New(var_170_4, var_170_4, var_170_4)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10128 then
				for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_170_7 then
						iter_170_7.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps10128 = nil
			end

			local var_170_5 = arg_167_1.actors_["1034"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1034 = var_170_5.localPosition
				var_170_5.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1034", 2)

				for iter_170_8 = 0, var_170_5.childCount - 1 do
					local var_170_6 = var_170_5:GetChild(iter_170_8)

					if var_170_6.name == "split_7" or not string.find(var_170_6.name, "split") then
						var_170_6.gameObject:SetActive(true)
					else
						var_170_6.gameObject:SetActive(false)
					end
				end
			end

			local var_170_7 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				var_170_5.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_167_1.time_ - 0) / var_170_7)
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				var_170_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_170_8 = 0
			local var_170_9 = 0.25

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(417071039)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 10 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 10)

				if (10 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 10)) > 0 and var_170_9 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071039", "story_v_out_417071.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_417071", "417071039", "story_v_out_417071.awb") / 1000

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_417071", "417071039", "story_v_out_417071.awb")

						arg_167_1:RecordAudio("417071039", var_170_15)
						arg_167_1:RecordAudio("417071039", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_417071", "417071039", "story_v_out_417071.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_417071", "417071039", "story_v_out_417071.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_16 = math.max(var_170_9, arg_167_1.talkMaxDuration)

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_16 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_8) / var_170_16

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_8 + var_170_16 and arg_167_1.time_ < var_170_8 + var_170_16 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play417071040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 417071040
		arg_171_1.duration_ = 5.7

		local var_171_0 = {
			zh = 4.366,
			ja = 5.7
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
				arg_171_0:Play417071041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.525

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(417071040)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 21 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 21)

				if (21 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 21)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071040", "story_v_out_417071.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071040", "story_v_out_417071.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_417071", "417071040", "story_v_out_417071.awb")

						arg_171_1:RecordAudio("417071040", var_174_6)
						arg_171_1:RecordAudio("417071040", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_417071", "417071040", "story_v_out_417071.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_417071", "417071040", "story_v_out_417071.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play417071041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 417071041
		arg_175_1.duration_ = 2.2

		local var_175_0 = {
			zh = 1.266,
			ja = 2.2
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
				arg_175_0:Play417071042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["10128"]) and arg_175_1.var_.actorSpriteComps10128 == nil then
				arg_175_1.var_.actorSpriteComps10128 = arg_175_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_0 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["10128"]) then
				if arg_175_1.var_.actorSpriteComps10128 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								iter_178_1.color = Color.New(Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor1.r, (arg_175_1.time_ - 0) / var_178_0), Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor1.g, (arg_175_1.time_ - 0) / var_178_0), (Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor1.b, (arg_175_1.time_ - 0) / var_178_0)))
							else
								local var_178_1 = Mathf.Lerp(iter_178_1.color.r, 1, (arg_175_1.time_ - 0) / var_178_0)

								iter_178_1.color = Color.New(var_178_1, var_178_1, var_178_1)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["10128"]) and arg_175_1.var_.actorSpriteComps10128 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_178_3 then
						iter_178_3.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps10128 = nil
			end

			local var_178_2 = arg_175_1.actors_["1034"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1034 == nil then
				arg_175_1.var_.actorSpriteComps1034 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps1034 then
					for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_178_5 then
							if arg_175_1.isInRecall_ then
								iter_178_5.color = Color.New(Mathf.Lerp(iter_178_5.color.r, arg_175_1.hightColor2.r, (arg_175_1.time_ - 0) / var_178_3), Mathf.Lerp(iter_178_5.color.g, arg_175_1.hightColor2.g, (arg_175_1.time_ - 0) / var_178_3), (Mathf.Lerp(iter_178_5.color.b, arg_175_1.hightColor2.b, (arg_175_1.time_ - 0) / var_178_3)))
							else
								local var_178_4 = Mathf.Lerp(iter_178_5.color.r, 0.5, (arg_175_1.time_ - 0) / var_178_3)

								iter_178_5.color = Color.New(var_178_4, var_178_4, var_178_4)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1034 then
				for iter_178_6, iter_178_7 in pairs(arg_175_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_178_7 then
						iter_178_7.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps1034 = nil
			end

			local var_178_5 = arg_175_1.actors_["10128"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10128 = var_178_5.localPosition
				var_178_5.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10128", 4)

				for iter_178_8 = 0, var_178_5.childCount - 1 do
					local var_178_6 = var_178_5:GetChild(iter_178_8)

					if var_178_6.name == "" or not string.find(var_178_6.name, "split") then
						var_178_6.gameObject:SetActive(true)
					else
						var_178_6.gameObject:SetActive(false)
					end
				end
			end

			local var_178_7 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				var_178_5.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_175_1.time_ - 0) / var_178_7)
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				var_178_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_178_8 = 0
			local var_178_9 = 0.125

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:GetWordFromCfg(417071041)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 5 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 5)

				if (5 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 5)) > 0 and var_178_9 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071041", "story_v_out_417071.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_417071", "417071041", "story_v_out_417071.awb") / 1000

					if var_178_14 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_8
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_out_417071", "417071041", "story_v_out_417071.awb")

						arg_175_1:RecordAudio("417071041", var_178_15)
						arg_175_1:RecordAudio("417071041", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_417071", "417071041", "story_v_out_417071.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_417071", "417071041", "story_v_out_417071.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_9, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_8) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_16 and arg_175_1.time_ < var_178_8 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play417071042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 417071042
		arg_179_1.duration_ = 10.07

		local var_179_0 = {
			zh = 7.2,
			ja = 10.066
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
				arg_179_0:Play417071043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1034"]) and arg_179_1.var_.actorSpriteComps1034 == nil then
				arg_179_1.var_.actorSpriteComps1034 = arg_179_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1034"]) then
				if arg_179_1.var_.actorSpriteComps1034 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 1, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1034"]) and arg_179_1.var_.actorSpriteComps1034 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps1034 = nil
			end

			local var_182_2 = arg_179_1.actors_["10128"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps10128 == nil then
				arg_179_1.var_.actorSpriteComps10128 = var_182_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_3 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.actorSpriteComps10128 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_182_5 then
							if arg_179_1.isInRecall_ then
								iter_182_5.color = Color.New(Mathf.Lerp(iter_182_5.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_3), Mathf.Lerp(iter_182_5.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_3), (Mathf.Lerp(iter_182_5.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_3)))
							else
								local var_182_4 = Mathf.Lerp(iter_182_5.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_3)

								iter_182_5.color = Color.New(var_182_4, var_182_4, var_182_4)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps10128 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_182_7 then
						iter_182_7.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps10128 = nil
			end

			local var_182_5 = arg_179_1.actors_["1034"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1034 = var_182_5.localPosition
				var_182_5.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("1034", 2)

				for iter_182_8 = 0, var_182_5.childCount - 1 do
					local var_182_6 = var_182_5:GetChild(iter_182_8)

					if var_182_6.name == "" or not string.find(var_182_6.name, "split") then
						var_182_6.gameObject:SetActive(true)
					else
						var_182_6.gameObject:SetActive(false)
					end
				end
			end

			local var_182_7 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				var_182_5.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_179_1.time_ - 0) / var_182_7)
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				var_182_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_182_8 = 0
			local var_182_9 = 0.775

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(417071042)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 31 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 31)

				if (31 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 31)) > 0 and var_182_9 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071042", "story_v_out_417071.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_417071", "417071042", "story_v_out_417071.awb") / 1000

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end

					if var_182_10.prefab_name ~= "" and arg_179_1.actors_[var_182_10.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_10.prefab_name].transform, "story_v_out_417071", "417071042", "story_v_out_417071.awb")

						arg_179_1:RecordAudio("417071042", var_182_15)
						arg_179_1:RecordAudio("417071042", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_417071", "417071042", "story_v_out_417071.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_417071", "417071042", "story_v_out_417071.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_9, arg_179_1.talkMaxDuration)

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_8) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_8 + var_182_16 and arg_179_1.time_ < var_182_8 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play417071043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 417071043
		arg_183_1.duration_ = 4.83

		local var_183_0 = {
			zh = 3.9,
			ja = 4.833
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
				arg_183_0:Play417071044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["10128"]) and arg_183_1.var_.actorSpriteComps10128 == nil then
				arg_183_1.var_.actorSpriteComps10128 = arg_183_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_0 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["10128"]) then
				if arg_183_1.var_.actorSpriteComps10128 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								iter_186_1.color = Color.New(Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_0), Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_0), (Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_0)))
							else
								local var_186_1 = Mathf.Lerp(iter_186_1.color.r, 1, (arg_183_1.time_ - 0) / var_186_0)

								iter_186_1.color = Color.New(var_186_1, var_186_1, var_186_1)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["10128"]) and arg_183_1.var_.actorSpriteComps10128 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_186_3 then
						iter_186_3.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps10128 = nil
			end

			local var_186_2 = arg_183_1.actors_["1034"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps1034 == nil then
				arg_183_1.var_.actorSpriteComps1034 = var_186_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_3 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 and not isNil(var_186_2) then
				if arg_183_1.var_.actorSpriteComps1034 then
					for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_186_5 then
							if arg_183_1.isInRecall_ then
								iter_186_5.color = Color.New(Mathf.Lerp(iter_186_5.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_3), Mathf.Lerp(iter_186_5.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_3), (Mathf.Lerp(iter_186_5.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_3)))
							else
								local var_186_4 = Mathf.Lerp(iter_186_5.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_3)

								iter_186_5.color = Color.New(var_186_4, var_186_4, var_186_4)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps1034 then
				for iter_186_6, iter_186_7 in pairs(arg_183_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_186_7 then
						iter_186_7.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps1034 = nil
			end

			local var_186_5 = arg_183_1.actors_["1034"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1034 = var_186_5.localPosition
				var_186_5.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1034", 2)

				for iter_186_8 = 0, var_186_5.childCount - 1 do
					local var_186_6 = var_186_5:GetChild(iter_186_8)

					if var_186_6.name == "" or not string.find(var_186_6.name, "split") then
						var_186_6.gameObject:SetActive(true)
					else
						var_186_6.gameObject:SetActive(false)
					end
				end
			end

			local var_186_7 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				var_186_5.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_183_1.time_ - 0) / var_186_7)
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				var_186_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_186_8 = 0
			local var_186_9 = 0.4

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_10 = arg_183_1:GetWordFromCfg(417071043)
				local var_186_11 = arg_183_1:FormatText(var_186_10.content)

				arg_183_1.text_.text = var_186_11

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_13 = 16 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 16)

				if (16 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 16)) > 0 and var_186_9 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_11
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071043", "story_v_out_417071.awb") ~= 0 then
					local var_186_14 = manager.audio:GetVoiceLength("story_v_out_417071", "417071043", "story_v_out_417071.awb") / 1000

					if var_186_14 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_8
					end

					if var_186_10.prefab_name ~= "" and arg_183_1.actors_[var_186_10.prefab_name] ~= nil then
						local var_186_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_10.prefab_name].transform, "story_v_out_417071", "417071043", "story_v_out_417071.awb")

						arg_183_1:RecordAudio("417071043", var_186_15)
						arg_183_1:RecordAudio("417071043", var_186_15)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_417071", "417071043", "story_v_out_417071.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_417071", "417071043", "story_v_out_417071.awb")
				end

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

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play417071044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 417071044
		arg_187_1.duration_ = 1.57

		local var_187_0 = {
			zh = 1.266,
			ja = 1.566
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
				arg_187_0:Play417071045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1034"]) and arg_187_1.var_.actorSpriteComps1034 == nil then
				arg_187_1.var_.actorSpriteComps1034 = arg_187_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_0 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1034"]) then
				if arg_187_1.var_.actorSpriteComps1034 then
					for iter_190_0, iter_190_1 in pairs(arg_187_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_190_1 then
							if arg_187_1.isInRecall_ then
								iter_190_1.color = Color.New(Mathf.Lerp(iter_190_1.color.r, arg_187_1.hightColor1.r, (arg_187_1.time_ - 0) / var_190_0), Mathf.Lerp(iter_190_1.color.g, arg_187_1.hightColor1.g, (arg_187_1.time_ - 0) / var_190_0), (Mathf.Lerp(iter_190_1.color.b, arg_187_1.hightColor1.b, (arg_187_1.time_ - 0) / var_190_0)))
							else
								local var_190_1 = Mathf.Lerp(iter_190_1.color.r, 1, (arg_187_1.time_ - 0) / var_190_0)

								iter_190_1.color = Color.New(var_190_1, var_190_1, var_190_1)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1034"]) and arg_187_1.var_.actorSpriteComps1034 then
				for iter_190_2, iter_190_3 in pairs(arg_187_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_190_3 then
						iter_190_3.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_187_1.var_.actorSpriteComps1034 = nil
			end

			local var_190_2 = arg_187_1.actors_["10128"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.actorSpriteComps10128 == nil then
				arg_187_1.var_.actorSpriteComps10128 = var_190_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_3 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 and not isNil(var_190_2) then
				if arg_187_1.var_.actorSpriteComps10128 then
					for iter_190_4, iter_190_5 in pairs(arg_187_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_190_5 then
							if arg_187_1.isInRecall_ then
								iter_190_5.color = Color.New(Mathf.Lerp(iter_190_5.color.r, arg_187_1.hightColor2.r, (arg_187_1.time_ - 0) / var_190_3), Mathf.Lerp(iter_190_5.color.g, arg_187_1.hightColor2.g, (arg_187_1.time_ - 0) / var_190_3), (Mathf.Lerp(iter_190_5.color.b, arg_187_1.hightColor2.b, (arg_187_1.time_ - 0) / var_190_3)))
							else
								local var_190_4 = Mathf.Lerp(iter_190_5.color.r, 0.5, (arg_187_1.time_ - 0) / var_190_3)

								iter_190_5.color = Color.New(var_190_4, var_190_4, var_190_4)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.actorSpriteComps10128 then
				for iter_190_6, iter_190_7 in pairs(arg_187_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_190_7 then
						iter_190_7.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_187_1.var_.actorSpriteComps10128 = nil
			end

			local var_190_5 = arg_187_1.actors_["1034"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1034 = var_190_5.localPosition
				var_190_5.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1034", 2)

				for iter_190_8 = 0, var_190_5.childCount - 1 do
					local var_190_6 = var_190_5:GetChild(iter_190_8)

					if var_190_6.name == "split_3" or not string.find(var_190_6.name, "split") then
						var_190_6.gameObject:SetActive(true)
					else
						var_190_6.gameObject:SetActive(false)
					end
				end
			end

			local var_190_7 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				var_190_5.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_187_1.time_ - 0) / var_190_7)
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				var_190_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_190_8 = 0
			local var_190_9 = 0.125

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_10 = arg_187_1:GetWordFromCfg(417071044)
				local var_190_11 = arg_187_1:FormatText(var_190_10.content)

				arg_187_1.text_.text = var_190_11

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_13 = 5 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 5)

				if (5 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 5)) > 0 and var_190_9 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_8
					end
				end

				arg_187_1.text_.text = var_190_11
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071044", "story_v_out_417071.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_out_417071", "417071044", "story_v_out_417071.awb") / 1000

					if var_190_14 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_8
					end

					if var_190_10.prefab_name ~= "" and arg_187_1.actors_[var_190_10.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_10.prefab_name].transform, "story_v_out_417071", "417071044", "story_v_out_417071.awb")

						arg_187_1:RecordAudio("417071044", var_190_15)
						arg_187_1:RecordAudio("417071044", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_417071", "417071044", "story_v_out_417071.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_417071", "417071044", "story_v_out_417071.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_9, arg_187_1.talkMaxDuration)

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_8) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_8 + var_190_16 and arg_187_1.time_ < var_190_8 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play417071045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 417071045
		arg_191_1.duration_ = 8.1

		local var_191_0 = {
			zh = 7.066,
			ja = 8.1
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play417071046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["10128"]) and arg_191_1.var_.actorSpriteComps10128 == nil then
				arg_191_1.var_.actorSpriteComps10128 = arg_191_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_0 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["10128"]) then
				if arg_191_1.var_.actorSpriteComps10128 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								iter_194_1.color = Color.New(Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor1.r, (arg_191_1.time_ - 0) / var_194_0), Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor1.g, (arg_191_1.time_ - 0) / var_194_0), (Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor1.b, (arg_191_1.time_ - 0) / var_194_0)))
							else
								local var_194_1 = Mathf.Lerp(iter_194_1.color.r, 1, (arg_191_1.time_ - 0) / var_194_0)

								iter_194_1.color = Color.New(var_194_1, var_194_1, var_194_1)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["10128"]) and arg_191_1.var_.actorSpriteComps10128 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_194_3 then
						iter_194_3.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps10128 = nil
			end

			local var_194_2 = arg_191_1.actors_["1034"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps1034 == nil then
				arg_191_1.var_.actorSpriteComps1034 = var_194_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_3 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 and not isNil(var_194_2) then
				if arg_191_1.var_.actorSpriteComps1034 then
					for iter_194_4, iter_194_5 in pairs(arg_191_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_194_5 then
							if arg_191_1.isInRecall_ then
								iter_194_5.color = Color.New(Mathf.Lerp(iter_194_5.color.r, arg_191_1.hightColor2.r, (arg_191_1.time_ - 0) / var_194_3), Mathf.Lerp(iter_194_5.color.g, arg_191_1.hightColor2.g, (arg_191_1.time_ - 0) / var_194_3), (Mathf.Lerp(iter_194_5.color.b, arg_191_1.hightColor2.b, (arg_191_1.time_ - 0) / var_194_3)))
							else
								local var_194_4 = Mathf.Lerp(iter_194_5.color.r, 0.5, (arg_191_1.time_ - 0) / var_194_3)

								iter_194_5.color = Color.New(var_194_4, var_194_4, var_194_4)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps1034 then
				for iter_194_6, iter_194_7 in pairs(arg_191_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_194_7 then
						iter_194_7.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_191_1.var_.actorSpriteComps1034 = nil
			end

			local var_194_5 = arg_191_1.actors_["10128"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10128 = var_194_5.localPosition
				var_194_5.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10128", 4)

				for iter_194_8 = 0, var_194_5.childCount - 1 do
					local var_194_6 = var_194_5:GetChild(iter_194_8)

					if var_194_6.name == "" or not string.find(var_194_6.name, "split") then
						var_194_6.gameObject:SetActive(true)
					else
						var_194_6.gameObject:SetActive(false)
					end
				end
			end

			local var_194_7 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				var_194_5.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_191_1.time_ - 0) / var_194_7)
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				var_194_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_194_8 = 0
			local var_194_9 = 0.925

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_10 = arg_191_1:GetWordFromCfg(417071045)
				local var_194_11 = arg_191_1:FormatText(var_194_10.content)

				arg_191_1.text_.text = var_194_11

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_13 = 37 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 37)

				if (37 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 37)) > 0 and var_194_9 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_8
					end
				end

				arg_191_1.text_.text = var_194_11
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071045", "story_v_out_417071.awb") ~= 0 then
					local var_194_14 = manager.audio:GetVoiceLength("story_v_out_417071", "417071045", "story_v_out_417071.awb") / 1000

					if var_194_14 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_8
					end

					if var_194_10.prefab_name ~= "" and arg_191_1.actors_[var_194_10.prefab_name] ~= nil then
						local var_194_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_10.prefab_name].transform, "story_v_out_417071", "417071045", "story_v_out_417071.awb")

						arg_191_1:RecordAudio("417071045", var_194_15)
						arg_191_1:RecordAudio("417071045", var_194_15)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_417071", "417071045", "story_v_out_417071.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_417071", "417071045", "story_v_out_417071.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_16 = math.max(var_194_9, arg_191_1.talkMaxDuration)

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_16 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_8) / var_194_16

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_8 + var_194_16 and arg_191_1.time_ < var_194_8 + var_194_16 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play417071046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 417071046
		arg_195_1.duration_ = 5.67

		local var_195_0 = {
			zh = 2.1,
			ja = 5.666
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play417071047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1034"]) and arg_195_1.var_.actorSpriteComps1034 == nil then
				arg_195_1.var_.actorSpriteComps1034 = arg_195_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1034"]) then
				if arg_195_1.var_.actorSpriteComps1034 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								iter_198_1.color = Color.New(Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor1.r, (arg_195_1.time_ - 0) / var_198_0), Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor1.g, (arg_195_1.time_ - 0) / var_198_0), (Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor1.b, (arg_195_1.time_ - 0) / var_198_0)))
							else
								local var_198_1 = Mathf.Lerp(iter_198_1.color.r, 1, (arg_195_1.time_ - 0) / var_198_0)

								iter_198_1.color = Color.New(var_198_1, var_198_1, var_198_1)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1034"]) and arg_195_1.var_.actorSpriteComps1034 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_198_3 then
						iter_198_3.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_195_1.var_.actorSpriteComps1034 = nil
			end

			local var_198_2 = arg_195_1.actors_["10128"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps10128 == nil then
				arg_195_1.var_.actorSpriteComps10128 = var_198_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_3 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.actorSpriteComps10128 then
					for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_198_5 then
							if arg_195_1.isInRecall_ then
								iter_198_5.color = Color.New(Mathf.Lerp(iter_198_5.color.r, arg_195_1.hightColor2.r, (arg_195_1.time_ - 0) / var_198_3), Mathf.Lerp(iter_198_5.color.g, arg_195_1.hightColor2.g, (arg_195_1.time_ - 0) / var_198_3), (Mathf.Lerp(iter_198_5.color.b, arg_195_1.hightColor2.b, (arg_195_1.time_ - 0) / var_198_3)))
							else
								local var_198_4 = Mathf.Lerp(iter_198_5.color.r, 0.5, (arg_195_1.time_ - 0) / var_198_3)

								iter_198_5.color = Color.New(var_198_4, var_198_4, var_198_4)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps10128 then
				for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_198_7 then
						iter_198_7.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps10128 = nil
			end

			local var_198_5 = arg_195_1.actors_["1034"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1034 = var_198_5.localPosition
				var_198_5.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1034", 2)

				for iter_198_8 = 0, var_198_5.childCount - 1 do
					local var_198_6 = var_198_5:GetChild(iter_198_8)

					if var_198_6.name == "split_6" or not string.find(var_198_6.name, "split") then
						var_198_6.gameObject:SetActive(true)
					else
						var_198_6.gameObject:SetActive(false)
					end
				end
			end

			local var_198_7 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				var_198_5.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_195_1.time_ - 0) / var_198_7)
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				var_198_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_198_8 = 0
			local var_198_9 = 0.25

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_10 = arg_195_1:GetWordFromCfg(417071046)
				local var_198_11 = arg_195_1:FormatText(var_198_10.content)

				arg_195_1.text_.text = var_198_11

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_13 = 10 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_11) / 10)

				if (10 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_11) / 10)) > 0 and var_198_9 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_8
					end
				end

				arg_195_1.text_.text = var_198_11
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071046", "story_v_out_417071.awb") ~= 0 then
					local var_198_14 = manager.audio:GetVoiceLength("story_v_out_417071", "417071046", "story_v_out_417071.awb") / 1000

					if var_198_14 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_14 + var_198_8
					end

					if var_198_10.prefab_name ~= "" and arg_195_1.actors_[var_198_10.prefab_name] ~= nil then
						local var_198_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_10.prefab_name].transform, "story_v_out_417071", "417071046", "story_v_out_417071.awb")

						arg_195_1:RecordAudio("417071046", var_198_15)
						arg_195_1:RecordAudio("417071046", var_198_15)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_417071", "417071046", "story_v_out_417071.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_417071", "417071046", "story_v_out_417071.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_16 = math.max(var_198_9, arg_195_1.talkMaxDuration)

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_16 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_8) / var_198_16

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_8 + var_198_16 and arg_195_1.time_ < var_198_8 + var_198_16 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play417071047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 417071047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play417071048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1034"]) and arg_199_1.var_.actorSpriteComps1034 == nil then
				arg_199_1.var_.actorSpriteComps1034 = arg_199_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_0 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1034"]) then
				if arg_199_1.var_.actorSpriteComps1034 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								iter_202_1.color = Color.New(Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_0), Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_0), (Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_0)))
							else
								local var_202_1 = Mathf.Lerp(iter_202_1.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_0)

								iter_202_1.color = Color.New(var_202_1, var_202_1, var_202_1)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1034"]) and arg_199_1.var_.actorSpriteComps1034 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_202_3 then
						iter_202_3.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps1034 = nil
			end

			local var_202_2 = arg_199_1.actors_["1034"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1034 = var_202_2.localPosition
				var_202_2.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("1034", 7)

				for iter_202_4 = 0, var_202_2.childCount - 1 do
					local var_202_3 = var_202_2:GetChild(iter_202_4)

					if var_202_3.name == "" or not string.find(var_202_3.name, "split") then
						var_202_3.gameObject:SetActive(true)
					else
						var_202_3.gameObject:SetActive(false)
					end
				end
			end

			local var_202_4 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				var_202_2.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_199_1.time_ - 0) / var_202_4)
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				var_202_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_202_5 = arg_199_1.actors_["10128"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10128 = var_202_5.localPosition
				var_202_5.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10128", 7)

				for iter_202_5 = 0, var_202_5.childCount - 1 do
					local var_202_6 = var_202_5:GetChild(iter_202_5)

					if var_202_6.name == "" or not string.find(var_202_6.name, "split") then
						var_202_6.gameObject:SetActive(true)
					else
						var_202_6.gameObject:SetActive(false)
					end
				end
			end

			local var_202_7 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				var_202_5.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_199_1.time_ - 0) / var_202_7)
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				var_202_5.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_202_8 = 0
			local var_202_9 = 1.75

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_10 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(417071047).content)

				arg_199_1.text_.text = var_202_10

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_12 = 70 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_10) / 70)

				if (70 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_10) / 70)) > 0 and var_202_9 < var_202_12 then
					arg_199_1.talkMaxDuration = var_202_12

					if var_202_12 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_8
					end
				end

				arg_199_1.text_.text = var_202_10
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_13 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_13 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_13

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_13 and arg_199_1.time_ < var_202_8 + var_202_13 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play417071048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 417071048
		arg_203_1.duration_ = 7.43

		local var_203_0 = {
			zh = 7.4,
			ja = 7.433
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
				arg_203_0:Play417071049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1034"]) and arg_203_1.var_.actorSpriteComps1034 == nil then
				arg_203_1.var_.actorSpriteComps1034 = arg_203_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1034"]) then
				if arg_203_1.var_.actorSpriteComps1034 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								iter_206_1.color = Color.New(Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor1.r, (arg_203_1.time_ - 0) / var_206_0), Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor1.g, (arg_203_1.time_ - 0) / var_206_0), (Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor1.b, (arg_203_1.time_ - 0) / var_206_0)))
							else
								local var_206_1 = Mathf.Lerp(iter_206_1.color.r, 1, (arg_203_1.time_ - 0) / var_206_0)

								iter_206_1.color = Color.New(var_206_1, var_206_1, var_206_1)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1034"]) and arg_203_1.var_.actorSpriteComps1034 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps1034 = nil
			end

			local var_206_2 = arg_203_1.actors_["1034"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1034 = var_206_2.localPosition
				var_206_2.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1034", 3)

				for iter_206_4 = 0, var_206_2.childCount - 1 do
					local var_206_3 = var_206_2:GetChild(iter_206_4)

					if var_206_3.name == "split_7" or not string.find(var_206_3.name, "split") then
						var_206_3.gameObject:SetActive(true)
					else
						var_206_3.gameObject:SetActive(false)
					end
				end
			end

			local var_206_4 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				var_206_2.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_203_1.time_ - 0) / var_206_4)
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				var_206_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_206_5 = 0
			local var_206_6 = 0.875

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_7 = arg_203_1:GetWordFromCfg(417071048)
				local var_206_8 = arg_203_1:FormatText(var_206_7.content)

				arg_203_1.text_.text = var_206_8

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_10 = 35 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 35)

				if (35 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 35)) > 0 and var_206_6 < var_206_10 then
					arg_203_1.talkMaxDuration = var_206_10

					if var_206_10 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_5
					end
				end

				arg_203_1.text_.text = var_206_8
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071048", "story_v_out_417071.awb") ~= 0 then
					local var_206_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071048", "story_v_out_417071.awb") / 1000

					if var_206_11 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_5
					end

					if var_206_7.prefab_name ~= "" and arg_203_1.actors_[var_206_7.prefab_name] ~= nil then
						local var_206_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_7.prefab_name].transform, "story_v_out_417071", "417071048", "story_v_out_417071.awb")

						arg_203_1:RecordAudio("417071048", var_206_12)
						arg_203_1:RecordAudio("417071048", var_206_12)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_417071", "417071048", "story_v_out_417071.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_417071", "417071048", "story_v_out_417071.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_13 = math.max(var_206_6, arg_203_1.talkMaxDuration)

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_13 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_5) / var_206_13

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_5 + var_206_13 and arg_203_1.time_ < var_206_5 + var_206_13 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play417071049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 417071049
		arg_207_1.duration_ = 5.33

		local var_207_0 = {
			zh = 3.733,
			ja = 5.333
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
				arg_207_0:Play417071050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1034 = arg_207_1.actors_["1034"].transform.localPosition
				arg_207_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("1034", 3)

				for iter_210_0 = 0, arg_207_1.actors_["1034"].transform.childCount - 1 do
					local var_210_0 = arg_207_1.actors_["1034"].transform:GetChild(iter_210_0)

					if var_210_0.name == "split_6" or not string.find(var_210_0.name, "split") then
						var_210_0.gameObject:SetActive(true)
					else
						var_210_0.gameObject:SetActive(false)
					end
				end
			end

			local var_210_1 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_1 then
				arg_207_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_207_1.time_ - 0) / var_210_1)
			end

			if arg_207_1.time_ >= 0 + var_210_1 and arg_207_1.time_ < 0 + var_210_1 + arg_210_0 then
				arg_207_1.actors_["1034"].transform.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_210_2 = 0
			local var_210_3 = 0.425

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_4 = arg_207_1:GetWordFromCfg(417071049)
				local var_210_5 = arg_207_1:FormatText(var_210_4.content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_7 = 17 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 17)

				if (17 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 17)) > 0 and var_210_3 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_2
					end
				end

				arg_207_1.text_.text = var_210_5
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071049", "story_v_out_417071.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071049", "story_v_out_417071.awb") / 1000

					if var_210_8 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_2
					end

					if var_210_4.prefab_name ~= "" and arg_207_1.actors_[var_210_4.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_4.prefab_name].transform, "story_v_out_417071", "417071049", "story_v_out_417071.awb")

						arg_207_1:RecordAudio("417071049", var_210_9)
						arg_207_1:RecordAudio("417071049", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_417071", "417071049", "story_v_out_417071.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_417071", "417071049", "story_v_out_417071.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_3, arg_207_1.talkMaxDuration)

			if var_210_2 <= arg_207_1.time_ and arg_207_1.time_ < var_210_2 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_2) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_2 + var_210_10 and arg_207_1.time_ < var_210_2 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play417071050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 417071050
		arg_211_1.duration_ = 1.33

		local var_211_0 = {
			zh = 0.999999999999,
			ja = 1.333
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
				arg_211_0:Play417071051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1034"]) and arg_211_1.var_.actorSpriteComps1034 == nil then
				arg_211_1.var_.actorSpriteComps1034 = arg_211_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_0 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1034"]) then
				if arg_211_1.var_.actorSpriteComps1034 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								iter_214_1.color = Color.New(Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor2.r, (arg_211_1.time_ - 0) / var_214_0), Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor2.g, (arg_211_1.time_ - 0) / var_214_0), (Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor2.b, (arg_211_1.time_ - 0) / var_214_0)))
							else
								local var_214_1 = Mathf.Lerp(iter_214_1.color.r, 0.5, (arg_211_1.time_ - 0) / var_214_0)

								iter_214_1.color = Color.New(var_214_1, var_214_1, var_214_1)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1034"]) and arg_211_1.var_.actorSpriteComps1034 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_214_3 then
						iter_214_3.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_211_1.var_.actorSpriteComps1034 = nil
			end

			local var_214_2 = 0
			local var_214_3 = 0.075

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_4 = arg_211_1:GetWordFromCfg(417071050)
				local var_214_5 = arg_211_1:FormatText(var_214_4.content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 3 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 3)

				if (3 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 3)) > 0 and var_214_3 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071050", "story_v_out_417071.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071050", "story_v_out_417071.awb") / 1000

					if var_214_8 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_2
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_out_417071", "417071050", "story_v_out_417071.awb")

						arg_211_1:RecordAudio("417071050", var_214_9)
						arg_211_1:RecordAudio("417071050", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_417071", "417071050", "story_v_out_417071.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_417071", "417071050", "story_v_out_417071.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_10 and arg_211_1.time_ < var_214_2 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play417071051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 417071051
		arg_215_1.duration_ = 4.97

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play417071052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 1.63266666666667 < arg_215_1.time_ and arg_215_1.time_ <= 1.63266666666667 + arg_218_0 then
				arg_215_1.var_.moveOldPos10128 = arg_215_1.actors_["10128"].transform.localPosition
				arg_215_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("10128", 7)

				for iter_218_0 = 0, arg_215_1.actors_["10128"].transform.childCount - 1 do
					local var_218_0 = arg_215_1.actors_["10128"].transform:GetChild(iter_218_0)

					if var_218_0.name == "" or not string.find(var_218_0.name, "split") then
						var_218_0.gameObject:SetActive(true)
					else
						var_218_0.gameObject:SetActive(false)
					end
				end
			end

			local var_218_1 = 0.001

			if 1.63266666666667 <= arg_215_1.time_ and arg_215_1.time_ < 1.63266666666667 + var_218_1 then
				arg_215_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_215_1.time_ - 1.63266666666667) / var_218_1)
			end

			if arg_215_1.time_ >= 1.63266666666667 + var_218_1 and arg_215_1.time_ < 1.63266666666667 + var_218_1 + arg_218_0 then
				arg_215_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_218_2 = arg_215_1.actors_["1034"].transform

			if 1.63266666666667 < arg_215_1.time_ and arg_215_1.time_ <= 1.63266666666667 + arg_218_0 then
				arg_215_1.var_.moveOldPos1034 = var_218_2.localPosition
				var_218_2.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1034", 7)

				for iter_218_1 = 0, var_218_2.childCount - 1 do
					local var_218_3 = var_218_2:GetChild(iter_218_1)

					if var_218_3.name == "" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if 1.63266666666667 <= arg_215_1.time_ and arg_215_1.time_ < 1.63266666666667 + var_218_4 then
				var_218_2.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_215_1.time_ - 1.63266666666667) / var_218_4)
			end

			if arg_215_1.time_ >= 1.63266666666667 + var_218_4 and arg_215_1.time_ < 1.63266666666667 + var_218_4 + arg_218_0 then
				var_218_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.66666666666667 < arg_215_1.time_ and arg_215_1.time_ <= 1.66666666666667 + arg_218_0 then
				arg_215_1.cswbg_:SetActive(true)

				local var_218_5 = arg_215_1.cswt_:GetComponent("RectTransform")

				arg_215_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_218_5.offsetMin = Vector2.New(400, 105)
				var_218_5.offsetMax = Vector2.New(-400, -200)
				arg_215_1.cswt_.text = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(419101).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.cswt_)

				arg_215_1.cswt_.fontSize = 120
				arg_215_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_215_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_215_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1.66666666666667 < arg_215_1.time_ and arg_215_1.time_ <= 1.66666666666667 + arg_218_0 then
				local var_218_6 = arg_215_1.fswbg_.transform:Find("textbox/adapt/content") or arg_215_1.fswbg_.transform:Find("textbox/content")
				local var_218_7 = arg_215_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_218_8 = var_218_6:GetComponent("RectTransform")

				var_218_6:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_218_8.offsetMin = Vector2.New(0, 0)
				var_218_8.offsetMax = Vector2.New(0, 0)
			end

			if 1.66666666666667 < arg_215_1.time_ and arg_215_1.time_ <= 1.66666666666667 + arg_218_0 then
				arg_215_1.fswbg_:SetActive(true)
				arg_215_1.dialog_:SetActive(false)

				arg_215_1.fswtw_.percent = 0
				arg_215_1.fswt_.text = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(417071051).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.fswt_)

				arg_215_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_215_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_215_1.fswtw_:SetDirty()

				arg_215_1.typewritterCharCountI18N = 0

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_9 = 2.66666666666667

			if 2.66666666666667 < arg_215_1.time_ and arg_215_1.time_ <= var_218_9 + arg_218_0 then
				arg_215_1.var_.oldValueTypewriter = arg_215_1.fswtw_.percent

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_10 = 31
			local var_218_11 = 2.06666666666667
			local var_218_12, var_218_13 = arg_215_1:GetPercentByPara(arg_215_1:FormatText(arg_215_1:GetWordFromCfg(417071051).content), 1)

			if var_218_9 < arg_215_1.time_ and arg_215_1.time_ <= var_218_9 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				local var_218_14 = var_218_10 <= 0 and var_218_11 or var_218_11 * ((var_218_13 - arg_215_1.typewritterCharCountI18N) / var_218_10)

				if (var_218_10 <= 0 and var_218_11 or var_218_11 * ((var_218_13 - arg_215_1.typewritterCharCountI18N) / var_218_10)) > 0 and var_218_11 < var_218_14 then
					arg_215_1.talkMaxDuration = var_218_14

					if var_218_14 + var_218_9 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_9
					end
				end
			end

			local var_218_15 = math.max(2.06666666666667, arg_215_1.talkMaxDuration)

			if var_218_9 <= arg_215_1.time_ and arg_215_1.time_ < var_218_9 + var_218_15 then
				arg_215_1.fswtw_.percent = Mathf.Lerp(arg_215_1.var_.oldValueTypewriter, var_218_12, (arg_215_1.time_ - var_218_9) / var_218_15)
				arg_215_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_215_1.fswtw_:SetDirty()
			end

			if arg_215_1.time_ >= var_218_9 + var_218_15 and arg_215_1.time_ < var_218_9 + var_218_15 + arg_218_0 then
				arg_215_1.fswtw_.percent = var_218_12

				arg_215_1.fswtw_:SetDirty()
				arg_215_1:ShowNextGo(true)

				arg_215_1.typewritterCharCountI18N = var_218_13
			end

			local var_218_16 = 0

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_16 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_17 = 1.66666666666667

			if var_218_16 <= arg_215_1.time_ and arg_215_1.time_ < var_218_16 + var_218_17 then
				local var_218_18 = Color.New(0, 0, 0)

				var_218_18.a = Mathf.Lerp(0, 1, (arg_215_1.time_ - var_218_16) / var_218_17)
				arg_215_1.mask_.color = var_218_18
			end

			if arg_215_1.time_ >= var_218_16 + var_218_17 and arg_215_1.time_ < var_218_16 + var_218_17 + arg_218_0 then
				local var_218_19 = Color.New(0, 0, 0)

				var_218_19.a = 1
				arg_215_1.mask_.color = var_218_19
			end

			local var_218_20 = 1.66666666666667

			if 1.66666666666667 < arg_215_1.time_ and arg_215_1.time_ <= var_218_20 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_21 = 2

			if var_218_20 <= arg_215_1.time_ and arg_215_1.time_ < var_218_20 + var_218_21 then
				local var_218_22 = Color.New(0, 0, 0)

				var_218_22.a = Mathf.Lerp(1, 0, (arg_215_1.time_ - var_218_20) / var_218_21)
				arg_215_1.mask_.color = var_218_22
			end

			if arg_215_1.time_ >= var_218_20 + var_218_21 and arg_215_1.time_ < var_218_20 + var_218_21 + arg_218_0 then
				local var_218_23 = Color.New(0, 0, 0)

				arg_215_1.mask_.enabled = false
				var_218_23.a = 0
				arg_215_1.mask_.color = var_218_23
			end

			local var_218_24 = "STblack"

			if arg_215_1.bgs_.STblack == nil then
				local var_218_25 = Object.Instantiate(arg_215_1.paintGo_)

				var_218_25:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_218_24)
				var_218_25.name = var_218_24
				var_218_25.transform.parent = arg_215_1.stage_.transform
				var_218_25.transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.bgs_[var_218_24] = var_218_25
			end

			if 1.66666666666667 < arg_215_1.time_ and arg_215_1.time_ <= 1.66666666666667 + arg_218_0 then
				local var_218_26 = arg_215_1.bgs_.STblack

				arg_215_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_218_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_27 = var_218_26:GetComponent("SpriteRenderer")

				if var_218_27 and var_218_27.sprite then
					local var_218_28 = 2 * (var_218_26.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_218_26.transform.localScale = Vector3.New(var_218_28 / var_218_27.sprite.bounds.size.y < var_218_28 * manager.ui.mainCameraCom_.aspect / var_218_27.sprite.bounds.size.x and var_218_28 * manager.ui.mainCameraCom_.aspect / var_218_27.sprite.bounds.size.x or var_218_28 / var_218_27.sprite.bounds.size.y, var_218_28 / var_218_27.sprite.bounds.size.y < var_218_28 * manager.ui.mainCameraCom_.aspect / var_218_27.sprite.bounds.size.x and var_218_28 * manager.ui.mainCameraCom_.aspect / var_218_27.sprite.bounds.size.x or var_218_28 / var_218_27.sprite.bounds.size.y, 0)
				end

				for iter_218_2, iter_218_3 in pairs(arg_215_1.bgs_) do
					if iter_218_2 ~= "STblack" then
						iter_218_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_29 = 2.66666666666667
			local var_218_30 = manager.audio:GetVoiceLength("story_v_out_417071", "417071051", "") / 1000

			if var_218_30 > 0 and 2.3 < var_218_30 and var_218_30 + var_218_29 > arg_215_1.duration_ then
				arg_215_1.duration_ = var_218_30 + var_218_29
			end

			if var_218_29 < arg_215_1.time_ and arg_215_1.time_ <= var_218_29 + arg_218_0 then
				arg_215_1:AudioAction("play", "voice", "story_v_out_417071", "417071051", "")
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.63266666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.63266666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play417071052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 417071052
		arg_219_1.duration_ = 2.33

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play417071053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.fswbg_:SetActive(true)
				arg_219_1.dialog_:SetActive(false)

				arg_219_1.fswtw_.percent = 0
				arg_219_1.fswt_.text = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(417071052).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.fswt_)

				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_219_1.fswtw_:SetDirty()

				arg_219_1.typewritterCharCountI18N = 0

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_0 = 0.034

			if 0.034 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.var_.oldValueTypewriter = arg_219_1.fswtw_.percent

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_1 = 27
			local var_222_2 = 1.8
			local var_222_3, var_222_4 = arg_219_1:GetPercentByPara(arg_219_1:FormatText(arg_219_1:GetWordFromCfg(417071052).content), 1)

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				local var_222_5 = var_222_1 <= 0 and var_222_2 or var_222_2 * ((var_222_4 - arg_219_1.typewritterCharCountI18N) / var_222_1)

				if (var_222_1 <= 0 and var_222_2 or var_222_2 * ((var_222_4 - arg_219_1.typewritterCharCountI18N) / var_222_1)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_0
					end
				end
			end

			local var_222_6 = math.max(1.8, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_6 then
				arg_219_1.fswtw_.percent = Mathf.Lerp(arg_219_1.var_.oldValueTypewriter, var_222_3, (arg_219_1.time_ - var_222_0) / var_222_6)
				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.fswtw_:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_6 and arg_219_1.time_ < var_222_0 + var_222_6 + arg_222_0 then
				arg_219_1.fswtw_.percent = var_222_3

				arg_219_1.fswtw_:SetDirty()
				arg_219_1:ShowNextGo(true)

				arg_219_1.typewritterCharCountI18N = var_222_4
			end

			local var_222_7 = 0.034
			local var_222_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071052", "") / 1000

			if var_222_8 > 0 and 2.3 < var_222_8 and var_222_8 + var_222_7 > arg_219_1.duration_ then
				arg_219_1.duration_ = var_222_8 + var_222_7
			end

			if var_222_7 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
				arg_219_1:AudioAction("play", "voice", "story_v_out_417071", "417071052", "")
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play417071053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 417071053
		arg_223_1.duration_ = 4.83

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play417071054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.fswbg_:SetActive(true)
				arg_223_1.dialog_:SetActive(false)

				arg_223_1.fswtw_.percent = 0
				arg_223_1.fswt_.text = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(417071053).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.fswt_)

				arg_223_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_223_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_223_1.fswtw_:SetDirty()

				arg_223_1.typewritterCharCountI18N = 0

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_0 = 0.166666666666667

			if 0.166666666666667 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.var_.oldValueTypewriter = arg_223_1.fswtw_.percent

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_1 = 24
			local var_226_2 = 1.6
			local var_226_3, var_226_4 = arg_223_1:GetPercentByPara(arg_223_1:FormatText(arg_223_1:GetWordFromCfg(417071053).content), 1)

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				local var_226_5 = var_226_1 <= 0 and var_226_2 or var_226_2 * ((var_226_4 - arg_223_1.typewritterCharCountI18N) / var_226_1)

				if (var_226_1 <= 0 and var_226_2 or var_226_2 * ((var_226_4 - arg_223_1.typewritterCharCountI18N) / var_226_1)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_0
					end
				end
			end

			local var_226_6 = math.max(1.6, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_6 then
				arg_223_1.fswtw_.percent = Mathf.Lerp(arg_223_1.var_.oldValueTypewriter, var_226_3, (arg_223_1.time_ - var_226_0) / var_226_6)
				arg_223_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.fswtw_:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_6 and arg_223_1.time_ < var_226_0 + var_226_6 + arg_226_0 then
				arg_223_1.fswtw_.percent = var_226_3

				arg_223_1.fswtw_:SetDirty()
				arg_223_1:ShowNextGo(true)

				arg_223_1.typewritterCharCountI18N = var_226_4
			end

			local var_226_7 = 0.166666666666667
			local var_226_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071053", "") / 1000

			if var_226_8 > 0 and 4.666 < var_226_8 and var_226_8 + var_226_7 > arg_223_1.duration_ then
				arg_223_1.duration_ = var_226_8 + var_226_7
			end

			if var_226_7 < arg_223_1.time_ and arg_223_1.time_ <= var_226_7 + arg_226_0 then
				arg_223_1:AudioAction("play", "voice", "story_v_out_417071", "417071053", "")
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play417071054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 417071054
		arg_227_1.duration_ = 4.87

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play417071055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.fswbg_:SetActive(true)
				arg_227_1.dialog_:SetActive(false)

				arg_227_1.fswtw_.percent = 0
				arg_227_1.fswt_.text = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(417071054).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.fswt_)

				arg_227_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_227_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_227_1.fswtw_:SetDirty()

				arg_227_1.typewritterCharCountI18N = 0

				SetActive(arg_227_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_227_1:ShowNextGo(false)
			end

			local var_230_0 = 0.2

			if 0.2 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.var_.oldValueTypewriter = arg_227_1.fswtw_.percent

				SetActive(arg_227_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_227_1:ShowNextGo(false)
			end

			local var_230_1 = 17
			local var_230_2 = 1.13333333333333
			local var_230_3, var_230_4 = arg_227_1:GetPercentByPara(arg_227_1:FormatText(arg_227_1:GetWordFromCfg(417071054).content), 1)

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				local var_230_5 = var_230_1 <= 0 and var_230_2 or var_230_2 * ((var_230_4 - arg_227_1.typewritterCharCountI18N) / var_230_1)

				if (var_230_1 <= 0 and var_230_2 or var_230_2 * ((var_230_4 - arg_227_1.typewritterCharCountI18N) / var_230_1)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_0
					end
				end
			end

			local var_230_6 = math.max(1.13333333333333, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_6 then
				arg_227_1.fswtw_.percent = Mathf.Lerp(arg_227_1.var_.oldValueTypewriter, var_230_3, (arg_227_1.time_ - var_230_0) / var_230_6)
				arg_227_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_227_1.fswtw_:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_6 and arg_227_1.time_ < var_230_0 + var_230_6 + arg_230_0 then
				arg_227_1.fswtw_.percent = var_230_3

				arg_227_1.fswtw_:SetDirty()
				arg_227_1:ShowNextGo(true)

				arg_227_1.typewritterCharCountI18N = var_230_4
			end

			local var_230_7 = 0.2
			local var_230_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071054", "") / 1000

			if var_230_8 > 0 and 4.666 < var_230_8 and var_230_8 + var_230_7 > arg_227_1.duration_ then
				arg_227_1.duration_ = var_230_8 + var_230_7
			end

			if var_230_7 < arg_227_1.time_ and arg_227_1.time_ <= var_230_7 + arg_230_0 then
				arg_227_1:AudioAction("play", "voice", "story_v_out_417071", "417071054", "")
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play417071055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 417071055
		arg_231_1.duration_ = 4.8

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play417071056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.fswbg_:SetActive(true)
				arg_231_1.dialog_:SetActive(false)

				arg_231_1.fswtw_.percent = 0
				arg_231_1.fswt_.text = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(417071055).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.fswt_)

				arg_231_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_231_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_231_1.fswtw_:SetDirty()

				arg_231_1.typewritterCharCountI18N = 0

				SetActive(arg_231_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_231_1:ShowNextGo(false)
			end

			local var_234_0 = 0.133333333333333

			if 0.133333333333333 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.var_.oldValueTypewriter = arg_231_1.fswtw_.percent

				SetActive(arg_231_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_231_1:ShowNextGo(false)
			end

			local var_234_1 = 22
			local var_234_2 = 1.46666666666667
			local var_234_3, var_234_4 = arg_231_1:GetPercentByPara(arg_231_1:FormatText(arg_231_1:GetWordFromCfg(417071055).content), 1)

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				local var_234_5 = var_234_1 <= 0 and var_234_2 or var_234_2 * ((var_234_4 - arg_231_1.typewritterCharCountI18N) / var_234_1)

				if (var_234_1 <= 0 and var_234_2 or var_234_2 * ((var_234_4 - arg_231_1.typewritterCharCountI18N) / var_234_1)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_0
					end
				end
			end

			local var_234_6 = math.max(1.46666666666667, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_6 then
				arg_231_1.fswtw_.percent = Mathf.Lerp(arg_231_1.var_.oldValueTypewriter, var_234_3, (arg_231_1.time_ - var_234_0) / var_234_6)
				arg_231_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_231_1.fswtw_:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_6 and arg_231_1.time_ < var_234_0 + var_234_6 + arg_234_0 then
				arg_231_1.fswtw_.percent = var_234_3

				arg_231_1.fswtw_:SetDirty()
				arg_231_1:ShowNextGo(true)

				arg_231_1.typewritterCharCountI18N = var_234_4
			end

			local var_234_7 = 0.133333333333333
			local var_234_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071055", "") / 1000

			if var_234_8 > 0 and 4.666 < var_234_8 and var_234_8 + var_234_7 > arg_231_1.duration_ then
				arg_231_1.duration_ = var_234_8 + var_234_7
			end

			if var_234_7 < arg_231_1.time_ and arg_231_1.time_ <= var_234_7 + arg_234_0 then
				arg_231_1:AudioAction("play", "voice", "story_v_out_417071", "417071055", "")
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play417071056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 417071056
		arg_235_1.duration_ = 9.59

		local var_235_0 = {
			zh = 7.75766666666667,
			ja = 9.59166666666667
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
				arg_235_0:Play417071057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 1.759 < arg_235_1.time_ and arg_235_1.time_ <= 1.759 + arg_238_0 then
				local var_238_0 = arg_235_1.bgs_.ST73

				arg_235_1.bgs_.ST73.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_238_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_238_1 = var_238_0:GetComponent("SpriteRenderer")

				if var_238_1 and var_238_1.sprite then
					local var_238_2 = 2 * (var_238_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_238_0.transform.localScale = Vector3.New(var_238_2 / var_238_1.sprite.bounds.size.y < var_238_2 * manager.ui.mainCameraCom_.aspect / var_238_1.sprite.bounds.size.x and var_238_2 * manager.ui.mainCameraCom_.aspect / var_238_1.sprite.bounds.size.x or var_238_2 / var_238_1.sprite.bounds.size.y, var_238_2 / var_238_1.sprite.bounds.size.y < var_238_2 * manager.ui.mainCameraCom_.aspect / var_238_1.sprite.bounds.size.x and var_238_2 * manager.ui.mainCameraCom_.aspect / var_238_1.sprite.bounds.size.x or var_238_2 / var_238_1.sprite.bounds.size.y, 0)
				end

				for iter_238_0, iter_238_1 in pairs(arg_235_1.bgs_) do
					if iter_238_0 ~= "ST73" then
						iter_238_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_238_3 = arg_235_1.actors_["10128"]

			if 3.95833333333333 < arg_235_1.time_ and arg_235_1.time_ <= 3.95833333333333 + arg_238_0 and not isNil(var_238_3) and arg_235_1.var_.actorSpriteComps10128 == nil then
				arg_235_1.var_.actorSpriteComps10128 = var_238_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_4 = 0.2

			if 3.95833333333333 <= arg_235_1.time_ and arg_235_1.time_ < 3.95833333333333 + var_238_4 and not isNil(var_238_3) then
				if arg_235_1.var_.actorSpriteComps10128 then
					for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_238_3 then
							if arg_235_1.isInRecall_ then
								iter_238_3.color = Color.New(Mathf.Lerp(iter_238_3.color.r, arg_235_1.hightColor1.r, (arg_235_1.time_ - 3.95833333333333) / var_238_4), Mathf.Lerp(iter_238_3.color.g, arg_235_1.hightColor1.g, (arg_235_1.time_ - 3.95833333333333) / var_238_4), (Mathf.Lerp(iter_238_3.color.b, arg_235_1.hightColor1.b, (arg_235_1.time_ - 3.95833333333333) / var_238_4)))
							else
								local var_238_5 = Mathf.Lerp(iter_238_3.color.r, 1, (arg_235_1.time_ - 3.95833333333333) / var_238_4)

								iter_238_3.color = Color.New(var_238_5, var_238_5, var_238_5)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 3.95833333333333 + var_238_4 and arg_235_1.time_ < 3.95833333333333 + var_238_4 + arg_238_0 and not isNil(var_238_3) and arg_235_1.var_.actorSpriteComps10128 then
				for iter_238_4, iter_238_5 in pairs(arg_235_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_238_5 then
						iter_238_5.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_235_1.var_.actorSpriteComps10128 = nil
			end

			local var_238_6 = arg_235_1.actors_["10128"].transform

			if 3.95833333333333 < arg_235_1.time_ and arg_235_1.time_ <= 3.95833333333333 + arg_238_0 then
				arg_235_1.var_.moveOldPos10128 = var_238_6.localPosition
				var_238_6.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10128", 4)

				for iter_238_6 = 0, var_238_6.childCount - 1 do
					local var_238_7 = var_238_6:GetChild(iter_238_6)

					if var_238_7.name == "" or not string.find(var_238_7.name, "split") then
						var_238_7.gameObject:SetActive(true)
					else
						var_238_7.gameObject:SetActive(false)
					end
				end
			end

			local var_238_8 = 0.001

			if 3.95833333333333 <= arg_235_1.time_ and arg_235_1.time_ < 3.95833333333333 + var_238_8 then
				var_238_6.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_235_1.time_ - 3.95833333333333) / var_238_8)
			end

			if arg_235_1.time_ >= 3.95833333333333 + var_238_8 and arg_235_1.time_ < 3.95833333333333 + var_238_8 + arg_238_0 then
				var_238_6.localPosition = Vector3.New(390, -347, -300)
			end

			if 1.725 < arg_235_1.time_ and arg_235_1.time_ <= 1.725 + arg_238_0 then
				arg_235_1.cswbg_:SetActive(false)
			end

			if 1.725 < arg_235_1.time_ and arg_235_1.time_ <= 1.725 + arg_238_0 then
				arg_235_1.fswbg_:SetActive(false)
				arg_235_1.dialog_:SetActive(false)
				SetActive(arg_235_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_235_1:ShowNextGo(false)
			end

			if 1.759 < arg_235_1.time_ and arg_235_1.time_ <= 1.759 + arg_238_0 then
				arg_235_1.fswbg_:SetActive(false)
				arg_235_1.dialog_:SetActive(false)
				SetActive(arg_235_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_235_1:ShowNextGo(false)
			end

			local var_238_9 = 0

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_10 = 1.725

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_10 then
				local var_238_11 = Color.New(0, 0, 0)

				var_238_11.a = Mathf.Lerp(0, 1, (arg_235_1.time_ - var_238_9) / var_238_10)
				arg_235_1.mask_.color = var_238_11
			end

			if arg_235_1.time_ >= var_238_9 + var_238_10 and arg_235_1.time_ < var_238_9 + var_238_10 + arg_238_0 then
				local var_238_12 = Color.New(0, 0, 0)

				var_238_12.a = 1
				arg_235_1.mask_.color = var_238_12
			end

			local var_238_13 = 1.725

			if 1.725 < arg_235_1.time_ and arg_235_1.time_ <= var_238_13 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_14 = 2.46666666666667

			if var_238_13 <= arg_235_1.time_ and arg_235_1.time_ < var_238_13 + var_238_14 then
				local var_238_15 = Color.New(0, 0, 0)

				var_238_15.a = Mathf.Lerp(1, 0, (arg_235_1.time_ - var_238_13) / var_238_14)
				arg_235_1.mask_.color = var_238_15
			end

			if arg_235_1.time_ >= var_238_13 + var_238_14 and arg_235_1.time_ < var_238_13 + var_238_14 + arg_238_0 then
				local var_238_16 = Color.New(0, 0, 0)

				arg_235_1.mask_.enabled = false
				var_238_16.a = 0
				arg_235_1.mask_.color = var_238_16
			end

			if 3.95833333333333 < arg_235_1.time_ and arg_235_1.time_ <= 3.95833333333333 + arg_238_0 then
				local var_238_17 = arg_235_1.actors_["10128"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_238_17 then
					arg_235_1.var_.alphaOldValue10128 = var_238_17.alpha
					arg_235_1.var_.characterEffect10128 = var_238_17
				end

				arg_235_1.var_.alphaOldValue10128 = 0
			end

			local var_238_18 = 0.2

			if 3.95833333333333 <= arg_235_1.time_ and arg_235_1.time_ < 3.95833333333333 + var_238_18 then
				if arg_235_1.var_.characterEffect10128 then
					arg_235_1.var_.characterEffect10128.alpha = Mathf.Lerp(arg_235_1.var_.alphaOldValue10128, 1, (arg_235_1.time_ - 3.95833333333333) / var_238_18)
				end
			end

			if arg_235_1.time_ >= 3.95833333333333 + var_238_18 and arg_235_1.time_ < 3.95833333333333 + var_238_18 + arg_238_0 and arg_235_1.var_.characterEffect10128 then
				arg_235_1.var_.characterEffect10128.alpha = 1
			end

			if arg_235_1.frameCnt_ <= 1 then
				arg_235_1.dialog_:SetActive(false)
			end

			local var_238_19 = 4.19166666666667
			local var_238_20 = 0.425

			if 4.19166666666667 < arg_235_1.time_ and arg_235_1.time_ <= var_238_19 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				arg_235_1.dialog_:SetActive(true)

				arg_235_1.dialogCg_.alpha = 0

				local var_238_21 = LeanTween.value(arg_235_1.dialog_, 0, 1, 0.3)

				var_238_21:setOnUpdate(LuaHelper.FloatAction(function(arg_239_0)
					arg_235_1.dialogCg_.alpha = arg_239_0
				end))
				var_238_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_235_1.dialog_)
					var_238_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_235_1.duration_ = arg_235_1.duration_ + 0.3

				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_22 = arg_235_1:GetWordFromCfg(417071056)
				local var_238_23 = arg_235_1:FormatText(var_238_22.content)

				arg_235_1.text_.text = var_238_23

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_25 = 17 <= 0 and var_238_20 or var_238_20 * (utf8.len(var_238_23) / 17)

				if (17 <= 0 and var_238_20 or var_238_20 * (utf8.len(var_238_23) / 17)) > 0 and var_238_20 < var_238_25 then
					arg_235_1.talkMaxDuration = var_238_25
					var_238_19 = var_238_19 + 0.3

					if var_238_25 + var_238_19 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_25 + var_238_19
					end
				end

				arg_235_1.text_.text = var_238_23
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071056", "story_v_out_417071.awb") ~= 0 then
					local var_238_26 = manager.audio:GetVoiceLength("story_v_out_417071", "417071056", "story_v_out_417071.awb") / 1000

					if var_238_26 + var_238_19 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_26 + var_238_19
					end

					if var_238_22.prefab_name ~= "" and arg_235_1.actors_[var_238_22.prefab_name] ~= nil then
						local var_238_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_22.prefab_name].transform, "story_v_out_417071", "417071056", "story_v_out_417071.awb")

						arg_235_1:RecordAudio("417071056", var_238_27)
						arg_235_1:RecordAudio("417071056", var_238_27)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_417071", "417071056", "story_v_out_417071.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_417071", "417071056", "story_v_out_417071.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_28 = var_238_19 + 0.3
			local var_238_29 = math.max(var_238_20, arg_235_1.talkMaxDuration)

			if var_238_19 + 0.3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_28 + var_238_29 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_28) / var_238_29

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_28 + var_238_29 and arg_235_1.time_ < var_238_28 + var_238_29 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.95833333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play417071057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 417071057
		arg_241_1.duration_ = 10.3

		local var_241_0 = {
			zh = 7.3,
			ja = 10.3
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play417071058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1034"]) and arg_241_1.var_.actorSpriteComps1034 == nil then
				arg_241_1.var_.actorSpriteComps1034 = arg_241_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_0 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1034"]) then
				if arg_241_1.var_.actorSpriteComps1034 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_244_1 then
							if arg_241_1.isInRecall_ then
								iter_244_1.color = Color.New(Mathf.Lerp(iter_244_1.color.r, arg_241_1.hightColor1.r, (arg_241_1.time_ - 0) / var_244_0), Mathf.Lerp(iter_244_1.color.g, arg_241_1.hightColor1.g, (arg_241_1.time_ - 0) / var_244_0), (Mathf.Lerp(iter_244_1.color.b, arg_241_1.hightColor1.b, (arg_241_1.time_ - 0) / var_244_0)))
							else
								local var_244_1 = Mathf.Lerp(iter_244_1.color.r, 1, (arg_241_1.time_ - 0) / var_244_0)

								iter_244_1.color = Color.New(var_244_1, var_244_1, var_244_1)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1034"]) and arg_241_1.var_.actorSpriteComps1034 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_244_3 then
						iter_244_3.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_241_1.var_.actorSpriteComps1034 = nil
			end

			local var_244_2 = arg_241_1.actors_["10128"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps10128 == nil then
				arg_241_1.var_.actorSpriteComps10128 = var_244_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_3 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.actorSpriteComps10128 then
					for iter_244_4, iter_244_5 in pairs(arg_241_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_244_5 then
							if arg_241_1.isInRecall_ then
								iter_244_5.color = Color.New(Mathf.Lerp(iter_244_5.color.r, arg_241_1.hightColor2.r, (arg_241_1.time_ - 0) / var_244_3), Mathf.Lerp(iter_244_5.color.g, arg_241_1.hightColor2.g, (arg_241_1.time_ - 0) / var_244_3), (Mathf.Lerp(iter_244_5.color.b, arg_241_1.hightColor2.b, (arg_241_1.time_ - 0) / var_244_3)))
							else
								local var_244_4 = Mathf.Lerp(iter_244_5.color.r, 0.5, (arg_241_1.time_ - 0) / var_244_3)

								iter_244_5.color = Color.New(var_244_4, var_244_4, var_244_4)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps10128 then
				for iter_244_6, iter_244_7 in pairs(arg_241_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_244_7 then
						iter_244_7.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_241_1.var_.actorSpriteComps10128 = nil
			end

			local var_244_5 = arg_241_1.actors_["1034"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1034 = var_244_5.localPosition
				var_244_5.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("1034", 2)

				for iter_244_8 = 0, var_244_5.childCount - 1 do
					local var_244_6 = var_244_5:GetChild(iter_244_8)

					if var_244_6.name == "" or not string.find(var_244_6.name, "split") then
						var_244_6.gameObject:SetActive(true)
					else
						var_244_6.gameObject:SetActive(false)
					end
				end
			end

			local var_244_7 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				var_244_5.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_241_1.time_ - 0) / var_244_7)
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				var_244_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_244_8 = 0
			local var_244_9 = 0.75

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_10 = arg_241_1:GetWordFromCfg(417071057)
				local var_244_11 = arg_241_1:FormatText(var_244_10.content)

				arg_241_1.text_.text = var_244_11

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_13 = 30 <= 0 and var_244_9 or var_244_9 * (utf8.len(var_244_11) / 30)

				if (30 <= 0 and var_244_9 or var_244_9 * (utf8.len(var_244_11) / 30)) > 0 and var_244_9 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_8
					end
				end

				arg_241_1.text_.text = var_244_11
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071057", "story_v_out_417071.awb") ~= 0 then
					local var_244_14 = manager.audio:GetVoiceLength("story_v_out_417071", "417071057", "story_v_out_417071.awb") / 1000

					if var_244_14 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_14 + var_244_8
					end

					if var_244_10.prefab_name ~= "" and arg_241_1.actors_[var_244_10.prefab_name] ~= nil then
						local var_244_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_10.prefab_name].transform, "story_v_out_417071", "417071057", "story_v_out_417071.awb")

						arg_241_1:RecordAudio("417071057", var_244_15)
						arg_241_1:RecordAudio("417071057", var_244_15)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_417071", "417071057", "story_v_out_417071.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_417071", "417071057", "story_v_out_417071.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_16 = math.max(var_244_9, arg_241_1.talkMaxDuration)

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_16 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_8) / var_244_16

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_8 + var_244_16 and arg_241_1.time_ < var_244_8 + var_244_16 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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

		arg_241_1:InitPlayNodeList()
	end,
	Play417071058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 417071058
		arg_245_1.duration_ = 7

		local var_245_0 = {
			zh = 1.833,
			ja = 7
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play417071059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10128"]) and arg_245_1.var_.actorSpriteComps10128 == nil then
				arg_245_1.var_.actorSpriteComps10128 = arg_245_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_0 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10128"]) then
				if arg_245_1.var_.actorSpriteComps10128 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_248_1 then
							if arg_245_1.isInRecall_ then
								iter_248_1.color = Color.New(Mathf.Lerp(iter_248_1.color.r, arg_245_1.hightColor1.r, (arg_245_1.time_ - 0) / var_248_0), Mathf.Lerp(iter_248_1.color.g, arg_245_1.hightColor1.g, (arg_245_1.time_ - 0) / var_248_0), (Mathf.Lerp(iter_248_1.color.b, arg_245_1.hightColor1.b, (arg_245_1.time_ - 0) / var_248_0)))
							else
								local var_248_1 = Mathf.Lerp(iter_248_1.color.r, 1, (arg_245_1.time_ - 0) / var_248_0)

								iter_248_1.color = Color.New(var_248_1, var_248_1, var_248_1)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10128"]) and arg_245_1.var_.actorSpriteComps10128 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_248_3 then
						iter_248_3.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_245_1.var_.actorSpriteComps10128 = nil
			end

			local var_248_2 = arg_245_1.actors_["1034"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.actorSpriteComps1034 == nil then
				arg_245_1.var_.actorSpriteComps1034 = var_248_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_3 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_3 and not isNil(var_248_2) then
				if arg_245_1.var_.actorSpriteComps1034 then
					for iter_248_4, iter_248_5 in pairs(arg_245_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_248_5 then
							if arg_245_1.isInRecall_ then
								iter_248_5.color = Color.New(Mathf.Lerp(iter_248_5.color.r, arg_245_1.hightColor2.r, (arg_245_1.time_ - 0) / var_248_3), Mathf.Lerp(iter_248_5.color.g, arg_245_1.hightColor2.g, (arg_245_1.time_ - 0) / var_248_3), (Mathf.Lerp(iter_248_5.color.b, arg_245_1.hightColor2.b, (arg_245_1.time_ - 0) / var_248_3)))
							else
								local var_248_4 = Mathf.Lerp(iter_248_5.color.r, 0.5, (arg_245_1.time_ - 0) / var_248_3)

								iter_248_5.color = Color.New(var_248_4, var_248_4, var_248_4)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 0 + var_248_3 and arg_245_1.time_ < 0 + var_248_3 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.actorSpriteComps1034 then
				for iter_248_6, iter_248_7 in pairs(arg_245_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_248_7 then
						iter_248_7.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_245_1.var_.actorSpriteComps1034 = nil
			end

			local var_248_5 = 0
			local var_248_6 = 0.225

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_7 = arg_245_1:GetWordFromCfg(417071058)
				local var_248_8 = arg_245_1:FormatText(var_248_7.content)

				arg_245_1.text_.text = var_248_8

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_10 = 9 <= 0 and var_248_6 or var_248_6 * (utf8.len(var_248_8) / 9)

				if (9 <= 0 and var_248_6 or var_248_6 * (utf8.len(var_248_8) / 9)) > 0 and var_248_6 < var_248_10 then
					arg_245_1.talkMaxDuration = var_248_10

					if var_248_10 + var_248_5 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_5
					end
				end

				arg_245_1.text_.text = var_248_8
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071058", "story_v_out_417071.awb") ~= 0 then
					local var_248_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071058", "story_v_out_417071.awb") / 1000

					if var_248_11 + var_248_5 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_11 + var_248_5
					end

					if var_248_7.prefab_name ~= "" and arg_245_1.actors_[var_248_7.prefab_name] ~= nil then
						local var_248_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_7.prefab_name].transform, "story_v_out_417071", "417071058", "story_v_out_417071.awb")

						arg_245_1:RecordAudio("417071058", var_248_12)
						arg_245_1:RecordAudio("417071058", var_248_12)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_417071", "417071058", "story_v_out_417071.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_417071", "417071058", "story_v_out_417071.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_13 = math.max(var_248_6, arg_245_1.talkMaxDuration)

			if var_248_5 <= arg_245_1.time_ and arg_245_1.time_ < var_248_5 + var_248_13 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_5) / var_248_13

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_5 + var_248_13 and arg_245_1.time_ < var_248_5 + var_248_13 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play417071059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 417071059
		arg_249_1.duration_ = 9.77

		local var_249_0 = {
			zh = 8.5,
			ja = 9.766
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
				arg_249_0:Play417071060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1034"]) and arg_249_1.var_.actorSpriteComps1034 == nil then
				arg_249_1.var_.actorSpriteComps1034 = arg_249_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1034"]) then
				if arg_249_1.var_.actorSpriteComps1034 then
					for iter_252_0, iter_252_1 in pairs(arg_249_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_252_1 then
							if arg_249_1.isInRecall_ then
								iter_252_1.color = Color.New(Mathf.Lerp(iter_252_1.color.r, arg_249_1.hightColor1.r, (arg_249_1.time_ - 0) / var_252_0), Mathf.Lerp(iter_252_1.color.g, arg_249_1.hightColor1.g, (arg_249_1.time_ - 0) / var_252_0), (Mathf.Lerp(iter_252_1.color.b, arg_249_1.hightColor1.b, (arg_249_1.time_ - 0) / var_252_0)))
							else
								local var_252_1 = Mathf.Lerp(iter_252_1.color.r, 1, (arg_249_1.time_ - 0) / var_252_0)

								iter_252_1.color = Color.New(var_252_1, var_252_1, var_252_1)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1034"]) and arg_249_1.var_.actorSpriteComps1034 then
				for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_252_3 then
						iter_252_3.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps1034 = nil
			end

			local var_252_2 = arg_249_1.actors_["10128"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps10128 == nil then
				arg_249_1.var_.actorSpriteComps10128 = var_252_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_3 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 and not isNil(var_252_2) then
				if arg_249_1.var_.actorSpriteComps10128 then
					for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_252_5 then
							if arg_249_1.isInRecall_ then
								iter_252_5.color = Color.New(Mathf.Lerp(iter_252_5.color.r, arg_249_1.hightColor2.r, (arg_249_1.time_ - 0) / var_252_3), Mathf.Lerp(iter_252_5.color.g, arg_249_1.hightColor2.g, (arg_249_1.time_ - 0) / var_252_3), (Mathf.Lerp(iter_252_5.color.b, arg_249_1.hightColor2.b, (arg_249_1.time_ - 0) / var_252_3)))
							else
								local var_252_4 = Mathf.Lerp(iter_252_5.color.r, 0.5, (arg_249_1.time_ - 0) / var_252_3)

								iter_252_5.color = Color.New(var_252_4, var_252_4, var_252_4)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps10128 then
				for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_252_7 then
						iter_252_7.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_249_1.var_.actorSpriteComps10128 = nil
			end

			local var_252_5 = arg_249_1.actors_["1034"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1034 = var_252_5.localPosition
				var_252_5.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1034", 2)

				for iter_252_8 = 0, var_252_5.childCount - 1 do
					local var_252_6 = var_252_5:GetChild(iter_252_8)

					if var_252_6.name == "" or not string.find(var_252_6.name, "split") then
						var_252_6.gameObject:SetActive(true)
					else
						var_252_6.gameObject:SetActive(false)
					end
				end
			end

			local var_252_7 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				var_252_5.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_249_1.time_ - 0) / var_252_7)
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				var_252_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_252_8 = 0
			local var_252_9 = 1.075

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_10 = arg_249_1:GetWordFromCfg(417071059)
				local var_252_11 = arg_249_1:FormatText(var_252_10.content)

				arg_249_1.text_.text = var_252_11

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_13 = 43 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 43)

				if (43 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 43)) > 0 and var_252_9 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_8
					end
				end

				arg_249_1.text_.text = var_252_11
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071059", "story_v_out_417071.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_417071", "417071059", "story_v_out_417071.awb") / 1000

					if var_252_14 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_8
					end

					if var_252_10.prefab_name ~= "" and arg_249_1.actors_[var_252_10.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_10.prefab_name].transform, "story_v_out_417071", "417071059", "story_v_out_417071.awb")

						arg_249_1:RecordAudio("417071059", var_252_15)
						arg_249_1:RecordAudio("417071059", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_417071", "417071059", "story_v_out_417071.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_417071", "417071059", "story_v_out_417071.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_16 = math.max(var_252_9, arg_249_1.talkMaxDuration)

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_16 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_8) / var_252_16

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_8 + var_252_16 and arg_249_1.time_ < var_252_8 + var_252_16 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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

		arg_249_1:InitPlayNodeList()
	end,
	Play417071060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 417071060
		arg_253_1.duration_ = 10.6

		local var_253_0 = {
			zh = 10.6,
			ja = 7.933
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
				arg_253_0:Play417071061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1034 = arg_253_1.actors_["1034"].transform.localPosition
				arg_253_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1034", 2)

				for iter_256_0 = 0, arg_253_1.actors_["1034"].transform.childCount - 1 do
					local var_256_0 = arg_253_1.actors_["1034"].transform:GetChild(iter_256_0)

					if var_256_0.name == "split_6" or not string.find(var_256_0.name, "split") then
						var_256_0.gameObject:SetActive(true)
					else
						var_256_0.gameObject:SetActive(false)
					end
				end
			end

			local var_256_1 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_1 then
				arg_253_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_253_1.time_ - 0) / var_256_1)
			end

			if arg_253_1.time_ >= 0 + var_256_1 and arg_253_1.time_ < 0 + var_256_1 + arg_256_0 then
				arg_253_1.actors_["1034"].transform.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_256_2 = 0
			local var_256_3 = 1.15

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_2 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_4 = arg_253_1:GetWordFromCfg(417071060)
				local var_256_5 = arg_253_1:FormatText(var_256_4.content)

				arg_253_1.text_.text = var_256_5

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_7 = 46 <= 0 and var_256_3 or var_256_3 * (utf8.len(var_256_5) / 46)

				if (46 <= 0 and var_256_3 or var_256_3 * (utf8.len(var_256_5) / 46)) > 0 and var_256_3 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_2 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_2
					end
				end

				arg_253_1.text_.text = var_256_5
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071060", "story_v_out_417071.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071060", "story_v_out_417071.awb") / 1000

					if var_256_8 + var_256_2 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_2
					end

					if var_256_4.prefab_name ~= "" and arg_253_1.actors_[var_256_4.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_4.prefab_name].transform, "story_v_out_417071", "417071060", "story_v_out_417071.awb")

						arg_253_1:RecordAudio("417071060", var_256_9)
						arg_253_1:RecordAudio("417071060", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_417071", "417071060", "story_v_out_417071.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_417071", "417071060", "story_v_out_417071.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_3, arg_253_1.talkMaxDuration)

			if var_256_2 <= arg_253_1.time_ and arg_253_1.time_ < var_256_2 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_2) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_2 + var_256_10 and arg_253_1.time_ < var_256_2 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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

		arg_253_1:InitPlayNodeList()
	end,
	Play417071061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 417071061
		arg_257_1.duration_ = 14.9

		local var_257_0 = {
			zh = 7.9,
			ja = 14.9
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
				arg_257_0:Play417071062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 1.025

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:GetWordFromCfg(417071061)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 41 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 41)

				if (41 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 41)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071061", "story_v_out_417071.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071061", "story_v_out_417071.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_417071", "417071061", "story_v_out_417071.awb")

						arg_257_1:RecordAudio("417071061", var_260_6)
						arg_257_1:RecordAudio("417071061", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_417071", "417071061", "story_v_out_417071.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_417071", "417071061", "story_v_out_417071.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play417071062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 417071062
		arg_261_1.duration_ = 8.5

		local var_261_0 = {
			zh = 8.5,
			ja = 6.966
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
				arg_261_0:Play417071063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 1.2

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:GetWordFromCfg(417071062)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 48 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 48)

				if (48 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 48)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071062", "story_v_out_417071.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071062", "story_v_out_417071.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_417071", "417071062", "story_v_out_417071.awb")

						arg_261_1:RecordAudio("417071062", var_264_6)
						arg_261_1:RecordAudio("417071062", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_417071", "417071062", "story_v_out_417071.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_417071", "417071062", "story_v_out_417071.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play417071063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 417071063
		arg_265_1.duration_ = 9.4

		local var_265_0 = {
			zh = 1.933,
			ja = 9.4
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
				arg_265_0:Play417071064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1034 = arg_265_1.actors_["1034"].transform.localPosition
				arg_265_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1034", 2)

				for iter_268_0 = 0, arg_265_1.actors_["1034"].transform.childCount - 1 do
					local var_268_0 = arg_265_1.actors_["1034"].transform:GetChild(iter_268_0)

					if var_268_0.name == "" or not string.find(var_268_0.name, "split") then
						var_268_0.gameObject:SetActive(true)
					else
						var_268_0.gameObject:SetActive(false)
					end
				end
			end

			local var_268_1 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				arg_265_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_265_1.time_ - 0) / var_268_1)
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				arg_265_1.actors_["1034"].transform.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_268_2 = 0
			local var_268_3 = 0.275

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_4 = arg_265_1:GetWordFromCfg(417071063)
				local var_268_5 = arg_265_1:FormatText(var_268_4.content)

				arg_265_1.text_.text = var_268_5

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_7 = 11 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 11)

				if (11 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 11)) > 0 and var_268_3 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_5
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071063", "story_v_out_417071.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071063", "story_v_out_417071.awb") / 1000

					if var_268_8 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_2
					end

					if var_268_4.prefab_name ~= "" and arg_265_1.actors_[var_268_4.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_4.prefab_name].transform, "story_v_out_417071", "417071063", "story_v_out_417071.awb")

						arg_265_1:RecordAudio("417071063", var_268_9)
						arg_265_1:RecordAudio("417071063", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_417071", "417071063", "story_v_out_417071.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_417071", "417071063", "story_v_out_417071.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_3, arg_265_1.talkMaxDuration)

			if var_268_2 <= arg_265_1.time_ and arg_265_1.time_ < var_268_2 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_2) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_2 + var_268_10 and arg_265_1.time_ < var_268_2 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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

		arg_265_1:InitPlayNodeList()
	end,
	Play417071064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 417071064
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play417071065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1034"]) and arg_269_1.var_.actorSpriteComps1034 == nil then
				arg_269_1.var_.actorSpriteComps1034 = arg_269_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1034"]) then
				if arg_269_1.var_.actorSpriteComps1034 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_272_1 then
							if arg_269_1.isInRecall_ then
								iter_272_1.color = Color.New(Mathf.Lerp(iter_272_1.color.r, arg_269_1.hightColor2.r, (arg_269_1.time_ - 0) / var_272_0), Mathf.Lerp(iter_272_1.color.g, arg_269_1.hightColor2.g, (arg_269_1.time_ - 0) / var_272_0), (Mathf.Lerp(iter_272_1.color.b, arg_269_1.hightColor2.b, (arg_269_1.time_ - 0) / var_272_0)))
							else
								local var_272_1 = Mathf.Lerp(iter_272_1.color.r, 0.5, (arg_269_1.time_ - 0) / var_272_0)

								iter_272_1.color = Color.New(var_272_1, var_272_1, var_272_1)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1034"]) and arg_269_1.var_.actorSpriteComps1034 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_272_3 then
						iter_272_3.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_269_1.var_.actorSpriteComps1034 = nil
			end

			local var_272_2 = arg_269_1.actors_["10128"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10128 = var_272_2.localPosition
				var_272_2.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("10128", 6)

				for iter_272_4 = 0, var_272_2.childCount - 1 do
					local var_272_3 = var_272_2:GetChild(iter_272_4)

					if var_272_3.name == "" or not string.find(var_272_3.name, "split") then
						var_272_3.gameObject:SetActive(true)
					else
						var_272_3.gameObject:SetActive(false)
					end
				end
			end

			local var_272_4 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				var_272_2.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10128, Vector3.New(1500, -347, -300), (arg_269_1.time_ - 0) / var_272_4)
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				var_272_2.localPosition = Vector3.New(1500, -347, -300)
			end

			local var_272_5 = arg_269_1.actors_["1034"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1034 = var_272_5.localPosition
				var_272_5.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1034", 7)

				for iter_272_5 = 0, var_272_5.childCount - 1 do
					local var_272_6 = var_272_5:GetChild(iter_272_5)

					if var_272_6.name == "" or not string.find(var_272_6.name, "split") then
						var_272_6.gameObject:SetActive(true)
					else
						var_272_6.gameObject:SetActive(false)
					end
				end
			end

			local var_272_7 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				var_272_5.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_269_1.time_ - 0) / var_272_7)
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
				var_272_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.05 < arg_269_1.time_ and arg_269_1.time_ <= 0.05 + arg_272_0 then
				arg_269_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_knock", "")
			end

			local var_272_9 = 0
			local var_272_10 = 1.45

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_9 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_11 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(417071064).content)

				arg_269_1.text_.text = var_272_11

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_13 = 58 <= 0 and var_272_10 or var_272_10 * (utf8.len(var_272_11) / 58)

				if (58 <= 0 and var_272_10 or var_272_10 * (utf8.len(var_272_11) / 58)) > 0 and var_272_10 < var_272_13 then
					arg_269_1.talkMaxDuration = var_272_13

					if var_272_13 + var_272_9 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_13 + var_272_9
					end
				end

				arg_269_1.text_.text = var_272_11
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_14 = math.max(var_272_10, arg_269_1.talkMaxDuration)

			if var_272_9 <= arg_269_1.time_ and arg_269_1.time_ < var_272_9 + var_272_14 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_9) / var_272_14

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_9 + var_272_14 and arg_269_1.time_ < var_272_9 + var_272_14 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
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

		arg_269_1:InitPlayNodeList()
	end,
	Play417071065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 417071065
		arg_273_1.duration_ = 6.17

		local var_273_0 = {
			zh = 4.4,
			ja = 6.166
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
				arg_273_0:Play417071066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.5

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_1 = arg_273_1:GetWordFromCfg(417071065)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 20 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 20)

				if (20 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 20)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071065", "story_v_out_417071.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071065", "story_v_out_417071.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_417071", "417071065", "story_v_out_417071.awb")

						arg_273_1:RecordAudio("417071065", var_276_6)
						arg_273_1:RecordAudio("417071065", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_417071", "417071065", "story_v_out_417071.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_417071", "417071065", "story_v_out_417071.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play417071066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 417071066
		arg_277_1.duration_ = 12.63

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play417071067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if arg_277_1.bgs_.B08b == nil then
				local var_280_0 = Object.Instantiate(arg_277_1.paintGo_)

				var_280_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B08b")
				var_280_0.name = "B08b"
				var_280_0.transform.parent = arg_277_1.stage_.transform
				var_280_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_277_1.bgs_.B08b = var_280_0
			end

			if 1.86666666666667 < arg_277_1.time_ and arg_277_1.time_ <= 1.86666666666667 + arg_280_0 then
				local var_280_1 = arg_277_1.bgs_.B08b

				arg_277_1.bgs_.B08b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_280_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_280_2 = var_280_1:GetComponent("SpriteRenderer")

				if var_280_2 and var_280_2.sprite then
					local var_280_3 = 2 * (var_280_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_280_1.transform.localScale = Vector3.New(var_280_3 / var_280_2.sprite.bounds.size.y < var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x and var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x or var_280_3 / var_280_2.sprite.bounds.size.y, var_280_3 / var_280_2.sprite.bounds.size.y < var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x and var_280_3 * manager.ui.mainCameraCom_.aspect / var_280_2.sprite.bounds.size.x or var_280_3 / var_280_2.sprite.bounds.size.y, 0)
				end

				for iter_280_0, iter_280_1 in pairs(arg_277_1.bgs_) do
					if iter_280_0 ~= "B08b" then
						iter_280_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_280_4 = 0

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_5 = 1.86666666666667

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_5 then
				local var_280_6 = Color.New(0, 0, 0)

				var_280_6.a = Mathf.Lerp(0, 1, (arg_277_1.time_ - var_280_4) / var_280_5)
				arg_277_1.mask_.color = var_280_6
			end

			if arg_277_1.time_ >= var_280_4 + var_280_5 and arg_277_1.time_ < var_280_4 + var_280_5 + arg_280_0 then
				local var_280_7 = Color.New(0, 0, 0)

				var_280_7.a = 1
				arg_277_1.mask_.color = var_280_7
			end

			local var_280_8 = 7.66666666666667

			if 7.66666666666667 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			if arg_277_1.time_ >= var_280_8 + 0.3 and arg_277_1.time_ < var_280_8 + 0.3 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_280_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_277_1.bgmTxt_.text ~= var_280_11 and arg_277_1.bgmTxt_.text ~= "" then
						if arg_277_1.bgmTxt2_.text ~= "" then
							arg_277_1.bgmTxt_.text = arg_277_1.bgmTxt2_.text
						end

						arg_277_1.bgmTxt2_.text = var_280_11

						arg_277_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_277_1.bgmTxt_.text = var_280_11
						arg_277_1.bgmTxt2_.text = var_280_11
					end

					if arg_277_1.bgmTimer then
						arg_277_1.bgmTimer:Stop()

						arg_277_1.bgmTimer = nil
					end

					if arg_277_1.settingData.show_music_name == 1 then
						arg_277_1.musicController:SetSelectedState("show")
						arg_277_1.musicAnimator_:Play("open", 0, 0)

						if arg_277_1.settingData.music_time ~= 0 then
							arg_277_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_277_1.settingData.music_time), function()
								if arg_277_1 == nil or isNil(arg_277_1.bgmTxt_) then
									return
								end

								arg_277_1.musicController:SetSelectedState("hide")
								arg_277_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.63333333333333 < arg_277_1.time_ and arg_277_1.time_ <= 1.63333333333333 + arg_280_0 then
				arg_277_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_280_14 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

				if "" ~= "" then
					if arg_277_1.bgmTxt_.text ~= var_280_14 and arg_277_1.bgmTxt_.text ~= "" then
						if arg_277_1.bgmTxt2_.text ~= "" then
							arg_277_1.bgmTxt_.text = arg_277_1.bgmTxt2_.text
						end

						arg_277_1.bgmTxt2_.text = var_280_14

						arg_277_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_277_1.bgmTxt_.text = var_280_14
						arg_277_1.bgmTxt2_.text = var_280_14
					end

					if arg_277_1.bgmTimer then
						arg_277_1.bgmTimer:Stop()

						arg_277_1.bgmTimer = nil
					end

					if arg_277_1.settingData.show_music_name == 1 then
						arg_277_1.musicController:SetSelectedState("show")
						arg_277_1.musicAnimator_:Play("open", 0, 0)

						if arg_277_1.settingData.music_time ~= 0 then
							arg_277_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_277_1.settingData.music_time), function()
								if arg_277_1 == nil or isNil(arg_277_1.bgmTxt_) then
									return
								end

								arg_277_1.musicController:SetSelectedState("hide")
								arg_277_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.63333333333333 < arg_277_1.time_ and arg_277_1.time_ <= 1.63333333333333 + arg_280_0 then
				arg_277_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_environment_factory", "")
			end

			if 7.26666666666667 < arg_277_1.time_ and arg_277_1.time_ <= 7.26666666666667 + arg_280_0 then
				arg_277_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_car02", "")
			end

			local var_280_17 = 1.86666666666667

			if 1.86666666666667 < arg_277_1.time_ and arg_277_1.time_ <= var_280_17 + arg_280_0 then
				arg_277_1.timestampController_:SetSelectedState("show")
				arg_277_1.timestampAni_:Play("in")

				arg_277_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B08b")

				arg_277_1.timestampColorController_:SetSelectedState("cold")
				arg_277_1.timeColdImg_:SetAlpha(0.031)

				arg_277_1.text_timeText_.text = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(501027).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_timeText_)

				arg_277_1.text_siteText_.text = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(501028).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_siteText_)
			end

			if arg_277_1.time_ >= var_280_17 + 3 and arg_277_1.time_ < var_280_17 + 3 + arg_280_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_277_1.timestampAni_, "out", function()
					arg_277_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_280_18 = 4.86666666666666

			if 4.86666666666666 < arg_277_1.time_ and arg_277_1.time_ <= var_280_18 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_19 = 1.2

			if var_280_18 <= arg_277_1.time_ and arg_277_1.time_ < var_280_18 + var_280_19 then
				local var_280_20 = Color.New(0, 0, 0)

				var_280_20.a = Mathf.Lerp(0, 1, (arg_277_1.time_ - var_280_18) / var_280_19)
				arg_277_1.mask_.color = var_280_20
			end

			if arg_277_1.time_ >= var_280_18 + var_280_19 and arg_277_1.time_ < var_280_18 + var_280_19 + arg_280_0 then
				local var_280_21 = Color.New(0, 0, 0)

				var_280_21.a = 1
				arg_277_1.mask_.color = var_280_21
			end

			local var_280_22 = 6.06666666666667

			if 6.06666666666667 < arg_277_1.time_ and arg_277_1.time_ <= var_280_22 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_23 = 1.2

			if var_280_22 <= arg_277_1.time_ and arg_277_1.time_ < var_280_22 + var_280_23 then
				local var_280_24 = Color.New(0, 0, 0)

				var_280_24.a = Mathf.Lerp(1, 0, (arg_277_1.time_ - var_280_22) / var_280_23)
				arg_277_1.mask_.color = var_280_24
			end

			if arg_277_1.time_ >= var_280_22 + var_280_23 and arg_277_1.time_ < var_280_22 + var_280_23 + arg_280_0 then
				local var_280_25 = Color.New(0, 0, 0)

				arg_277_1.mask_.enabled = false
				var_280_25.a = 0
				arg_277_1.mask_.color = var_280_25
			end

			local var_280_26 = 1.86666666666667

			if 1.86666666666667 < arg_277_1.time_ and arg_277_1.time_ <= var_280_26 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = false

				arg_277_1:SetGaussion(false)
			end

			local var_280_27 = 1

			if var_280_26 <= arg_277_1.time_ and arg_277_1.time_ < var_280_26 + var_280_27 then
				local var_280_28 = Color.New(0, 0, 0)

				var_280_28.a = Mathf.Lerp(1, 0, (arg_277_1.time_ - var_280_26) / var_280_27)
				arg_277_1.mask_.color = var_280_28
			end

			if arg_277_1.time_ >= var_280_26 + var_280_27 and arg_277_1.time_ < var_280_26 + var_280_27 + arg_280_0 then
				local var_280_29 = Color.New(0, 0, 0)

				arg_277_1.mask_.enabled = false
				var_280_29.a = 0
				arg_277_1.mask_.color = var_280_29
			end

			local var_280_30 = 1.86666666666667

			if 1.86666666666667 < arg_277_1.time_ and arg_277_1.time_ <= var_280_30 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			if arg_277_1.time_ >= var_280_30 + 3 and arg_277_1.time_ < var_280_30 + 3 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end

			if arg_277_1.frameCnt_ <= 1 then
				arg_277_1.dialog_:SetActive(false)
			end

			local var_280_31 = 7.63333333333334
			local var_280_32 = 1.55

			if 7.63333333333334 < arg_277_1.time_ and arg_277_1.time_ <= var_280_31 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				arg_277_1.dialog_:SetActive(true)

				arg_277_1.dialogCg_.alpha = 0

				local var_280_33 = LeanTween.value(arg_277_1.dialog_, 0, 1, 0.3)

				var_280_33:setOnUpdate(LuaHelper.FloatAction(function(arg_284_0)
					arg_277_1.dialogCg_.alpha = arg_284_0
				end))
				var_280_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_277_1.dialog_)
					var_280_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_277_1.duration_ = arg_277_1.duration_ + 0.3

				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_34 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(417071066).content)

				arg_277_1.text_.text = var_280_34

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_36 = 62 <= 0 and var_280_32 or var_280_32 * (utf8.len(var_280_34) / 62)

				if (62 <= 0 and var_280_32 or var_280_32 * (utf8.len(var_280_34) / 62)) > 0 and var_280_32 < var_280_36 then
					arg_277_1.talkMaxDuration = var_280_36
					var_280_31 = var_280_31 + 0.3

					if var_280_36 + var_280_31 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_36 + var_280_31
					end
				end

				arg_277_1.text_.text = var_280_34
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_37 = var_280_31 + 0.3
			local var_280_38 = math.max(var_280_32, arg_277_1.talkMaxDuration)

			if var_280_31 + 0.3 <= arg_277_1.time_ and arg_277_1.time_ < var_280_37 + var_280_38 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_37) / var_280_38

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_37 + var_280_38 and arg_277_1.time_ < var_280_37 + var_280_38 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play417071067 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 417071067
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play417071068(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.975

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_1 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(417071067).content)

				arg_286_1.text_.text = var_289_1

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_3 = 39 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 39)

				if (39 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 39)) > 0 and var_289_0 < var_289_3 then
					arg_286_1.talkMaxDuration = var_289_3

					if var_289_3 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_3 + 0
					end
				end

				arg_286_1.text_.text = var_289_1
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_4 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_4

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play417071068 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 417071068
		arg_290_1.duration_ = 2.47

		local var_290_0 = {
			zh = 1.333,
			ja = 2.466
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play417071069(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["10128"]) and arg_290_1.var_.actorSpriteComps10128 == nil then
				arg_290_1.var_.actorSpriteComps10128 = arg_290_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_0 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["10128"]) then
				if arg_290_1.var_.actorSpriteComps10128 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								iter_293_1.color = Color.New(Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor1.r, (arg_290_1.time_ - 0) / var_293_0), Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor1.g, (arg_290_1.time_ - 0) / var_293_0), (Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor1.b, (arg_290_1.time_ - 0) / var_293_0)))
							else
								local var_293_1 = Mathf.Lerp(iter_293_1.color.r, 1, (arg_290_1.time_ - 0) / var_293_0)

								iter_293_1.color = Color.New(var_293_1, var_293_1, var_293_1)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["10128"]) and arg_290_1.var_.actorSpriteComps10128 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_293_3 then
						iter_293_3.color = arg_290_1.isInRecall_ and (arg_290_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_290_1.var_.actorSpriteComps10128 = nil
			end

			local var_293_2 = arg_290_1.actors_["10128"].transform

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos10128 = var_293_2.localPosition
				var_293_2.localScale = Vector3.New(1, 1, 1)

				arg_290_1:CheckSpriteTmpPos("10128", 3)

				for iter_293_4 = 0, var_293_2.childCount - 1 do
					local var_293_3 = var_293_2:GetChild(iter_293_4)

					if var_293_3.name == "" or not string.find(var_293_3.name, "split") then
						var_293_3.gameObject:SetActive(true)
					else
						var_293_3.gameObject:SetActive(false)
					end
				end
			end

			local var_293_4 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 then
				var_293_2.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_290_1.time_ - 0) / var_293_4)
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 then
				var_293_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_293_5 = 0
			local var_293_6 = 0.125

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_7 = arg_290_1:GetWordFromCfg(417071068)
				local var_293_8 = arg_290_1:FormatText(var_293_7.content)

				arg_290_1.text_.text = var_293_8

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_10 = 5 <= 0 and var_293_6 or var_293_6 * (utf8.len(var_293_8) / 5)

				if (5 <= 0 and var_293_6 or var_293_6 * (utf8.len(var_293_8) / 5)) > 0 and var_293_6 < var_293_10 then
					arg_290_1.talkMaxDuration = var_293_10

					if var_293_10 + var_293_5 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_5
					end
				end

				arg_290_1.text_.text = var_293_8
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071068", "story_v_out_417071.awb") ~= 0 then
					local var_293_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071068", "story_v_out_417071.awb") / 1000

					if var_293_11 + var_293_5 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_11 + var_293_5
					end

					if var_293_7.prefab_name ~= "" and arg_290_1.actors_[var_293_7.prefab_name] ~= nil then
						local var_293_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_7.prefab_name].transform, "story_v_out_417071", "417071068", "story_v_out_417071.awb")

						arg_290_1:RecordAudio("417071068", var_293_12)
						arg_290_1:RecordAudio("417071068", var_293_12)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_417071", "417071068", "story_v_out_417071.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_417071", "417071068", "story_v_out_417071.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_13 = math.max(var_293_6, arg_290_1.talkMaxDuration)

			if var_293_5 <= arg_290_1.time_ and arg_290_1.time_ < var_293_5 + var_293_13 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_5) / var_293_13

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_5 + var_293_13 and arg_290_1.time_ < var_293_5 + var_293_13 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
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

		arg_290_1:InitPlayNodeList()
	end,
	Play417071069 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 417071069
		arg_294_1.duration_ = 8.6

		local var_294_0 = {
			zh = 4.633,
			ja = 8.6
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play417071070(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["10128"]) and arg_294_1.var_.actorSpriteComps10128 == nil then
				arg_294_1.var_.actorSpriteComps10128 = arg_294_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_0 = 0.2

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["10128"]) then
				if arg_294_1.var_.actorSpriteComps10128 then
					for iter_297_0, iter_297_1 in pairs(arg_294_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_297_1 then
							if arg_294_1.isInRecall_ then
								iter_297_1.color = Color.New(Mathf.Lerp(iter_297_1.color.r, arg_294_1.hightColor2.r, (arg_294_1.time_ - 0) / var_297_0), Mathf.Lerp(iter_297_1.color.g, arg_294_1.hightColor2.g, (arg_294_1.time_ - 0) / var_297_0), (Mathf.Lerp(iter_297_1.color.b, arg_294_1.hightColor2.b, (arg_294_1.time_ - 0) / var_297_0)))
							else
								local var_297_1 = Mathf.Lerp(iter_297_1.color.r, 0.5, (arg_294_1.time_ - 0) / var_297_0)

								iter_297_1.color = Color.New(var_297_1, var_297_1, var_297_1)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["10128"]) and arg_294_1.var_.actorSpriteComps10128 then
				for iter_297_2, iter_297_3 in pairs(arg_294_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_297_3 then
						iter_297_3.color = arg_294_1.isInRecall_ and (arg_294_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_294_1.var_.actorSpriteComps10128 = nil
			end

			local var_297_2 = 0
			local var_297_3 = 0.45

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_2 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[1130].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_4 = arg_294_1:GetWordFromCfg(417071069)
				local var_297_5 = arg_294_1:FormatText(var_297_4.content)

				arg_294_1.text_.text = var_297_5

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_7 = 18 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_5) / 18)

				if (18 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_5) / 18)) > 0 and var_297_3 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_2 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_2
					end
				end

				arg_294_1.text_.text = var_297_5
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071069", "story_v_out_417071.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071069", "story_v_out_417071.awb") / 1000

					if var_297_8 + var_297_2 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_2
					end

					if var_297_4.prefab_name ~= "" and arg_294_1.actors_[var_297_4.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_4.prefab_name].transform, "story_v_out_417071", "417071069", "story_v_out_417071.awb")

						arg_294_1:RecordAudio("417071069", var_297_9)
						arg_294_1:RecordAudio("417071069", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_417071", "417071069", "story_v_out_417071.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_417071", "417071069", "story_v_out_417071.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_3, arg_294_1.talkMaxDuration)

			if var_297_2 <= arg_294_1.time_ and arg_294_1.time_ < var_297_2 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_2) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_2 + var_297_10 and arg_294_1.time_ < var_297_2 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play417071070 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 417071070
		arg_298_1.duration_ = 6.73

		local var_298_0 = {
			zh = 5.1,
			ja = 6.733
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play417071071(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["10128"]) and arg_298_1.var_.actorSpriteComps10128 == nil then
				arg_298_1.var_.actorSpriteComps10128 = arg_298_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_0 = 0.2

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["10128"]) then
				if arg_298_1.var_.actorSpriteComps10128 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								iter_301_1.color = Color.New(Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor1.r, (arg_298_1.time_ - 0) / var_301_0), Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor1.g, (arg_298_1.time_ - 0) / var_301_0), (Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor1.b, (arg_298_1.time_ - 0) / var_301_0)))
							else
								local var_301_1 = Mathf.Lerp(iter_301_1.color.r, 1, (arg_298_1.time_ - 0) / var_301_0)

								iter_301_1.color = Color.New(var_301_1, var_301_1, var_301_1)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["10128"]) and arg_298_1.var_.actorSpriteComps10128 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_301_3 then
						iter_301_3.color = arg_298_1.isInRecall_ and (arg_298_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_298_1.var_.actorSpriteComps10128 = nil
			end

			local var_301_2 = 0
			local var_301_3 = 0.525

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_2 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_4 = arg_298_1:GetWordFromCfg(417071070)
				local var_301_5 = arg_298_1:FormatText(var_301_4.content)

				arg_298_1.text_.text = var_301_5

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_7 = 21 <= 0 and var_301_3 or var_301_3 * (utf8.len(var_301_5) / 21)

				if (21 <= 0 and var_301_3 or var_301_3 * (utf8.len(var_301_5) / 21)) > 0 and var_301_3 < var_301_7 then
					arg_298_1.talkMaxDuration = var_301_7

					if var_301_7 + var_301_2 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_7 + var_301_2
					end
				end

				arg_298_1.text_.text = var_301_5
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071070", "story_v_out_417071.awb") ~= 0 then
					local var_301_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071070", "story_v_out_417071.awb") / 1000

					if var_301_8 + var_301_2 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_8 + var_301_2
					end

					if var_301_4.prefab_name ~= "" and arg_298_1.actors_[var_301_4.prefab_name] ~= nil then
						local var_301_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_4.prefab_name].transform, "story_v_out_417071", "417071070", "story_v_out_417071.awb")

						arg_298_1:RecordAudio("417071070", var_301_9)
						arg_298_1:RecordAudio("417071070", var_301_9)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_417071", "417071070", "story_v_out_417071.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_417071", "417071070", "story_v_out_417071.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_10 = math.max(var_301_3, arg_298_1.talkMaxDuration)

			if var_301_2 <= arg_298_1.time_ and arg_298_1.time_ < var_301_2 + var_301_10 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_2) / var_301_10

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_2 + var_301_10 and arg_298_1.time_ < var_301_2 + var_301_10 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play417071071 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 417071071
		arg_302_1.duration_ = 19.43

		local var_302_0 = {
			zh = 8.4,
			ja = 19.433
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play417071072(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["10128"]) and arg_302_1.var_.actorSpriteComps10128 == nil then
				arg_302_1.var_.actorSpriteComps10128 = arg_302_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_0 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["10128"]) then
				if arg_302_1.var_.actorSpriteComps10128 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								iter_305_1.color = Color.New(Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor2.r, (arg_302_1.time_ - 0) / var_305_0), Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor2.g, (arg_302_1.time_ - 0) / var_305_0), (Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor2.b, (arg_302_1.time_ - 0) / var_305_0)))
							else
								local var_305_1 = Mathf.Lerp(iter_305_1.color.r, 0.5, (arg_302_1.time_ - 0) / var_305_0)

								iter_305_1.color = Color.New(var_305_1, var_305_1, var_305_1)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["10128"]) and arg_302_1.var_.actorSpriteComps10128 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_305_3 then
						iter_305_3.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_302_1.var_.actorSpriteComps10128 = nil
			end

			local var_305_2 = 0
			local var_305_3 = 0.95

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[1130].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_4 = arg_302_1:GetWordFromCfg(417071071)
				local var_305_5 = arg_302_1:FormatText(var_305_4.content)

				arg_302_1.text_.text = var_305_5

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_7 = 38 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_5) / 38)

				if (38 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_5) / 38)) > 0 and var_305_3 < var_305_7 then
					arg_302_1.talkMaxDuration = var_305_7

					if var_305_7 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_7 + var_305_2
					end
				end

				arg_302_1.text_.text = var_305_5
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071071", "story_v_out_417071.awb") ~= 0 then
					local var_305_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071071", "story_v_out_417071.awb") / 1000

					if var_305_8 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_8 + var_305_2
					end

					if var_305_4.prefab_name ~= "" and arg_302_1.actors_[var_305_4.prefab_name] ~= nil then
						local var_305_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_4.prefab_name].transform, "story_v_out_417071", "417071071", "story_v_out_417071.awb")

						arg_302_1:RecordAudio("417071071", var_305_9)
						arg_302_1:RecordAudio("417071071", var_305_9)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_417071", "417071071", "story_v_out_417071.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_417071", "417071071", "story_v_out_417071.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_10 = math.max(var_305_3, arg_302_1.talkMaxDuration)

			if var_305_2 <= arg_302_1.time_ and arg_302_1.time_ < var_305_2 + var_305_10 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_2) / var_305_10

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_2 + var_305_10 and arg_302_1.time_ < var_305_2 + var_305_10 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play417071072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 417071072
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play417071073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos10128 = arg_306_1.actors_["10128"].transform.localPosition
				arg_306_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("10128", 7)

				for iter_309_0 = 0, arg_306_1.actors_["10128"].transform.childCount - 1 do
					local var_309_0 = arg_306_1.actors_["10128"].transform:GetChild(iter_309_0)

					if var_309_0.name == "" or not string.find(var_309_0.name, "split") then
						var_309_0.gameObject:SetActive(true)
					else
						var_309_0.gameObject:SetActive(false)
					end
				end
			end

			local var_309_1 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_1 then
				arg_306_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_306_1.time_ - 0) / var_309_1)
			end

			if arg_306_1.time_ >= 0 + var_309_1 and arg_306_1.time_ < 0 + var_309_1 + arg_309_0 then
				arg_306_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_309_2 = 0
			local var_309_3 = 0.975

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_2 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_4 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(417071072).content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_6 = 39 <= 0 and var_309_3 or var_309_3 * (utf8.len(var_309_4) / 39)

				if (39 <= 0 and var_309_3 or var_309_3 * (utf8.len(var_309_4) / 39)) > 0 and var_309_3 < var_309_6 then
					arg_306_1.talkMaxDuration = var_309_6

					if var_309_6 + var_309_2 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_6 + var_309_2
					end
				end

				arg_306_1.text_.text = var_309_4
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_3, arg_306_1.talkMaxDuration)

			if var_309_2 <= arg_306_1.time_ and arg_306_1.time_ < var_309_2 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_2) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_2 + var_309_7 and arg_306_1.time_ < var_309_2 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
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

		arg_306_1:InitPlayNodeList()
	end,
	Play417071073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 417071073
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play417071074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 1.325

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_1 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(417071073).content)

				arg_310_1.text_.text = var_313_1

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_3 = 53 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 53)

				if (53 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 53)) > 0 and var_313_0 < var_313_3 then
					arg_310_1.talkMaxDuration = var_313_3

					if var_313_3 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_3 + 0
					end
				end

				arg_310_1.text_.text = var_313_1
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_4 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_4

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play417071074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 417071074
		arg_314_1.duration_ = 2.1

		local var_314_0 = {
			zh = 1.266,
			ja = 2.1
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play417071075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["10128"]) and arg_314_1.var_.actorSpriteComps10128 == nil then
				arg_314_1.var_.actorSpriteComps10128 = arg_314_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_0 = 0.2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["10128"]) then
				if arg_314_1.var_.actorSpriteComps10128 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								iter_317_1.color = Color.New(Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor1.r, (arg_314_1.time_ - 0) / var_317_0), Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor1.g, (arg_314_1.time_ - 0) / var_317_0), (Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor1.b, (arg_314_1.time_ - 0) / var_317_0)))
							else
								local var_317_1 = Mathf.Lerp(iter_317_1.color.r, 1, (arg_314_1.time_ - 0) / var_317_0)

								iter_317_1.color = Color.New(var_317_1, var_317_1, var_317_1)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["10128"]) and arg_314_1.var_.actorSpriteComps10128 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_317_3 then
						iter_317_3.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_314_1.var_.actorSpriteComps10128 = nil
			end

			local var_317_2 = arg_314_1.actors_["10128"].transform

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos10128 = var_317_2.localPosition
				var_317_2.localScale = Vector3.New(1, 1, 1)

				arg_314_1:CheckSpriteTmpPos("10128", 3)

				for iter_317_4 = 0, var_317_2.childCount - 1 do
					local var_317_3 = var_317_2:GetChild(iter_317_4)

					if var_317_3.name == "" or not string.find(var_317_3.name, "split") then
						var_317_3.gameObject:SetActive(true)
					else
						var_317_3.gameObject:SetActive(false)
					end
				end
			end

			local var_317_4 = 0.001

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_4 then
				var_317_2.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_314_1.time_ - 0) / var_317_4)
			end

			if arg_314_1.time_ >= 0 + var_317_4 and arg_314_1.time_ < 0 + var_317_4 + arg_317_0 then
				var_317_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_317_5 = 0
			local var_317_6 = 0.175

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_7 = arg_314_1:GetWordFromCfg(417071074)
				local var_317_8 = arg_314_1:FormatText(var_317_7.content)

				arg_314_1.text_.text = var_317_8

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_10 = 7 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_8) / 7)

				if (7 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_8) / 7)) > 0 and var_317_6 < var_317_10 then
					arg_314_1.talkMaxDuration = var_317_10

					if var_317_10 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_10 + var_317_5
					end
				end

				arg_314_1.text_.text = var_317_8
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071074", "story_v_out_417071.awb") ~= 0 then
					local var_317_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071074", "story_v_out_417071.awb") / 1000

					if var_317_11 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_11 + var_317_5
					end

					if var_317_7.prefab_name ~= "" and arg_314_1.actors_[var_317_7.prefab_name] ~= nil then
						local var_317_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_7.prefab_name].transform, "story_v_out_417071", "417071074", "story_v_out_417071.awb")

						arg_314_1:RecordAudio("417071074", var_317_12)
						arg_314_1:RecordAudio("417071074", var_317_12)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_417071", "417071074", "story_v_out_417071.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_417071", "417071074", "story_v_out_417071.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_13 = math.max(var_317_6, arg_314_1.talkMaxDuration)

			if var_317_5 <= arg_314_1.time_ and arg_314_1.time_ < var_317_5 + var_317_13 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_5) / var_317_13

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_5 + var_317_13 and arg_314_1.time_ < var_317_5 + var_317_13 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
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

		arg_314_1:InitPlayNodeList()
	end,
	Play417071075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 417071075
		arg_318_1.duration_ = 12.23

		local var_318_0 = {
			zh = 5.3,
			ja = 12.233
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play417071076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["10128"]) and arg_318_1.var_.actorSpriteComps10128 == nil then
				arg_318_1.var_.actorSpriteComps10128 = arg_318_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_0 = 0.2

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["10128"]) then
				if arg_318_1.var_.actorSpriteComps10128 then
					for iter_321_0, iter_321_1 in pairs(arg_318_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_321_1 then
							if arg_318_1.isInRecall_ then
								iter_321_1.color = Color.New(Mathf.Lerp(iter_321_1.color.r, arg_318_1.hightColor2.r, (arg_318_1.time_ - 0) / var_321_0), Mathf.Lerp(iter_321_1.color.g, arg_318_1.hightColor2.g, (arg_318_1.time_ - 0) / var_321_0), (Mathf.Lerp(iter_321_1.color.b, arg_318_1.hightColor2.b, (arg_318_1.time_ - 0) / var_321_0)))
							else
								local var_321_1 = Mathf.Lerp(iter_321_1.color.r, 0.5, (arg_318_1.time_ - 0) / var_321_0)

								iter_321_1.color = Color.New(var_321_1, var_321_1, var_321_1)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["10128"]) and arg_318_1.var_.actorSpriteComps10128 then
				for iter_321_2, iter_321_3 in pairs(arg_318_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_321_3 then
						iter_321_3.color = arg_318_1.isInRecall_ and (arg_318_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_318_1.var_.actorSpriteComps10128 = nil
			end

			local var_321_2 = 0
			local var_321_3 = 0.6

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_2 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[1130].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_4 = arg_318_1:GetWordFromCfg(417071075)
				local var_321_5 = arg_318_1:FormatText(var_321_4.content)

				arg_318_1.text_.text = var_321_5

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_7 = 24 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_5) / 24)

				if (24 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_5) / 24)) > 0 and var_321_3 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_2 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_2
					end
				end

				arg_318_1.text_.text = var_321_5
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071075", "story_v_out_417071.awb") ~= 0 then
					local var_321_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071075", "story_v_out_417071.awb") / 1000

					if var_321_8 + var_321_2 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_8 + var_321_2
					end

					if var_321_4.prefab_name ~= "" and arg_318_1.actors_[var_321_4.prefab_name] ~= nil then
						local var_321_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_4.prefab_name].transform, "story_v_out_417071", "417071075", "story_v_out_417071.awb")

						arg_318_1:RecordAudio("417071075", var_321_9)
						arg_318_1:RecordAudio("417071075", var_321_9)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_417071", "417071075", "story_v_out_417071.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_417071", "417071075", "story_v_out_417071.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_10 = math.max(var_321_3, arg_318_1.talkMaxDuration)

			if var_321_2 <= arg_318_1.time_ and arg_318_1.time_ < var_321_2 + var_321_10 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_2) / var_321_10

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_2 + var_321_10 and arg_318_1.time_ < var_321_2 + var_321_10 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play417071076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 417071076
		arg_322_1.duration_ = 9.07

		local var_322_0 = {
			zh = 7.433,
			ja = 9.066
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play417071077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 1

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[1130].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_1 = arg_322_1:GetWordFromCfg(417071076)
				local var_325_2 = arg_322_1:FormatText(var_325_1.content)

				arg_322_1.text_.text = var_325_2

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 40 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 40)

				if (40 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 40)) > 0 and var_325_0 < var_325_4 then
					arg_322_1.talkMaxDuration = var_325_4

					if var_325_4 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_4 + 0
					end
				end

				arg_322_1.text_.text = var_325_2
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071076", "story_v_out_417071.awb") ~= 0 then
					local var_325_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071076", "story_v_out_417071.awb") / 1000

					if var_325_5 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + 0
					end

					if var_325_1.prefab_name ~= "" and arg_322_1.actors_[var_325_1.prefab_name] ~= nil then
						local var_325_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_1.prefab_name].transform, "story_v_out_417071", "417071076", "story_v_out_417071.awb")

						arg_322_1:RecordAudio("417071076", var_325_6)
						arg_322_1:RecordAudio("417071076", var_325_6)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_417071", "417071076", "story_v_out_417071.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_417071", "417071076", "story_v_out_417071.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_7 and arg_322_1.time_ < 0 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play417071077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 417071077
		arg_326_1.duration_ = 3.77

		local var_326_0 = {
			zh = 3.7,
			ja = 3.766
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play417071078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["10128"]) and arg_326_1.var_.actorSpriteComps10128 == nil then
				arg_326_1.var_.actorSpriteComps10128 = arg_326_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_0 = 0.2

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["10128"]) then
				if arg_326_1.var_.actorSpriteComps10128 then
					for iter_329_0, iter_329_1 in pairs(arg_326_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_329_1 then
							if arg_326_1.isInRecall_ then
								iter_329_1.color = Color.New(Mathf.Lerp(iter_329_1.color.r, arg_326_1.hightColor1.r, (arg_326_1.time_ - 0) / var_329_0), Mathf.Lerp(iter_329_1.color.g, arg_326_1.hightColor1.g, (arg_326_1.time_ - 0) / var_329_0), (Mathf.Lerp(iter_329_1.color.b, arg_326_1.hightColor1.b, (arg_326_1.time_ - 0) / var_329_0)))
							else
								local var_329_1 = Mathf.Lerp(iter_329_1.color.r, 1, (arg_326_1.time_ - 0) / var_329_0)

								iter_329_1.color = Color.New(var_329_1, var_329_1, var_329_1)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["10128"]) and arg_326_1.var_.actorSpriteComps10128 then
				for iter_329_2, iter_329_3 in pairs(arg_326_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_329_3 then
						iter_329_3.color = arg_326_1.isInRecall_ and (arg_326_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_326_1.var_.actorSpriteComps10128 = nil
			end

			local var_329_2 = 0
			local var_329_3 = 0.475

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_2 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_4 = arg_326_1:GetWordFromCfg(417071077)
				local var_329_5 = arg_326_1:FormatText(var_329_4.content)

				arg_326_1.text_.text = var_329_5

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_7 = 19 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_5) / 19)

				if (19 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_5) / 19)) > 0 and var_329_3 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_2
					end
				end

				arg_326_1.text_.text = var_329_5
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071077", "story_v_out_417071.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071077", "story_v_out_417071.awb") / 1000

					if var_329_8 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_2
					end

					if var_329_4.prefab_name ~= "" and arg_326_1.actors_[var_329_4.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_4.prefab_name].transform, "story_v_out_417071", "417071077", "story_v_out_417071.awb")

						arg_326_1:RecordAudio("417071077", var_329_9)
						arg_326_1:RecordAudio("417071077", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_417071", "417071077", "story_v_out_417071.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_417071", "417071077", "story_v_out_417071.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_3, arg_326_1.talkMaxDuration)

			if var_329_2 <= arg_326_1.time_ and arg_326_1.time_ < var_329_2 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_2) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_2 + var_329_10 and arg_326_1.time_ < var_329_2 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play417071078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 417071078
		arg_330_1.duration_ = 12.63

		local var_330_0 = {
			zh = 6.366,
			ja = 12.633
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play417071079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos10128 = arg_330_1.actors_["10128"].transform.localPosition
				arg_330_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("10128", 3)

				for iter_333_0 = 0, arg_330_1.actors_["10128"].transform.childCount - 1 do
					local var_333_0 = arg_330_1.actors_["10128"].transform:GetChild(iter_333_0)

					if var_333_0.name == "split_6" or not string.find(var_333_0.name, "split") then
						var_333_0.gameObject:SetActive(true)
					else
						var_333_0.gameObject:SetActive(false)
					end
				end
			end

			local var_333_1 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_1 then
				arg_330_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_330_1.time_ - 0) / var_333_1)
			end

			if arg_330_1.time_ >= 0 + var_333_1 and arg_330_1.time_ < 0 + var_333_1 + arg_333_0 then
				arg_330_1.actors_["10128"].transform.localPosition = Vector3.New(0, -347, -300)
			end

			local var_333_2 = 0
			local var_333_3 = 0.75

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_2 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_4 = arg_330_1:GetWordFromCfg(417071078)
				local var_333_5 = arg_330_1:FormatText(var_333_4.content)

				arg_330_1.text_.text = var_333_5

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_7 = 30 <= 0 and var_333_3 or var_333_3 * (utf8.len(var_333_5) / 30)

				if (30 <= 0 and var_333_3 or var_333_3 * (utf8.len(var_333_5) / 30)) > 0 and var_333_3 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_2 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_2
					end
				end

				arg_330_1.text_.text = var_333_5
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071078", "story_v_out_417071.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071078", "story_v_out_417071.awb") / 1000

					if var_333_8 + var_333_2 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_2
					end

					if var_333_4.prefab_name ~= "" and arg_330_1.actors_[var_333_4.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_4.prefab_name].transform, "story_v_out_417071", "417071078", "story_v_out_417071.awb")

						arg_330_1:RecordAudio("417071078", var_333_9)
						arg_330_1:RecordAudio("417071078", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_417071", "417071078", "story_v_out_417071.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_417071", "417071078", "story_v_out_417071.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_3, arg_330_1.talkMaxDuration)

			if var_333_2 <= arg_330_1.time_ and arg_330_1.time_ < var_333_2 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_2) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_2 + var_333_10 and arg_330_1.time_ < var_333_2 + var_333_10 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
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

		arg_330_1:InitPlayNodeList()
	end,
	Play417071079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 417071079
		arg_334_1.duration_ = 10.03

		local var_334_0 = {
			zh = 4.933,
			ja = 10.033
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play417071080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["10128"]) and arg_334_1.var_.actorSpriteComps10128 == nil then
				arg_334_1.var_.actorSpriteComps10128 = arg_334_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_0 = 0.2

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["10128"]) then
				if arg_334_1.var_.actorSpriteComps10128 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								iter_337_1.color = Color.New(Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor2.r, (arg_334_1.time_ - 0) / var_337_0), Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor2.g, (arg_334_1.time_ - 0) / var_337_0), (Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor2.b, (arg_334_1.time_ - 0) / var_337_0)))
							else
								local var_337_1 = Mathf.Lerp(iter_337_1.color.r, 0.5, (arg_334_1.time_ - 0) / var_337_0)

								iter_337_1.color = Color.New(var_337_1, var_337_1, var_337_1)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["10128"]) and arg_334_1.var_.actorSpriteComps10128 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_337_3 then
						iter_337_3.color = arg_334_1.isInRecall_ and (arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_334_1.var_.actorSpriteComps10128 = nil
			end

			local var_337_2 = 0
			local var_337_3 = 0.4

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1130].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_4 = arg_334_1:GetWordFromCfg(417071079)
				local var_337_5 = arg_334_1:FormatText(var_337_4.content)

				arg_334_1.text_.text = var_337_5

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_7 = 16 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_5) / 16)

				if (16 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_5) / 16)) > 0 and var_337_3 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_2
					end
				end

				arg_334_1.text_.text = var_337_5
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071079", "story_v_out_417071.awb") ~= 0 then
					local var_337_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071079", "story_v_out_417071.awb") / 1000

					if var_337_8 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_8 + var_337_2
					end

					if var_337_4.prefab_name ~= "" and arg_334_1.actors_[var_337_4.prefab_name] ~= nil then
						local var_337_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_4.prefab_name].transform, "story_v_out_417071", "417071079", "story_v_out_417071.awb")

						arg_334_1:RecordAudio("417071079", var_337_9)
						arg_334_1:RecordAudio("417071079", var_337_9)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_417071", "417071079", "story_v_out_417071.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_417071", "417071079", "story_v_out_417071.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_10 = math.max(var_337_3, arg_334_1.talkMaxDuration)

			if var_337_2 <= arg_334_1.time_ and arg_334_1.time_ < var_337_2 + var_337_10 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_2) / var_337_10

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_2 + var_337_10 and arg_334_1.time_ < var_337_2 + var_337_10 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play417071080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 417071080
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play417071081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos10128 = arg_338_1.actors_["10128"].transform.localPosition
				arg_338_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("10128", 7)

				for iter_341_0 = 0, arg_338_1.actors_["10128"].transform.childCount - 1 do
					local var_341_0 = arg_338_1.actors_["10128"].transform:GetChild(iter_341_0)

					if var_341_0.name == "" or not string.find(var_341_0.name, "split") then
						var_341_0.gameObject:SetActive(true)
					else
						var_341_0.gameObject:SetActive(false)
					end
				end
			end

			local var_341_1 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_1 then
				arg_338_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_338_1.time_ - 0) / var_341_1)
			end

			if arg_338_1.time_ >= 0 + var_341_1 and arg_338_1.time_ < 0 + var_341_1 + arg_341_0 then
				arg_338_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_341_2 = 0
			local var_341_3 = 1.25

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_4 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(417071080).content)

				arg_338_1.text_.text = var_341_4

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_6 = 50 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_4) / 50)

				if (50 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_4) / 50)) > 0 and var_341_3 < var_341_6 then
					arg_338_1.talkMaxDuration = var_341_6

					if var_341_6 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_6 + var_341_2
					end
				end

				arg_338_1.text_.text = var_341_4
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_7 = math.max(var_341_3, arg_338_1.talkMaxDuration)

			if var_341_2 <= arg_338_1.time_ and arg_338_1.time_ < var_341_2 + var_341_7 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_2) / var_341_7

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_2 + var_341_7 and arg_338_1.time_ < var_341_2 + var_341_7 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
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

		arg_338_1:InitPlayNodeList()
	end,
	Play417071081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 417071081
		arg_342_1.duration_ = 6.93

		local var_342_0 = {
			zh = 6.93333333333333,
			ja = 6.56633333333333
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play417071082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if arg_342_1.bgs_.B01 == nil then
				local var_345_0 = Object.Instantiate(arg_342_1.paintGo_)

				var_345_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B01")
				var_345_0.name = "B01"
				var_345_0.transform.parent = arg_342_1.stage_.transform
				var_345_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_342_1.bgs_.B01 = var_345_0
			end

			if 1.86666666666667 < arg_342_1.time_ and arg_342_1.time_ <= 1.86666666666667 + arg_345_0 then
				local var_345_1 = arg_342_1.bgs_.B01

				arg_342_1.bgs_.B01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_345_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_345_2 = var_345_1:GetComponent("SpriteRenderer")

				if var_345_2 and var_345_2.sprite then
					local var_345_3 = 2 * (var_345_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_345_1.transform.localScale = Vector3.New(var_345_3 / var_345_2.sprite.bounds.size.y < var_345_3 * manager.ui.mainCameraCom_.aspect / var_345_2.sprite.bounds.size.x and var_345_3 * manager.ui.mainCameraCom_.aspect / var_345_2.sprite.bounds.size.x or var_345_3 / var_345_2.sprite.bounds.size.y, var_345_3 / var_345_2.sprite.bounds.size.y < var_345_3 * manager.ui.mainCameraCom_.aspect / var_345_2.sprite.bounds.size.x and var_345_3 * manager.ui.mainCameraCom_.aspect / var_345_2.sprite.bounds.size.x or var_345_3 / var_345_2.sprite.bounds.size.y, 0)
				end

				for iter_345_0, iter_345_1 in pairs(arg_342_1.bgs_) do
					if iter_345_0 ~= "B01" then
						iter_345_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_345_4 = 1.86666666666667

			if 1.86666666666667 < arg_342_1.time_ and arg_342_1.time_ <= var_345_4 + arg_345_0 then
				arg_342_1.allBtn_.enabled = false
			end

			if arg_342_1.time_ >= var_345_4 + 0.3 and arg_342_1.time_ < var_345_4 + 0.3 + arg_345_0 then
				arg_342_1.allBtn_.enabled = true
			end

			local var_345_5 = 0

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_5 + arg_345_0 then
				arg_342_1.mask_.enabled = true
				arg_342_1.mask_.raycastTarget = true

				arg_342_1:SetGaussion(false)
			end

			local var_345_6 = 1.86666666666667

			if var_345_5 <= arg_342_1.time_ and arg_342_1.time_ < var_345_5 + var_345_6 then
				local var_345_7 = Color.New(0, 0, 0)

				var_345_7.a = Mathf.Lerp(0, 1, (arg_342_1.time_ - var_345_5) / var_345_6)
				arg_342_1.mask_.color = var_345_7
			end

			if arg_342_1.time_ >= var_345_5 + var_345_6 and arg_342_1.time_ < var_345_5 + var_345_6 + arg_345_0 then
				local var_345_8 = Color.New(0, 0, 0)

				var_345_8.a = 1
				arg_342_1.mask_.color = var_345_8
			end

			local var_345_9 = 1.86666666666667

			if 1.86666666666667 < arg_342_1.time_ and arg_342_1.time_ <= var_345_9 + arg_345_0 then
				arg_342_1.mask_.enabled = true
				arg_342_1.mask_.raycastTarget = true

				arg_342_1:SetGaussion(false)
			end

			local var_345_10 = 2

			if var_345_9 <= arg_342_1.time_ and arg_342_1.time_ < var_345_9 + var_345_10 then
				local var_345_11 = Color.New(0, 0, 0)

				var_345_11.a = Mathf.Lerp(1, 0, (arg_342_1.time_ - var_345_9) / var_345_10)
				arg_342_1.mask_.color = var_345_11
			end

			if arg_342_1.time_ >= var_345_9 + var_345_10 and arg_342_1.time_ < var_345_9 + var_345_10 + arg_345_0 then
				local var_345_12 = Color.New(0, 0, 0)

				arg_342_1.mask_.enabled = false
				var_345_12.a = 0
				arg_342_1.mask_.color = var_345_12
			end

			if 0.133333333333333 < arg_342_1.time_ and arg_342_1.time_ <= 0.133333333333333 + arg_345_0 then
				arg_342_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_environment_factory", "")
			end

			if arg_342_1.frameCnt_ <= 1 then
				arg_342_1.dialog_:SetActive(false)
			end

			local var_345_14 = 3.23333333333333
			local var_345_15 = 0.35

			if 3.23333333333333 < arg_342_1.time_ and arg_342_1.time_ <= var_345_14 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0

				arg_342_1.dialog_:SetActive(true)

				arg_342_1.dialogCg_.alpha = 0

				local var_345_16 = LeanTween.value(arg_342_1.dialog_, 0, 1, 0.3)

				var_345_16:setOnUpdate(LuaHelper.FloatAction(function(arg_346_0)
					arg_342_1.dialogCg_.alpha = arg_346_0
				end))
				var_345_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_342_1.dialog_)
					var_345_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_342_1.duration_ = arg_342_1.duration_ + 0.3

				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_17 = arg_342_1:GetWordFromCfg(417071081)
				local var_345_18 = arg_342_1:FormatText(var_345_17.content)

				arg_342_1.text_.text = var_345_18

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_20 = 14 <= 0 and var_345_15 or var_345_15 * (utf8.len(var_345_18) / 14)

				if (14 <= 0 and var_345_15 or var_345_15 * (utf8.len(var_345_18) / 14)) > 0 and var_345_15 < var_345_20 then
					arg_342_1.talkMaxDuration = var_345_20
					var_345_14 = var_345_14 + 0.3

					if var_345_20 + var_345_14 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_20 + var_345_14
					end
				end

				arg_342_1.text_.text = var_345_18
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071081", "story_v_out_417071.awb") ~= 0 then
					local var_345_21 = manager.audio:GetVoiceLength("story_v_out_417071", "417071081", "story_v_out_417071.awb") / 1000

					if var_345_21 + var_345_14 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_21 + var_345_14
					end

					if var_345_17.prefab_name ~= "" and arg_342_1.actors_[var_345_17.prefab_name] ~= nil then
						local var_345_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_17.prefab_name].transform, "story_v_out_417071", "417071081", "story_v_out_417071.awb")

						arg_342_1:RecordAudio("417071081", var_345_22)
						arg_342_1:RecordAudio("417071081", var_345_22)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_417071", "417071081", "story_v_out_417071.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_417071", "417071081", "story_v_out_417071.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_23 = var_345_14 + 0.3
			local var_345_24 = math.max(var_345_15, arg_342_1.talkMaxDuration)

			if var_345_14 + 0.3 <= arg_342_1.time_ and arg_342_1.time_ < var_345_23 + var_345_24 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_23) / var_345_24

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_23 + var_345_24 and arg_342_1.time_ < var_345_23 + var_345_24 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play417071082 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 417071082
		arg_348_1.duration_ = 4.5

		local var_348_0 = {
			zh = 1.466,
			ja = 4.5
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play417071083(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(arg_348_1.actors_["1034"]) and arg_348_1.var_.actorSpriteComps1034 == nil then
				arg_348_1.var_.actorSpriteComps1034 = arg_348_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_0 = 0.2

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 and not isNil(arg_348_1.actors_["1034"]) then
				if arg_348_1.var_.actorSpriteComps1034 then
					for iter_351_0, iter_351_1 in pairs(arg_348_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_351_1 then
							if arg_348_1.isInRecall_ then
								iter_351_1.color = Color.New(Mathf.Lerp(iter_351_1.color.r, arg_348_1.hightColor1.r, (arg_348_1.time_ - 0) / var_351_0), Mathf.Lerp(iter_351_1.color.g, arg_348_1.hightColor1.g, (arg_348_1.time_ - 0) / var_351_0), (Mathf.Lerp(iter_351_1.color.b, arg_348_1.hightColor1.b, (arg_348_1.time_ - 0) / var_351_0)))
							else
								local var_351_1 = Mathf.Lerp(iter_351_1.color.r, 1, (arg_348_1.time_ - 0) / var_351_0)

								iter_351_1.color = Color.New(var_351_1, var_351_1, var_351_1)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 and not isNil(arg_348_1.actors_["1034"]) and arg_348_1.var_.actorSpriteComps1034 then
				for iter_351_2, iter_351_3 in pairs(arg_348_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_351_3 then
						iter_351_3.color = arg_348_1.isInRecall_ and (arg_348_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_348_1.var_.actorSpriteComps1034 = nil
			end

			local var_351_2 = arg_348_1.actors_["1034"].transform

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos1034 = var_351_2.localPosition
				var_351_2.localScale = Vector3.New(1, 1, 1)

				arg_348_1:CheckSpriteTmpPos("1034", 3)

				for iter_351_4 = 0, var_351_2.childCount - 1 do
					local var_351_3 = var_351_2:GetChild(iter_351_4)

					if var_351_3.name == "" or not string.find(var_351_3.name, "split") then
						var_351_3.gameObject:SetActive(true)
					else
						var_351_3.gameObject:SetActive(false)
					end
				end
			end

			local var_351_4 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_4 then
				var_351_2.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_348_1.time_ - 0) / var_351_4)
			end

			if arg_348_1.time_ >= 0 + var_351_4 and arg_348_1.time_ < 0 + var_351_4 + arg_351_0 then
				var_351_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_351_5 = 0
			local var_351_6 = 0.15

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_5 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_7 = arg_348_1:GetWordFromCfg(417071082)
				local var_351_8 = arg_348_1:FormatText(var_351_7.content)

				arg_348_1.text_.text = var_351_8

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_10 = 6 <= 0 and var_351_6 or var_351_6 * (utf8.len(var_351_8) / 6)

				if (6 <= 0 and var_351_6 or var_351_6 * (utf8.len(var_351_8) / 6)) > 0 and var_351_6 < var_351_10 then
					arg_348_1.talkMaxDuration = var_351_10

					if var_351_10 + var_351_5 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_10 + var_351_5
					end
				end

				arg_348_1.text_.text = var_351_8
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071082", "story_v_out_417071.awb") ~= 0 then
					local var_351_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071082", "story_v_out_417071.awb") / 1000

					if var_351_11 + var_351_5 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_11 + var_351_5
					end

					if var_351_7.prefab_name ~= "" and arg_348_1.actors_[var_351_7.prefab_name] ~= nil then
						local var_351_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_7.prefab_name].transform, "story_v_out_417071", "417071082", "story_v_out_417071.awb")

						arg_348_1:RecordAudio("417071082", var_351_12)
						arg_348_1:RecordAudio("417071082", var_351_12)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_417071", "417071082", "story_v_out_417071.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_417071", "417071082", "story_v_out_417071.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_13 = math.max(var_351_6, arg_348_1.talkMaxDuration)

			if var_351_5 <= arg_348_1.time_ and arg_348_1.time_ < var_351_5 + var_351_13 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_5) / var_351_13

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_5 + var_351_13 and arg_348_1.time_ < var_351_5 + var_351_13 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
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

		arg_348_1:InitPlayNodeList()
	end,
	Play417071083 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 417071083
		arg_352_1.duration_ = 9.17

		local var_352_0 = {
			zh = 6.7,
			ja = 9.166
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play417071084(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1034"]) and arg_352_1.var_.actorSpriteComps1034 == nil then
				arg_352_1.var_.actorSpriteComps1034 = arg_352_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_0 = 0.2

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1034"]) then
				if arg_352_1.var_.actorSpriteComps1034 then
					for iter_355_0, iter_355_1 in pairs(arg_352_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_355_1 then
							if arg_352_1.isInRecall_ then
								iter_355_1.color = Color.New(Mathf.Lerp(iter_355_1.color.r, arg_352_1.hightColor2.r, (arg_352_1.time_ - 0) / var_355_0), Mathf.Lerp(iter_355_1.color.g, arg_352_1.hightColor2.g, (arg_352_1.time_ - 0) / var_355_0), (Mathf.Lerp(iter_355_1.color.b, arg_352_1.hightColor2.b, (arg_352_1.time_ - 0) / var_355_0)))
							else
								local var_355_1 = Mathf.Lerp(iter_355_1.color.r, 0.5, (arg_352_1.time_ - 0) / var_355_0)

								iter_355_1.color = Color.New(var_355_1, var_355_1, var_355_1)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1034"]) and arg_352_1.var_.actorSpriteComps1034 then
				for iter_355_2, iter_355_3 in pairs(arg_352_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_355_3 then
						iter_355_3.color = arg_352_1.isInRecall_ and (arg_352_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_352_1.var_.actorSpriteComps1034 = nil
			end

			local var_355_2 = 0
			local var_355_3 = 0.7

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_2 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_4 = arg_352_1:GetWordFromCfg(417071083)
				local var_355_5 = arg_352_1:FormatText(var_355_4.content)

				arg_352_1.text_.text = var_355_5

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_7 = 28 <= 0 and var_355_3 or var_355_3 * (utf8.len(var_355_5) / 28)

				if (28 <= 0 and var_355_3 or var_355_3 * (utf8.len(var_355_5) / 28)) > 0 and var_355_3 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_2 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_2
					end
				end

				arg_352_1.text_.text = var_355_5
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071083", "story_v_out_417071.awb") ~= 0 then
					local var_355_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071083", "story_v_out_417071.awb") / 1000

					if var_355_8 + var_355_2 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_8 + var_355_2
					end

					if var_355_4.prefab_name ~= "" and arg_352_1.actors_[var_355_4.prefab_name] ~= nil then
						local var_355_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_4.prefab_name].transform, "story_v_out_417071", "417071083", "story_v_out_417071.awb")

						arg_352_1:RecordAudio("417071083", var_355_9)
						arg_352_1:RecordAudio("417071083", var_355_9)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_417071", "417071083", "story_v_out_417071.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_417071", "417071083", "story_v_out_417071.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_10 = math.max(var_355_3, arg_352_1.talkMaxDuration)

			if var_355_2 <= arg_352_1.time_ and arg_352_1.time_ < var_355_2 + var_355_10 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_2) / var_355_10

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_2 + var_355_10 and arg_352_1.time_ < var_355_2 + var_355_10 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play417071084 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 417071084
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play417071085(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos1034 = arg_356_1.actors_["1034"].transform.localPosition
				arg_356_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_356_1:CheckSpriteTmpPos("1034", 7)

				for iter_359_0 = 0, arg_356_1.actors_["1034"].transform.childCount - 1 do
					local var_359_0 = arg_356_1.actors_["1034"].transform:GetChild(iter_359_0)

					if var_359_0.name == "" or not string.find(var_359_0.name, "split") then
						var_359_0.gameObject:SetActive(true)
					else
						var_359_0.gameObject:SetActive(false)
					end
				end
			end

			local var_359_1 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_1 then
				arg_356_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_356_1.time_ - 0) / var_359_1)
			end

			if arg_356_1.time_ >= 0 + var_359_1 and arg_356_1.time_ < 0 + var_359_1 + arg_359_0 then
				arg_356_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_359_2 = 0
			local var_359_3 = 1.8

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_2 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_4 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(417071084).content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_6 = 72 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_4) / 72)

				if (72 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_4) / 72)) > 0 and var_359_3 < var_359_6 then
					arg_356_1.talkMaxDuration = var_359_6

					if var_359_6 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_6 + var_359_2
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_7 = math.max(var_359_3, arg_356_1.talkMaxDuration)

			if var_359_2 <= arg_356_1.time_ and arg_356_1.time_ < var_359_2 + var_359_7 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_2) / var_359_7

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_2 + var_359_7 and arg_356_1.time_ < var_359_2 + var_359_7 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
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

		arg_356_1:InitPlayNodeList()
	end,
	Play417071085 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 417071085
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play417071086(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 1.075

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_1 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(417071085).content)

				arg_360_1.text_.text = var_363_1

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_3 = 43 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_1) / 43)

				if (43 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_1) / 43)) > 0 and var_363_0 < var_363_3 then
					arg_360_1.talkMaxDuration = var_363_3

					if var_363_3 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_3 + 0
					end
				end

				arg_360_1.text_.text = var_363_1
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_4 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_4 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_4

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_4 and arg_360_1.time_ < 0 + var_363_4 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play417071086 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 417071086
		arg_364_1.duration_ = 6

		local var_364_0 = {
			zh = 5.766,
			ja = 6
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play417071087(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(arg_364_1.actors_["1034"]) and arg_364_1.var_.actorSpriteComps1034 == nil then
				arg_364_1.var_.actorSpriteComps1034 = arg_364_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_367_0 = 0.2

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 and not isNil(arg_364_1.actors_["1034"]) then
				if arg_364_1.var_.actorSpriteComps1034 then
					for iter_367_0, iter_367_1 in pairs(arg_364_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_367_1 then
							if arg_364_1.isInRecall_ then
								iter_367_1.color = Color.New(Mathf.Lerp(iter_367_1.color.r, arg_364_1.hightColor1.r, (arg_364_1.time_ - 0) / var_367_0), Mathf.Lerp(iter_367_1.color.g, arg_364_1.hightColor1.g, (arg_364_1.time_ - 0) / var_367_0), (Mathf.Lerp(iter_367_1.color.b, arg_364_1.hightColor1.b, (arg_364_1.time_ - 0) / var_367_0)))
							else
								local var_367_1 = Mathf.Lerp(iter_367_1.color.r, 1, (arg_364_1.time_ - 0) / var_367_0)

								iter_367_1.color = Color.New(var_367_1, var_367_1, var_367_1)
							end
						end
					end
				end
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 and not isNil(arg_364_1.actors_["1034"]) and arg_364_1.var_.actorSpriteComps1034 then
				for iter_367_2, iter_367_3 in pairs(arg_364_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_367_3 then
						iter_367_3.color = arg_364_1.isInRecall_ and (arg_364_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_364_1.var_.actorSpriteComps1034 = nil
			end

			local var_367_2 = arg_364_1.actors_["1034"].transform

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos1034 = var_367_2.localPosition
				var_367_2.localScale = Vector3.New(1, 1, 1)

				arg_364_1:CheckSpriteTmpPos("1034", 3)

				for iter_367_4 = 0, var_367_2.childCount - 1 do
					local var_367_3 = var_367_2:GetChild(iter_367_4)

					if var_367_3.name == "" or not string.find(var_367_3.name, "split") then
						var_367_3.gameObject:SetActive(true)
					else
						var_367_3.gameObject:SetActive(false)
					end
				end
			end

			local var_367_4 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_4 then
				var_367_2.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_364_1.time_ - 0) / var_367_4)
			end

			if arg_364_1.time_ >= 0 + var_367_4 and arg_364_1.time_ < 0 + var_367_4 + arg_367_0 then
				var_367_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_367_5 = 0
			local var_367_6 = 0.8

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_5 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_7 = arg_364_1:GetWordFromCfg(417071086)
				local var_367_8 = arg_364_1:FormatText(var_367_7.content)

				arg_364_1.text_.text = var_367_8

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_10 = 32 <= 0 and var_367_6 or var_367_6 * (utf8.len(var_367_8) / 32)

				if (32 <= 0 and var_367_6 or var_367_6 * (utf8.len(var_367_8) / 32)) > 0 and var_367_6 < var_367_10 then
					arg_364_1.talkMaxDuration = var_367_10

					if var_367_10 + var_367_5 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_10 + var_367_5
					end
				end

				arg_364_1.text_.text = var_367_8
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071086", "story_v_out_417071.awb") ~= 0 then
					local var_367_11 = manager.audio:GetVoiceLength("story_v_out_417071", "417071086", "story_v_out_417071.awb") / 1000

					if var_367_11 + var_367_5 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_11 + var_367_5
					end

					if var_367_7.prefab_name ~= "" and arg_364_1.actors_[var_367_7.prefab_name] ~= nil then
						local var_367_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_7.prefab_name].transform, "story_v_out_417071", "417071086", "story_v_out_417071.awb")

						arg_364_1:RecordAudio("417071086", var_367_12)
						arg_364_1:RecordAudio("417071086", var_367_12)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_417071", "417071086", "story_v_out_417071.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_417071", "417071086", "story_v_out_417071.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_13 = math.max(var_367_6, arg_364_1.talkMaxDuration)

			if var_367_5 <= arg_364_1.time_ and arg_364_1.time_ < var_367_5 + var_367_13 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_5) / var_367_13

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_5 + var_367_13 and arg_364_1.time_ < var_367_5 + var_367_13 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
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

		arg_364_1:InitPlayNodeList()
	end,
	Play417071087 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 417071087
		arg_368_1.duration_ = 7.43

		local var_368_0 = {
			zh = 6,
			ja = 7.433
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play417071088(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(arg_368_1.actors_["1034"]) and arg_368_1.var_.actorSpriteComps1034 == nil then
				arg_368_1.var_.actorSpriteComps1034 = arg_368_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_371_0 = 0.2

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 and not isNil(arg_368_1.actors_["1034"]) then
				if arg_368_1.var_.actorSpriteComps1034 then
					for iter_371_0, iter_371_1 in pairs(arg_368_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_371_1 then
							if arg_368_1.isInRecall_ then
								iter_371_1.color = Color.New(Mathf.Lerp(iter_371_1.color.r, arg_368_1.hightColor2.r, (arg_368_1.time_ - 0) / var_371_0), Mathf.Lerp(iter_371_1.color.g, arg_368_1.hightColor2.g, (arg_368_1.time_ - 0) / var_371_0), (Mathf.Lerp(iter_371_1.color.b, arg_368_1.hightColor2.b, (arg_368_1.time_ - 0) / var_371_0)))
							else
								local var_371_1 = Mathf.Lerp(iter_371_1.color.r, 0.5, (arg_368_1.time_ - 0) / var_371_0)

								iter_371_1.color = Color.New(var_371_1, var_371_1, var_371_1)
							end
						end
					end
				end
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 and not isNil(arg_368_1.actors_["1034"]) and arg_368_1.var_.actorSpriteComps1034 then
				for iter_371_2, iter_371_3 in pairs(arg_368_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_371_3 then
						iter_371_3.color = arg_368_1.isInRecall_ and (arg_368_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_368_1.var_.actorSpriteComps1034 = nil
			end

			local var_371_2 = 0
			local var_371_3 = 0.725

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_2 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_4 = arg_368_1:GetWordFromCfg(417071087)
				local var_371_5 = arg_368_1:FormatText(var_371_4.content)

				arg_368_1.text_.text = var_371_5

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_7 = 29 <= 0 and var_371_3 or var_371_3 * (utf8.len(var_371_5) / 29)

				if (29 <= 0 and var_371_3 or var_371_3 * (utf8.len(var_371_5) / 29)) > 0 and var_371_3 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_2 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_2
					end
				end

				arg_368_1.text_.text = var_371_5
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071087", "story_v_out_417071.awb") ~= 0 then
					local var_371_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071087", "story_v_out_417071.awb") / 1000

					if var_371_8 + var_371_2 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_2
					end

					if var_371_4.prefab_name ~= "" and arg_368_1.actors_[var_371_4.prefab_name] ~= nil then
						local var_371_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_4.prefab_name].transform, "story_v_out_417071", "417071087", "story_v_out_417071.awb")

						arg_368_1:RecordAudio("417071087", var_371_9)
						arg_368_1:RecordAudio("417071087", var_371_9)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_417071", "417071087", "story_v_out_417071.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_417071", "417071087", "story_v_out_417071.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_10 = math.max(var_371_3, arg_368_1.talkMaxDuration)

			if var_371_2 <= arg_368_1.time_ and arg_368_1.time_ < var_371_2 + var_371_10 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_2) / var_371_10

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_2 + var_371_10 and arg_368_1.time_ < var_371_2 + var_371_10 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play417071088 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 417071088
		arg_372_1.duration_ = 8.97

		local var_372_0 = {
			zh = 5.7,
			ja = 8.966
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play417071089(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["1034"]) and arg_372_1.var_.actorSpriteComps1034 == nil then
				arg_372_1.var_.actorSpriteComps1034 = arg_372_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_375_0 = 0.2

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["1034"]) then
				if arg_372_1.var_.actorSpriteComps1034 then
					for iter_375_0, iter_375_1 in pairs(arg_372_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_375_1 then
							if arg_372_1.isInRecall_ then
								iter_375_1.color = Color.New(Mathf.Lerp(iter_375_1.color.r, arg_372_1.hightColor1.r, (arg_372_1.time_ - 0) / var_375_0), Mathf.Lerp(iter_375_1.color.g, arg_372_1.hightColor1.g, (arg_372_1.time_ - 0) / var_375_0), (Mathf.Lerp(iter_375_1.color.b, arg_372_1.hightColor1.b, (arg_372_1.time_ - 0) / var_375_0)))
							else
								local var_375_1 = Mathf.Lerp(iter_375_1.color.r, 1, (arg_372_1.time_ - 0) / var_375_0)

								iter_375_1.color = Color.New(var_375_1, var_375_1, var_375_1)
							end
						end
					end
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["1034"]) and arg_372_1.var_.actorSpriteComps1034 then
				for iter_375_2, iter_375_3 in pairs(arg_372_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_375_3 then
						iter_375_3.color = arg_372_1.isInRecall_ and (arg_372_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_372_1.var_.actorSpriteComps1034 = nil
			end

			local var_375_2 = 0
			local var_375_3 = 0.6

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_2 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_4 = arg_372_1:GetWordFromCfg(417071088)
				local var_375_5 = arg_372_1:FormatText(var_375_4.content)

				arg_372_1.text_.text = var_375_5

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_7 = 24 <= 0 and var_375_3 or var_375_3 * (utf8.len(var_375_5) / 24)

				if (24 <= 0 and var_375_3 or var_375_3 * (utf8.len(var_375_5) / 24)) > 0 and var_375_3 < var_375_7 then
					arg_372_1.talkMaxDuration = var_375_7

					if var_375_7 + var_375_2 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_2
					end
				end

				arg_372_1.text_.text = var_375_5
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071088", "story_v_out_417071.awb") ~= 0 then
					local var_375_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071088", "story_v_out_417071.awb") / 1000

					if var_375_8 + var_375_2 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_8 + var_375_2
					end

					if var_375_4.prefab_name ~= "" and arg_372_1.actors_[var_375_4.prefab_name] ~= nil then
						local var_375_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_4.prefab_name].transform, "story_v_out_417071", "417071088", "story_v_out_417071.awb")

						arg_372_1:RecordAudio("417071088", var_375_9)
						arg_372_1:RecordAudio("417071088", var_375_9)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_417071", "417071088", "story_v_out_417071.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_417071", "417071088", "story_v_out_417071.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_10 = math.max(var_375_3, arg_372_1.talkMaxDuration)

			if var_375_2 <= arg_372_1.time_ and arg_372_1.time_ < var_375_2 + var_375_10 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_2) / var_375_10

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_2 + var_375_10 and arg_372_1.time_ < var_375_2 + var_375_10 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play417071089 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 417071089
		arg_376_1.duration_ = 3.5

		local var_376_0 = {
			zh = 3.5,
			ja = 3.133
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play417071090(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["1034"]) and arg_376_1.var_.actorSpriteComps1034 == nil then
				arg_376_1.var_.actorSpriteComps1034 = arg_376_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_0 = 0.2

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["1034"]) then
				if arg_376_1.var_.actorSpriteComps1034 then
					for iter_379_0, iter_379_1 in pairs(arg_376_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_379_1 then
							if arg_376_1.isInRecall_ then
								iter_379_1.color = Color.New(Mathf.Lerp(iter_379_1.color.r, arg_376_1.hightColor2.r, (arg_376_1.time_ - 0) / var_379_0), Mathf.Lerp(iter_379_1.color.g, arg_376_1.hightColor2.g, (arg_376_1.time_ - 0) / var_379_0), (Mathf.Lerp(iter_379_1.color.b, arg_376_1.hightColor2.b, (arg_376_1.time_ - 0) / var_379_0)))
							else
								local var_379_1 = Mathf.Lerp(iter_379_1.color.r, 0.5, (arg_376_1.time_ - 0) / var_379_0)

								iter_379_1.color = Color.New(var_379_1, var_379_1, var_379_1)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["1034"]) and arg_376_1.var_.actorSpriteComps1034 then
				for iter_379_2, iter_379_3 in pairs(arg_376_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_379_3 then
						iter_379_3.color = arg_376_1.isInRecall_ and (arg_376_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_376_1.var_.actorSpriteComps1034 = nil
			end

			local var_379_2 = 0
			local var_379_3 = 0.25

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_2 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_4 = arg_376_1:GetWordFromCfg(417071089)
				local var_379_5 = arg_376_1:FormatText(var_379_4.content)

				arg_376_1.text_.text = var_379_5

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_7 = 10 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 10)

				if (10 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 10)) > 0 and var_379_3 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_2
					end
				end

				arg_376_1.text_.text = var_379_5
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071089", "story_v_out_417071.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071089", "story_v_out_417071.awb") / 1000

					if var_379_8 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_2
					end

					if var_379_4.prefab_name ~= "" and arg_376_1.actors_[var_379_4.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_4.prefab_name].transform, "story_v_out_417071", "417071089", "story_v_out_417071.awb")

						arg_376_1:RecordAudio("417071089", var_379_9)
						arg_376_1:RecordAudio("417071089", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_417071", "417071089", "story_v_out_417071.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_417071", "417071089", "story_v_out_417071.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_10 = math.max(var_379_3, arg_376_1.talkMaxDuration)

			if var_379_2 <= arg_376_1.time_ and arg_376_1.time_ < var_379_2 + var_379_10 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_2) / var_379_10

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_2 + var_379_10 and arg_376_1.time_ < var_379_2 + var_379_10 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play417071090 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 417071090
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play417071091(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos1034 = arg_380_1.actors_["1034"].transform.localPosition
				arg_380_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_380_1:CheckSpriteTmpPos("1034", 7)

				for iter_383_0 = 0, arg_380_1.actors_["1034"].transform.childCount - 1 do
					local var_383_0 = arg_380_1.actors_["1034"].transform:GetChild(iter_383_0)

					if var_383_0.name == "" or not string.find(var_383_0.name, "split") then
						var_383_0.gameObject:SetActive(true)
					else
						var_383_0.gameObject:SetActive(false)
					end
				end
			end

			local var_383_1 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_1 then
				arg_380_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_380_1.time_ - 0) / var_383_1)
			end

			if arg_380_1.time_ >= 0 + var_383_1 and arg_380_1.time_ < 0 + var_383_1 + arg_383_0 then
				arg_380_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_383_2 = 0
			local var_383_3 = 0.85

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_2 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_4 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(417071090).content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_6 = 34 <= 0 and var_383_3 or var_383_3 * (utf8.len(var_383_4) / 34)

				if (34 <= 0 and var_383_3 or var_383_3 * (utf8.len(var_383_4) / 34)) > 0 and var_383_3 < var_383_6 then
					arg_380_1.talkMaxDuration = var_383_6

					if var_383_6 + var_383_2 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_6 + var_383_2
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_3, arg_380_1.talkMaxDuration)

			if var_383_2 <= arg_380_1.time_ and arg_380_1.time_ < var_383_2 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_2) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_2 + var_383_7 and arg_380_1.time_ < var_383_2 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
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

		arg_380_1:InitPlayNodeList()
	end,
	Play417071091 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 417071091
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play417071092(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.875

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_1 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(417071091).content)

				arg_384_1.text_.text = var_387_1

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_3 = 35 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_1) / 35)

				if (35 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_1) / 35)) > 0 and var_387_0 < var_387_3 then
					arg_384_1.talkMaxDuration = var_387_3

					if var_387_3 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_3 + 0
					end
				end

				arg_384_1.text_.text = var_387_1
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_4 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_4 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_4

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_4 and arg_384_1.time_ < 0 + var_387_4 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play417071092 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 417071092
		arg_388_1.duration_ = 3.13

		local var_388_0 = {
			zh = 1.566,
			ja = 3.133
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play417071093(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["1034"]) and arg_388_1.var_.actorSpriteComps1034 == nil then
				arg_388_1.var_.actorSpriteComps1034 = arg_388_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_0 = 0.2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["1034"]) then
				if arg_388_1.var_.actorSpriteComps1034 then
					for iter_391_0, iter_391_1 in pairs(arg_388_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_391_1 then
							if arg_388_1.isInRecall_ then
								iter_391_1.color = Color.New(Mathf.Lerp(iter_391_1.color.r, arg_388_1.hightColor1.r, (arg_388_1.time_ - 0) / var_391_0), Mathf.Lerp(iter_391_1.color.g, arg_388_1.hightColor1.g, (arg_388_1.time_ - 0) / var_391_0), (Mathf.Lerp(iter_391_1.color.b, arg_388_1.hightColor1.b, (arg_388_1.time_ - 0) / var_391_0)))
							else
								local var_391_1 = Mathf.Lerp(iter_391_1.color.r, 1, (arg_388_1.time_ - 0) / var_391_0)

								iter_391_1.color = Color.New(var_391_1, var_391_1, var_391_1)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["1034"]) and arg_388_1.var_.actorSpriteComps1034 then
				for iter_391_2, iter_391_3 in pairs(arg_388_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_391_3 then
						iter_391_3.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_388_1.var_.actorSpriteComps1034 = nil
			end

			local var_391_2 = 0
			local var_391_3 = 0.175

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_2 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_4")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_4 = arg_388_1:GetWordFromCfg(417071092)
				local var_391_5 = arg_388_1:FormatText(var_391_4.content)

				arg_388_1.text_.text = var_391_5

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_7 = 7 <= 0 and var_391_3 or var_391_3 * (utf8.len(var_391_5) / 7)

				if (7 <= 0 and var_391_3 or var_391_3 * (utf8.len(var_391_5) / 7)) > 0 and var_391_3 < var_391_7 then
					arg_388_1.talkMaxDuration = var_391_7

					if var_391_7 + var_391_2 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_7 + var_391_2
					end
				end

				arg_388_1.text_.text = var_391_5
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071092", "story_v_out_417071.awb") ~= 0 then
					local var_391_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071092", "story_v_out_417071.awb") / 1000

					if var_391_8 + var_391_2 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_8 + var_391_2
					end

					if var_391_4.prefab_name ~= "" and arg_388_1.actors_[var_391_4.prefab_name] ~= nil then
						local var_391_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_4.prefab_name].transform, "story_v_out_417071", "417071092", "story_v_out_417071.awb")

						arg_388_1:RecordAudio("417071092", var_391_9)
						arg_388_1:RecordAudio("417071092", var_391_9)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_417071", "417071092", "story_v_out_417071.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_417071", "417071092", "story_v_out_417071.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_10 = math.max(var_391_3, arg_388_1.talkMaxDuration)

			if var_391_2 <= arg_388_1.time_ and arg_388_1.time_ < var_391_2 + var_391_10 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_2) / var_391_10

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_2 + var_391_10 and arg_388_1.time_ < var_391_2 + var_391_10 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play417071093 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 417071093
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play417071094(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["1034"]) and arg_392_1.var_.actorSpriteComps1034 == nil then
				arg_392_1.var_.actorSpriteComps1034 = arg_392_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_0 = 0.2

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["1034"]) then
				if arg_392_1.var_.actorSpriteComps1034 then
					for iter_395_0, iter_395_1 in pairs(arg_392_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_395_1 then
							if arg_392_1.isInRecall_ then
								iter_395_1.color = Color.New(Mathf.Lerp(iter_395_1.color.r, arg_392_1.hightColor2.r, (arg_392_1.time_ - 0) / var_395_0), Mathf.Lerp(iter_395_1.color.g, arg_392_1.hightColor2.g, (arg_392_1.time_ - 0) / var_395_0), (Mathf.Lerp(iter_395_1.color.b, arg_392_1.hightColor2.b, (arg_392_1.time_ - 0) / var_395_0)))
							else
								local var_395_1 = Mathf.Lerp(iter_395_1.color.r, 0.5, (arg_392_1.time_ - 0) / var_395_0)

								iter_395_1.color = Color.New(var_395_1, var_395_1, var_395_1)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["1034"]) and arg_392_1.var_.actorSpriteComps1034 then
				for iter_395_2, iter_395_3 in pairs(arg_392_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_395_3 then
						iter_395_3.color = arg_392_1.isInRecall_ and (arg_392_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_392_1.var_.actorSpriteComps1034 = nil
			end

			if 0.05 < arg_392_1.time_ and arg_392_1.time_ <= 0.05 + arg_395_0 then
				arg_392_1:AudioAction("play", "effect", "se_story_136", "se_story_136_bodyfall", "")
			end

			if 0.65 < arg_392_1.time_ and arg_392_1.time_ <= 0.65 + arg_395_0 then
				arg_392_1:AudioAction("stop", "effect", "se_story_136", "se_story_136_bodyfall", "")
			end

			local var_395_4 = 0
			local var_395_5 = 0.85

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_4 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, false)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_6 = arg_392_1:FormatText(arg_392_1:GetWordFromCfg(417071093).content)

				arg_392_1.text_.text = var_395_6

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_8 = 34 <= 0 and var_395_5 or var_395_5 * (utf8.len(var_395_6) / 34)

				if (34 <= 0 and var_395_5 or var_395_5 * (utf8.len(var_395_6) / 34)) > 0 and var_395_5 < var_395_8 then
					arg_392_1.talkMaxDuration = var_395_8

					if var_395_8 + var_395_4 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_8 + var_395_4
					end
				end

				arg_392_1.text_.text = var_395_6
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_9 = math.max(var_395_5, arg_392_1.talkMaxDuration)

			if var_395_4 <= arg_392_1.time_ and arg_392_1.time_ < var_395_4 + var_395_9 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_4) / var_395_9

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_4 + var_395_9 and arg_392_1.time_ < var_395_4 + var_395_9 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play417071094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 417071094
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play417071095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0.233333333333333 < arg_396_1.time_ and arg_396_1.time_ <= 0.233333333333333 + arg_399_0 then
				arg_396_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_mask", "")
			end

			local var_399_1 = 0
			local var_399_2 = 1.675

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_3 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(417071094).content)

				arg_396_1.text_.text = var_399_3

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 67 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_3) / 67)

				if (67 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_3) / 67)) > 0 and var_399_2 < var_399_5 then
					arg_396_1.talkMaxDuration = var_399_5

					if var_399_5 + var_399_1 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_5 + var_399_1
					end
				end

				arg_396_1.text_.text = var_399_3
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_6 = math.max(var_399_2, arg_396_1.talkMaxDuration)

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_6 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_1) / var_399_6

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_1 + var_399_6 and arg_396_1.time_ < var_399_1 + var_399_6 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play417071095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 417071095
		arg_400_1.duration_ = 5.57

		local var_400_0 = {
			zh = 4.266,
			ja = 5.566
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play417071096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0.3

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_1 = arg_400_1:GetWordFromCfg(417071095)
				local var_403_2 = arg_400_1:FormatText(var_403_1.content)

				arg_400_1.text_.text = var_403_2

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_4 = 12 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_2) / 12)

				if (12 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_2) / 12)) > 0 and var_403_0 < var_403_4 then
					arg_400_1.talkMaxDuration = var_403_4

					if var_403_4 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_4 + 0
					end
				end

				arg_400_1.text_.text = var_403_2
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071095", "story_v_out_417071.awb") ~= 0 then
					local var_403_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071095", "story_v_out_417071.awb") / 1000

					if var_403_5 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_5 + 0
					end

					if var_403_1.prefab_name ~= "" and arg_400_1.actors_[var_403_1.prefab_name] ~= nil then
						local var_403_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_1.prefab_name].transform, "story_v_out_417071", "417071095", "story_v_out_417071.awb")

						arg_400_1:RecordAudio("417071095", var_403_6)
						arg_400_1:RecordAudio("417071095", var_403_6)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_417071", "417071095", "story_v_out_417071.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_417071", "417071095", "story_v_out_417071.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_7 = math.max(var_403_0, arg_400_1.talkMaxDuration)

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_7 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - 0) / var_403_7

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= 0 + var_403_7 and arg_400_1.time_ < 0 + var_403_7 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play417071096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 417071096
		arg_404_1.duration_ = 5.5

		local var_404_0 = {
			zh = 3.666,
			ja = 5.5
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play417071097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0.3

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[1132].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_1 = arg_404_1:GetWordFromCfg(417071096)
				local var_407_2 = arg_404_1:FormatText(var_407_1.content)

				arg_404_1.text_.text = var_407_2

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 12 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 12)

				if (12 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 12)) > 0 and var_407_0 < var_407_4 then
					arg_404_1.talkMaxDuration = var_407_4

					if var_407_4 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_4 + 0
					end
				end

				arg_404_1.text_.text = var_407_2
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071096", "story_v_out_417071.awb") ~= 0 then
					local var_407_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071096", "story_v_out_417071.awb") / 1000

					if var_407_5 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_5 + 0
					end

					if var_407_1.prefab_name ~= "" and arg_404_1.actors_[var_407_1.prefab_name] ~= nil then
						local var_407_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_1.prefab_name].transform, "story_v_out_417071", "417071096", "story_v_out_417071.awb")

						arg_404_1:RecordAudio("417071096", var_407_6)
						arg_404_1:RecordAudio("417071096", var_407_6)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_417071", "417071096", "story_v_out_417071.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_417071", "417071096", "story_v_out_417071.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_0, arg_404_1.talkMaxDuration)

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - 0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= 0 + var_407_7 and arg_404_1.time_ < 0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play417071097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 417071097
		arg_408_1.duration_ = 13.63

		local var_408_0 = {
			zh = 6.833,
			ja = 13.633
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play417071098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0.9

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_1 = arg_408_1:GetWordFromCfg(417071097)
				local var_411_2 = arg_408_1:FormatText(var_411_1.content)

				arg_408_1.text_.text = var_411_2

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 36 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 36)

				if (36 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 36)) > 0 and var_411_0 < var_411_4 then
					arg_408_1.talkMaxDuration = var_411_4

					if var_411_4 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_4 + 0
					end
				end

				arg_408_1.text_.text = var_411_2
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071097", "story_v_out_417071.awb") ~= 0 then
					local var_411_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071097", "story_v_out_417071.awb") / 1000

					if var_411_5 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_5 + 0
					end

					if var_411_1.prefab_name ~= "" and arg_408_1.actors_[var_411_1.prefab_name] ~= nil then
						local var_411_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_1.prefab_name].transform, "story_v_out_417071", "417071097", "story_v_out_417071.awb")

						arg_408_1:RecordAudio("417071097", var_411_6)
						arg_408_1:RecordAudio("417071097", var_411_6)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_417071", "417071097", "story_v_out_417071.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_417071", "417071097", "story_v_out_417071.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_7 and arg_408_1.time_ < 0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play417071098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 417071098
		arg_412_1.duration_ = 3.5

		local var_412_0 = {
			zh = 1.6,
			ja = 3.5
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play417071099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0.175

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[1132].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_1 = arg_412_1:GetWordFromCfg(417071098)
				local var_415_2 = arg_412_1:FormatText(var_415_1.content)

				arg_412_1.text_.text = var_415_2

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_4 = 7 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 7)

				if (7 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 7)) > 0 and var_415_0 < var_415_4 then
					arg_412_1.talkMaxDuration = var_415_4

					if var_415_4 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_4 + 0
					end
				end

				arg_412_1.text_.text = var_415_2
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071098", "story_v_out_417071.awb") ~= 0 then
					local var_415_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071098", "story_v_out_417071.awb") / 1000

					if var_415_5 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_5 + 0
					end

					if var_415_1.prefab_name ~= "" and arg_412_1.actors_[var_415_1.prefab_name] ~= nil then
						local var_415_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_1.prefab_name].transform, "story_v_out_417071", "417071098", "story_v_out_417071.awb")

						arg_412_1:RecordAudio("417071098", var_415_6)
						arg_412_1:RecordAudio("417071098", var_415_6)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_417071", "417071098", "story_v_out_417071.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_417071", "417071098", "story_v_out_417071.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_7 = math.max(var_415_0, arg_412_1.talkMaxDuration)

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_7 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - 0) / var_415_7

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= 0 + var_415_7 and arg_412_1.time_ < 0 + var_415_7 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play417071099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 417071099
		arg_416_1.duration_ = 13.2

		local var_416_0 = {
			zh = 8.833,
			ja = 13.2
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play417071100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 1.075

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_1 = arg_416_1:GetWordFromCfg(417071099)
				local var_419_2 = arg_416_1:FormatText(var_419_1.content)

				arg_416_1.text_.text = var_419_2

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 43 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 43)

				if (43 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 43)) > 0 and var_419_0 < var_419_4 then
					arg_416_1.talkMaxDuration = var_419_4

					if var_419_4 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_4 + 0
					end
				end

				arg_416_1.text_.text = var_419_2
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071099", "story_v_out_417071.awb") ~= 0 then
					local var_419_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071099", "story_v_out_417071.awb") / 1000

					if var_419_5 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + 0
					end

					if var_419_1.prefab_name ~= "" and arg_416_1.actors_[var_419_1.prefab_name] ~= nil then
						local var_419_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_1.prefab_name].transform, "story_v_out_417071", "417071099", "story_v_out_417071.awb")

						arg_416_1:RecordAudio("417071099", var_419_6)
						arg_416_1:RecordAudio("417071099", var_419_6)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_417071", "417071099", "story_v_out_417071.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_417071", "417071099", "story_v_out_417071.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play417071100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 417071100
		arg_420_1.duration_ = 7.03

		local var_420_0 = {
			zh = 7.033,
			ja = 2.433
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play417071101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0.925

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_420_1.callingController_:SetSelectedState("normal")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_1 = arg_420_1:GetWordFromCfg(417071100)
				local var_423_2 = arg_420_1:FormatText(var_423_1.content)

				arg_420_1.text_.text = var_423_2

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_4 = 37 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 37)

				if (37 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 37)) > 0 and var_423_0 < var_423_4 then
					arg_420_1.talkMaxDuration = var_423_4

					if var_423_4 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_4 + 0
					end
				end

				arg_420_1.text_.text = var_423_2
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071100", "story_v_out_417071.awb") ~= 0 then
					local var_423_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071100", "story_v_out_417071.awb") / 1000

					if var_423_5 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_5 + 0
					end

					if var_423_1.prefab_name ~= "" and arg_420_1.actors_[var_423_1.prefab_name] ~= nil then
						local var_423_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_1.prefab_name].transform, "story_v_out_417071", "417071100", "story_v_out_417071.awb")

						arg_420_1:RecordAudio("417071100", var_423_6)
						arg_420_1:RecordAudio("417071100", var_423_6)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_417071", "417071100", "story_v_out_417071.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_417071", "417071100", "story_v_out_417071.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_7 = math.max(var_423_0, arg_420_1.talkMaxDuration)

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_7 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - 0) / var_423_7

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= 0 + var_423_7 and arg_420_1.time_ < 0 + var_423_7 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play417071101 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 417071101
		arg_424_1.duration_ = 3.47

		local var_424_0 = {
			zh = 2.566,
			ja = 3.466
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play417071102(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0.35

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[1132].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_1 = arg_424_1:GetWordFromCfg(417071101)
				local var_427_2 = arg_424_1:FormatText(var_427_1.content)

				arg_424_1.text_.text = var_427_2

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_4 = 14 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_2) / 14)

				if (14 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_2) / 14)) > 0 and var_427_0 < var_427_4 then
					arg_424_1.talkMaxDuration = var_427_4

					if var_427_4 + 0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_4 + 0
					end
				end

				arg_424_1.text_.text = var_427_2
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071101", "story_v_out_417071.awb") ~= 0 then
					local var_427_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071101", "story_v_out_417071.awb") / 1000

					if var_427_5 + 0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_5 + 0
					end

					if var_427_1.prefab_name ~= "" and arg_424_1.actors_[var_427_1.prefab_name] ~= nil then
						local var_427_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_1.prefab_name].transform, "story_v_out_417071", "417071101", "story_v_out_417071.awb")

						arg_424_1:RecordAudio("417071101", var_427_6)
						arg_424_1:RecordAudio("417071101", var_427_6)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_417071", "417071101", "story_v_out_417071.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_417071", "417071101", "story_v_out_417071.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_7 = math.max(var_427_0, arg_424_1.talkMaxDuration)

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_7 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - 0) / var_427_7

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= 0 + var_427_7 and arg_424_1.time_ < 0 + var_427_7 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play417071102 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 417071102
		arg_428_1.duration_ = 8.5

		local var_428_0 = {
			zh = 8.5,
			ja = 8.466
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play417071103(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0.75

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_1 = arg_428_1:GetWordFromCfg(417071102)
				local var_431_2 = arg_428_1:FormatText(var_431_1.content)

				arg_428_1.text_.text = var_431_2

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_4 = 30 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_2) / 30)

				if (30 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_2) / 30)) > 0 and var_431_0 < var_431_4 then
					arg_428_1.talkMaxDuration = var_431_4

					if var_431_4 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_4 + 0
					end
				end

				arg_428_1.text_.text = var_431_2
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071102", "story_v_out_417071.awb") ~= 0 then
					local var_431_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071102", "story_v_out_417071.awb") / 1000

					if var_431_5 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_5 + 0
					end

					if var_431_1.prefab_name ~= "" and arg_428_1.actors_[var_431_1.prefab_name] ~= nil then
						local var_431_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_1.prefab_name].transform, "story_v_out_417071", "417071102", "story_v_out_417071.awb")

						arg_428_1:RecordAudio("417071102", var_431_6)
						arg_428_1:RecordAudio("417071102", var_431_6)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_417071", "417071102", "story_v_out_417071.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_417071", "417071102", "story_v_out_417071.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_7 = math.max(var_431_0, arg_428_1.talkMaxDuration)

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_7 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - 0) / var_431_7

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= 0 + var_431_7 and arg_428_1.time_ < 0 + var_431_7 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play417071103 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 417071103
		arg_432_1.duration_ = 14.17

		local var_432_0 = {
			zh = 14.166,
			ja = 12.666
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play417071104(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 1.275

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_1 = arg_432_1:GetWordFromCfg(417071103)
				local var_435_2 = arg_432_1:FormatText(var_435_1.content)

				arg_432_1.text_.text = var_435_2

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_4 = 51 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_2) / 51)

				if (51 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_2) / 51)) > 0 and var_435_0 < var_435_4 then
					arg_432_1.talkMaxDuration = var_435_4

					if var_435_4 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_4 + 0
					end
				end

				arg_432_1.text_.text = var_435_2
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071103", "story_v_out_417071.awb") ~= 0 then
					local var_435_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071103", "story_v_out_417071.awb") / 1000

					if var_435_5 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_5 + 0
					end

					if var_435_1.prefab_name ~= "" and arg_432_1.actors_[var_435_1.prefab_name] ~= nil then
						local var_435_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_1.prefab_name].transform, "story_v_out_417071", "417071103", "story_v_out_417071.awb")

						arg_432_1:RecordAudio("417071103", var_435_6)
						arg_432_1:RecordAudio("417071103", var_435_6)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_417071", "417071103", "story_v_out_417071.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_417071", "417071103", "story_v_out_417071.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_7 = math.max(var_435_0, arg_432_1.talkMaxDuration)

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_7 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - 0) / var_435_7

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= 0 + var_435_7 and arg_432_1.time_ < 0 + var_435_7 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play417071104 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 417071104
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play417071105(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0.725

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_1 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(417071104).content)

				arg_436_1.text_.text = var_439_1

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_3 = 29 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_1) / 29)

				if (29 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_1) / 29)) > 0 and var_439_0 < var_439_3 then
					arg_436_1.talkMaxDuration = var_439_3

					if var_439_3 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_3 + 0
					end
				end

				arg_436_1.text_.text = var_439_1
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_4 = math.max(var_439_0, arg_436_1.talkMaxDuration)

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_4 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - 0) / var_439_4

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= 0 + var_439_4 and arg_436_1.time_ < 0 + var_439_4 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play417071105 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 417071105
		arg_440_1.duration_ = 5.2

		local var_440_0 = {
			zh = 5.2,
			ja = 2.2
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play417071106(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0.35

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_1 = arg_440_1:GetWordFromCfg(417071105)
				local var_443_2 = arg_440_1:FormatText(var_443_1.content)

				arg_440_1.text_.text = var_443_2

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_4 = 14 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 14)

				if (14 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 14)) > 0 and var_443_0 < var_443_4 then
					arg_440_1.talkMaxDuration = var_443_4

					if var_443_4 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_4 + 0
					end
				end

				arg_440_1.text_.text = var_443_2
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071105", "story_v_out_417071.awb") ~= 0 then
					local var_443_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071105", "story_v_out_417071.awb") / 1000

					if var_443_5 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + 0
					end

					if var_443_1.prefab_name ~= "" and arg_440_1.actors_[var_443_1.prefab_name] ~= nil then
						local var_443_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_1.prefab_name].transform, "story_v_out_417071", "417071105", "story_v_out_417071.awb")

						arg_440_1:RecordAudio("417071105", var_443_6)
						arg_440_1:RecordAudio("417071105", var_443_6)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_417071", "417071105", "story_v_out_417071.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_417071", "417071105", "story_v_out_417071.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_7 = math.max(var_443_0, arg_440_1.talkMaxDuration)

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_7 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - 0) / var_443_7

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= 0 + var_443_7 and arg_440_1.time_ < 0 + var_443_7 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play417071106 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 417071106
		arg_444_1.duration_ = 8.97

		local var_444_0 = {
			zh = 4.2,
			ja = 8.966
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play417071107(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(arg_444_1.actors_["1034"]) and arg_444_1.var_.actorSpriteComps1034 == nil then
				arg_444_1.var_.actorSpriteComps1034 = arg_444_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_0 = 0.2

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 and not isNil(arg_444_1.actors_["1034"]) then
				if arg_444_1.var_.actorSpriteComps1034 then
					for iter_447_0, iter_447_1 in pairs(arg_444_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_447_1 then
							if arg_444_1.isInRecall_ then
								iter_447_1.color = Color.New(Mathf.Lerp(iter_447_1.color.r, arg_444_1.hightColor1.r, (arg_444_1.time_ - 0) / var_447_0), Mathf.Lerp(iter_447_1.color.g, arg_444_1.hightColor1.g, (arg_444_1.time_ - 0) / var_447_0), (Mathf.Lerp(iter_447_1.color.b, arg_444_1.hightColor1.b, (arg_444_1.time_ - 0) / var_447_0)))
							else
								local var_447_1 = Mathf.Lerp(iter_447_1.color.r, 1, (arg_444_1.time_ - 0) / var_447_0)

								iter_447_1.color = Color.New(var_447_1, var_447_1, var_447_1)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 and not isNil(arg_444_1.actors_["1034"]) and arg_444_1.var_.actorSpriteComps1034 then
				for iter_447_2, iter_447_3 in pairs(arg_444_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_447_3 then
						iter_447_3.color = arg_444_1.isInRecall_ and (arg_444_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_444_1.var_.actorSpriteComps1034 = nil
			end

			if arg_444_1.frameCnt_ <= 1 then
				arg_444_1.dialog_:SetActive(false)
			end

			local var_447_2 = 0.2
			local var_447_3 = 0.425

			if 0.2 < arg_444_1.time_ and arg_444_1.time_ <= var_447_2 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0

				arg_444_1.dialog_:SetActive(true)

				arg_444_1.dialogCg_.alpha = 0

				local var_447_4 = LeanTween.value(arg_444_1.dialog_, 0, 1, 0.3)

				var_447_4:setOnUpdate(LuaHelper.FloatAction(function(arg_448_0)
					arg_444_1.dialogCg_.alpha = arg_448_0
				end))
				var_447_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_444_1.dialog_)
					var_447_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_444_1.duration_ = arg_444_1.duration_ + 0.3

				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_7")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_5 = arg_444_1:GetWordFromCfg(417071106)
				local var_447_6 = arg_444_1:FormatText(var_447_5.content)

				arg_444_1.text_.text = var_447_6

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_8 = 17 <= 0 and var_447_3 or var_447_3 * (utf8.len(var_447_6) / 17)

				if (17 <= 0 and var_447_3 or var_447_3 * (utf8.len(var_447_6) / 17)) > 0 and var_447_3 < var_447_8 then
					arg_444_1.talkMaxDuration = var_447_8
					var_447_2 = var_447_2 + 0.3

					if var_447_8 + var_447_2 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_8 + var_447_2
					end
				end

				arg_444_1.text_.text = var_447_6
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071106", "story_v_out_417071.awb") ~= 0 then
					local var_447_9 = manager.audio:GetVoiceLength("story_v_out_417071", "417071106", "story_v_out_417071.awb") / 1000

					if var_447_9 + var_447_2 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_9 + var_447_2
					end

					if var_447_5.prefab_name ~= "" and arg_444_1.actors_[var_447_5.prefab_name] ~= nil then
						local var_447_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_5.prefab_name].transform, "story_v_out_417071", "417071106", "story_v_out_417071.awb")

						arg_444_1:RecordAudio("417071106", var_447_10)
						arg_444_1:RecordAudio("417071106", var_447_10)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_417071", "417071106", "story_v_out_417071.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_417071", "417071106", "story_v_out_417071.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_11 = var_447_2 + 0.3
			local var_447_12 = math.max(var_447_3, arg_444_1.talkMaxDuration)

			if var_447_2 + 0.3 <= arg_444_1.time_ and arg_444_1.time_ < var_447_11 + var_447_12 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_11) / var_447_12

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_11 + var_447_12 and arg_444_1.time_ < var_447_11 + var_447_12 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play417071107 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 417071107
		arg_450_1.duration_ = 1.27

		local var_450_0 = {
			zh = 1.1,
			ja = 1.266
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play417071108(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(arg_450_1.actors_["1034"]) and arg_450_1.var_.actorSpriteComps1034 == nil then
				arg_450_1.var_.actorSpriteComps1034 = arg_450_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_0 = 0.2

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 and not isNil(arg_450_1.actors_["1034"]) then
				if arg_450_1.var_.actorSpriteComps1034 then
					for iter_453_0, iter_453_1 in pairs(arg_450_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_453_1 then
							if arg_450_1.isInRecall_ then
								iter_453_1.color = Color.New(Mathf.Lerp(iter_453_1.color.r, arg_450_1.hightColor2.r, (arg_450_1.time_ - 0) / var_453_0), Mathf.Lerp(iter_453_1.color.g, arg_450_1.hightColor2.g, (arg_450_1.time_ - 0) / var_453_0), (Mathf.Lerp(iter_453_1.color.b, arg_450_1.hightColor2.b, (arg_450_1.time_ - 0) / var_453_0)))
							else
								local var_453_1 = Mathf.Lerp(iter_453_1.color.r, 0.5, (arg_450_1.time_ - 0) / var_453_0)

								iter_453_1.color = Color.New(var_453_1, var_453_1, var_453_1)
							end
						end
					end
				end
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 and not isNil(arg_450_1.actors_["1034"]) and arg_450_1.var_.actorSpriteComps1034 then
				for iter_453_2, iter_453_3 in pairs(arg_450_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_453_3 then
						iter_453_3.color = arg_450_1.isInRecall_ and (arg_450_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_450_1.var_.actorSpriteComps1034 = nil
			end

			local var_453_2 = 0
			local var_453_3 = 0.05

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_2 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_4 = arg_450_1:GetWordFromCfg(417071107)
				local var_453_5 = arg_450_1:FormatText(var_453_4.content)

				arg_450_1.text_.text = var_453_5

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_7 = 2 <= 0 and var_453_3 or var_453_3 * (utf8.len(var_453_5) / 2)

				if (2 <= 0 and var_453_3 or var_453_3 * (utf8.len(var_453_5) / 2)) > 0 and var_453_3 < var_453_7 then
					arg_450_1.talkMaxDuration = var_453_7

					if var_453_7 + var_453_2 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_7 + var_453_2
					end
				end

				arg_450_1.text_.text = var_453_5
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071107", "story_v_out_417071.awb") ~= 0 then
					local var_453_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071107", "story_v_out_417071.awb") / 1000

					if var_453_8 + var_453_2 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_8 + var_453_2
					end

					if var_453_4.prefab_name ~= "" and arg_450_1.actors_[var_453_4.prefab_name] ~= nil then
						local var_453_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_4.prefab_name].transform, "story_v_out_417071", "417071107", "story_v_out_417071.awb")

						arg_450_1:RecordAudio("417071107", var_453_9)
						arg_450_1:RecordAudio("417071107", var_453_9)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_417071", "417071107", "story_v_out_417071.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_417071", "417071107", "story_v_out_417071.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_10 = math.max(var_453_3, arg_450_1.talkMaxDuration)

			if var_453_2 <= arg_450_1.time_ and arg_450_1.time_ < var_453_2 + var_453_10 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_2) / var_453_10

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_2 + var_453_10 and arg_450_1.time_ < var_453_2 + var_453_10 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play417071108 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 417071108
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play417071109(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0.775

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, false)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_1 = arg_454_1:FormatText(arg_454_1:GetWordFromCfg(417071108).content)

				arg_454_1.text_.text = var_457_1

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_3 = 31 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 31)

				if (31 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 31)) > 0 and var_457_0 < var_457_3 then
					arg_454_1.talkMaxDuration = var_457_3

					if var_457_3 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_3 + 0
					end
				end

				arg_454_1.text_.text = var_457_1
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_4 = math.max(var_457_0, arg_454_1.talkMaxDuration)

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_4 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - 0) / var_457_4

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= 0 + var_457_4 and arg_454_1.time_ < 0 + var_457_4 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play417071109 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 417071109
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play417071110(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0.466666666666667 < arg_458_1.time_ and arg_458_1.time_ <= 0.466666666666667 + arg_461_0 then
				arg_458_1:AudioAction("play", "effect", "se_story_128", "se_story_128_stab", "")
			end

			if 0.666666666666667 < arg_458_1.time_ and arg_458_1.time_ <= 0.666666666666667 + arg_461_0 then
				arg_458_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_stab2", "")
			end

			local var_461_2 = 0
			local var_461_3 = 1.05

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_2 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_4 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(417071109).content)

				arg_458_1.text_.text = var_461_4

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_6 = 42 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_4) / 42)

				if (42 <= 0 and var_461_3 or var_461_3 * (utf8.len(var_461_4) / 42)) > 0 and var_461_3 < var_461_6 then
					arg_458_1.talkMaxDuration = var_461_6

					if var_461_6 + var_461_2 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_6 + var_461_2
					end
				end

				arg_458_1.text_.text = var_461_4
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_7 = math.max(var_461_3, arg_458_1.talkMaxDuration)

			if var_461_2 <= arg_458_1.time_ and arg_458_1.time_ < var_461_2 + var_461_7 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_2) / var_461_7

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_2 + var_461_7 and arg_458_1.time_ < var_461_2 + var_461_7 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play417071110 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 417071110
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play417071111(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0.9

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, false)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_1 = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(417071110).content)

				arg_462_1.text_.text = var_465_1

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_3 = 36 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 36)

				if (36 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 36)) > 0 and var_465_0 < var_465_3 then
					arg_462_1.talkMaxDuration = var_465_3

					if var_465_3 + 0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_3 + 0
					end
				end

				arg_462_1.text_.text = var_465_1
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_4 = math.max(var_465_0, arg_462_1.talkMaxDuration)

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_4 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - 0) / var_465_4

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= 0 + var_465_4 and arg_462_1.time_ < 0 + var_465_4 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play417071111 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 417071111
		arg_466_1.duration_ = 3.1

		local var_466_0 = {
			zh = 3.1,
			ja = 2.8
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play417071112(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0.2

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_1 = arg_466_1:GetWordFromCfg(417071111)
				local var_469_2 = arg_466_1:FormatText(var_469_1.content)

				arg_466_1.text_.text = var_469_2

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_4 = 8 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_2) / 8)

				if (8 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_2) / 8)) > 0 and var_469_0 < var_469_4 then
					arg_466_1.talkMaxDuration = var_469_4

					if var_469_4 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_4 + 0
					end
				end

				arg_466_1.text_.text = var_469_2
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071111", "story_v_out_417071.awb") ~= 0 then
					local var_469_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071111", "story_v_out_417071.awb") / 1000

					if var_469_5 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_5 + 0
					end

					if var_469_1.prefab_name ~= "" and arg_466_1.actors_[var_469_1.prefab_name] ~= nil then
						local var_469_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_1.prefab_name].transform, "story_v_out_417071", "417071111", "story_v_out_417071.awb")

						arg_466_1:RecordAudio("417071111", var_469_6)
						arg_466_1:RecordAudio("417071111", var_469_6)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_417071", "417071111", "story_v_out_417071.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_417071", "417071111", "story_v_out_417071.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_7 = math.max(var_469_0, arg_466_1.talkMaxDuration)

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_7 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - 0) / var_469_7

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= 0 + var_469_7 and arg_466_1.time_ < 0 + var_469_7 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play417071112 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 417071112
		arg_470_1.duration_ = 2.73

		local var_470_0 = {
			zh = 2.6,
			ja = 2.733
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play417071113(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0.15

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[1131].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, true)
				arg_470_1.iconController_:SetSelectedState("hero")

				arg_470_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_470_1.callingController_:SetSelectedState("normal")

				arg_470_1.keyicon_.color = Color.New(1, 1, 1)
				arg_470_1.icon_.color = Color.New(1, 1, 1)

				local var_473_1 = arg_470_1:GetWordFromCfg(417071112)
				local var_473_2 = arg_470_1:FormatText(var_473_1.content)

				arg_470_1.text_.text = var_473_2

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_4 = 6 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 6)

				if (6 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 6)) > 0 and var_473_0 < var_473_4 then
					arg_470_1.talkMaxDuration = var_473_4

					if var_473_4 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_4 + 0
					end
				end

				arg_470_1.text_.text = var_473_2
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071112", "story_v_out_417071.awb") ~= 0 then
					local var_473_5 = manager.audio:GetVoiceLength("story_v_out_417071", "417071112", "story_v_out_417071.awb") / 1000

					if var_473_5 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_5 + 0
					end

					if var_473_1.prefab_name ~= "" and arg_470_1.actors_[var_473_1.prefab_name] ~= nil then
						local var_473_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_1.prefab_name].transform, "story_v_out_417071", "417071112", "story_v_out_417071.awb")

						arg_470_1:RecordAudio("417071112", var_473_6)
						arg_470_1:RecordAudio("417071112", var_473_6)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_417071", "417071112", "story_v_out_417071.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_417071", "417071112", "story_v_out_417071.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_7 = math.max(var_473_0, arg_470_1.talkMaxDuration)

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_7 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - 0) / var_473_7

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= 0 + var_473_7 and arg_470_1.time_ < 0 + var_473_7 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play417071113 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 417071113
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play417071114(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0.9

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_1 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(417071113).content)

				arg_474_1.text_.text = var_477_1

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_3 = 36 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_1) / 36)

				if (36 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_1) / 36)) > 0 and var_477_0 < var_477_3 then
					arg_474_1.talkMaxDuration = var_477_3

					if var_477_3 + 0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_3 + 0
					end
				end

				arg_474_1.text_.text = var_477_1
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_4 = math.max(var_477_0, arg_474_1.talkMaxDuration)

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_4 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - 0) / var_477_4

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= 0 + var_477_4 and arg_474_1.time_ < 0 + var_477_4 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play417071114 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 417071114
		arg_478_1.duration_ = 6.53

		local var_478_0 = {
			zh = 5.5,
			ja = 6.533
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
			arg_478_1.auto_ = false
		end

		function arg_478_1.playNext_(arg_480_0)
			arg_478_1.onStoryFinished_()
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(arg_478_1.actors_["1034"]) and arg_478_1.var_.actorSpriteComps1034 == nil then
				arg_478_1.var_.actorSpriteComps1034 = arg_478_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_481_0 = 0.2

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_0 and not isNil(arg_478_1.actors_["1034"]) then
				if arg_478_1.var_.actorSpriteComps1034 then
					for iter_481_0, iter_481_1 in pairs(arg_478_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_481_1 then
							if arg_478_1.isInRecall_ then
								iter_481_1.color = Color.New(Mathf.Lerp(iter_481_1.color.r, arg_478_1.hightColor1.r, (arg_478_1.time_ - 0) / var_481_0), Mathf.Lerp(iter_481_1.color.g, arg_478_1.hightColor1.g, (arg_478_1.time_ - 0) / var_481_0), (Mathf.Lerp(iter_481_1.color.b, arg_478_1.hightColor1.b, (arg_478_1.time_ - 0) / var_481_0)))
							else
								local var_481_1 = Mathf.Lerp(iter_481_1.color.r, 1, (arg_478_1.time_ - 0) / var_481_0)

								iter_481_1.color = Color.New(var_481_1, var_481_1, var_481_1)
							end
						end
					end
				end
			end

			if arg_478_1.time_ >= 0 + var_481_0 and arg_478_1.time_ < 0 + var_481_0 + arg_481_0 and not isNil(arg_478_1.actors_["1034"]) and arg_478_1.var_.actorSpriteComps1034 then
				for iter_481_2, iter_481_3 in pairs(arg_478_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_481_3 then
						iter_481_3.color = arg_478_1.isInRecall_ and (arg_478_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_478_1.var_.actorSpriteComps1034 = nil
			end

			local var_481_2 = 0
			local var_481_3 = 0.525

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_2 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_4")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_4 = arg_478_1:GetWordFromCfg(417071114)
				local var_481_5 = arg_478_1:FormatText(var_481_4.content)

				arg_478_1.text_.text = var_481_5

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_7 = 21 <= 0 and var_481_3 or var_481_3 * (utf8.len(var_481_5) / 21)

				if (21 <= 0 and var_481_3 or var_481_3 * (utf8.len(var_481_5) / 21)) > 0 and var_481_3 < var_481_7 then
					arg_478_1.talkMaxDuration = var_481_7

					if var_481_7 + var_481_2 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_7 + var_481_2
					end
				end

				arg_478_1.text_.text = var_481_5
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417071", "417071114", "story_v_out_417071.awb") ~= 0 then
					local var_481_8 = manager.audio:GetVoiceLength("story_v_out_417071", "417071114", "story_v_out_417071.awb") / 1000

					if var_481_8 + var_481_2 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_8 + var_481_2
					end

					if var_481_4.prefab_name ~= "" and arg_478_1.actors_[var_481_4.prefab_name] ~= nil then
						local var_481_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_4.prefab_name].transform, "story_v_out_417071", "417071114", "story_v_out_417071.awb")

						arg_478_1:RecordAudio("417071114", var_481_9)
						arg_478_1:RecordAudio("417071114", var_481_9)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_417071", "417071114", "story_v_out_417071.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_417071", "417071114", "story_v_out_417071.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_10 = math.max(var_481_3, arg_478_1.talkMaxDuration)

			if var_481_2 <= arg_478_1.time_ and arg_478_1.time_ < var_481_2 + var_481_10 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_2) / var_481_10

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_2 + var_481_10 and arg_478_1.time_ < var_481_2 + var_481_10 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/B08b",
		"TextureConfig/Background/B01"
	},
	voices = {
		"story_v_out_417071.awb"
	}
}
