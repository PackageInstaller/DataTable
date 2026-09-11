return {
	Play417191001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417191001
		arg_1_1.duration_ = 9.2

		local var_1_0 = {
			zh = 8.9,
			ja = 9.2
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
				arg_1_0:Play417191002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST73 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST73")
				var_4_0.name = "ST73"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST73 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST73

				arg_1_1.bgs_.ST73.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST73" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST73")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501059).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501060).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_4 + 5 and arg_1_1.time_ < var_4_4 + 5 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_5 = 5

			if 5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 1.2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				var_4_8.a = 1
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = 6.2

			if 6.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_10 = 1.2

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_10 then
				local var_4_11 = Color.New(0, 0, 0)

				var_4_11.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_9) / var_4_10)
				arg_1_1.mask_.color = var_4_11
			end

			if arg_1_1.time_ >= var_4_9 + var_4_10 and arg_1_1.time_ < var_4_9 + var_4_10 + arg_4_0 then
				local var_4_12 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_12.a = 0
				arg_1_1.mask_.color = var_4_12
			end

			local var_4_13 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_13 + 6.2 and arg_1_1.time_ < var_4_13 + 6.2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_14 = "10113"

			if arg_1_1.actors_["10113"] == nil then
				local var_4_15 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_4_15) then
					local var_4_16 = Object.Instantiate(var_4_15, arg_1_1.canvasGo_.transform)

					var_4_16.transform:SetSiblingIndex(1)

					var_4_16.name = var_4_14
					var_4_16.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_14] = var_4_16

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs((var_4_16:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_17 = arg_1_1.actors_["10113"]

			if 7.06666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 7.06666666666667 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.actorSpriteComps10113 == nil then
				arg_1_1.var_.actorSpriteComps10113 = var_4_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_18 = 0.2

			if 7.06666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 7.06666666666667 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.actorSpriteComps10113 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 7.06666666666667) / var_4_18), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 7.06666666666667) / var_4_18), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 7.06666666666667) / var_4_18)))
							else
								local var_4_19 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 7.06666666666667) / var_4_18)

								iter_4_5.color = Color.New(var_4_19, var_4_19, var_4_19)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 7.06666666666667 + var_4_18 and arg_1_1.time_ < 7.06666666666667 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.actorSpriteComps10113 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10113 = nil
			end

			local var_4_20 = arg_1_1.actors_["10113"].transform

			if 7.06666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 7.06666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos10113 = var_4_20.localPosition
				var_4_20.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10113", 3)

				for iter_4_8 = 0, var_4_20.childCount - 1 do
					local var_4_21 = var_4_20:GetChild(iter_4_8)

					if var_4_21.name == "split_3" or not string.find(var_4_21.name, "split") then
						var_4_21.gameObject:SetActive(true)
					else
						var_4_21.gameObject:SetActive(false)
					end
				end
			end

			local var_4_22 = 0.001

			if 7.06666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 7.06666666666667 + var_4_22 then
				var_4_20.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_1_1.time_ - 7.06666666666667) / var_4_22)
			end

			if arg_1_1.time_ >= 7.06666666666667 + var_4_22 and arg_1_1.time_ < 7.06666666666667 + var_4_22 + arg_4_0 then
				var_4_20.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			if 7.06666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 7.06666666666667 + arg_4_0 then
				local var_4_23 = arg_1_1.actors_["10113"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_23 then
					arg_1_1.var_.alphaOldValue10113 = var_4_23.alpha
					arg_1_1.var_.characterEffect10113 = var_4_23
				end

				arg_1_1.var_.alphaOldValue10113 = 0
			end

			local var_4_24 = 0.333333333333333

			if 7.06666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 7.06666666666667 + var_4_24 then
				if arg_1_1.var_.characterEffect10113 then
					arg_1_1.var_.characterEffect10113.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10113, 1, (arg_1_1.time_ - 7.06666666666667) / var_4_24)
				end
			end

			if arg_1_1.time_ >= 7.06666666666667 + var_4_24 and arg_1_1.time_ < 7.06666666666667 + var_4_24 + arg_4_0 and arg_1_1.var_.characterEffect10113 then
				arg_1_1.var_.characterEffect10113.alpha = 1
			end

			local var_4_25 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_26 = 1

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				local var_4_27 = Color.New(0, 0, 0)

				var_4_27.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_25) / var_4_26)
				arg_1_1.mask_.color = var_4_27
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				local var_4_28 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_28.a = 0
				arg_1_1.mask_.color = var_4_28
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_4_34 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_34 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_34

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_34
						arg_1_1.bgmTxt2_.text = var_4_34
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

			local var_4_35 = 7.4
			local var_4_36 = 0.075

			if 7.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_37 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_37:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_38 = arg_1_1:GetWordFromCfg(417191001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 3 <= 0 and var_4_36 or var_4_36 * (utf8.len(var_4_39) / 3)

				if (3 <= 0 and var_4_36 or var_4_36 * (utf8.len(var_4_39) / 3)) > 0 and var_4_36 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_35 = var_4_35 + 0.3

					if var_4_41 + var_4_35 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_35
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191001", "story_v_out_417191.awb") ~= 0 then
					local var_4_42 = manager.audio:GetVoiceLength("story_v_out_417191", "417191001", "story_v_out_417191.awb") / 1000

					if var_4_42 + var_4_35 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_35
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_417191", "417191001", "story_v_out_417191.awb")

						arg_1_1:RecordAudio("417191001", var_4_43)
						arg_1_1:RecordAudio("417191001", var_4_43)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417191", "417191001", "story_v_out_417191.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417191", "417191001", "story_v_out_417191.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_35 + 0.3
			local var_4_45 = math.max(var_4_36, arg_1_1.talkMaxDuration)

			if var_4_35 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 7.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play417191002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417191002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417191003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(arg_10_1.actors_["10113"]) and arg_10_1.var_.actorSpriteComps10113 == nil then
				arg_10_1.var_.actorSpriteComps10113 = arg_10_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_0 = 0.2

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_0 and not isNil(arg_10_1.actors_["10113"]) then
				if arg_10_1.var_.actorSpriteComps10113 then
					for iter_13_0, iter_13_1 in pairs(arg_10_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_13_1 then
							if arg_10_1.isInRecall_ then
								iter_13_1.color = Color.New(Mathf.Lerp(iter_13_1.color.r, arg_10_1.hightColor2.r, (arg_10_1.time_ - 0) / var_13_0), Mathf.Lerp(iter_13_1.color.g, arg_10_1.hightColor2.g, (arg_10_1.time_ - 0) / var_13_0), (Mathf.Lerp(iter_13_1.color.b, arg_10_1.hightColor2.b, (arg_10_1.time_ - 0) / var_13_0)))
							else
								local var_13_1 = Mathf.Lerp(iter_13_1.color.r, 0.5, (arg_10_1.time_ - 0) / var_13_0)

								iter_13_1.color = Color.New(var_13_1, var_13_1, var_13_1)
							end
						end
					end
				end
			end

			if arg_10_1.time_ >= 0 + var_13_0 and arg_10_1.time_ < 0 + var_13_0 + arg_13_0 and not isNil(arg_10_1.actors_["10113"]) and arg_10_1.var_.actorSpriteComps10113 then
				for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_13_3 then
						iter_13_3.color = arg_10_1.isInRecall_ and (arg_10_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_10_1.var_.actorSpriteComps10113 = nil
			end

			if 1.2 < arg_10_1.time_ and arg_10_1.time_ <= 1.2 + arg_13_0 then
				arg_10_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_hittable01", "")
			end

			local var_13_3 = 0
			local var_13_4 = 1.075

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_5 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(417191002).content)

				arg_10_1.text_.text = var_13_5

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_7 = 43 <= 0 and var_13_4 or var_13_4 * (utf8.len(var_13_5) / 43)

				if (43 <= 0 and var_13_4 or var_13_4 * (utf8.len(var_13_5) / 43)) > 0 and var_13_4 < var_13_7 then
					arg_10_1.talkMaxDuration = var_13_7

					if var_13_7 + var_13_3 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_7 + var_13_3
					end
				end

				arg_10_1.text_.text = var_13_5
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_8 = math.max(var_13_4, arg_10_1.talkMaxDuration)

			if var_13_3 <= arg_10_1.time_ and arg_10_1.time_ < var_13_3 + var_13_8 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_3) / var_13_8

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_3 + var_13_8 and arg_10_1.time_ < var_13_3 + var_13_8 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417191003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417191003
		arg_14_1.duration_ = 9.63

		local var_14_0 = {
			zh = 4.966,
			ja = 9.633
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
				arg_14_0:Play417191004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(arg_14_1.actors_["10113"]) and arg_14_1.var_.actorSpriteComps10113 == nil then
				arg_14_1.var_.actorSpriteComps10113 = arg_14_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_0 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 and not isNil(arg_14_1.actors_["10113"]) then
				if arg_14_1.var_.actorSpriteComps10113 then
					for iter_17_0, iter_17_1 in pairs(arg_14_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_17_1 then
							if arg_14_1.isInRecall_ then
								iter_17_1.color = Color.New(Mathf.Lerp(iter_17_1.color.r, arg_14_1.hightColor1.r, (arg_14_1.time_ - 0) / var_17_0), Mathf.Lerp(iter_17_1.color.g, arg_14_1.hightColor1.g, (arg_14_1.time_ - 0) / var_17_0), (Mathf.Lerp(iter_17_1.color.b, arg_14_1.hightColor1.b, (arg_14_1.time_ - 0) / var_17_0)))
							else
								local var_17_1 = Mathf.Lerp(iter_17_1.color.r, 1, (arg_14_1.time_ - 0) / var_17_0)

								iter_17_1.color = Color.New(var_17_1, var_17_1, var_17_1)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 and not isNil(arg_14_1.actors_["10113"]) and arg_14_1.var_.actorSpriteComps10113 then
				for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_17_3 then
						iter_17_3.color = arg_14_1.isInRecall_ and (arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_14_1.var_.actorSpriteComps10113 = nil
			end

			local var_17_2 = 0
			local var_17_3 = 0.7

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_2 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_4 = arg_14_1:GetWordFromCfg(417191003)
				local var_17_5 = arg_14_1:FormatText(var_17_4.content)

				arg_14_1.text_.text = var_17_5

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_7 = 28 <= 0 and var_17_3 or var_17_3 * (utf8.len(var_17_5) / 28)

				if (28 <= 0 and var_17_3 or var_17_3 * (utf8.len(var_17_5) / 28)) > 0 and var_17_3 < var_17_7 then
					arg_14_1.talkMaxDuration = var_17_7

					if var_17_7 + var_17_2 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_7 + var_17_2
					end
				end

				arg_14_1.text_.text = var_17_5
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191003", "story_v_out_417191.awb") ~= 0 then
					local var_17_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191003", "story_v_out_417191.awb") / 1000

					if var_17_8 + var_17_2 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_8 + var_17_2
					end

					if var_17_4.prefab_name ~= "" and arg_14_1.actors_[var_17_4.prefab_name] ~= nil then
						local var_17_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_4.prefab_name].transform, "story_v_out_417191", "417191003", "story_v_out_417191.awb")

						arg_14_1:RecordAudio("417191003", var_17_9)
						arg_14_1:RecordAudio("417191003", var_17_9)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417191", "417191003", "story_v_out_417191.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417191", "417191003", "story_v_out_417191.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_10 = math.max(var_17_3, arg_14_1.talkMaxDuration)

			if var_17_2 <= arg_14_1.time_ and arg_14_1.time_ < var_17_2 + var_17_10 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_2) / var_17_10

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_2 + var_17_10 and arg_14_1.time_ < var_17_2 + var_17_10 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417191004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417191004
		arg_18_1.duration_ = 5.3

		local var_18_0 = {
			zh = 3.333,
			ja = 5.3
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
				arg_18_0:Play417191005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos10113 = arg_18_1.actors_["10113"].transform.localPosition
				arg_18_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_18_1:CheckSpriteTmpPos("10113", 3)

				for iter_21_0 = 0, arg_18_1.actors_["10113"].transform.childCount - 1 do
					local var_21_0 = arg_18_1.actors_["10113"].transform:GetChild(iter_21_0)

					if var_21_0.name == "split_3" or not string.find(var_21_0.name, "split") then
						var_21_0.gameObject:SetActive(true)
					else
						var_21_0.gameObject:SetActive(false)
					end
				end
			end

			local var_21_1 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_1 then
				arg_18_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_18_1.time_ - 0) / var_21_1)
			end

			if arg_18_1.time_ >= 0 + var_21_1 and arg_18_1.time_ < 0 + var_21_1 + arg_21_0 then
				arg_18_1.actors_["10113"].transform.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_21_2 = 0
			local var_21_3 = 0.525

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_2 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_4 = arg_18_1:GetWordFromCfg(417191004)
				local var_21_5 = arg_18_1:FormatText(var_21_4.content)

				arg_18_1.text_.text = var_21_5

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_7 = 21 <= 0 and var_21_3 or var_21_3 * (utf8.len(var_21_5) / 21)

				if (21 <= 0 and var_21_3 or var_21_3 * (utf8.len(var_21_5) / 21)) > 0 and var_21_3 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_2 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_2
					end
				end

				arg_18_1.text_.text = var_21_5
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191004", "story_v_out_417191.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191004", "story_v_out_417191.awb") / 1000

					if var_21_8 + var_21_2 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_2
					end

					if var_21_4.prefab_name ~= "" and arg_18_1.actors_[var_21_4.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_4.prefab_name].transform, "story_v_out_417191", "417191004", "story_v_out_417191.awb")

						arg_18_1:RecordAudio("417191004", var_21_9)
						arg_18_1:RecordAudio("417191004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417191", "417191004", "story_v_out_417191.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417191", "417191004", "story_v_out_417191.awb")
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

		arg_18_1.nodeConfigList_ = {
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

		arg_18_1:InitPlayNodeList()
	end,
	Play417191005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417191005
		arg_22_1.duration_ = 6

		local var_22_0 = {
			zh = 3.233,
			ja = 6
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
				arg_22_0:Play417191006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.475

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_1 = arg_22_1:GetWordFromCfg(417191005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 19 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 19)

				if (19 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 19)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191005", "story_v_out_417191.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191005", "story_v_out_417191.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_417191", "417191005", "story_v_out_417191.awb")

						arg_22_1:RecordAudio("417191005", var_25_6)
						arg_22_1:RecordAudio("417191005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417191", "417191005", "story_v_out_417191.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417191", "417191005", "story_v_out_417191.awb")
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
	Play417191006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417191006
		arg_26_1.duration_ = 1

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417191007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.075

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:GetWordFromCfg(417191006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 3 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 3)

				if (3 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 3)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191006", "story_v_out_417191.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191006", "story_v_out_417191.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_417191", "417191006", "story_v_out_417191.awb")

						arg_26_1:RecordAudio("417191006", var_29_6)
						arg_26_1:RecordAudio("417191006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417191", "417191006", "story_v_out_417191.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417191", "417191006", "story_v_out_417191.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417191007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417191007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play417191008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["10113"]) and arg_30_1.var_.actorSpriteComps10113 == nil then
				arg_30_1.var_.actorSpriteComps10113 = arg_30_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["10113"]) then
				if arg_30_1.var_.actorSpriteComps10113 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["10113"]) and arg_30_1.var_.actorSpriteComps10113 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_30_1.var_.actorSpriteComps10113 = nil
			end

			local var_33_2 = arg_30_1.actors_["10113"].transform

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos10113 = var_33_2.localPosition
				var_33_2.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("10113", 7)

				for iter_33_4 = 0, var_33_2.childCount - 1 do
					local var_33_3 = var_33_2:GetChild(iter_33_4)

					if var_33_3.name == "" or not string.find(var_33_3.name, "split") then
						var_33_3.gameObject:SetActive(true)
					else
						var_33_3.gameObject:SetActive(false)
					end
				end
			end

			local var_33_4 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				var_33_2.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_30_1.time_ - 0) / var_33_4)
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				var_33_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.425 < arg_30_1.time_ and arg_30_1.time_ <= 0.425 + arg_33_0 then
				arg_30_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_medication", "")
			end

			local var_33_6 = 0
			local var_33_7 = 1.425

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_8 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(417191007).content)

				arg_30_1.text_.text = var_33_8

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_10 = 57 <= 0 and var_33_7 or var_33_7 * (utf8.len(var_33_8) / 57)

				if (57 <= 0 and var_33_7 or var_33_7 * (utf8.len(var_33_8) / 57)) > 0 and var_33_7 < var_33_10 then
					arg_30_1.talkMaxDuration = var_33_10

					if var_33_10 + var_33_6 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_6
					end
				end

				arg_30_1.text_.text = var_33_8
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_11 = math.max(var_33_7, arg_30_1.talkMaxDuration)

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_11 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_6) / var_33_11

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_6 + var_33_11 and arg_30_1.time_ < var_33_6 + var_33_11 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
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

		arg_30_1:InitPlayNodeList()
	end,
	Play417191008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417191008
		arg_34_1.duration_ = 4.73

		local var_34_0 = {
			zh = 3.7,
			ja = 4.733
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
				arg_34_0:Play417191009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["10113"]) and arg_34_1.var_.actorSpriteComps10113 == nil then
				arg_34_1.var_.actorSpriteComps10113 = arg_34_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_0 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["10113"]) then
				if arg_34_1.var_.actorSpriteComps10113 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["10113"]) and arg_34_1.var_.actorSpriteComps10113 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_37_3 then
						iter_37_3.color = arg_34_1.isInRecall_ and (arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_34_1.var_.actorSpriteComps10113 = nil
			end

			local var_37_2 = arg_34_1.actors_["10113"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos10113 = var_37_2.localPosition
				var_37_2.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("10113", 3)

				for iter_37_4 = 0, var_37_2.childCount - 1 do
					local var_37_3 = var_37_2:GetChild(iter_37_4)

					if var_37_3.name == "split_6" or not string.find(var_37_3.name, "split") then
						var_37_3.gameObject:SetActive(true)
					else
						var_37_3.gameObject:SetActive(false)
					end
				end
			end

			local var_37_4 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				var_37_2.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_34_1.time_ - 0) / var_37_4)
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				var_37_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_37_5 = 0
			local var_37_6 = 0.275

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_7 = arg_34_1:GetWordFromCfg(417191008)
				local var_37_8 = arg_34_1:FormatText(var_37_7.content)

				arg_34_1.text_.text = var_37_8

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_10 = 11 <= 0 and var_37_6 or var_37_6 * (utf8.len(var_37_8) / 11)

				if (11 <= 0 and var_37_6 or var_37_6 * (utf8.len(var_37_8) / 11)) > 0 and var_37_6 < var_37_10 then
					arg_34_1.talkMaxDuration = var_37_10

					if var_37_10 + var_37_5 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_10 + var_37_5
					end
				end

				arg_34_1.text_.text = var_37_8
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191008", "story_v_out_417191.awb") ~= 0 then
					local var_37_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191008", "story_v_out_417191.awb") / 1000

					if var_37_11 + var_37_5 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_11 + var_37_5
					end

					if var_37_7.prefab_name ~= "" and arg_34_1.actors_[var_37_7.prefab_name] ~= nil then
						local var_37_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_7.prefab_name].transform, "story_v_out_417191", "417191008", "story_v_out_417191.awb")

						arg_34_1:RecordAudio("417191008", var_37_12)
						arg_34_1:RecordAudio("417191008", var_37_12)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417191", "417191008", "story_v_out_417191.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417191", "417191008", "story_v_out_417191.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_13 = math.max(var_37_6, arg_34_1.talkMaxDuration)

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_13 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_5) / var_37_13

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_5 + var_37_13 and arg_34_1.time_ < var_37_5 + var_37_13 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
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

		arg_34_1:InitPlayNodeList()
	end,
	Play417191009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417191009
		arg_38_1.duration_ = 3.1

		local var_38_0 = {
			zh = 2.6,
			ja = 3.1
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
				arg_38_0:Play417191010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["10113"]) and arg_38_1.var_.actorSpriteComps10113 == nil then
				arg_38_1.var_.actorSpriteComps10113 = arg_38_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["10113"]) then
				if arg_38_1.var_.actorSpriteComps10113 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["10113"]) and arg_38_1.var_.actorSpriteComps10113 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_41_3 then
						iter_41_3.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_38_1.var_.actorSpriteComps10113 = nil
			end

			local var_41_2 = 0
			local var_41_3 = 0.3

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_2 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_4 = arg_38_1:GetWordFromCfg(417191009)
				local var_41_5 = arg_38_1:FormatText(var_41_4.content)

				arg_38_1.text_.text = var_41_5

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_7 = 12 <= 0 and var_41_3 or var_41_3 * (utf8.len(var_41_5) / 12)

				if (12 <= 0 and var_41_3 or var_41_3 * (utf8.len(var_41_5) / 12)) > 0 and var_41_3 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_2 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_2
					end
				end

				arg_38_1.text_.text = var_41_5
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191009", "story_v_out_417191.awb") ~= 0 then
					local var_41_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191009", "story_v_out_417191.awb") / 1000

					if var_41_8 + var_41_2 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_2
					end

					if var_41_4.prefab_name ~= "" and arg_38_1.actors_[var_41_4.prefab_name] ~= nil then
						local var_41_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_4.prefab_name].transform, "story_v_out_417191", "417191009", "story_v_out_417191.awb")

						arg_38_1:RecordAudio("417191009", var_41_9)
						arg_38_1:RecordAudio("417191009", var_41_9)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417191", "417191009", "story_v_out_417191.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417191", "417191009", "story_v_out_417191.awb")
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

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play417191010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417191010
		arg_42_1.duration_ = 11.47

		local var_42_0 = {
			zh = 6,
			ja = 11.466
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
				arg_42_0:Play417191011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["10113"]) and arg_42_1.var_.actorSpriteComps10113 == nil then
				arg_42_1.var_.actorSpriteComps10113 = arg_42_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_0 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["10113"]) then
				if arg_42_1.var_.actorSpriteComps10113 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								iter_45_1.color = Color.New(Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor1.r, (arg_42_1.time_ - 0) / var_45_0), Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor1.g, (arg_42_1.time_ - 0) / var_45_0), (Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor1.b, (arg_42_1.time_ - 0) / var_45_0)))
							else
								local var_45_1 = Mathf.Lerp(iter_45_1.color.r, 1, (arg_42_1.time_ - 0) / var_45_0)

								iter_45_1.color = Color.New(var_45_1, var_45_1, var_45_1)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["10113"]) and arg_42_1.var_.actorSpriteComps10113 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_45_3 then
						iter_45_3.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_42_1.var_.actorSpriteComps10113 = nil
			end

			local var_45_2 = 0
			local var_45_3 = 0.825

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_4 = arg_42_1:GetWordFromCfg(417191010)
				local var_45_5 = arg_42_1:FormatText(var_45_4.content)

				arg_42_1.text_.text = var_45_5

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_7 = 33 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 33)

				if (33 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 33)) > 0 and var_45_3 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_2
					end
				end

				arg_42_1.text_.text = var_45_5
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191010", "story_v_out_417191.awb") ~= 0 then
					local var_45_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191010", "story_v_out_417191.awb") / 1000

					if var_45_8 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_2
					end

					if var_45_4.prefab_name ~= "" and arg_42_1.actors_[var_45_4.prefab_name] ~= nil then
						local var_45_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_4.prefab_name].transform, "story_v_out_417191", "417191010", "story_v_out_417191.awb")

						arg_42_1:RecordAudio("417191010", var_45_9)
						arg_42_1:RecordAudio("417191010", var_45_9)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417191", "417191010", "story_v_out_417191.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417191", "417191010", "story_v_out_417191.awb")
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
	Play417191011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417191011
		arg_46_1.duration_ = 5.3

		local var_46_0 = {
			zh = 3.1,
			ja = 5.3
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
				arg_46_0:Play417191012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["10113"]) and arg_46_1.var_.actorSpriteComps10113 == nil then
				arg_46_1.var_.actorSpriteComps10113 = arg_46_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["10113"]) then
				if arg_46_1.var_.actorSpriteComps10113 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								iter_49_1.color = Color.New(Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor2.r, (arg_46_1.time_ - 0) / var_49_0), Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor2.g, (arg_46_1.time_ - 0) / var_49_0), (Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor2.b, (arg_46_1.time_ - 0) / var_49_0)))
							else
								local var_49_1 = Mathf.Lerp(iter_49_1.color.r, 0.5, (arg_46_1.time_ - 0) / var_49_0)

								iter_49_1.color = Color.New(var_49_1, var_49_1, var_49_1)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["10113"]) and arg_46_1.var_.actorSpriteComps10113 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_49_3 then
						iter_49_3.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_46_1.var_.actorSpriteComps10113 = nil
			end

			local var_49_2 = 0
			local var_49_3 = 0.375

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_4 = arg_46_1:GetWordFromCfg(417191011)
				local var_49_5 = arg_46_1:FormatText(var_49_4.content)

				arg_46_1.text_.text = var_49_5

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_7 = 15 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 15)

				if (15 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 15)) > 0 and var_49_3 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_2
					end
				end

				arg_46_1.text_.text = var_49_5
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191011", "story_v_out_417191.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191011", "story_v_out_417191.awb") / 1000

					if var_49_8 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_2
					end

					if var_49_4.prefab_name ~= "" and arg_46_1.actors_[var_49_4.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_4.prefab_name].transform, "story_v_out_417191", "417191011", "story_v_out_417191.awb")

						arg_46_1:RecordAudio("417191011", var_49_9)
						arg_46_1:RecordAudio("417191011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417191", "417191011", "story_v_out_417191.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417191", "417191011", "story_v_out_417191.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_3, arg_46_1.talkMaxDuration)

			if var_49_2 <= arg_46_1.time_ and arg_46_1.time_ < var_49_2 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_2) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_2 + var_49_10 and arg_46_1.time_ < var_49_2 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play417191012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417191012
		arg_50_1.duration_ = 10.27

		local var_50_0 = {
			zh = 7.4,
			ja = 10.266
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
				arg_50_0:Play417191013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["10113"]) and arg_50_1.var_.actorSpriteComps10113 == nil then
				arg_50_1.var_.actorSpriteComps10113 = arg_50_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["10113"]) then
				if arg_50_1.var_.actorSpriteComps10113 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["10113"]) and arg_50_1.var_.actorSpriteComps10113 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_53_3 then
						iter_53_3.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_50_1.var_.actorSpriteComps10113 = nil
			end

			local var_53_2 = arg_50_1.actors_["10113"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos10113 = var_53_2.localPosition
				var_53_2.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("10113", 3)

				for iter_53_4 = 0, var_53_2.childCount - 1 do
					local var_53_3 = var_53_2:GetChild(iter_53_4)

					if var_53_3.name == "split_6" or not string.find(var_53_3.name, "split") then
						var_53_3.gameObject:SetActive(true)
					else
						var_53_3.gameObject:SetActive(false)
					end
				end
			end

			local var_53_4 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				var_53_2.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_50_1.time_ - 0) / var_53_4)
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				var_53_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_53_5 = 0
			local var_53_6 = 0.85

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_7 = arg_50_1:GetWordFromCfg(417191012)
				local var_53_8 = arg_50_1:FormatText(var_53_7.content)

				arg_50_1.text_.text = var_53_8

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_10 = 34 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 34)

				if (34 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 34)) > 0 and var_53_6 < var_53_10 then
					arg_50_1.talkMaxDuration = var_53_10

					if var_53_10 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_5
					end
				end

				arg_50_1.text_.text = var_53_8
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191012", "story_v_out_417191.awb") ~= 0 then
					local var_53_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191012", "story_v_out_417191.awb") / 1000

					if var_53_11 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_11 + var_53_5
					end

					if var_53_7.prefab_name ~= "" and arg_50_1.actors_[var_53_7.prefab_name] ~= nil then
						local var_53_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_7.prefab_name].transform, "story_v_out_417191", "417191012", "story_v_out_417191.awb")

						arg_50_1:RecordAudio("417191012", var_53_12)
						arg_50_1:RecordAudio("417191012", var_53_12)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417191", "417191012", "story_v_out_417191.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417191", "417191012", "story_v_out_417191.awb")
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
				actorName = "10113",
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
	Play417191013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417191013
		arg_54_1.duration_ = 11.87

		local var_54_0 = {
			zh = 8.1,
			ja = 11.866
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
				arg_54_0:Play417191014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.9

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_1 = arg_54_1:GetWordFromCfg(417191013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 36 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 36)

				if (36 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 36)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191013", "story_v_out_417191.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191013", "story_v_out_417191.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_417191", "417191013", "story_v_out_417191.awb")

						arg_54_1:RecordAudio("417191013", var_57_6)
						arg_54_1:RecordAudio("417191013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417191", "417191013", "story_v_out_417191.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417191", "417191013", "story_v_out_417191.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play417191014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417191014
		arg_58_1.duration_ = 11

		local var_58_0 = {
			zh = 11,
			ja = 10.933
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
				arg_58_0:Play417191015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10113 = arg_58_1.actors_["10113"].transform.localPosition
				arg_58_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("10113", 3)

				for iter_61_0 = 0, arg_58_1.actors_["10113"].transform.childCount - 1 do
					local var_61_0 = arg_58_1.actors_["10113"].transform:GetChild(iter_61_0)

					if var_61_0.name == "split_6" or not string.find(var_61_0.name, "split") then
						var_61_0.gameObject:SetActive(true)
					else
						var_61_0.gameObject:SetActive(false)
					end
				end
			end

			local var_61_1 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_1 then
				arg_58_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_58_1.time_ - 0) / var_61_1)
			end

			if arg_58_1.time_ >= 0 + var_61_1 and arg_58_1.time_ < 0 + var_61_1 + arg_61_0 then
				arg_58_1.actors_["10113"].transform.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_61_2 = 0
			local var_61_3 = 1.1

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_4 = arg_58_1:GetWordFromCfg(417191014)
				local var_61_5 = arg_58_1:FormatText(var_61_4.content)

				arg_58_1.text_.text = var_61_5

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_7 = 44 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 44)

				if (44 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 44)) > 0 and var_61_3 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_5
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191014", "story_v_out_417191.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191014", "story_v_out_417191.awb") / 1000

					if var_61_8 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_2
					end

					if var_61_4.prefab_name ~= "" and arg_58_1.actors_[var_61_4.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_4.prefab_name].transform, "story_v_out_417191", "417191014", "story_v_out_417191.awb")

						arg_58_1:RecordAudio("417191014", var_61_9)
						arg_58_1:RecordAudio("417191014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417191", "417191014", "story_v_out_417191.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417191", "417191014", "story_v_out_417191.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_10 and arg_58_1.time_ < var_61_2 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play417191015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417191015
		arg_62_1.duration_ = 4.47

		local var_62_0 = {
			zh = 2.966,
			ja = 4.466
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
				arg_62_0:Play417191016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["10113"]) and arg_62_1.var_.actorSpriteComps10113 == nil then
				arg_62_1.var_.actorSpriteComps10113 = arg_62_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_0 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["10113"]) then
				if arg_62_1.var_.actorSpriteComps10113 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_65_1 then
							if arg_62_1.isInRecall_ then
								iter_65_1.color = Color.New(Mathf.Lerp(iter_65_1.color.r, arg_62_1.hightColor2.r, (arg_62_1.time_ - 0) / var_65_0), Mathf.Lerp(iter_65_1.color.g, arg_62_1.hightColor2.g, (arg_62_1.time_ - 0) / var_65_0), (Mathf.Lerp(iter_65_1.color.b, arg_62_1.hightColor2.b, (arg_62_1.time_ - 0) / var_65_0)))
							else
								local var_65_1 = Mathf.Lerp(iter_65_1.color.r, 0.5, (arg_62_1.time_ - 0) / var_65_0)

								iter_65_1.color = Color.New(var_65_1, var_65_1, var_65_1)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["10113"]) and arg_62_1.var_.actorSpriteComps10113 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_65_3 then
						iter_65_3.color = arg_62_1.isInRecall_ and (arg_62_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_62_1.var_.actorSpriteComps10113 = nil
			end

			local var_65_2 = 0
			local var_65_3 = 0.35

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_4 = arg_62_1:GetWordFromCfg(417191015)
				local var_65_5 = arg_62_1:FormatText(var_65_4.content)

				arg_62_1.text_.text = var_65_5

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_7 = 14 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 14)

				if (14 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 14)) > 0 and var_65_3 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_5
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191015", "story_v_out_417191.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191015", "story_v_out_417191.awb") / 1000

					if var_65_8 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_2
					end

					if var_65_4.prefab_name ~= "" and arg_62_1.actors_[var_65_4.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_4.prefab_name].transform, "story_v_out_417191", "417191015", "story_v_out_417191.awb")

						arg_62_1:RecordAudio("417191015", var_65_9)
						arg_62_1:RecordAudio("417191015", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417191", "417191015", "story_v_out_417191.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417191", "417191015", "story_v_out_417191.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_3, arg_62_1.talkMaxDuration)

			if var_65_2 <= arg_62_1.time_ and arg_62_1.time_ < var_65_2 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_2) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_2 + var_65_10 and arg_62_1.time_ < var_65_2 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play417191016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417191016
		arg_66_1.duration_ = 10.77

		local var_66_0 = {
			zh = 8.966,
			ja = 10.766
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
				arg_66_0:Play417191017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["10113"]) and arg_66_1.var_.actorSpriteComps10113 == nil then
				arg_66_1.var_.actorSpriteComps10113 = arg_66_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["10113"]) then
				if arg_66_1.var_.actorSpriteComps10113 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								iter_69_1.color = Color.New(Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor1.r, (arg_66_1.time_ - 0) / var_69_0), Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor1.g, (arg_66_1.time_ - 0) / var_69_0), (Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor1.b, (arg_66_1.time_ - 0) / var_69_0)))
							else
								local var_69_1 = Mathf.Lerp(iter_69_1.color.r, 1, (arg_66_1.time_ - 0) / var_69_0)

								iter_69_1.color = Color.New(var_69_1, var_69_1, var_69_1)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["10113"]) and arg_66_1.var_.actorSpriteComps10113 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_69_3 then
						iter_69_3.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_66_1.var_.actorSpriteComps10113 = nil
			end

			local var_69_2 = 0
			local var_69_3 = 0.925

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_4 = arg_66_1:GetWordFromCfg(417191016)
				local var_69_5 = arg_66_1:FormatText(var_69_4.content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_7 = 37 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 37)

				if (37 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 37)) > 0 and var_69_3 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_2
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191016", "story_v_out_417191.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191016", "story_v_out_417191.awb") / 1000

					if var_69_8 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_2
					end

					if var_69_4.prefab_name ~= "" and arg_66_1.actors_[var_69_4.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_4.prefab_name].transform, "story_v_out_417191", "417191016", "story_v_out_417191.awb")

						arg_66_1:RecordAudio("417191016", var_69_9)
						arg_66_1:RecordAudio("417191016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417191", "417191016", "story_v_out_417191.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417191", "417191016", "story_v_out_417191.awb")
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
	Play417191017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417191017
		arg_70_1.duration_ = 6

		local var_70_0 = {
			zh = 3.833,
			ja = 6
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
				arg_70_0:Play417191018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["10113"]) and arg_70_1.var_.actorSpriteComps10113 == nil then
				arg_70_1.var_.actorSpriteComps10113 = arg_70_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_0 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["10113"]) then
				if arg_70_1.var_.actorSpriteComps10113 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								iter_73_1.color = Color.New(Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor2.r, (arg_70_1.time_ - 0) / var_73_0), Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor2.g, (arg_70_1.time_ - 0) / var_73_0), (Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor2.b, (arg_70_1.time_ - 0) / var_73_0)))
							else
								local var_73_1 = Mathf.Lerp(iter_73_1.color.r, 0.5, (arg_70_1.time_ - 0) / var_73_0)

								iter_73_1.color = Color.New(var_73_1, var_73_1, var_73_1)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["10113"]) and arg_70_1.var_.actorSpriteComps10113 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_73_3 then
						iter_73_3.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_70_1.var_.actorSpriteComps10113 = nil
			end

			local var_73_2 = 0
			local var_73_3 = 0.5

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_2 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_4 = arg_70_1:GetWordFromCfg(417191017)
				local var_73_5 = arg_70_1:FormatText(var_73_4.content)

				arg_70_1.text_.text = var_73_5

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_7 = 20 <= 0 and var_73_3 or var_73_3 * (utf8.len(var_73_5) / 20)

				if (20 <= 0 and var_73_3 or var_73_3 * (utf8.len(var_73_5) / 20)) > 0 and var_73_3 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_2 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_2
					end
				end

				arg_70_1.text_.text = var_73_5
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191017", "story_v_out_417191.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191017", "story_v_out_417191.awb") / 1000

					if var_73_8 + var_73_2 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_2
					end

					if var_73_4.prefab_name ~= "" and arg_70_1.actors_[var_73_4.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_4.prefab_name].transform, "story_v_out_417191", "417191017", "story_v_out_417191.awb")

						arg_70_1:RecordAudio("417191017", var_73_9)
						arg_70_1:RecordAudio("417191017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417191", "417191017", "story_v_out_417191.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417191", "417191017", "story_v_out_417191.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_3, arg_70_1.talkMaxDuration)

			if var_73_2 <= arg_70_1.time_ and arg_70_1.time_ < var_73_2 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_2) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_2 + var_73_10 and arg_70_1.time_ < var_73_2 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417191018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417191018
		arg_74_1.duration_ = 9.37

		local var_74_0 = {
			zh = 8.433,
			ja = 9.366
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
				arg_74_0:Play417191019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.975

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_1 = arg_74_1:GetWordFromCfg(417191018)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 39 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 39)

				if (39 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 39)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191018", "story_v_out_417191.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191018", "story_v_out_417191.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_417191", "417191018", "story_v_out_417191.awb")

						arg_74_1:RecordAudio("417191018", var_77_6)
						arg_74_1:RecordAudio("417191018", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_417191", "417191018", "story_v_out_417191.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_417191", "417191018", "story_v_out_417191.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play417191019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417191019
		arg_78_1.duration_ = 4.8

		local var_78_0 = {
			zh = 3.533,
			ja = 4.8
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
				arg_78_0:Play417191020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["10113"]) and arg_78_1.var_.actorSpriteComps10113 == nil then
				arg_78_1.var_.actorSpriteComps10113 = arg_78_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_0 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["10113"]) then
				if arg_78_1.var_.actorSpriteComps10113 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_81_1 then
							if arg_78_1.isInRecall_ then
								iter_81_1.color = Color.New(Mathf.Lerp(iter_81_1.color.r, arg_78_1.hightColor1.r, (arg_78_1.time_ - 0) / var_81_0), Mathf.Lerp(iter_81_1.color.g, arg_78_1.hightColor1.g, (arg_78_1.time_ - 0) / var_81_0), (Mathf.Lerp(iter_81_1.color.b, arg_78_1.hightColor1.b, (arg_78_1.time_ - 0) / var_81_0)))
							else
								local var_81_1 = Mathf.Lerp(iter_81_1.color.r, 1, (arg_78_1.time_ - 0) / var_81_0)

								iter_81_1.color = Color.New(var_81_1, var_81_1, var_81_1)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["10113"]) and arg_78_1.var_.actorSpriteComps10113 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_81_3 then
						iter_81_3.color = arg_78_1.isInRecall_ and (arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_78_1.var_.actorSpriteComps10113 = nil
			end

			local var_81_2 = 0
			local var_81_3 = 0.425

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_4 = arg_78_1:GetWordFromCfg(417191019)
				local var_81_5 = arg_78_1:FormatText(var_81_4.content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 17 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 17)

				if (17 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 17)) > 0 and var_81_3 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_2
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191019", "story_v_out_417191.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191019", "story_v_out_417191.awb") / 1000

					if var_81_8 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_2
					end

					if var_81_4.prefab_name ~= "" and arg_78_1.actors_[var_81_4.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_4.prefab_name].transform, "story_v_out_417191", "417191019", "story_v_out_417191.awb")

						arg_78_1:RecordAudio("417191019", var_81_9)
						arg_78_1:RecordAudio("417191019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417191", "417191019", "story_v_out_417191.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417191", "417191019", "story_v_out_417191.awb")
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
	Play417191020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417191020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play417191021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["10113"]) and arg_82_1.var_.actorSpriteComps10113 == nil then
				arg_82_1.var_.actorSpriteComps10113 = arg_82_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_0 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["10113"]) then
				if arg_82_1.var_.actorSpriteComps10113 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								iter_85_1.color = Color.New(Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor2.r, (arg_82_1.time_ - 0) / var_85_0), Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor2.g, (arg_82_1.time_ - 0) / var_85_0), (Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor2.b, (arg_82_1.time_ - 0) / var_85_0)))
							else
								local var_85_1 = Mathf.Lerp(iter_85_1.color.r, 0.5, (arg_82_1.time_ - 0) / var_85_0)

								iter_85_1.color = Color.New(var_85_1, var_85_1, var_85_1)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["10113"]) and arg_82_1.var_.actorSpriteComps10113 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_85_3 then
						iter_85_3.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_82_1.var_.actorSpriteComps10113 = nil
			end

			local var_85_2 = 0
			local var_85_3 = 1.2

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_2 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_4 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(417191020).content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_6 = 48 <= 0 and var_85_3 or var_85_3 * (utf8.len(var_85_4) / 48)

				if (48 <= 0 and var_85_3 or var_85_3 * (utf8.len(var_85_4) / 48)) > 0 and var_85_3 < var_85_6 then
					arg_82_1.talkMaxDuration = var_85_6

					if var_85_6 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_2
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_3, arg_82_1.talkMaxDuration)

			if var_85_2 <= arg_82_1.time_ and arg_82_1.time_ < var_85_2 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_2) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_2 + var_85_7 and arg_82_1.time_ < var_85_2 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417191021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417191021
		arg_86_1.duration_ = 4.9

		local var_86_0 = {
			zh = 4.9,
			ja = 4.166
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
				arg_86_0:Play417191022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.575

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

				local var_89_1 = arg_86_1:GetWordFromCfg(417191021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 23 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 23)

				if (23 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 23)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191021", "story_v_out_417191.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191021", "story_v_out_417191.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_417191", "417191021", "story_v_out_417191.awb")

						arg_86_1:RecordAudio("417191021", var_89_6)
						arg_86_1:RecordAudio("417191021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_417191", "417191021", "story_v_out_417191.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_417191", "417191021", "story_v_out_417191.awb")
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
	Play417191022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417191022
		arg_90_1.duration_ = 7.77

		local var_90_0 = {
			zh = 6.333,
			ja = 7.766
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
				arg_90_0:Play417191023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.75

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

				local var_93_1 = arg_90_1:GetWordFromCfg(417191022)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 30 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 30)

				if (30 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 30)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191022", "story_v_out_417191.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191022", "story_v_out_417191.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_417191", "417191022", "story_v_out_417191.awb")

						arg_90_1:RecordAudio("417191022", var_93_6)
						arg_90_1:RecordAudio("417191022", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417191", "417191022", "story_v_out_417191.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417191", "417191022", "story_v_out_417191.awb")
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
	Play417191023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417191023
		arg_94_1.duration_ = 2.9

		local var_94_0 = {
			zh = 2.266,
			ja = 2.9
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
				arg_94_0:Play417191024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["10113"]) and arg_94_1.var_.actorSpriteComps10113 == nil then
				arg_94_1.var_.actorSpriteComps10113 = arg_94_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["10113"]) then
				if arg_94_1.var_.actorSpriteComps10113 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["10113"]) and arg_94_1.var_.actorSpriteComps10113 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_94_1.var_.actorSpriteComps10113 = nil
			end

			local var_97_2 = 0
			local var_97_3 = 0.225

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_4 = arg_94_1:GetWordFromCfg(417191023)
				local var_97_5 = arg_94_1:FormatText(var_97_4.content)

				arg_94_1.text_.text = var_97_5

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_7 = 9 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 9)

				if (9 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 9)) > 0 and var_97_3 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_2
					end
				end

				arg_94_1.text_.text = var_97_5
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191023", "story_v_out_417191.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191023", "story_v_out_417191.awb") / 1000

					if var_97_8 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_2
					end

					if var_97_4.prefab_name ~= "" and arg_94_1.actors_[var_97_4.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_4.prefab_name].transform, "story_v_out_417191", "417191023", "story_v_out_417191.awb")

						arg_94_1:RecordAudio("417191023", var_97_9)
						arg_94_1:RecordAudio("417191023", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417191", "417191023", "story_v_out_417191.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417191", "417191023", "story_v_out_417191.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_3, arg_94_1.talkMaxDuration)

			if var_97_2 <= arg_94_1.time_ and arg_94_1.time_ < var_97_2 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_2) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_2 + var_97_10 and arg_94_1.time_ < var_97_2 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play417191024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417191024
		arg_98_1.duration_ = 8.03

		local var_98_0 = {
			zh = 7.133,
			ja = 8.033
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
				arg_98_0:Play417191025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["10113"]) and arg_98_1.var_.actorSpriteComps10113 == nil then
				arg_98_1.var_.actorSpriteComps10113 = arg_98_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_0 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["10113"]) then
				if arg_98_1.var_.actorSpriteComps10113 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["10113"]) and arg_98_1.var_.actorSpriteComps10113 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_101_3 then
						iter_101_3.color = arg_98_1.isInRecall_ and (arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_98_1.var_.actorSpriteComps10113 = nil
			end

			local var_101_2 = 0
			local var_101_3 = 0.75

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

				local var_101_4 = arg_98_1:GetWordFromCfg(417191024)
				local var_101_5 = arg_98_1:FormatText(var_101_4.content)

				arg_98_1.text_.text = var_101_5

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_7 = 30 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_5) / 30)

				if (30 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_5) / 30)) > 0 and var_101_3 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_2
					end
				end

				arg_98_1.text_.text = var_101_5
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191024", "story_v_out_417191.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191024", "story_v_out_417191.awb") / 1000

					if var_101_8 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_2
					end

					if var_101_4.prefab_name ~= "" and arg_98_1.actors_[var_101_4.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_4.prefab_name].transform, "story_v_out_417191", "417191024", "story_v_out_417191.awb")

						arg_98_1:RecordAudio("417191024", var_101_9)
						arg_98_1:RecordAudio("417191024", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_417191", "417191024", "story_v_out_417191.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_417191", "417191024", "story_v_out_417191.awb")
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
	Play417191025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417191025
		arg_102_1.duration_ = 5.33

		local var_102_0 = {
			zh = 5.333,
			ja = 3.6
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
				arg_102_0:Play417191026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10113"]) and arg_102_1.var_.actorSpriteComps10113 == nil then
				arg_102_1.var_.actorSpriteComps10113 = arg_102_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10113"]) then
				if arg_102_1.var_.actorSpriteComps10113 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10113"]) and arg_102_1.var_.actorSpriteComps10113 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_105_3 then
						iter_105_3.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_102_1.var_.actorSpriteComps10113 = nil
			end

			local var_105_2 = 0
			local var_105_3 = 0.55

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_4 = arg_102_1:GetWordFromCfg(417191025)
				local var_105_5 = arg_102_1:FormatText(var_105_4.content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 22 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 22)

				if (22 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 22)) > 0 and var_105_3 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_2
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191025", "story_v_out_417191.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191025", "story_v_out_417191.awb") / 1000

					if var_105_8 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_2
					end

					if var_105_4.prefab_name ~= "" and arg_102_1.actors_[var_105_4.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_4.prefab_name].transform, "story_v_out_417191", "417191025", "story_v_out_417191.awb")

						arg_102_1:RecordAudio("417191025", var_105_9)
						arg_102_1:RecordAudio("417191025", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_417191", "417191025", "story_v_out_417191.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_417191", "417191025", "story_v_out_417191.awb")
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
	Play417191026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417191026
		arg_106_1.duration_ = 4

		local var_106_0 = {
			zh = 2.1,
			ja = 4
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
				arg_106_0:Play417191027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["10113"]) and arg_106_1.var_.actorSpriteComps10113 == nil then
				arg_106_1.var_.actorSpriteComps10113 = arg_106_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_0 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["10113"]) then
				if arg_106_1.var_.actorSpriteComps10113 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["10113"]) and arg_106_1.var_.actorSpriteComps10113 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_109_3 then
						iter_109_3.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_106_1.var_.actorSpriteComps10113 = nil
			end

			local var_109_2 = 0
			local var_109_3 = 0.25

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

				local var_109_4 = arg_106_1:GetWordFromCfg(417191026)
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

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191026", "story_v_out_417191.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191026", "story_v_out_417191.awb") / 1000

					if var_109_8 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_2
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_out_417191", "417191026", "story_v_out_417191.awb")

						arg_106_1:RecordAudio("417191026", var_109_9)
						arg_106_1:RecordAudio("417191026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_417191", "417191026", "story_v_out_417191.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_417191", "417191026", "story_v_out_417191.awb")
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
	Play417191027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 417191027
		arg_110_1.duration_ = 12

		local var_110_0 = {
			zh = 7.633,
			ja = 12
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
				arg_110_0:Play417191028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["10113"]) and arg_110_1.var_.actorSpriteComps10113 == nil then
				arg_110_1.var_.actorSpriteComps10113 = arg_110_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_0 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["10113"]) then
				if arg_110_1.var_.actorSpriteComps10113 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["10113"]) and arg_110_1.var_.actorSpriteComps10113 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_113_3 then
						iter_113_3.color = arg_110_1.isInRecall_ and (arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_110_1.var_.actorSpriteComps10113 = nil
			end

			local var_113_2 = 0
			local var_113_3 = 0.85

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_4 = arg_110_1:GetWordFromCfg(417191027)
				local var_113_5 = arg_110_1:FormatText(var_113_4.content)

				arg_110_1.text_.text = var_113_5

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_7 = 34 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_5) / 34)

				if (34 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_5) / 34)) > 0 and var_113_3 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_2 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_2
					end
				end

				arg_110_1.text_.text = var_113_5
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191027", "story_v_out_417191.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191027", "story_v_out_417191.awb") / 1000

					if var_113_8 + var_113_2 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_2
					end

					if var_113_4.prefab_name ~= "" and arg_110_1.actors_[var_113_4.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_4.prefab_name].transform, "story_v_out_417191", "417191027", "story_v_out_417191.awb")

						arg_110_1:RecordAudio("417191027", var_113_9)
						arg_110_1:RecordAudio("417191027", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_417191", "417191027", "story_v_out_417191.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_417191", "417191027", "story_v_out_417191.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_3, arg_110_1.talkMaxDuration)

			if var_113_2 <= arg_110_1.time_ and arg_110_1.time_ < var_113_2 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_2) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_2 + var_113_10 and arg_110_1.time_ < var_113_2 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play417191028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 417191028
		arg_114_1.duration_ = 6.47

		local var_114_0 = {
			zh = 4.2,
			ja = 6.466
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
				arg_114_0:Play417191029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["10113"]) and arg_114_1.var_.actorSpriteComps10113 == nil then
				arg_114_1.var_.actorSpriteComps10113 = arg_114_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_0 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["10113"]) then
				if arg_114_1.var_.actorSpriteComps10113 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["10113"]) and arg_114_1.var_.actorSpriteComps10113 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_117_3 then
						iter_117_3.color = arg_114_1.isInRecall_ and (arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_114_1.var_.actorSpriteComps10113 = nil
			end

			local var_117_2 = 0
			local var_117_3 = 0.575

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_4 = arg_114_1:GetWordFromCfg(417191028)
				local var_117_5 = arg_114_1:FormatText(var_117_4.content)

				arg_114_1.text_.text = var_117_5

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_7 = 23 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 23)

				if (23 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 23)) > 0 and var_117_3 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_2
					end
				end

				arg_114_1.text_.text = var_117_5
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191028", "story_v_out_417191.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191028", "story_v_out_417191.awb") / 1000

					if var_117_8 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_2
					end

					if var_117_4.prefab_name ~= "" and arg_114_1.actors_[var_117_4.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_4.prefab_name].transform, "story_v_out_417191", "417191028", "story_v_out_417191.awb")

						arg_114_1:RecordAudio("417191028", var_117_9)
						arg_114_1:RecordAudio("417191028", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_417191", "417191028", "story_v_out_417191.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_417191", "417191028", "story_v_out_417191.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_3, arg_114_1.talkMaxDuration)

			if var_117_2 <= arg_114_1.time_ and arg_114_1.time_ < var_117_2 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_2) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_2 + var_117_10 and arg_114_1.time_ < var_117_2 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play417191029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 417191029
		arg_118_1.duration_ = 8

		local var_118_0 = {
			zh = 6.7,
			ja = 8
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
				arg_118_0:Play417191030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if arg_118_1.bgs_.I16g == nil then
				local var_121_0 = Object.Instantiate(arg_118_1.paintGo_)

				var_121_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I16g")
				var_121_0.name = "I16g"
				var_121_0.transform.parent = arg_118_1.stage_.transform
				var_121_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.bgs_.I16g = var_121_0
			end

			if 2 < arg_118_1.time_ and arg_118_1.time_ <= 2 + arg_121_0 then
				local var_121_1 = arg_118_1.bgs_.I16g

				arg_118_1.bgs_.I16g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_121_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_121_2 = var_121_1:GetComponent("SpriteRenderer")

				if var_121_2 and var_121_2.sprite then
					local var_121_3 = 2 * (var_121_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_121_1.transform.localScale = Vector3.New(var_121_3 / var_121_2.sprite.bounds.size.y < var_121_3 * manager.ui.mainCameraCom_.aspect / var_121_2.sprite.bounds.size.x and var_121_3 * manager.ui.mainCameraCom_.aspect / var_121_2.sprite.bounds.size.x or var_121_3 / var_121_2.sprite.bounds.size.y, var_121_3 / var_121_2.sprite.bounds.size.y < var_121_3 * manager.ui.mainCameraCom_.aspect / var_121_2.sprite.bounds.size.x and var_121_3 * manager.ui.mainCameraCom_.aspect / var_121_2.sprite.bounds.size.x or var_121_3 / var_121_2.sprite.bounds.size.y, 0)
				end

				for iter_121_0, iter_121_1 in pairs(arg_118_1.bgs_) do
					if iter_121_0 ~= "I16g" then
						iter_121_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_121_4 = 4

			if 4 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.allBtn_.enabled = false
			end

			if arg_118_1.time_ >= var_121_4 + 0.3 and arg_118_1.time_ < var_121_4 + 0.3 + arg_121_0 then
				arg_118_1.allBtn_.enabled = true
			end

			local var_121_5 = 0

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_6 = 2

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 then
				local var_121_7 = Color.New(0, 0, 0)

				var_121_7.a = Mathf.Lerp(0, 1, (arg_118_1.time_ - var_121_5) / var_121_6)
				arg_118_1.mask_.color = var_121_7
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 then
				local var_121_8 = Color.New(0, 0, 0)

				var_121_8.a = 1
				arg_118_1.mask_.color = var_121_8
			end

			local var_121_9 = 2

			if 2 < arg_118_1.time_ and arg_118_1.time_ <= var_121_9 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_10 = 2

			if var_121_9 <= arg_118_1.time_ and arg_118_1.time_ < var_121_9 + var_121_10 then
				local var_121_11 = Color.New(0, 0, 0)

				var_121_11.a = Mathf.Lerp(1, 0, (arg_118_1.time_ - var_121_9) / var_121_10)
				arg_118_1.mask_.color = var_121_11
			end

			if arg_118_1.time_ >= var_121_9 + var_121_10 and arg_118_1.time_ < var_121_9 + var_121_10 + arg_121_0 then
				local var_121_12 = Color.New(0, 0, 0)

				arg_118_1.mask_.enabled = false
				var_121_12.a = 0
				arg_118_1.mask_.color = var_121_12
			end

			local var_121_13 = arg_118_1.actors_["10113"].transform

			if 2 < arg_118_1.time_ and arg_118_1.time_ <= 2 + arg_121_0 then
				arg_118_1.var_.moveOldPos10113 = var_121_13.localPosition
				var_121_13.localScale = Vector3.New(1, 1, 1)

				arg_118_1:CheckSpriteTmpPos("10113", 7)

				for iter_121_2 = 0, var_121_13.childCount - 1 do
					local var_121_14 = var_121_13:GetChild(iter_121_2)

					if var_121_14.name == "" or not string.find(var_121_14.name, "split") then
						var_121_14.gameObject:SetActive(true)
					else
						var_121_14.gameObject:SetActive(false)
					end
				end
			end

			local var_121_15 = 0.001

			if 2 <= arg_118_1.time_ and arg_118_1.time_ < 2 + var_121_15 then
				var_121_13.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_118_1.time_ - 2) / var_121_15)
			end

			if arg_118_1.time_ >= 2 + var_121_15 and arg_118_1.time_ < 2 + var_121_15 + arg_121_0 then
				var_121_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_121_16 = "10110"

			if arg_118_1.actors_["10110"] == nil then
				local var_121_17 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10110")

				if not isNil(var_121_17) then
					local var_121_18 = Object.Instantiate(var_121_17, arg_118_1.canvasGo_.transform)

					var_121_18.transform:SetSiblingIndex(1)

					var_121_18.name = var_121_16
					var_121_18.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_118_1.actors_[var_121_16] = var_121_18

					if arg_118_1.isInRecall_ then
						for iter_121_3, iter_121_4 in ipairs((var_121_18:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_121_4.color = arg_118_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_121_19 = arg_118_1.actors_["10110"].transform

			if 3.966 < arg_118_1.time_ and arg_118_1.time_ <= 3.966 + arg_121_0 then
				arg_118_1.var_.moveOldPos10110 = var_121_19.localPosition
				var_121_19.localScale = Vector3.New(1, 1, 1)

				arg_118_1:CheckSpriteTmpPos("10110", 3)

				for iter_121_5 = 0, var_121_19.childCount - 1 do
					local var_121_20 = var_121_19:GetChild(iter_121_5)

					if var_121_20.name == "split_1" or not string.find(var_121_20.name, "split") then
						var_121_20.gameObject:SetActive(true)
					else
						var_121_20.gameObject:SetActive(false)
					end
				end
			end

			local var_121_21 = 0.001

			if 3.966 <= arg_118_1.time_ and arg_118_1.time_ < 3.966 + var_121_21 then
				var_121_19.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10110, Vector3.New(0, -413.3, -241.3), (arg_118_1.time_ - 3.966) / var_121_21)
			end

			if arg_118_1.time_ >= 3.966 + var_121_21 and arg_118_1.time_ < 3.966 + var_121_21 + arg_121_0 then
				var_121_19.localPosition = Vector3.New(0, -413.3, -241.3)
			end

			local var_121_22 = arg_118_1.actors_["10110"]

			if 3.966 < arg_118_1.time_ and arg_118_1.time_ <= 3.966 + arg_121_0 and not isNil(var_121_22) and arg_118_1.var_.actorSpriteComps10110 == nil then
				arg_118_1.var_.actorSpriteComps10110 = var_121_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_23 = 0.2

			if 3.966 <= arg_118_1.time_ and arg_118_1.time_ < 3.966 + var_121_23 and not isNil(var_121_22) then
				if arg_118_1.var_.actorSpriteComps10110 then
					for iter_121_6, iter_121_7 in pairs(arg_118_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_121_7 then
							if arg_118_1.isInRecall_ then
								iter_121_7.color = Color.New(Mathf.Lerp(iter_121_7.color.r, arg_118_1.hightColor1.r, (arg_118_1.time_ - 3.966) / var_121_23), Mathf.Lerp(iter_121_7.color.g, arg_118_1.hightColor1.g, (arg_118_1.time_ - 3.966) / var_121_23), (Mathf.Lerp(iter_121_7.color.b, arg_118_1.hightColor1.b, (arg_118_1.time_ - 3.966) / var_121_23)))
							else
								local var_121_24 = Mathf.Lerp(iter_121_7.color.r, 1, (arg_118_1.time_ - 3.966) / var_121_23)

								iter_121_7.color = Color.New(var_121_24, var_121_24, var_121_24)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= 3.966 + var_121_23 and arg_118_1.time_ < 3.966 + var_121_23 + arg_121_0 and not isNil(var_121_22) and arg_118_1.var_.actorSpriteComps10110 then
				for iter_121_8, iter_121_9 in pairs(arg_118_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_121_9 then
						iter_121_9.color = arg_118_1.isInRecall_ and (arg_118_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_118_1.var_.actorSpriteComps10110 = nil
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_25 = 4
			local var_121_26 = 0.35

			if 4 < arg_118_1.time_ and arg_118_1.time_ <= var_121_25 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_27 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_27:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[699].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_28 = arg_118_1:GetWordFromCfg(417191029)
				local var_121_29 = arg_118_1:FormatText(var_121_28.content)

				arg_118_1.text_.text = var_121_29

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_31 = 14 <= 0 and var_121_26 or var_121_26 * (utf8.len(var_121_29) / 14)

				if (14 <= 0 and var_121_26 or var_121_26 * (utf8.len(var_121_29) / 14)) > 0 and var_121_26 < var_121_31 then
					arg_118_1.talkMaxDuration = var_121_31
					var_121_25 = var_121_25 + 0.3

					if var_121_31 + var_121_25 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_31 + var_121_25
					end
				end

				arg_118_1.text_.text = var_121_29
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191029", "story_v_out_417191.awb") ~= 0 then
					local var_121_32 = manager.audio:GetVoiceLength("story_v_out_417191", "417191029", "story_v_out_417191.awb") / 1000

					if var_121_32 + var_121_25 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_32 + var_121_25
					end

					if var_121_28.prefab_name ~= "" and arg_118_1.actors_[var_121_28.prefab_name] ~= nil then
						local var_121_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_28.prefab_name].transform, "story_v_out_417191", "417191029", "story_v_out_417191.awb")

						arg_118_1:RecordAudio("417191029", var_121_33)
						arg_118_1:RecordAudio("417191029", var_121_33)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_417191", "417191029", "story_v_out_417191.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_417191", "417191029", "story_v_out_417191.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_34 = var_121_25 + 0.3
			local var_121_35 = math.max(var_121_26, arg_118_1.talkMaxDuration)

			if var_121_25 + 0.3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_34 + var_121_35 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_34) / var_121_35

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_34 + var_121_35 and arg_118_1.time_ < var_121_34 + var_121_35 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play417191030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417191030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play417191031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos10110 = arg_124_1.actors_["10110"].transform.localPosition
				arg_124_1.actors_["10110"].transform.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("10110", 7)

				for iter_127_0 = 0, arg_124_1.actors_["10110"].transform.childCount - 1 do
					local var_127_0 = arg_124_1.actors_["10110"].transform:GetChild(iter_127_0)

					if var_127_0.name == "" or not string.find(var_127_0.name, "split") then
						var_127_0.gameObject:SetActive(true)
					else
						var_127_0.gameObject:SetActive(false)
					end
				end
			end

			local var_127_1 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_1 then
				arg_124_1.actors_["10110"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10110, Vector3.New(0, -2000, -200), (arg_124_1.time_ - 0) / var_127_1)
			end

			if arg_124_1.time_ >= 0 + var_127_1 and arg_124_1.time_ < 0 + var_127_1 + arg_127_0 then
				arg_124_1.actors_["10110"].transform.localPosition = Vector3.New(0, -2000, -200)
			end

			if 0.05 < arg_124_1.time_ and arg_124_1.time_ <= 0.05 + arg_127_0 then
				arg_124_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep06", "")
			end

			local var_127_3 = 0
			local var_127_4 = 1.325

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_3 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_5 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(417191030).content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_7 = 53 <= 0 and var_127_4 or var_127_4 * (utf8.len(var_127_5) / 53)

				if (53 <= 0 and var_127_4 or var_127_4 * (utf8.len(var_127_5) / 53)) > 0 and var_127_4 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_3 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_3
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_4, arg_124_1.talkMaxDuration)

			if var_127_3 <= arg_124_1.time_ and arg_124_1.time_ < var_127_3 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_3) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_3 + var_127_8 and arg_124_1.time_ < var_127_3 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play417191031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417191031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play417191032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0.133333333333333 < arg_128_1.time_ and arg_128_1.time_ <= 0.133333333333333 + arg_131_0 then
				arg_128_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_car01", "")
			end

			local var_131_1 = 0
			local var_131_2 = 1.45

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(417191031).content)

				arg_128_1.text_.text = var_131_3

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 58 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_3) / 58)

				if (58 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_3) / 58)) > 0 and var_131_2 < var_131_5 then
					arg_128_1.talkMaxDuration = var_131_5

					if var_131_5 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + var_131_1
					end
				end

				arg_128_1.text_.text = var_131_3
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_6 = math.max(var_131_2, arg_128_1.talkMaxDuration)

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_6 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_1) / var_131_6

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_1 + var_131_6 and arg_128_1.time_ < var_131_1 + var_131_6 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play417191032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417191032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play417191033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 1.25

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(417191032).content)

				arg_132_1.text_.text = var_135_1

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_3 = 50 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 50)

				if (50 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 50)) > 0 and var_135_0 < var_135_3 then
					arg_132_1.talkMaxDuration = var_135_3

					if var_135_3 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_3 + 0
					end
				end

				arg_132_1.text_.text = var_135_1
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_4 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_4

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play417191033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417191033
		arg_136_1.duration_ = 9

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play417191034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if arg_136_1.bgs_.I11o == nil then
				local var_139_0 = Object.Instantiate(arg_136_1.paintGo_)

				var_139_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11o")
				var_139_0.name = "I11o"
				var_139_0.transform.parent = arg_136_1.stage_.transform
				var_139_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.bgs_.I11o = var_139_0
			end

			if 2 < arg_136_1.time_ and arg_136_1.time_ <= 2 + arg_139_0 then
				local var_139_1 = arg_136_1.bgs_.I11o

				arg_136_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_139_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_139_2 = var_139_1:GetComponent("SpriteRenderer")

				if var_139_2 and var_139_2.sprite then
					local var_139_3 = 2 * (var_139_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_139_1.transform.localScale = Vector3.New(var_139_3 / var_139_2.sprite.bounds.size.y < var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x and var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x or var_139_3 / var_139_2.sprite.bounds.size.y, var_139_3 / var_139_2.sprite.bounds.size.y < var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x and var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x or var_139_3 / var_139_2.sprite.bounds.size.y, 0)
				end

				for iter_139_0, iter_139_1 in pairs(arg_136_1.bgs_) do
					if iter_139_0 ~= "I11o" then
						iter_139_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_139_4 = 3.999999999999

			if 3.999999999999 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.allBtn_.enabled = false
			end

			if arg_136_1.time_ >= var_139_4 + 0.3 and arg_136_1.time_ < var_139_4 + 0.3 + arg_139_0 then
				arg_136_1.allBtn_.enabled = true
			end

			local var_139_5 = 0

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_6 = 2

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 then
				local var_139_7 = Color.New(0, 0, 0)

				var_139_7.a = Mathf.Lerp(0, 1, (arg_136_1.time_ - var_139_5) / var_139_6)
				arg_136_1.mask_.color = var_139_7
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 then
				local var_139_8 = Color.New(0, 0, 0)

				var_139_8.a = 1
				arg_136_1.mask_.color = var_139_8
			end

			local var_139_9 = 2

			if 2 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_10 = 2

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_10 then
				local var_139_11 = Color.New(0, 0, 0)

				var_139_11.a = Mathf.Lerp(1, 0, (arg_136_1.time_ - var_139_9) / var_139_10)
				arg_136_1.mask_.color = var_139_11
			end

			if arg_136_1.time_ >= var_139_9 + var_139_10 and arg_136_1.time_ < var_139_9 + var_139_10 + arg_139_0 then
				local var_139_12 = Color.New(0, 0, 0)

				arg_136_1.mask_.enabled = false
				var_139_12.a = 0
				arg_136_1.mask_.color = var_139_12
			end

			if arg_136_1.frameCnt_ <= 1 then
				arg_136_1.dialog_:SetActive(false)
			end

			local var_139_13 = 3.999999999999
			local var_139_14 = 1

			if 3.999999999999 < arg_136_1.time_ and arg_136_1.time_ <= var_139_13 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0

				arg_136_1.dialog_:SetActive(true)

				arg_136_1.dialogCg_.alpha = 0

				local var_139_15 = LeanTween.value(arg_136_1.dialog_, 0, 1, 0.3)

				var_139_15:setOnUpdate(LuaHelper.FloatAction(function(arg_140_0)
					arg_136_1.dialogCg_.alpha = arg_140_0
				end))
				var_139_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_136_1.dialog_)
					var_139_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_136_1.duration_ = arg_136_1.duration_ + 0.3

				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_16 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(417191033).content)

				arg_136_1.text_.text = var_139_16

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_18 = 40 <= 0 and var_139_14 or var_139_14 * (utf8.len(var_139_16) / 40)

				if (40 <= 0 and var_139_14 or var_139_14 * (utf8.len(var_139_16) / 40)) > 0 and var_139_14 < var_139_18 then
					arg_136_1.talkMaxDuration = var_139_18
					var_139_13 = var_139_13 + 0.3

					if var_139_18 + var_139_13 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_18 + var_139_13
					end
				end

				arg_136_1.text_.text = var_139_16
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_19 = var_139_13 + 0.3
			local var_139_20 = math.max(var_139_14, arg_136_1.talkMaxDuration)

			if var_139_13 + 0.3 <= arg_136_1.time_ and arg_136_1.time_ < var_139_19 + var_139_20 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_19) / var_139_20

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_19 + var_139_20 and arg_136_1.time_ < var_139_19 + var_139_20 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play417191034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 417191034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play417191035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0.333333333333333 < arg_142_1.time_ and arg_142_1.time_ <= 0.333333333333333 + arg_145_0 then
				arg_142_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_robot02", "")
			end

			local var_145_1 = 0
			local var_145_2 = 1.525

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_3 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(417191034).content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 61 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 61)

				if (61 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 61)) > 0 and var_145_2 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_1
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_6 = math.max(var_145_2, arg_142_1.talkMaxDuration)

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_6 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_1) / var_145_6

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_1 + var_145_6 and arg_142_1.time_ < var_145_1 + var_145_6 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play417191035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417191035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play417191036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.9

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_1 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(417191035).content)

				arg_146_1.text_.text = var_149_1

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_3 = 36 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 36)

				if (36 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 36)) > 0 and var_149_0 < var_149_3 then
					arg_146_1.talkMaxDuration = var_149_3

					if var_149_3 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_3 + 0
					end
				end

				arg_146_1.text_.text = var_149_1
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_4 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_4

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play417191036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 417191036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play417191037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 1.025

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(417191036).content)

				arg_150_1.text_.text = var_153_1

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_3 = 41 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 41)

				if (41 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 41)) > 0 and var_153_0 < var_153_3 then
					arg_150_1.talkMaxDuration = var_153_3

					if var_153_3 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_3 + 0
					end
				end

				arg_150_1.text_.text = var_153_1
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_4 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_4

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play417191037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 417191037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play417191038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 1.1

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(417191037).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 44 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 44)

				if (44 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 44)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play417191038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 417191038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play417191039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 1.075

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(417191038).content)

				arg_158_1.text_.text = var_161_1

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_3 = 43 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 43)

				if (43 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 43)) > 0 and var_161_0 < var_161_3 then
					arg_158_1.talkMaxDuration = var_161_3

					if var_161_3 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_3 + 0
					end
				end

				arg_158_1.text_.text = var_161_1
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_4 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_4

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play417191039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 417191039
		arg_162_1.duration_ = 7.23

		local var_162_0 = {
			zh = 6.8,
			ja = 7.233
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play417191040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if arg_162_1.bgs_.ST21 == nil then
				local var_165_0 = Object.Instantiate(arg_162_1.paintGo_)

				var_165_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST21")
				var_165_0.name = "ST21"
				var_165_0.transform.parent = arg_162_1.stage_.transform
				var_165_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_162_1.bgs_.ST21 = var_165_0
			end

			if 2 < arg_162_1.time_ and arg_162_1.time_ <= 2 + arg_165_0 then
				local var_165_1 = arg_162_1.bgs_.ST21

				arg_162_1.bgs_.ST21.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_165_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_165_2 = var_165_1:GetComponent("SpriteRenderer")

				if var_165_2 and var_165_2.sprite then
					local var_165_3 = 2 * (var_165_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_165_1.transform.localScale = Vector3.New(var_165_3 / var_165_2.sprite.bounds.size.y < var_165_3 * manager.ui.mainCameraCom_.aspect / var_165_2.sprite.bounds.size.x and var_165_3 * manager.ui.mainCameraCom_.aspect / var_165_2.sprite.bounds.size.x or var_165_3 / var_165_2.sprite.bounds.size.y, var_165_3 / var_165_2.sprite.bounds.size.y < var_165_3 * manager.ui.mainCameraCom_.aspect / var_165_2.sprite.bounds.size.x and var_165_3 * manager.ui.mainCameraCom_.aspect / var_165_2.sprite.bounds.size.x or var_165_3 / var_165_2.sprite.bounds.size.y, 0)
				end

				for iter_165_0, iter_165_1 in pairs(arg_162_1.bgs_) do
					if iter_165_0 ~= "ST21" then
						iter_165_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_165_4 = 4

			if 4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.allBtn_.enabled = false
			end

			if arg_162_1.time_ >= var_165_4 + 0.133333333333334 and arg_162_1.time_ < var_165_4 + 0.133333333333334 + arg_165_0 then
				arg_162_1.allBtn_.enabled = true
			end

			local var_165_5 = 0

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_6 = 2

			if var_165_5 <= arg_162_1.time_ and arg_162_1.time_ < var_165_5 + var_165_6 then
				local var_165_7 = Color.New(0, 0, 0)

				var_165_7.a = Mathf.Lerp(0, 1, (arg_162_1.time_ - var_165_5) / var_165_6)
				arg_162_1.mask_.color = var_165_7
			end

			if arg_162_1.time_ >= var_165_5 + var_165_6 and arg_162_1.time_ < var_165_5 + var_165_6 + arg_165_0 then
				local var_165_8 = Color.New(0, 0, 0)

				var_165_8.a = 1
				arg_162_1.mask_.color = var_165_8
			end

			local var_165_9 = 2

			if 2 < arg_162_1.time_ and arg_162_1.time_ <= var_165_9 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_10 = 2

			if var_165_9 <= arg_162_1.time_ and arg_162_1.time_ < var_165_9 + var_165_10 then
				local var_165_11 = Color.New(0, 0, 0)

				var_165_11.a = Mathf.Lerp(1, 0, (arg_162_1.time_ - var_165_9) / var_165_10)
				arg_162_1.mask_.color = var_165_11
			end

			if arg_162_1.time_ >= var_165_9 + var_165_10 and arg_162_1.time_ < var_165_9 + var_165_10 + arg_165_0 then
				local var_165_12 = Color.New(0, 0, 0)

				arg_162_1.mask_.enabled = false
				var_165_12.a = 0
				arg_162_1.mask_.color = var_165_12
			end

			local var_165_13 = arg_162_1.actors_["10110"].transform

			if 3.666 < arg_162_1.time_ and arg_162_1.time_ <= 3.666 + arg_165_0 then
				arg_162_1.var_.moveOldPos10110 = var_165_13.localPosition
				var_165_13.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("10110", 3)

				for iter_165_2 = 0, var_165_13.childCount - 1 do
					local var_165_14 = var_165_13:GetChild(iter_165_2)

					if var_165_14.name == "split_2" or not string.find(var_165_14.name, "split") then
						var_165_14.gameObject:SetActive(true)
					else
						var_165_14.gameObject:SetActive(false)
					end
				end
			end

			local var_165_15 = 0.001

			if 3.666 <= arg_162_1.time_ and arg_162_1.time_ < 3.666 + var_165_15 then
				var_165_13.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10110, Vector3.New(0, -413.3, -241.3), (arg_162_1.time_ - 3.666) / var_165_15)
			end

			if arg_162_1.time_ >= 3.666 + var_165_15 and arg_162_1.time_ < 3.666 + var_165_15 + arg_165_0 then
				var_165_13.localPosition = Vector3.New(0, -413.3, -241.3)
			end

			local var_165_16 = arg_162_1.actors_["10110"]

			if 3.66666666666667 < arg_162_1.time_ and arg_162_1.time_ <= 3.66666666666667 + arg_165_0 and not isNil(var_165_16) and arg_162_1.var_.actorSpriteComps10110 == nil then
				arg_162_1.var_.actorSpriteComps10110 = var_165_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_17 = 0.2

			if 3.66666666666667 <= arg_162_1.time_ and arg_162_1.time_ < 3.66666666666667 + var_165_17 and not isNil(var_165_16) then
				if arg_162_1.var_.actorSpriteComps10110 then
					for iter_165_3, iter_165_4 in pairs(arg_162_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_165_4 then
							if arg_162_1.isInRecall_ then
								iter_165_4.color = Color.New(Mathf.Lerp(iter_165_4.color.r, arg_162_1.hightColor1.r, (arg_162_1.time_ - 3.66666666666667) / var_165_17), Mathf.Lerp(iter_165_4.color.g, arg_162_1.hightColor1.g, (arg_162_1.time_ - 3.66666666666667) / var_165_17), (Mathf.Lerp(iter_165_4.color.b, arg_162_1.hightColor1.b, (arg_162_1.time_ - 3.66666666666667) / var_165_17)))
							else
								local var_165_18 = Mathf.Lerp(iter_165_4.color.r, 1, (arg_162_1.time_ - 3.66666666666667) / var_165_17)

								iter_165_4.color = Color.New(var_165_18, var_165_18, var_165_18)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= 3.66666666666667 + var_165_17 and arg_162_1.time_ < 3.66666666666667 + var_165_17 + arg_165_0 and not isNil(var_165_16) and arg_162_1.var_.actorSpriteComps10110 then
				for iter_165_5, iter_165_6 in pairs(arg_162_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_165_6 then
						iter_165_6.color = arg_162_1.isInRecall_ and (arg_162_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_162_1.var_.actorSpriteComps10110 = nil
			end

			if 3.66666666666667 < arg_162_1.time_ and arg_162_1.time_ <= 3.66666666666667 + arg_165_0 then
				local var_165_19 = arg_162_1.actors_["10110"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_165_19 then
					arg_162_1.var_.alphaOldValue10110 = var_165_19.alpha
					arg_162_1.var_.characterEffect10110 = var_165_19
				end

				arg_162_1.var_.alphaOldValue10110 = 0
			end

			local var_165_20 = 0.333333333333333

			if 3.66666666666667 <= arg_162_1.time_ and arg_162_1.time_ < 3.66666666666667 + var_165_20 then
				if arg_162_1.var_.characterEffect10110 then
					arg_162_1.var_.characterEffect10110.alpha = Mathf.Lerp(arg_162_1.var_.alphaOldValue10110, 1, (arg_162_1.time_ - 3.66666666666667) / var_165_20)
				end
			end

			if arg_162_1.time_ >= 3.66666666666667 + var_165_20 and arg_162_1.time_ < 3.66666666666667 + var_165_20 + arg_165_0 and arg_162_1.var_.characterEffect10110 then
				arg_162_1.var_.characterEffect10110.alpha = 1
			end

			if arg_162_1.frameCnt_ <= 1 then
				arg_162_1.dialog_:SetActive(false)
			end

			local var_165_21 = 4
			local var_165_22 = 0.25

			if 4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_21 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0

				arg_162_1.dialog_:SetActive(true)

				arg_162_1.dialogCg_.alpha = 0

				local var_165_23 = LeanTween.value(arg_162_1.dialog_, 0, 1, 0.3)

				var_165_23:setOnUpdate(LuaHelper.FloatAction(function(arg_166_0)
					arg_162_1.dialogCg_.alpha = arg_166_0
				end))
				var_165_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_162_1.dialog_)
					var_165_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_162_1.duration_ = arg_162_1.duration_ + 0.3

				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[699].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_24 = arg_162_1:GetWordFromCfg(417191039)
				local var_165_25 = arg_162_1:FormatText(var_165_24.content)

				arg_162_1.text_.text = var_165_25

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_27 = 10 <= 0 and var_165_22 or var_165_22 * (utf8.len(var_165_25) / 10)

				if (10 <= 0 and var_165_22 or var_165_22 * (utf8.len(var_165_25) / 10)) > 0 and var_165_22 < var_165_27 then
					arg_162_1.talkMaxDuration = var_165_27
					var_165_21 = var_165_21 + 0.3

					if var_165_27 + var_165_21 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_27 + var_165_21
					end
				end

				arg_162_1.text_.text = var_165_25
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191039", "story_v_out_417191.awb") ~= 0 then
					local var_165_28 = manager.audio:GetVoiceLength("story_v_out_417191", "417191039", "story_v_out_417191.awb") / 1000

					if var_165_28 + var_165_21 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_28 + var_165_21
					end

					if var_165_24.prefab_name ~= "" and arg_162_1.actors_[var_165_24.prefab_name] ~= nil then
						local var_165_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_24.prefab_name].transform, "story_v_out_417191", "417191039", "story_v_out_417191.awb")

						arg_162_1:RecordAudio("417191039", var_165_29)
						arg_162_1:RecordAudio("417191039", var_165_29)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_417191", "417191039", "story_v_out_417191.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_417191", "417191039", "story_v_out_417191.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_30 = var_165_21 + 0.3
			local var_165_31 = math.max(var_165_22, arg_162_1.talkMaxDuration)

			if var_165_21 + 0.3 <= arg_162_1.time_ and arg_162_1.time_ < var_165_30 + var_165_31 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_30) / var_165_31

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_30 + var_165_31 and arg_162_1.time_ < var_165_30 + var_165_31 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.666,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play417191040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 417191040
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play417191041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos10110 = arg_168_1.actors_["10110"].transform.localPosition
				arg_168_1.actors_["10110"].transform.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10110", 7)

				for iter_171_0 = 0, arg_168_1.actors_["10110"].transform.childCount - 1 do
					local var_171_0 = arg_168_1.actors_["10110"].transform:GetChild(iter_171_0)

					if var_171_0.name == "" or not string.find(var_171_0.name, "split") then
						var_171_0.gameObject:SetActive(true)
					else
						var_171_0.gameObject:SetActive(false)
					end
				end
			end

			local var_171_1 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_1 then
				arg_168_1.actors_["10110"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10110, Vector3.New(0, -2000, -200), (arg_168_1.time_ - 0) / var_171_1)
			end

			if arg_168_1.time_ >= 0 + var_171_1 and arg_168_1.time_ < 0 + var_171_1 + arg_171_0 then
				arg_168_1.actors_["10110"].transform.localPosition = Vector3.New(0, -2000, -200)
			end

			if 0.05 < arg_168_1.time_ and arg_168_1.time_ <= 0.05 + arg_171_0 then
				arg_168_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_ice", "")
			end

			local var_171_3 = 0
			local var_171_4 = 0.875

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_3 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_5 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(417191040).content)

				arg_168_1.text_.text = var_171_5

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_7 = 35 <= 0 and var_171_4 or var_171_4 * (utf8.len(var_171_5) / 35)

				if (35 <= 0 and var_171_4 or var_171_4 * (utf8.len(var_171_5) / 35)) > 0 and var_171_4 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_3 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_3
					end
				end

				arg_168_1.text_.text = var_171_5
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_8 = math.max(var_171_4, arg_168_1.talkMaxDuration)

			if var_171_3 <= arg_168_1.time_ and arg_168_1.time_ < var_171_3 + var_171_8 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_3) / var_171_8

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_3 + var_171_8 and arg_168_1.time_ < var_171_3 + var_171_8 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play417191041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 417191041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play417191042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 1.16666666666667 < arg_172_1.time_ and arg_172_1.time_ <= 1.16666666666667 + arg_175_0 then
				arg_172_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_coffeecup", "")
			end

			local var_175_1 = 0
			local var_175_2 = 1.275

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_3 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(417191041).content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 51 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 51)

				if (51 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 51)) > 0 and var_175_2 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_6 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_6 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_6

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_6 and arg_172_1.time_ < var_175_1 + var_175_6 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play417191042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 417191042
		arg_176_1.duration_ = 8.43

		local var_176_0 = {
			zh = 8.2,
			ja = 8.433
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play417191043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos10110 = arg_176_1.actors_["10110"].transform.localPosition
				arg_176_1.actors_["10110"].transform.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10110", 3)

				for iter_179_0 = 0, arg_176_1.actors_["10110"].transform.childCount - 1 do
					local var_179_0 = arg_176_1.actors_["10110"].transform:GetChild(iter_179_0)

					if var_179_0.name == "" or not string.find(var_179_0.name, "split") then
						var_179_0.gameObject:SetActive(true)
					else
						var_179_0.gameObject:SetActive(false)
					end
				end
			end

			local var_179_1 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_1 then
				arg_176_1.actors_["10110"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10110, Vector3.New(0, -413.3, -241.3), (arg_176_1.time_ - 0) / var_179_1)
			end

			if arg_176_1.time_ >= 0 + var_179_1 and arg_176_1.time_ < 0 + var_179_1 + arg_179_0 then
				arg_176_1.actors_["10110"].transform.localPosition = Vector3.New(0, -413.3, -241.3)
			end

			local var_179_2 = arg_176_1.actors_["10110"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.actorSpriteComps10110 == nil then
				arg_176_1.var_.actorSpriteComps10110 = var_179_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_3 = 0.034

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_3 and not isNil(var_179_2) then
				if arg_176_1.var_.actorSpriteComps10110 then
					for iter_179_1, iter_179_2 in pairs(arg_176_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_179_2 then
							if arg_176_1.isInRecall_ then
								iter_179_2.color = Color.New(Mathf.Lerp(iter_179_2.color.r, arg_176_1.hightColor1.r, (arg_176_1.time_ - 0) / var_179_3), Mathf.Lerp(iter_179_2.color.g, arg_176_1.hightColor1.g, (arg_176_1.time_ - 0) / var_179_3), (Mathf.Lerp(iter_179_2.color.b, arg_176_1.hightColor1.b, (arg_176_1.time_ - 0) / var_179_3)))
							else
								local var_179_4 = Mathf.Lerp(iter_179_2.color.r, 1, (arg_176_1.time_ - 0) / var_179_3)

								iter_179_2.color = Color.New(var_179_4, var_179_4, var_179_4)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= 0 + var_179_3 and arg_176_1.time_ < 0 + var_179_3 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.actorSpriteComps10110 then
				for iter_179_3, iter_179_4 in pairs(arg_176_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_179_4 then
						iter_179_4.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_176_1.var_.actorSpriteComps10110 = nil
			end

			local var_179_5 = 0
			local var_179_6 = 0.775

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[699].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_7 = arg_176_1:GetWordFromCfg(417191042)
				local var_179_8 = arg_176_1:FormatText(var_179_7.content)

				arg_176_1.text_.text = var_179_8

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_10 = 31 <= 0 and var_179_6 or var_179_6 * (utf8.len(var_179_8) / 31)

				if (31 <= 0 and var_179_6 or var_179_6 * (utf8.len(var_179_8) / 31)) > 0 and var_179_6 < var_179_10 then
					arg_176_1.talkMaxDuration = var_179_10

					if var_179_10 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_10 + var_179_5
					end
				end

				arg_176_1.text_.text = var_179_8
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191042", "story_v_out_417191.awb") ~= 0 then
					local var_179_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191042", "story_v_out_417191.awb") / 1000

					if var_179_11 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_11 + var_179_5
					end

					if var_179_7.prefab_name ~= "" and arg_176_1.actors_[var_179_7.prefab_name] ~= nil then
						local var_179_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_7.prefab_name].transform, "story_v_out_417191", "417191042", "story_v_out_417191.awb")

						arg_176_1:RecordAudio("417191042", var_179_12)
						arg_176_1:RecordAudio("417191042", var_179_12)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_417191", "417191042", "story_v_out_417191.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_417191", "417191042", "story_v_out_417191.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_13 = math.max(var_179_6, arg_176_1.talkMaxDuration)

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_13 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_5) / var_179_13

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_5 + var_179_13 and arg_176_1.time_ < var_179_5 + var_179_13 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play417191043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 417191043
		arg_180_1.duration_ = 8.03

		local var_180_0 = {
			zh = 8.033,
			ja = 7.666
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play417191044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if arg_180_1.actors_["10128"] == nil then
				local var_183_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_183_0) then
					local var_183_1 = Object.Instantiate(var_183_0, arg_180_1.canvasGo_.transform)

					var_183_1.transform:SetSiblingIndex(1)

					var_183_1.name = "10128"
					var_183_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_180_1.actors_["10128"] = var_183_1

					if arg_180_1.isInRecall_ then
						for iter_183_0, iter_183_1 in ipairs((var_183_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_183_1.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_183_2 = arg_180_1.actors_["10128"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.actorSpriteComps10128 == nil then
				arg_180_1.var_.actorSpriteComps10128 = var_183_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_3 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_3 and not isNil(var_183_2) then
				if arg_180_1.var_.actorSpriteComps10128 then
					for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_183_3 then
							if arg_180_1.isInRecall_ then
								iter_183_3.color = Color.New(Mathf.Lerp(iter_183_3.color.r, arg_180_1.hightColor1.r, (arg_180_1.time_ - 0) / var_183_3), Mathf.Lerp(iter_183_3.color.g, arg_180_1.hightColor1.g, (arg_180_1.time_ - 0) / var_183_3), (Mathf.Lerp(iter_183_3.color.b, arg_180_1.hightColor1.b, (arg_180_1.time_ - 0) / var_183_3)))
							else
								local var_183_4 = Mathf.Lerp(iter_183_3.color.r, 1, (arg_180_1.time_ - 0) / var_183_3)

								iter_183_3.color = Color.New(var_183_4, var_183_4, var_183_4)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_3 and arg_180_1.time_ < 0 + var_183_3 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.actorSpriteComps10128 then
				for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_183_5 then
						iter_183_5.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_180_1.var_.actorSpriteComps10128 = nil
			end

			local var_183_5 = arg_180_1.actors_["10128"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10128 = var_183_5.localPosition
				var_183_5.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10128", 4)

				for iter_183_6 = 0, var_183_5.childCount - 1 do
					local var_183_6 = var_183_5:GetChild(iter_183_6)

					if var_183_6.name == "" or not string.find(var_183_6.name, "split") then
						var_183_6.gameObject:SetActive(true)
					else
						var_183_6.gameObject:SetActive(false)
					end
				end
			end

			local var_183_7 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_7 then
				var_183_5.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_180_1.time_ - 0) / var_183_7)
			end

			if arg_180_1.time_ >= 0 + var_183_7 and arg_180_1.time_ < 0 + var_183_7 + arg_183_0 then
				var_183_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_183_8 = arg_180_1.actors_["10110"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10110 = var_183_8.localPosition
				var_183_8.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10110", 2)

				for iter_183_7 = 0, var_183_8.childCount - 1 do
					local var_183_9 = var_183_8:GetChild(iter_183_7)

					if var_183_9.name == "" or not string.find(var_183_9.name, "split") then
						var_183_9.gameObject:SetActive(true)
					else
						var_183_9.gameObject:SetActive(false)
					end
				end
			end

			local var_183_10 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_10 then
				var_183_8.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10110, Vector3.New(-390, -425.7, -223.7), (arg_180_1.time_ - 0) / var_183_10)
			end

			if arg_180_1.time_ >= 0 + var_183_10 and arg_180_1.time_ < 0 + var_183_10 + arg_183_0 then
				var_183_8.localPosition = Vector3.New(-390, -425.7, -223.7)
			end

			local var_183_11 = arg_180_1.actors_["10110"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_11) and arg_180_1.var_.actorSpriteComps10110 == nil then
				arg_180_1.var_.actorSpriteComps10110 = var_183_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_12 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_12 and not isNil(var_183_11) then
				if arg_180_1.var_.actorSpriteComps10110 then
					for iter_183_8, iter_183_9 in pairs(arg_180_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_183_9 then
							if arg_180_1.isInRecall_ then
								iter_183_9.color = Color.New(Mathf.Lerp(iter_183_9.color.r, arg_180_1.hightColor2.r, (arg_180_1.time_ - 0) / var_183_12), Mathf.Lerp(iter_183_9.color.g, arg_180_1.hightColor2.g, (arg_180_1.time_ - 0) / var_183_12), (Mathf.Lerp(iter_183_9.color.b, arg_180_1.hightColor2.b, (arg_180_1.time_ - 0) / var_183_12)))
							else
								local var_183_13 = Mathf.Lerp(iter_183_9.color.r, 0.5, (arg_180_1.time_ - 0) / var_183_12)

								iter_183_9.color = Color.New(var_183_13, var_183_13, var_183_13)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_12 and arg_180_1.time_ < 0 + var_183_12 + arg_183_0 and not isNil(var_183_11) and arg_180_1.var_.actorSpriteComps10110 then
				for iter_183_10, iter_183_11 in pairs(arg_180_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_183_11 then
						iter_183_11.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_180_1.var_.actorSpriteComps10110 = nil
			end

			local var_183_14 = 0
			local var_183_15 = 1

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_14 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_16 = arg_180_1:GetWordFromCfg(417191043)
				local var_183_17 = arg_180_1:FormatText(var_183_16.content)

				arg_180_1.text_.text = var_183_17

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_19 = 40 <= 0 and var_183_15 or var_183_15 * (utf8.len(var_183_17) / 40)

				if (40 <= 0 and var_183_15 or var_183_15 * (utf8.len(var_183_17) / 40)) > 0 and var_183_15 < var_183_19 then
					arg_180_1.talkMaxDuration = var_183_19

					if var_183_19 + var_183_14 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_19 + var_183_14
					end
				end

				arg_180_1.text_.text = var_183_17
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191043", "story_v_out_417191.awb") ~= 0 then
					local var_183_20 = manager.audio:GetVoiceLength("story_v_out_417191", "417191043", "story_v_out_417191.awb") / 1000

					if var_183_20 + var_183_14 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_20 + var_183_14
					end

					if var_183_16.prefab_name ~= "" and arg_180_1.actors_[var_183_16.prefab_name] ~= nil then
						local var_183_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_16.prefab_name].transform, "story_v_out_417191", "417191043", "story_v_out_417191.awb")

						arg_180_1:RecordAudio("417191043", var_183_21)
						arg_180_1:RecordAudio("417191043", var_183_21)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_417191", "417191043", "story_v_out_417191.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_417191", "417191043", "story_v_out_417191.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_22 = math.max(var_183_15, arg_180_1.talkMaxDuration)

			if var_183_14 <= arg_180_1.time_ and arg_180_1.time_ < var_183_14 + var_183_22 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_14) / var_183_22

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_14 + var_183_22 and arg_180_1.time_ < var_183_14 + var_183_22 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
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
				actorName = "10110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play417191044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417191044
		arg_184_1.duration_ = 4.03

		local var_184_0 = {
			zh = 3.5,
			ja = 4.033
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play417191045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["10110"]) and arg_184_1.var_.actorSpriteComps10110 == nil then
				arg_184_1.var_.actorSpriteComps10110 = arg_184_1.actors_["10110"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_0 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["10110"]) then
				if arg_184_1.var_.actorSpriteComps10110 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								iter_187_1.color = Color.New(Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor1.r, (arg_184_1.time_ - 0) / var_187_0), Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor1.g, (arg_184_1.time_ - 0) / var_187_0), (Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor1.b, (arg_184_1.time_ - 0) / var_187_0)))
							else
								local var_187_1 = Mathf.Lerp(iter_187_1.color.r, 1, (arg_184_1.time_ - 0) / var_187_0)

								iter_187_1.color = Color.New(var_187_1, var_187_1, var_187_1)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["10110"]) and arg_184_1.var_.actorSpriteComps10110 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_187_3 then
						iter_187_3.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_184_1.var_.actorSpriteComps10110 = nil
			end

			local var_187_2 = arg_184_1.actors_["10128"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.actorSpriteComps10128 == nil then
				arg_184_1.var_.actorSpriteComps10128 = var_187_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_3 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_3 and not isNil(var_187_2) then
				if arg_184_1.var_.actorSpriteComps10128 then
					for iter_187_4, iter_187_5 in pairs(arg_184_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_187_5 then
							if arg_184_1.isInRecall_ then
								iter_187_5.color = Color.New(Mathf.Lerp(iter_187_5.color.r, arg_184_1.hightColor2.r, (arg_184_1.time_ - 0) / var_187_3), Mathf.Lerp(iter_187_5.color.g, arg_184_1.hightColor2.g, (arg_184_1.time_ - 0) / var_187_3), (Mathf.Lerp(iter_187_5.color.b, arg_184_1.hightColor2.b, (arg_184_1.time_ - 0) / var_187_3)))
							else
								local var_187_4 = Mathf.Lerp(iter_187_5.color.r, 0.5, (arg_184_1.time_ - 0) / var_187_3)

								iter_187_5.color = Color.New(var_187_4, var_187_4, var_187_4)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= 0 + var_187_3 and arg_184_1.time_ < 0 + var_187_3 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.actorSpriteComps10128 then
				for iter_187_6, iter_187_7 in pairs(arg_184_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_187_7 then
						iter_187_7.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_184_1.var_.actorSpriteComps10128 = nil
			end

			local var_187_5 = 0
			local var_187_6 = 0.275

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[699].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_7 = arg_184_1:GetWordFromCfg(417191044)
				local var_187_8 = arg_184_1:FormatText(var_187_7.content)

				arg_184_1.text_.text = var_187_8

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_10 = 11 <= 0 and var_187_6 or var_187_6 * (utf8.len(var_187_8) / 11)

				if (11 <= 0 and var_187_6 or var_187_6 * (utf8.len(var_187_8) / 11)) > 0 and var_187_6 < var_187_10 then
					arg_184_1.talkMaxDuration = var_187_10

					if var_187_10 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_10 + var_187_5
					end
				end

				arg_184_1.text_.text = var_187_8
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191044", "story_v_out_417191.awb") ~= 0 then
					local var_187_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191044", "story_v_out_417191.awb") / 1000

					if var_187_11 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_11 + var_187_5
					end

					if var_187_7.prefab_name ~= "" and arg_184_1.actors_[var_187_7.prefab_name] ~= nil then
						local var_187_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_7.prefab_name].transform, "story_v_out_417191", "417191044", "story_v_out_417191.awb")

						arg_184_1:RecordAudio("417191044", var_187_12)
						arg_184_1:RecordAudio("417191044", var_187_12)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_417191", "417191044", "story_v_out_417191.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_417191", "417191044", "story_v_out_417191.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_13 = math.max(var_187_6, arg_184_1.talkMaxDuration)

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_13 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_5) / var_187_13

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_5 + var_187_13 and arg_184_1.time_ < var_187_5 + var_187_13 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play417191045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417191045
		arg_188_1.duration_ = 14.13

		local var_188_0 = {
			zh = 12,
			ja = 14.133
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play417191046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["10128"]) and arg_188_1.var_.actorSpriteComps10128 == nil then
				arg_188_1.var_.actorSpriteComps10128 = arg_188_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_0 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["10128"]) then
				if arg_188_1.var_.actorSpriteComps10128 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								iter_191_1.color = Color.New(Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor1.r, (arg_188_1.time_ - 0) / var_191_0), Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor1.g, (arg_188_1.time_ - 0) / var_191_0), (Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor1.b, (arg_188_1.time_ - 0) / var_191_0)))
							else
								local var_191_1 = Mathf.Lerp(iter_191_1.color.r, 1, (arg_188_1.time_ - 0) / var_191_0)

								iter_191_1.color = Color.New(var_191_1, var_191_1, var_191_1)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["10128"]) and arg_188_1.var_.actorSpriteComps10128 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_191_3 then
						iter_191_3.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_188_1.var_.actorSpriteComps10128 = nil
			end

			local var_191_2 = arg_188_1.actors_["10110"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10110 = var_191_2.localPosition
				var_191_2.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10110", 2)

				for iter_191_4 = 0, var_191_2.childCount - 1 do
					local var_191_3 = var_191_2:GetChild(iter_191_4)

					if var_191_3.name == "" or not string.find(var_191_3.name, "split") then
						var_191_3.gameObject:SetActive(true)
					else
						var_191_3.gameObject:SetActive(false)
					end
				end
			end

			local var_191_4 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				var_191_2.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10110, Vector3.New(-390, -425.7, -223.7), (arg_188_1.time_ - 0) / var_191_4)
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				var_191_2.localPosition = Vector3.New(-390, -425.7, -223.7)
			end

			local var_191_5 = arg_188_1.actors_["10128"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10128 = var_191_5.localPosition
				var_191_5.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10128", 4)

				for iter_191_5 = 0, var_191_5.childCount - 1 do
					local var_191_6 = var_191_5:GetChild(iter_191_5)

					if var_191_6.name == "" or not string.find(var_191_6.name, "split") then
						var_191_6.gameObject:SetActive(true)
					else
						var_191_6.gameObject:SetActive(false)
					end
				end
			end

			local var_191_7 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 then
				var_191_5.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_188_1.time_ - 0) / var_191_7)
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 then
				var_191_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_191_8 = arg_188_1.actors_["10110"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps10110 == nil then
				arg_188_1.var_.actorSpriteComps10110 = var_191_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_9 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_9 and not isNil(var_191_8) then
				if arg_188_1.var_.actorSpriteComps10110 then
					for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_191_7 then
							if arg_188_1.isInRecall_ then
								iter_191_7.color = Color.New(Mathf.Lerp(iter_191_7.color.r, arg_188_1.hightColor2.r, (arg_188_1.time_ - 0) / var_191_9), Mathf.Lerp(iter_191_7.color.g, arg_188_1.hightColor2.g, (arg_188_1.time_ - 0) / var_191_9), (Mathf.Lerp(iter_191_7.color.b, arg_188_1.hightColor2.b, (arg_188_1.time_ - 0) / var_191_9)))
							else
								local var_191_10 = Mathf.Lerp(iter_191_7.color.r, 0.5, (arg_188_1.time_ - 0) / var_191_9)

								iter_191_7.color = Color.New(var_191_10, var_191_10, var_191_10)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_9 and arg_188_1.time_ < 0 + var_191_9 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps10110 then
				for iter_191_8, iter_191_9 in pairs(arg_188_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_191_9 then
						iter_191_9.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_188_1.var_.actorSpriteComps10110 = nil
			end

			local var_191_11 = 0
			local var_191_12 = 1.4

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_11 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_13 = arg_188_1:GetWordFromCfg(417191045)
				local var_191_14 = arg_188_1:FormatText(var_191_13.content)

				arg_188_1.text_.text = var_191_14

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_16 = 56 <= 0 and var_191_12 or var_191_12 * (utf8.len(var_191_14) / 56)

				if (56 <= 0 and var_191_12 or var_191_12 * (utf8.len(var_191_14) / 56)) > 0 and var_191_12 < var_191_16 then
					arg_188_1.talkMaxDuration = var_191_16

					if var_191_16 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_16 + var_191_11
					end
				end

				arg_188_1.text_.text = var_191_14
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191045", "story_v_out_417191.awb") ~= 0 then
					local var_191_17 = manager.audio:GetVoiceLength("story_v_out_417191", "417191045", "story_v_out_417191.awb") / 1000

					if var_191_17 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_17 + var_191_11
					end

					if var_191_13.prefab_name ~= "" and arg_188_1.actors_[var_191_13.prefab_name] ~= nil then
						local var_191_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_13.prefab_name].transform, "story_v_out_417191", "417191045", "story_v_out_417191.awb")

						arg_188_1:RecordAudio("417191045", var_191_18)
						arg_188_1:RecordAudio("417191045", var_191_18)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417191", "417191045", "story_v_out_417191.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417191", "417191045", "story_v_out_417191.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_19 = math.max(var_191_12, arg_188_1.talkMaxDuration)

			if var_191_11 <= arg_188_1.time_ and arg_188_1.time_ < var_191_11 + var_191_19 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_11) / var_191_19

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_11 + var_191_19 and arg_188_1.time_ < var_191_11 + var_191_19 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10110",
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

		arg_188_1:InitPlayNodeList()
	end,
	Play417191046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 417191046
		arg_192_1.duration_ = 8.77

		local var_192_0 = {
			zh = 7.533,
			ja = 8.766
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play417191047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.875

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_1 = arg_192_1:GetWordFromCfg(417191046)
				local var_195_2 = arg_192_1:FormatText(var_195_1.content)

				arg_192_1.text_.text = var_195_2

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_4 = 35 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 35)

				if (35 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 35)) > 0 and var_195_0 < var_195_4 then
					arg_192_1.talkMaxDuration = var_195_4

					if var_195_4 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_4 + 0
					end
				end

				arg_192_1.text_.text = var_195_2
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191046", "story_v_out_417191.awb") ~= 0 then
					local var_195_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191046", "story_v_out_417191.awb") / 1000

					if var_195_5 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + 0
					end

					if var_195_1.prefab_name ~= "" and arg_192_1.actors_[var_195_1.prefab_name] ~= nil then
						local var_195_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_1.prefab_name].transform, "story_v_out_417191", "417191046", "story_v_out_417191.awb")

						arg_192_1:RecordAudio("417191046", var_195_6)
						arg_192_1:RecordAudio("417191046", var_195_6)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_417191", "417191046", "story_v_out_417191.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_417191", "417191046", "story_v_out_417191.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_7 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_7 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_7

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_7 and arg_192_1.time_ < 0 + var_195_7 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play417191047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 417191047
		arg_196_1.duration_ = 7.57

		local var_196_0 = {
			zh = 4.366,
			ja = 7.566
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
				arg_196_0:Play417191048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0.55

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_1 = arg_196_1:GetWordFromCfg(417191047)
				local var_199_2 = arg_196_1:FormatText(var_199_1.content)

				arg_196_1.text_.text = var_199_2

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_4 = 22 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 22)

				if (22 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 22)) > 0 and var_199_0 < var_199_4 then
					arg_196_1.talkMaxDuration = var_199_4

					if var_199_4 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_4 + 0
					end
				end

				arg_196_1.text_.text = var_199_2
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191047", "story_v_out_417191.awb") ~= 0 then
					local var_199_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191047", "story_v_out_417191.awb") / 1000

					if var_199_5 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + 0
					end

					if var_199_1.prefab_name ~= "" and arg_196_1.actors_[var_199_1.prefab_name] ~= nil then
						local var_199_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_1.prefab_name].transform, "story_v_out_417191", "417191047", "story_v_out_417191.awb")

						arg_196_1:RecordAudio("417191047", var_199_6)
						arg_196_1:RecordAudio("417191047", var_199_6)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_417191", "417191047", "story_v_out_417191.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_417191", "417191047", "story_v_out_417191.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_0, arg_196_1.talkMaxDuration)

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - 0) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= 0 + var_199_7 and arg_196_1.time_ < 0 + var_199_7 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play417191048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 417191048
		arg_200_1.duration_ = 10.1

		local var_200_0 = {
			zh = 5.5,
			ja = 10.1
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play417191049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["10110"]) and arg_200_1.var_.actorSpriteComps10110 == nil then
				arg_200_1.var_.actorSpriteComps10110 = arg_200_1.actors_["10110"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_0 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["10110"]) then
				if arg_200_1.var_.actorSpriteComps10110 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								iter_203_1.color = Color.New(Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor1.r, (arg_200_1.time_ - 0) / var_203_0), Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor1.g, (arg_200_1.time_ - 0) / var_203_0), (Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor1.b, (arg_200_1.time_ - 0) / var_203_0)))
							else
								local var_203_1 = Mathf.Lerp(iter_203_1.color.r, 1, (arg_200_1.time_ - 0) / var_203_0)

								iter_203_1.color = Color.New(var_203_1, var_203_1, var_203_1)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["10110"]) and arg_200_1.var_.actorSpriteComps10110 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_203_3 then
						iter_203_3.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_200_1.var_.actorSpriteComps10110 = nil
			end

			local var_203_2 = arg_200_1.actors_["10128"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10128 == nil then
				arg_200_1.var_.actorSpriteComps10128 = var_203_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_3 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.actorSpriteComps10128 then
					for iter_203_4, iter_203_5 in pairs(arg_200_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_203_5 then
							if arg_200_1.isInRecall_ then
								iter_203_5.color = Color.New(Mathf.Lerp(iter_203_5.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 0) / var_203_3), Mathf.Lerp(iter_203_5.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 0) / var_203_3), (Mathf.Lerp(iter_203_5.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 0) / var_203_3)))
							else
								local var_203_4 = Mathf.Lerp(iter_203_5.color.r, 0.5, (arg_200_1.time_ - 0) / var_203_3)

								iter_203_5.color = Color.New(var_203_4, var_203_4, var_203_4)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10128 then
				for iter_203_6, iter_203_7 in pairs(arg_200_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_203_7 then
						iter_203_7.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps10128 = nil
			end

			local var_203_5 = 0
			local var_203_6 = 0.55

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_5 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_7 = arg_200_1:GetWordFromCfg(417191048)
				local var_203_8 = arg_200_1:FormatText(var_203_7.content)

				arg_200_1.text_.text = var_203_8

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_10 = 22 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_8) / 22)

				if (22 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_8) / 22)) > 0 and var_203_6 < var_203_10 then
					arg_200_1.talkMaxDuration = var_203_10

					if var_203_10 + var_203_5 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_5
					end
				end

				arg_200_1.text_.text = var_203_8
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191048", "story_v_out_417191.awb") ~= 0 then
					local var_203_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191048", "story_v_out_417191.awb") / 1000

					if var_203_11 + var_203_5 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_11 + var_203_5
					end

					if var_203_7.prefab_name ~= "" and arg_200_1.actors_[var_203_7.prefab_name] ~= nil then
						local var_203_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_7.prefab_name].transform, "story_v_out_417191", "417191048", "story_v_out_417191.awb")

						arg_200_1:RecordAudio("417191048", var_203_12)
						arg_200_1:RecordAudio("417191048", var_203_12)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_417191", "417191048", "story_v_out_417191.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_417191", "417191048", "story_v_out_417191.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_13 = math.max(var_203_6, arg_200_1.talkMaxDuration)

			if var_203_5 <= arg_200_1.time_ and arg_200_1.time_ < var_203_5 + var_203_13 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_5) / var_203_13

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_5 + var_203_13 and arg_200_1.time_ < var_203_5 + var_203_13 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play417191049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 417191049
		arg_204_1.duration_ = 14.4

		local var_204_0 = {
			zh = 10.4,
			ja = 14.4
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
				arg_204_0:Play417191050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["10128"]) and arg_204_1.var_.actorSpriteComps10128 == nil then
				arg_204_1.var_.actorSpriteComps10128 = arg_204_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_0 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["10128"]) then
				if arg_204_1.var_.actorSpriteComps10128 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_207_1 then
							if arg_204_1.isInRecall_ then
								iter_207_1.color = Color.New(Mathf.Lerp(iter_207_1.color.r, arg_204_1.hightColor1.r, (arg_204_1.time_ - 0) / var_207_0), Mathf.Lerp(iter_207_1.color.g, arg_204_1.hightColor1.g, (arg_204_1.time_ - 0) / var_207_0), (Mathf.Lerp(iter_207_1.color.b, arg_204_1.hightColor1.b, (arg_204_1.time_ - 0) / var_207_0)))
							else
								local var_207_1 = Mathf.Lerp(iter_207_1.color.r, 1, (arg_204_1.time_ - 0) / var_207_0)

								iter_207_1.color = Color.New(var_207_1, var_207_1, var_207_1)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["10128"]) and arg_204_1.var_.actorSpriteComps10128 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_207_3 then
						iter_207_3.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_204_1.var_.actorSpriteComps10128 = nil
			end

			local var_207_2 = arg_204_1.actors_["10110"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.actorSpriteComps10110 == nil then
				arg_204_1.var_.actorSpriteComps10110 = var_207_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_3 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_3 and not isNil(var_207_2) then
				if arg_204_1.var_.actorSpriteComps10110 then
					for iter_207_4, iter_207_5 in pairs(arg_204_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_207_5 then
							if arg_204_1.isInRecall_ then
								iter_207_5.color = Color.New(Mathf.Lerp(iter_207_5.color.r, arg_204_1.hightColor2.r, (arg_204_1.time_ - 0) / var_207_3), Mathf.Lerp(iter_207_5.color.g, arg_204_1.hightColor2.g, (arg_204_1.time_ - 0) / var_207_3), (Mathf.Lerp(iter_207_5.color.b, arg_204_1.hightColor2.b, (arg_204_1.time_ - 0) / var_207_3)))
							else
								local var_207_4 = Mathf.Lerp(iter_207_5.color.r, 0.5, (arg_204_1.time_ - 0) / var_207_3)

								iter_207_5.color = Color.New(var_207_4, var_207_4, var_207_4)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_3 and arg_204_1.time_ < 0 + var_207_3 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.actorSpriteComps10110 then
				for iter_207_6, iter_207_7 in pairs(arg_204_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_207_7 then
						iter_207_7.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_204_1.var_.actorSpriteComps10110 = nil
			end

			local var_207_5 = arg_204_1.actors_["10110"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10110 = var_207_5.localPosition
				var_207_5.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10110", 2)

				for iter_207_8 = 0, var_207_5.childCount - 1 do
					local var_207_6 = var_207_5:GetChild(iter_207_8)

					if var_207_6.name == "" or not string.find(var_207_6.name, "split") then
						var_207_6.gameObject:SetActive(true)
					else
						var_207_6.gameObject:SetActive(false)
					end
				end
			end

			local var_207_7 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				var_207_5.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10110, Vector3.New(-390, -425.7, -223.7), (arg_204_1.time_ - 0) / var_207_7)
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				var_207_5.localPosition = Vector3.New(-390, -425.7, -223.7)
			end

			local var_207_8 = arg_204_1.actors_["10128"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10128 = var_207_8.localPosition
				var_207_8.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10128", 4)

				for iter_207_9 = 0, var_207_8.childCount - 1 do
					local var_207_9 = var_207_8:GetChild(iter_207_9)

					if var_207_9.name == "" or not string.find(var_207_9.name, "split") then
						var_207_9.gameObject:SetActive(true)
					else
						var_207_9.gameObject:SetActive(false)
					end
				end
			end

			local var_207_10 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_10 then
				var_207_8.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_204_1.time_ - 0) / var_207_10)
			end

			if arg_204_1.time_ >= 0 + var_207_10 and arg_204_1.time_ < 0 + var_207_10 + arg_207_0 then
				var_207_8.localPosition = Vector3.New(390, -347, -300)
			end

			local var_207_11 = 0
			local var_207_12 = 1.15

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_11 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_13 = arg_204_1:GetWordFromCfg(417191049)
				local var_207_14 = arg_204_1:FormatText(var_207_13.content)

				arg_204_1.text_.text = var_207_14

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_16 = 46 <= 0 and var_207_12 or var_207_12 * (utf8.len(var_207_14) / 46)

				if (46 <= 0 and var_207_12 or var_207_12 * (utf8.len(var_207_14) / 46)) > 0 and var_207_12 < var_207_16 then
					arg_204_1.talkMaxDuration = var_207_16

					if var_207_16 + var_207_11 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_16 + var_207_11
					end
				end

				arg_204_1.text_.text = var_207_14
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191049", "story_v_out_417191.awb") ~= 0 then
					local var_207_17 = manager.audio:GetVoiceLength("story_v_out_417191", "417191049", "story_v_out_417191.awb") / 1000

					if var_207_17 + var_207_11 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_17 + var_207_11
					end

					if var_207_13.prefab_name ~= "" and arg_204_1.actors_[var_207_13.prefab_name] ~= nil then
						local var_207_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_13.prefab_name].transform, "story_v_out_417191", "417191049", "story_v_out_417191.awb")

						arg_204_1:RecordAudio("417191049", var_207_18)
						arg_204_1:RecordAudio("417191049", var_207_18)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_417191", "417191049", "story_v_out_417191.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_417191", "417191049", "story_v_out_417191.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_19 = math.max(var_207_12, arg_204_1.talkMaxDuration)

			if var_207_11 <= arg_204_1.time_ and arg_204_1.time_ < var_207_11 + var_207_19 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_11) / var_207_19

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_11 + var_207_19 and arg_204_1.time_ < var_207_11 + var_207_19 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10110",
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

		arg_204_1:InitPlayNodeList()
	end,
	Play417191050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 417191050
		arg_208_1.duration_ = 10.43

		local var_208_0 = {
			zh = 9.366,
			ja = 10.433
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
				arg_208_0:Play417191051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["10110"]) and arg_208_1.var_.actorSpriteComps10110 == nil then
				arg_208_1.var_.actorSpriteComps10110 = arg_208_1.actors_["10110"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_0 = 0.2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["10110"]) then
				if arg_208_1.var_.actorSpriteComps10110 then
					for iter_211_0, iter_211_1 in pairs(arg_208_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_211_1 then
							if arg_208_1.isInRecall_ then
								iter_211_1.color = Color.New(Mathf.Lerp(iter_211_1.color.r, arg_208_1.hightColor1.r, (arg_208_1.time_ - 0) / var_211_0), Mathf.Lerp(iter_211_1.color.g, arg_208_1.hightColor1.g, (arg_208_1.time_ - 0) / var_211_0), (Mathf.Lerp(iter_211_1.color.b, arg_208_1.hightColor1.b, (arg_208_1.time_ - 0) / var_211_0)))
							else
								local var_211_1 = Mathf.Lerp(iter_211_1.color.r, 1, (arg_208_1.time_ - 0) / var_211_0)

								iter_211_1.color = Color.New(var_211_1, var_211_1, var_211_1)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["10110"]) and arg_208_1.var_.actorSpriteComps10110 then
				for iter_211_2, iter_211_3 in pairs(arg_208_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_211_3 then
						iter_211_3.color = arg_208_1.isInRecall_ and (arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_208_1.var_.actorSpriteComps10110 = nil
			end

			local var_211_2 = arg_208_1.actors_["10128"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.actorSpriteComps10128 == nil then
				arg_208_1.var_.actorSpriteComps10128 = var_211_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_3 = 0.2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_3 and not isNil(var_211_2) then
				if arg_208_1.var_.actorSpriteComps10128 then
					for iter_211_4, iter_211_5 in pairs(arg_208_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_211_5 then
							if arg_208_1.isInRecall_ then
								iter_211_5.color = Color.New(Mathf.Lerp(iter_211_5.color.r, arg_208_1.hightColor2.r, (arg_208_1.time_ - 0) / var_211_3), Mathf.Lerp(iter_211_5.color.g, arg_208_1.hightColor2.g, (arg_208_1.time_ - 0) / var_211_3), (Mathf.Lerp(iter_211_5.color.b, arg_208_1.hightColor2.b, (arg_208_1.time_ - 0) / var_211_3)))
							else
								local var_211_4 = Mathf.Lerp(iter_211_5.color.r, 0.5, (arg_208_1.time_ - 0) / var_211_3)

								iter_211_5.color = Color.New(var_211_4, var_211_4, var_211_4)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= 0 + var_211_3 and arg_208_1.time_ < 0 + var_211_3 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.actorSpriteComps10128 then
				for iter_211_6, iter_211_7 in pairs(arg_208_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_211_7 then
						iter_211_7.color = arg_208_1.isInRecall_ and (arg_208_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_208_1.var_.actorSpriteComps10128 = nil
			end

			local var_211_5 = 0
			local var_211_6 = 0.825

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_7 = arg_208_1:GetWordFromCfg(417191050)
				local var_211_8 = arg_208_1:FormatText(var_211_7.content)

				arg_208_1.text_.text = var_211_8

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_10 = 33 <= 0 and var_211_6 or var_211_6 * (utf8.len(var_211_8) / 33)

				if (33 <= 0 and var_211_6 or var_211_6 * (utf8.len(var_211_8) / 33)) > 0 and var_211_6 < var_211_10 then
					arg_208_1.talkMaxDuration = var_211_10

					if var_211_10 + var_211_5 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_10 + var_211_5
					end
				end

				arg_208_1.text_.text = var_211_8
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191050", "story_v_out_417191.awb") ~= 0 then
					local var_211_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191050", "story_v_out_417191.awb") / 1000

					if var_211_11 + var_211_5 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_11 + var_211_5
					end

					if var_211_7.prefab_name ~= "" and arg_208_1.actors_[var_211_7.prefab_name] ~= nil then
						local var_211_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_7.prefab_name].transform, "story_v_out_417191", "417191050", "story_v_out_417191.awb")

						arg_208_1:RecordAudio("417191050", var_211_12)
						arg_208_1:RecordAudio("417191050", var_211_12)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_417191", "417191050", "story_v_out_417191.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_417191", "417191050", "story_v_out_417191.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_13 = math.max(var_211_6, arg_208_1.talkMaxDuration)

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_13 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_5) / var_211_13

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_5 + var_211_13 and arg_208_1.time_ < var_211_5 + var_211_13 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play417191051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 417191051
		arg_212_1.duration_ = 6.87

		local var_212_0 = {
			zh = 4.766,
			ja = 6.866
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
				arg_212_0:Play417191052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["10128"]) and arg_212_1.var_.actorSpriteComps10128 == nil then
				arg_212_1.var_.actorSpriteComps10128 = arg_212_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_0 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["10128"]) then
				if arg_212_1.var_.actorSpriteComps10128 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_215_1 then
							if arg_212_1.isInRecall_ then
								iter_215_1.color = Color.New(Mathf.Lerp(iter_215_1.color.r, arg_212_1.hightColor1.r, (arg_212_1.time_ - 0) / var_215_0), Mathf.Lerp(iter_215_1.color.g, arg_212_1.hightColor1.g, (arg_212_1.time_ - 0) / var_215_0), (Mathf.Lerp(iter_215_1.color.b, arg_212_1.hightColor1.b, (arg_212_1.time_ - 0) / var_215_0)))
							else
								local var_215_1 = Mathf.Lerp(iter_215_1.color.r, 1, (arg_212_1.time_ - 0) / var_215_0)

								iter_215_1.color = Color.New(var_215_1, var_215_1, var_215_1)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["10128"]) and arg_212_1.var_.actorSpriteComps10128 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_215_3 then
						iter_215_3.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_212_1.var_.actorSpriteComps10128 = nil
			end

			local var_215_2 = arg_212_1.actors_["10110"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps10110 == nil then
				arg_212_1.var_.actorSpriteComps10110 = var_215_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_3 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 and not isNil(var_215_2) then
				if arg_212_1.var_.actorSpriteComps10110 then
					for iter_215_4, iter_215_5 in pairs(arg_212_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_215_5 then
							if arg_212_1.isInRecall_ then
								iter_215_5.color = Color.New(Mathf.Lerp(iter_215_5.color.r, arg_212_1.hightColor2.r, (arg_212_1.time_ - 0) / var_215_3), Mathf.Lerp(iter_215_5.color.g, arg_212_1.hightColor2.g, (arg_212_1.time_ - 0) / var_215_3), (Mathf.Lerp(iter_215_5.color.b, arg_212_1.hightColor2.b, (arg_212_1.time_ - 0) / var_215_3)))
							else
								local var_215_4 = Mathf.Lerp(iter_215_5.color.r, 0.5, (arg_212_1.time_ - 0) / var_215_3)

								iter_215_5.color = Color.New(var_215_4, var_215_4, var_215_4)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps10110 then
				for iter_215_6, iter_215_7 in pairs(arg_212_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_215_7 then
						iter_215_7.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_212_1.var_.actorSpriteComps10110 = nil
			end

			local var_215_5 = 0
			local var_215_6 = 0.525

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_7 = arg_212_1:GetWordFromCfg(417191051)
				local var_215_8 = arg_212_1:FormatText(var_215_7.content)

				arg_212_1.text_.text = var_215_8

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_10 = 21 <= 0 and var_215_6 or var_215_6 * (utf8.len(var_215_8) / 21)

				if (21 <= 0 and var_215_6 or var_215_6 * (utf8.len(var_215_8) / 21)) > 0 and var_215_6 < var_215_10 then
					arg_212_1.talkMaxDuration = var_215_10

					if var_215_10 + var_215_5 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_5
					end
				end

				arg_212_1.text_.text = var_215_8
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191051", "story_v_out_417191.awb") ~= 0 then
					local var_215_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191051", "story_v_out_417191.awb") / 1000

					if var_215_11 + var_215_5 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_11 + var_215_5
					end

					if var_215_7.prefab_name ~= "" and arg_212_1.actors_[var_215_7.prefab_name] ~= nil then
						local var_215_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_7.prefab_name].transform, "story_v_out_417191", "417191051", "story_v_out_417191.awb")

						arg_212_1:RecordAudio("417191051", var_215_12)
						arg_212_1:RecordAudio("417191051", var_215_12)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_417191", "417191051", "story_v_out_417191.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_417191", "417191051", "story_v_out_417191.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_13 = math.max(var_215_6, arg_212_1.talkMaxDuration)

			if var_215_5 <= arg_212_1.time_ and arg_212_1.time_ < var_215_5 + var_215_13 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_5) / var_215_13

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_5 + var_215_13 and arg_212_1.time_ < var_215_5 + var_215_13 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play417191052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 417191052
		arg_216_1.duration_ = 12.7

		local var_216_0 = {
			zh = 8.7,
			ja = 12.7
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
				arg_216_0:Play417191053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 1.05

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_1 = arg_216_1:GetWordFromCfg(417191052)
				local var_219_2 = arg_216_1:FormatText(var_219_1.content)

				arg_216_1.text_.text = var_219_2

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_4 = 42 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 42)

				if (42 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 42)) > 0 and var_219_0 < var_219_4 then
					arg_216_1.talkMaxDuration = var_219_4

					if var_219_4 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_4 + 0
					end
				end

				arg_216_1.text_.text = var_219_2
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191052", "story_v_out_417191.awb") ~= 0 then
					local var_219_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191052", "story_v_out_417191.awb") / 1000

					if var_219_5 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + 0
					end

					if var_219_1.prefab_name ~= "" and arg_216_1.actors_[var_219_1.prefab_name] ~= nil then
						local var_219_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_1.prefab_name].transform, "story_v_out_417191", "417191052", "story_v_out_417191.awb")

						arg_216_1:RecordAudio("417191052", var_219_6)
						arg_216_1:RecordAudio("417191052", var_219_6)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_417191", "417191052", "story_v_out_417191.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_417191", "417191052", "story_v_out_417191.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_0, arg_216_1.talkMaxDuration)

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - 0) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= 0 + var_219_7 and arg_216_1.time_ < 0 + var_219_7 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play417191053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 417191053
		arg_220_1.duration_ = 12.6

		local var_220_0 = {
			zh = 10.2,
			ja = 12.6
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
				arg_220_0:Play417191054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["10110"]) and arg_220_1.var_.actorSpriteComps10110 == nil then
				arg_220_1.var_.actorSpriteComps10110 = arg_220_1.actors_["10110"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_0 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["10110"]) then
				if arg_220_1.var_.actorSpriteComps10110 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								iter_223_1.color = Color.New(Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor1.r, (arg_220_1.time_ - 0) / var_223_0), Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor1.g, (arg_220_1.time_ - 0) / var_223_0), (Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor1.b, (arg_220_1.time_ - 0) / var_223_0)))
							else
								local var_223_1 = Mathf.Lerp(iter_223_1.color.r, 1, (arg_220_1.time_ - 0) / var_223_0)

								iter_223_1.color = Color.New(var_223_1, var_223_1, var_223_1)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["10110"]) and arg_220_1.var_.actorSpriteComps10110 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_223_3 then
						iter_223_3.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_220_1.var_.actorSpriteComps10110 = nil
			end

			local var_223_2 = arg_220_1.actors_["10128"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.actorSpriteComps10128 == nil then
				arg_220_1.var_.actorSpriteComps10128 = var_223_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_3 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_3 and not isNil(var_223_2) then
				if arg_220_1.var_.actorSpriteComps10128 then
					for iter_223_4, iter_223_5 in pairs(arg_220_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_223_5 then
							if arg_220_1.isInRecall_ then
								iter_223_5.color = Color.New(Mathf.Lerp(iter_223_5.color.r, arg_220_1.hightColor2.r, (arg_220_1.time_ - 0) / var_223_3), Mathf.Lerp(iter_223_5.color.g, arg_220_1.hightColor2.g, (arg_220_1.time_ - 0) / var_223_3), (Mathf.Lerp(iter_223_5.color.b, arg_220_1.hightColor2.b, (arg_220_1.time_ - 0) / var_223_3)))
							else
								local var_223_4 = Mathf.Lerp(iter_223_5.color.r, 0.5, (arg_220_1.time_ - 0) / var_223_3)

								iter_223_5.color = Color.New(var_223_4, var_223_4, var_223_4)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= 0 + var_223_3 and arg_220_1.time_ < 0 + var_223_3 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.actorSpriteComps10128 then
				for iter_223_6, iter_223_7 in pairs(arg_220_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_223_7 then
						iter_223_7.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_220_1.var_.actorSpriteComps10128 = nil
			end

			local var_223_5 = 0
			local var_223_6 = 0.875

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_7 = arg_220_1:GetWordFromCfg(417191053)
				local var_223_8 = arg_220_1:FormatText(var_223_7.content)

				arg_220_1.text_.text = var_223_8

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_10 = 35 <= 0 and var_223_6 or var_223_6 * (utf8.len(var_223_8) / 35)

				if (35 <= 0 and var_223_6 or var_223_6 * (utf8.len(var_223_8) / 35)) > 0 and var_223_6 < var_223_10 then
					arg_220_1.talkMaxDuration = var_223_10

					if var_223_10 + var_223_5 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_5
					end
				end

				arg_220_1.text_.text = var_223_8
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191053", "story_v_out_417191.awb") ~= 0 then
					local var_223_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191053", "story_v_out_417191.awb") / 1000

					if var_223_11 + var_223_5 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_11 + var_223_5
					end

					if var_223_7.prefab_name ~= "" and arg_220_1.actors_[var_223_7.prefab_name] ~= nil then
						local var_223_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_7.prefab_name].transform, "story_v_out_417191", "417191053", "story_v_out_417191.awb")

						arg_220_1:RecordAudio("417191053", var_223_12)
						arg_220_1:RecordAudio("417191053", var_223_12)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_417191", "417191053", "story_v_out_417191.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_417191", "417191053", "story_v_out_417191.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_13 = math.max(var_223_6, arg_220_1.talkMaxDuration)

			if var_223_5 <= arg_220_1.time_ and arg_220_1.time_ < var_223_5 + var_223_13 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_5) / var_223_13

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_5 + var_223_13 and arg_220_1.time_ < var_223_5 + var_223_13 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play417191054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 417191054
		arg_224_1.duration_ = 13.07

		local var_224_0 = {
			zh = 9.866,
			ja = 13.066
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
				arg_224_0:Play417191055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0.875

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_1 = arg_224_1:GetWordFromCfg(417191054)
				local var_227_2 = arg_224_1:FormatText(var_227_1.content)

				arg_224_1.text_.text = var_227_2

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_4 = 35 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 35)

				if (35 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 35)) > 0 and var_227_0 < var_227_4 then
					arg_224_1.talkMaxDuration = var_227_4

					if var_227_4 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_4 + 0
					end
				end

				arg_224_1.text_.text = var_227_2
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191054", "story_v_out_417191.awb") ~= 0 then
					local var_227_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191054", "story_v_out_417191.awb") / 1000

					if var_227_5 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + 0
					end

					if var_227_1.prefab_name ~= "" and arg_224_1.actors_[var_227_1.prefab_name] ~= nil then
						local var_227_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_1.prefab_name].transform, "story_v_out_417191", "417191054", "story_v_out_417191.awb")

						arg_224_1:RecordAudio("417191054", var_227_6)
						arg_224_1:RecordAudio("417191054", var_227_6)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_417191", "417191054", "story_v_out_417191.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_417191", "417191054", "story_v_out_417191.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_7 = math.max(var_227_0, arg_224_1.talkMaxDuration)

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_7 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - 0) / var_227_7

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= 0 + var_227_7 and arg_224_1.time_ < 0 + var_227_7 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play417191055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 417191055
		arg_228_1.duration_ = 6.47

		local var_228_0 = {
			zh = 6.233,
			ja = 6.466
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
				arg_228_0:Play417191056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0.525

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_1 = arg_228_1:GetWordFromCfg(417191055)
				local var_231_2 = arg_228_1:FormatText(var_231_1.content)

				arg_228_1.text_.text = var_231_2

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_4 = 21 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 21)

				if (21 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 21)) > 0 and var_231_0 < var_231_4 then
					arg_228_1.talkMaxDuration = var_231_4

					if var_231_4 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_4 + 0
					end
				end

				arg_228_1.text_.text = var_231_2
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191055", "story_v_out_417191.awb") ~= 0 then
					local var_231_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191055", "story_v_out_417191.awb") / 1000

					if var_231_5 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + 0
					end

					if var_231_1.prefab_name ~= "" and arg_228_1.actors_[var_231_1.prefab_name] ~= nil then
						local var_231_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_1.prefab_name].transform, "story_v_out_417191", "417191055", "story_v_out_417191.awb")

						arg_228_1:RecordAudio("417191055", var_231_6)
						arg_228_1:RecordAudio("417191055", var_231_6)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_417191", "417191055", "story_v_out_417191.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_417191", "417191055", "story_v_out_417191.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_7 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_7 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_7

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_7 and arg_228_1.time_ < 0 + var_231_7 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play417191056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 417191056
		arg_232_1.duration_ = 9

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play417191057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 4 < arg_232_1.time_ and arg_232_1.time_ <= 4 + arg_235_0 then
				arg_232_1.allBtn_.enabled = false
			end

			if arg_232_1.time_ >= 4 + 0.933333333333334 and arg_232_1.time_ < 4 + 0.933333333333334 + arg_235_0 then
				arg_232_1.allBtn_.enabled = true
			end

			local var_235_0 = "SS1707"

			if arg_232_1.bgs_.SS1707 == nil then
				local var_235_1 = Object.Instantiate(arg_232_1.paintGo_)

				var_235_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_235_0)
				var_235_1.name = var_235_0
				var_235_1.transform.parent = arg_232_1.stage_.transform
				var_235_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.bgs_[var_235_0] = var_235_1
			end

			if 2 < arg_232_1.time_ and arg_232_1.time_ <= 2 + arg_235_0 then
				local var_235_2 = arg_232_1.bgs_.SS1707

				arg_232_1.bgs_.SS1707.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_235_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_235_3 = var_235_2:GetComponent("SpriteRenderer")

				if var_235_3 and var_235_3.sprite then
					local var_235_4 = 2 * (var_235_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_235_2.transform.localScale = Vector3.New(var_235_4 / var_235_3.sprite.bounds.size.y < var_235_4 * manager.ui.mainCameraCom_.aspect / var_235_3.sprite.bounds.size.x and var_235_4 * manager.ui.mainCameraCom_.aspect / var_235_3.sprite.bounds.size.x or var_235_4 / var_235_3.sprite.bounds.size.y, var_235_4 / var_235_3.sprite.bounds.size.y < var_235_4 * manager.ui.mainCameraCom_.aspect / var_235_3.sprite.bounds.size.x and var_235_4 * manager.ui.mainCameraCom_.aspect / var_235_3.sprite.bounds.size.x or var_235_4 / var_235_3.sprite.bounds.size.y, 0)
				end

				for iter_235_0, iter_235_1 in pairs(arg_232_1.bgs_) do
					if iter_235_0 ~= "SS1707" then
						iter_235_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_235_5 = 0

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 then
				arg_232_1.mask_.enabled = true
				arg_232_1.mask_.raycastTarget = true

				arg_232_1:SetGaussion(false)
			end

			local var_235_6 = 2

			if var_235_5 <= arg_232_1.time_ and arg_232_1.time_ < var_235_5 + var_235_6 then
				local var_235_7 = Color.New(0, 0, 0)

				var_235_7.a = Mathf.Lerp(0, 1, (arg_232_1.time_ - var_235_5) / var_235_6)
				arg_232_1.mask_.color = var_235_7
			end

			if arg_232_1.time_ >= var_235_5 + var_235_6 and arg_232_1.time_ < var_235_5 + var_235_6 + arg_235_0 then
				local var_235_8 = Color.New(0, 0, 0)

				var_235_8.a = 1
				arg_232_1.mask_.color = var_235_8
			end

			local var_235_9 = 2

			if 2 < arg_232_1.time_ and arg_232_1.time_ <= var_235_9 + arg_235_0 then
				arg_232_1.mask_.enabled = true
				arg_232_1.mask_.raycastTarget = true

				arg_232_1:SetGaussion(false)
			end

			local var_235_10 = 2

			if var_235_9 <= arg_232_1.time_ and arg_232_1.time_ < var_235_9 + var_235_10 then
				local var_235_11 = Color.New(0, 0, 0)

				var_235_11.a = Mathf.Lerp(1, 0, (arg_232_1.time_ - var_235_9) / var_235_10)
				arg_232_1.mask_.color = var_235_11
			end

			if arg_232_1.time_ >= var_235_9 + var_235_10 and arg_232_1.time_ < var_235_9 + var_235_10 + arg_235_0 then
				local var_235_12 = Color.New(0, 0, 0)

				arg_232_1.mask_.enabled = false
				var_235_12.a = 0
				arg_232_1.mask_.color = var_235_12
			end

			local var_235_13 = arg_232_1.actors_["10128"].transform

			if 1.966 < arg_232_1.time_ and arg_232_1.time_ <= 1.966 + arg_235_0 then
				arg_232_1.var_.moveOldPos10128 = var_235_13.localPosition
				var_235_13.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10128", 7)

				for iter_235_2 = 0, var_235_13.childCount - 1 do
					local var_235_14 = var_235_13:GetChild(iter_235_2)

					if var_235_14.name == "" or not string.find(var_235_14.name, "split") then
						var_235_14.gameObject:SetActive(true)
					else
						var_235_14.gameObject:SetActive(false)
					end
				end
			end

			local var_235_15 = 0.001

			if 1.966 <= arg_232_1.time_ and arg_232_1.time_ < 1.966 + var_235_15 then
				var_235_13.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_232_1.time_ - 1.966) / var_235_15)
			end

			if arg_232_1.time_ >= 1.966 + var_235_15 and arg_232_1.time_ < 1.966 + var_235_15 + arg_235_0 then
				var_235_13.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_235_16 = arg_232_1.actors_["10110"].transform

			if 1.96666666666667 < arg_232_1.time_ and arg_232_1.time_ <= 1.96666666666667 + arg_235_0 then
				arg_232_1.var_.moveOldPos10110 = var_235_16.localPosition
				var_235_16.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10110", 7)

				for iter_235_3 = 0, var_235_16.childCount - 1 do
					local var_235_17 = var_235_16:GetChild(iter_235_3)

					if var_235_17.name == "" or not string.find(var_235_17.name, "split") then
						var_235_17.gameObject:SetActive(true)
					else
						var_235_17.gameObject:SetActive(false)
					end
				end
			end

			local var_235_18 = 0.001

			if 1.96666666666667 <= arg_232_1.time_ and arg_232_1.time_ < 1.96666666666667 + var_235_18 then
				var_235_16.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10110, Vector3.New(0, -2000, -200), (arg_232_1.time_ - 1.96666666666667) / var_235_18)
			end

			if arg_232_1.time_ >= 1.96666666666667 + var_235_18 and arg_232_1.time_ < 1.96666666666667 + var_235_18 + arg_235_0 then
				var_235_16.localPosition = Vector3.New(0, -2000, -200)
			end

			local var_235_19 = arg_232_1.bgs_.SS1707.transform

			if 2.25427150144242 < arg_232_1.time_ and arg_232_1.time_ <= 2.25427150144242 + arg_235_0 then
				arg_232_1.var_.moveOldPosSS1707 = var_235_19.localPosition
			end

			local var_235_20 = 0.0666666666666668

			if 2.25427150144242 <= arg_232_1.time_ and arg_232_1.time_ < 2.25427150144242 + var_235_20 then
				var_235_19.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPosSS1707, Vector3.New(0, 1, 10), (arg_232_1.time_ - 2.25427150144242) / var_235_20)
			end

			if arg_232_1.time_ >= 2.25427150144242 + var_235_20 and arg_232_1.time_ < 2.25427150144242 + var_235_20 + arg_235_0 then
				var_235_19.localPosition = Vector3.New(0, 1, 10)
			end

			local var_235_21 = arg_232_1.bgs_.SS1707.transform

			if 2.32093816810908 < arg_232_1.time_ and arg_232_1.time_ <= 2.32093816810908 + arg_235_0 then
				arg_232_1.var_.moveOldPosSS1707 = var_235_21.localPosition
			end

			local var_235_22 = 1.56944766586336

			if 2.32093816810908 <= arg_232_1.time_ and arg_232_1.time_ < 2.32093816810908 + var_235_22 then
				var_235_21.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPosSS1707, Vector3.New(0, 1, 9.5), (arg_232_1.time_ - 2.32093816810908) / var_235_22)
			end

			if arg_232_1.time_ >= 2.32093816810908 + var_235_22 and arg_232_1.time_ < 2.32093816810908 + var_235_22 + arg_235_0 then
				var_235_21.localPosition = Vector3.New(0, 1, 9.5)
			end

			if arg_232_1.frameCnt_ <= 1 then
				arg_232_1.dialog_:SetActive(false)
			end

			local var_235_23 = 4
			local var_235_24 = 1.375

			if 4 < arg_232_1.time_ and arg_232_1.time_ <= var_235_23 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0

				arg_232_1.dialog_:SetActive(true)

				arg_232_1.dialogCg_.alpha = 0

				local var_235_25 = LeanTween.value(arg_232_1.dialog_, 0, 1, 0.3)

				var_235_25:setOnUpdate(LuaHelper.FloatAction(function(arg_236_0)
					arg_232_1.dialogCg_.alpha = arg_236_0
				end))
				var_235_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_232_1.dialog_)
					var_235_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_232_1.duration_ = arg_232_1.duration_ + 0.3

				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_26 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(417191056).content)

				arg_232_1.text_.text = var_235_26

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_28 = 55 <= 0 and var_235_24 or var_235_24 * (utf8.len(var_235_26) / 55)

				if (55 <= 0 and var_235_24 or var_235_24 * (utf8.len(var_235_26) / 55)) > 0 and var_235_24 < var_235_28 then
					arg_232_1.talkMaxDuration = var_235_28
					var_235_23 = var_235_23 + 0.3

					if var_235_28 + var_235_23 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_28 + var_235_23
					end
				end

				arg_232_1.text_.text = var_235_26
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_29 = var_235_23 + 0.3
			local var_235_30 = math.max(var_235_24, arg_232_1.talkMaxDuration)

			if var_235_23 + 0.3 <= arg_232_1.time_ and arg_232_1.time_ < var_235_29 + var_235_30 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_29) / var_235_30

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_29 + var_235_30 and arg_232_1.time_ < var_235_29 + var_235_30 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SS1707",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0666666666666668,
				className = "StoryMoveNode",
				startTime = 2.25427150144242,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1707",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.56944766586336,
				className = "StoryMoveNode",
				startTime = 2.32093816810908,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play417191057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 417191057
		arg_238_1.duration_ = 13.33

		local var_238_0 = {
			zh = 10.666,
			ja = 13.333
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play417191058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 1

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:GetWordFromCfg(417191057)
				local var_241_2 = arg_238_1:FormatText(var_241_1.content)

				arg_238_1.text_.text = var_241_2

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_4 = 40 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 40)

				if (40 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 40)) > 0 and var_241_0 < var_241_4 then
					arg_238_1.talkMaxDuration = var_241_4

					if var_241_4 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_4 + 0
					end
				end

				arg_238_1.text_.text = var_241_2
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191057", "story_v_out_417191.awb") ~= 0 then
					local var_241_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191057", "story_v_out_417191.awb") / 1000

					if var_241_5 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + 0
					end

					if var_241_1.prefab_name ~= "" and arg_238_1.actors_[var_241_1.prefab_name] ~= nil then
						local var_241_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_1.prefab_name].transform, "story_v_out_417191", "417191057", "story_v_out_417191.awb")

						arg_238_1:RecordAudio("417191057", var_241_6)
						arg_238_1:RecordAudio("417191057", var_241_6)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_417191", "417191057", "story_v_out_417191.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_417191", "417191057", "story_v_out_417191.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_7 and arg_238_1.time_ < 0 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play417191058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 417191058
		arg_242_1.duration_ = 14.37

		local var_242_0 = {
			zh = 11.066,
			ja = 14.366
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play417191059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 1.2

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_1 = arg_242_1:GetWordFromCfg(417191058)
				local var_245_2 = arg_242_1:FormatText(var_245_1.content)

				arg_242_1.text_.text = var_245_2

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_4 = 48 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 48)

				if (48 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 48)) > 0 and var_245_0 < var_245_4 then
					arg_242_1.talkMaxDuration = var_245_4

					if var_245_4 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_4 + 0
					end
				end

				arg_242_1.text_.text = var_245_2
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191058", "story_v_out_417191.awb") ~= 0 then
					local var_245_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191058", "story_v_out_417191.awb") / 1000

					if var_245_5 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + 0
					end

					if var_245_1.prefab_name ~= "" and arg_242_1.actors_[var_245_1.prefab_name] ~= nil then
						local var_245_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_1.prefab_name].transform, "story_v_out_417191", "417191058", "story_v_out_417191.awb")

						arg_242_1:RecordAudio("417191058", var_245_6)
						arg_242_1:RecordAudio("417191058", var_245_6)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_417191", "417191058", "story_v_out_417191.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_417191", "417191058", "story_v_out_417191.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play417191059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 417191059
		arg_246_1.duration_ = 4.43

		local var_246_0 = {
			zh = 2.466,
			ja = 4.433
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play417191060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.325

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:GetWordFromCfg(417191059)
				local var_249_2 = arg_246_1:FormatText(var_249_1.content)

				arg_246_1.text_.text = var_249_2

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 13 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 13)

				if (13 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 13)) > 0 and var_249_0 < var_249_4 then
					arg_246_1.talkMaxDuration = var_249_4

					if var_249_4 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_4 + 0
					end
				end

				arg_246_1.text_.text = var_249_2
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191059", "story_v_out_417191.awb") ~= 0 then
					local var_249_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191059", "story_v_out_417191.awb") / 1000

					if var_249_5 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + 0
					end

					if var_249_1.prefab_name ~= "" and arg_246_1.actors_[var_249_1.prefab_name] ~= nil then
						local var_249_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_1.prefab_name].transform, "story_v_out_417191", "417191059", "story_v_out_417191.awb")

						arg_246_1:RecordAudio("417191059", var_249_6)
						arg_246_1:RecordAudio("417191059", var_249_6)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_417191", "417191059", "story_v_out_417191.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_417191", "417191059", "story_v_out_417191.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play417191060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 417191060
		arg_250_1.duration_ = 8.27

		local var_250_0 = {
			zh = 6.5,
			ja = 8.266
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play417191061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.625

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_1 = arg_250_1:GetWordFromCfg(417191060)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.text_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 25 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 25)

				if (25 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 25)) > 0 and var_253_0 < var_253_4 then
					arg_250_1.talkMaxDuration = var_253_4

					if var_253_4 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_4 + 0
					end
				end

				arg_250_1.text_.text = var_253_2
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191060", "story_v_out_417191.awb") ~= 0 then
					local var_253_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191060", "story_v_out_417191.awb") / 1000

					if var_253_5 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + 0
					end

					if var_253_1.prefab_name ~= "" and arg_250_1.actors_[var_253_1.prefab_name] ~= nil then
						local var_253_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_1.prefab_name].transform, "story_v_out_417191", "417191060", "story_v_out_417191.awb")

						arg_250_1:RecordAudio("417191060", var_253_6)
						arg_250_1:RecordAudio("417191060", var_253_6)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_417191", "417191060", "story_v_out_417191.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_417191", "417191060", "story_v_out_417191.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_7 and arg_250_1.time_ < 0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play417191061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 417191061
		arg_254_1.duration_ = 8.83

		local var_254_0 = {
			zh = 8.233,
			ja = 8.833
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play417191062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.925

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_1 = arg_254_1:GetWordFromCfg(417191061)
				local var_257_2 = arg_254_1:FormatText(var_257_1.content)

				arg_254_1.text_.text = var_257_2

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_4 = 37 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_2) / 37)

				if (37 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_2) / 37)) > 0 and var_257_0 < var_257_4 then
					arg_254_1.talkMaxDuration = var_257_4

					if var_257_4 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_4 + 0
					end
				end

				arg_254_1.text_.text = var_257_2
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191061", "story_v_out_417191.awb") ~= 0 then
					local var_257_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191061", "story_v_out_417191.awb") / 1000

					if var_257_5 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + 0
					end

					if var_257_1.prefab_name ~= "" and arg_254_1.actors_[var_257_1.prefab_name] ~= nil then
						local var_257_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_1.prefab_name].transform, "story_v_out_417191", "417191061", "story_v_out_417191.awb")

						arg_254_1:RecordAudio("417191061", var_257_6)
						arg_254_1:RecordAudio("417191061", var_257_6)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_417191", "417191061", "story_v_out_417191.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_417191", "417191061", "story_v_out_417191.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_7 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_7

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play417191062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 417191062
		arg_258_1.duration_ = 9.87

		local var_258_0 = {
			zh = 6.5,
			ja = 9.866
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play417191063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.525

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:GetWordFromCfg(417191062)
				local var_261_2 = arg_258_1:FormatText(var_261_1.content)

				arg_258_1.text_.text = var_261_2

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 21 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 21)

				if (21 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 21)) > 0 and var_261_0 < var_261_4 then
					arg_258_1.talkMaxDuration = var_261_4

					if var_261_4 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_4 + 0
					end
				end

				arg_258_1.text_.text = var_261_2
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191062", "story_v_out_417191.awb") ~= 0 then
					local var_261_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191062", "story_v_out_417191.awb") / 1000

					if var_261_5 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + 0
					end

					if var_261_1.prefab_name ~= "" and arg_258_1.actors_[var_261_1.prefab_name] ~= nil then
						local var_261_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_1.prefab_name].transform, "story_v_out_417191", "417191062", "story_v_out_417191.awb")

						arg_258_1:RecordAudio("417191062", var_261_6)
						arg_258_1:RecordAudio("417191062", var_261_6)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_417191", "417191062", "story_v_out_417191.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_417191", "417191062", "story_v_out_417191.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play417191063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 417191063
		arg_262_1.duration_ = 5.3

		local var_262_0 = {
			zh = 4.466,
			ja = 5.3
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play417191064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.325

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_1 = arg_262_1:GetWordFromCfg(417191063)
				local var_265_2 = arg_262_1:FormatText(var_265_1.content)

				arg_262_1.text_.text = var_265_2

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 13 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 13)

				if (13 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 13)) > 0 and var_265_0 < var_265_4 then
					arg_262_1.talkMaxDuration = var_265_4

					if var_265_4 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_4 + 0
					end
				end

				arg_262_1.text_.text = var_265_2
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191063", "story_v_out_417191.awb") ~= 0 then
					local var_265_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191063", "story_v_out_417191.awb") / 1000

					if var_265_5 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + 0
					end

					if var_265_1.prefab_name ~= "" and arg_262_1.actors_[var_265_1.prefab_name] ~= nil then
						local var_265_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_1.prefab_name].transform, "story_v_out_417191", "417191063", "story_v_out_417191.awb")

						arg_262_1:RecordAudio("417191063", var_265_6)
						arg_262_1:RecordAudio("417191063", var_265_6)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_417191", "417191063", "story_v_out_417191.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_417191", "417191063", "story_v_out_417191.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play417191064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 417191064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play417191065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0.05 < arg_266_1.time_ and arg_266_1.time_ <= 0.05 + arg_269_0 then
				arg_266_1:AudioAction("play", "effect", "se_story_17", "se_story_17_elecclock", "")
			end

			local var_269_1 = 0
			local var_269_2 = 1.125

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_3 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(417191064).content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 45 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 45)

				if (45 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 45)) > 0 and var_269_2 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_6 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_6 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_1) / var_269_6

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_1 + var_269_6 and arg_266_1.time_ < var_269_1 + var_269_6 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play417191065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 417191065
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play417191066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 1.2

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_1 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(417191065).content)

				arg_270_1.text_.text = var_273_1

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_3 = 48 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 48)

				if (48 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 48)) > 0 and var_273_0 < var_273_3 then
					arg_270_1.talkMaxDuration = var_273_3

					if var_273_3 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_3 + 0
					end
				end

				arg_270_1.text_.text = var_273_1
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_4 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_4

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play417191066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 417191066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play417191067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 1.225

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_1 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(417191066).content)

				arg_274_1.text_.text = var_277_1

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_3 = 49 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 49)

				if (49 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 49)) > 0 and var_277_0 < var_277_3 then
					arg_274_1.talkMaxDuration = var_277_3

					if var_277_3 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_3 + 0
					end
				end

				arg_274_1.text_.text = var_277_1
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_4 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_4

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play417191067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 417191067
		arg_278_1.duration_ = 9.93

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play417191068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = false

				arg_278_1:SetGaussion(false)
			end

			local var_281_0 = 1.2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 then
				local var_281_1 = Color.New(0, 0, 0)

				var_281_1.a = Mathf.Lerp(0, 1, (arg_278_1.time_ - 0) / var_281_0)
				arg_278_1.mask_.color = var_281_1
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 then
				local var_281_2 = Color.New(0, 0, 0)

				var_281_2.a = 1
				arg_278_1.mask_.color = var_281_2
			end

			local var_281_3 = 1.2

			if 1.2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_3 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_4 = 2.9

			if var_281_3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_3 + var_281_4 then
				local var_281_5 = Color.New(0, 0, 0)

				var_281_5.a = Mathf.Lerp(1, 0, (arg_278_1.time_ - var_281_3) / var_281_4)
				arg_278_1.mask_.color = var_281_5
			end

			if arg_278_1.time_ >= var_281_3 + var_281_4 and arg_278_1.time_ < var_281_3 + var_281_4 + arg_281_0 then
				local var_281_6 = Color.New(0, 0, 0)

				arg_278_1.mask_.enabled = false
				var_281_6.a = 0
				arg_278_1.mask_.color = var_281_6
			end

			local var_281_7 = "STblack"

			if arg_278_1.bgs_.STblack == nil then
				local var_281_8 = Object.Instantiate(arg_278_1.paintGo_)

				var_281_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_281_7)
				var_281_8.name = var_281_7
				var_281_8.transform.parent = arg_278_1.stage_.transform
				var_281_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_278_1.bgs_[var_281_7] = var_281_8
			end

			if 1.2 < arg_278_1.time_ and arg_278_1.time_ <= 1.2 + arg_281_0 then
				local var_281_9 = arg_278_1.bgs_.STblack

				arg_278_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_281_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_10 = var_281_9:GetComponent("SpriteRenderer")

				if var_281_10 and var_281_10.sprite then
					local var_281_11 = 2 * (var_281_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_281_9.transform.localScale = Vector3.New(var_281_11 / var_281_10.sprite.bounds.size.y < var_281_11 * manager.ui.mainCameraCom_.aspect / var_281_10.sprite.bounds.size.x and var_281_11 * manager.ui.mainCameraCom_.aspect / var_281_10.sprite.bounds.size.x or var_281_11 / var_281_10.sprite.bounds.size.y, var_281_11 / var_281_10.sprite.bounds.size.y < var_281_11 * manager.ui.mainCameraCom_.aspect / var_281_10.sprite.bounds.size.x and var_281_11 * manager.ui.mainCameraCom_.aspect / var_281_10.sprite.bounds.size.x or var_281_11 / var_281_10.sprite.bounds.size.y, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "STblack" then
						iter_281_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.2 < arg_278_1.time_ and arg_278_1.time_ <= 1.2 + arg_281_0 then
				arg_278_1.fswbg_:SetActive(true)
				arg_278_1.dialog_:SetActive(false)

				arg_278_1.fswtw_.percent = 0
				arg_278_1.fswt_.text = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(417191067).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.fswt_)

				arg_278_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_278_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_278_1.fswtw_:SetDirty()

				arg_278_1.typewritterCharCountI18N = 0

				SetActive(arg_278_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_278_1:ShowNextGo(false)
			end

			local var_281_12 = 3

			if 3 < arg_278_1.time_ and arg_278_1.time_ <= var_281_12 + arg_281_0 then
				arg_278_1.var_.oldValueTypewriter = arg_278_1.fswtw_.percent

				SetActive(arg_278_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_278_1:ShowNextGo(false)
			end

			local var_281_13 = 30
			local var_281_14 = 2
			local var_281_15, var_281_16 = arg_278_1:GetPercentByPara(arg_278_1:FormatText(arg_278_1:GetWordFromCfg(417191067).content), 1)

			if var_281_12 < arg_278_1.time_ and arg_278_1.time_ <= var_281_12 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				local var_281_17 = var_281_13 <= 0 and var_281_14 or var_281_14 * ((var_281_16 - arg_278_1.typewritterCharCountI18N) / var_281_13)

				if (var_281_13 <= 0 and var_281_14 or var_281_14 * ((var_281_16 - arg_278_1.typewritterCharCountI18N) / var_281_13)) > 0 and var_281_14 < var_281_17 then
					arg_278_1.talkMaxDuration = var_281_17

					if var_281_17 + var_281_12 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_17 + var_281_12
					end
				end
			end

			local var_281_18 = math.max(2, arg_278_1.talkMaxDuration)

			if var_281_12 <= arg_278_1.time_ and arg_278_1.time_ < var_281_12 + var_281_18 then
				arg_278_1.fswtw_.percent = Mathf.Lerp(arg_278_1.var_.oldValueTypewriter, var_281_15, (arg_278_1.time_ - var_281_12) / var_281_18)
				arg_278_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_278_1.fswtw_:SetDirty()
			end

			if arg_278_1.time_ >= var_281_12 + var_281_18 and arg_278_1.time_ < var_281_12 + var_281_18 + arg_281_0 then
				arg_278_1.fswtw_.percent = var_281_15

				arg_278_1.fswtw_:SetDirty()
				arg_278_1:ShowNextGo(true)

				arg_278_1.typewritterCharCountI18N = var_281_16
			end

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				local var_281_19 = arg_278_1.fswbg_.transform:Find("textbox/adapt/content") or arg_278_1.fswbg_.transform:Find("textbox/content")
				local var_281_20 = arg_278_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_281_21 = var_281_19:GetComponent("RectTransform")

				var_281_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_281_21.offsetMin = Vector2.New(0, 0)
				var_281_21.offsetMax = Vector2.New(0, 0)
			end

			if 1.53333333333333 < arg_278_1.time_ and arg_278_1.time_ <= 1.53333333333333 + arg_281_0 then
				arg_278_1.cswbg_:SetActive(true)

				local var_281_22 = arg_278_1.cswt_:GetComponent("RectTransform")

				arg_278_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_281_22.offsetMin = Vector2.New(0, 0)
				var_281_22.offsetMax = Vector2.New(0, 0)
				arg_278_1.cswt_.text = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(419108).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.cswt_)

				arg_278_1.cswt_.fontSize = 120
				arg_278_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_278_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_278_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_281_23 = 2.1
			local var_281_24 = manager.audio:GetVoiceLength("story_v_out_417191", "417191067", "") / 1000

			if var_281_24 > 0 and 7.833 < var_281_24 and var_281_24 + var_281_23 > arg_278_1.duration_ then
				arg_278_1.duration_ = var_281_24 + var_281_23
			end

			if var_281_23 < arg_278_1.time_ and arg_278_1.time_ <= var_281_23 + arg_281_0 then
				arg_278_1:AudioAction("play", "voice", "story_v_out_417191", "417191067", "")
			end

			local var_281_26 = 1.2

			if 1.2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_26 + arg_281_0 then
				arg_278_1.allBtn_.enabled = false
			end

			if arg_278_1.time_ >= var_281_26 + 3.8 and arg_278_1.time_ < var_281_26 + 3.8 + arg_281_0 then
				arg_278_1.allBtn_.enabled = true
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play417191068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 417191068
		arg_282_1.duration_ = 10.37

		local var_282_0 = {
			zh = 10.366,
			ja = 10.266
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play417191069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = false

				arg_282_1:SetGaussion(false)
			end

			local var_285_0 = 1.2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 then
				local var_285_1 = Color.New(0, 0, 0)

				var_285_1.a = Mathf.Lerp(0, 1, (arg_282_1.time_ - 0) / var_285_0)
				arg_282_1.mask_.color = var_285_1
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 then
				local var_285_2 = Color.New(0, 0, 0)

				var_285_2.a = 1
				arg_282_1.mask_.color = var_285_2
			end

			local var_285_3 = 1.2

			if 1.2 < arg_282_1.time_ and arg_282_1.time_ <= var_285_3 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = false

				arg_282_1:SetGaussion(false)
			end

			local var_285_4 = 1.2

			if var_285_3 <= arg_282_1.time_ and arg_282_1.time_ < var_285_3 + var_285_4 then
				local var_285_5 = Color.New(0, 0, 0)

				var_285_5.a = Mathf.Lerp(1, 0, (arg_282_1.time_ - var_285_3) / var_285_4)
				arg_282_1.mask_.color = var_285_5
			end

			if arg_282_1.time_ >= var_285_3 + var_285_4 and arg_282_1.time_ < var_285_3 + var_285_4 + arg_285_0 then
				local var_285_6 = Color.New(0, 0, 0)

				arg_282_1.mask_.enabled = false
				var_285_6.a = 0
				arg_282_1.mask_.color = var_285_6
			end

			if 1.2 < arg_282_1.time_ and arg_282_1.time_ <= 1.2 + arg_285_0 then
				local var_285_7 = arg_282_1.bgs_.SS1707

				arg_282_1.bgs_.SS1707.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_285_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_285_8 = var_285_7:GetComponent("SpriteRenderer")

				if var_285_8 and var_285_8.sprite then
					local var_285_9 = 2 * (var_285_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_285_7.transform.localScale = Vector3.New(var_285_9 / var_285_8.sprite.bounds.size.y < var_285_9 * manager.ui.mainCameraCom_.aspect / var_285_8.sprite.bounds.size.x and var_285_9 * manager.ui.mainCameraCom_.aspect / var_285_8.sprite.bounds.size.x or var_285_9 / var_285_8.sprite.bounds.size.y, var_285_9 / var_285_8.sprite.bounds.size.y < var_285_9 * manager.ui.mainCameraCom_.aspect / var_285_8.sprite.bounds.size.x and var_285_9 * manager.ui.mainCameraCom_.aspect / var_285_8.sprite.bounds.size.x or var_285_9 / var_285_8.sprite.bounds.size.y, 0)
				end

				for iter_285_0, iter_285_1 in pairs(arg_282_1.bgs_) do
					if iter_285_0 ~= "SS1707" then
						iter_285_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.1 < arg_282_1.time_ and arg_282_1.time_ <= 1.1 + arg_285_0 then
				arg_282_1.fswbg_:SetActive(false)
				arg_282_1.dialog_:SetActive(false)
				SetActive(arg_282_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_282_1:ShowNextGo(false)
			end

			if 1.1 < arg_282_1.time_ and arg_282_1.time_ <= 1.1 + arg_285_0 then
				arg_282_1.cswbg_:SetActive(false)
			end

			if arg_282_1.frameCnt_ <= 1 then
				arg_282_1.dialog_:SetActive(false)
			end

			local var_285_10 = 2.4
			local var_285_11 = 0.725

			if 2.4 < arg_282_1.time_ and arg_282_1.time_ <= var_285_10 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0

				arg_282_1.dialog_:SetActive(true)

				arg_282_1.dialogCg_.alpha = 0

				local var_285_12 = LeanTween.value(arg_282_1.dialog_, 0, 1, 0.3)

				var_285_12:setOnUpdate(LuaHelper.FloatAction(function(arg_286_0)
					arg_282_1.dialogCg_.alpha = arg_286_0
				end))
				var_285_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_282_1.dialog_)
					var_285_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_282_1.duration_ = arg_282_1.duration_ + 0.3

				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_13 = arg_282_1:GetWordFromCfg(417191068)
				local var_285_14 = arg_282_1:FormatText(var_285_13.content)

				arg_282_1.text_.text = var_285_14

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_16 = 29 <= 0 and var_285_11 or var_285_11 * (utf8.len(var_285_14) / 29)

				if (29 <= 0 and var_285_11 or var_285_11 * (utf8.len(var_285_14) / 29)) > 0 and var_285_11 < var_285_16 then
					arg_282_1.talkMaxDuration = var_285_16
					var_285_10 = var_285_10 + 0.3

					if var_285_16 + var_285_10 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_16 + var_285_10
					end
				end

				arg_282_1.text_.text = var_285_14
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191068", "story_v_out_417191.awb") ~= 0 then
					local var_285_17 = manager.audio:GetVoiceLength("story_v_out_417191", "417191068", "story_v_out_417191.awb") / 1000

					if var_285_17 + var_285_10 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_17 + var_285_10
					end

					if var_285_13.prefab_name ~= "" and arg_282_1.actors_[var_285_13.prefab_name] ~= nil then
						local var_285_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_13.prefab_name].transform, "story_v_out_417191", "417191068", "story_v_out_417191.awb")

						arg_282_1:RecordAudio("417191068", var_285_18)
						arg_282_1:RecordAudio("417191068", var_285_18)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_417191", "417191068", "story_v_out_417191.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_417191", "417191068", "story_v_out_417191.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_19 = var_285_10 + 0.3
			local var_285_20 = math.max(var_285_11, arg_282_1.talkMaxDuration)

			if var_285_10 + 0.3 <= arg_282_1.time_ and arg_282_1.time_ < var_285_19 + var_285_20 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_19) / var_285_20

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_19 + var_285_20 and arg_282_1.time_ < var_285_19 + var_285_20 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play417191069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 417191069
		arg_288_1.duration_ = 15.77

		local var_288_0 = {
			zh = 11.9,
			ja = 15.766
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play417191070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 1.15

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_1 = arg_288_1:GetWordFromCfg(417191069)
				local var_291_2 = arg_288_1:FormatText(var_291_1.content)

				arg_288_1.text_.text = var_291_2

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_4 = 46 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 46)

				if (46 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 46)) > 0 and var_291_0 < var_291_4 then
					arg_288_1.talkMaxDuration = var_291_4

					if var_291_4 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_4 + 0
					end
				end

				arg_288_1.text_.text = var_291_2
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191069", "story_v_out_417191.awb") ~= 0 then
					local var_291_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191069", "story_v_out_417191.awb") / 1000

					if var_291_5 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + 0
					end

					if var_291_1.prefab_name ~= "" and arg_288_1.actors_[var_291_1.prefab_name] ~= nil then
						local var_291_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_1.prefab_name].transform, "story_v_out_417191", "417191069", "story_v_out_417191.awb")

						arg_288_1:RecordAudio("417191069", var_291_6)
						arg_288_1:RecordAudio("417191069", var_291_6)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_417191", "417191069", "story_v_out_417191.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_417191", "417191069", "story_v_out_417191.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_7 and arg_288_1.time_ < 0 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play417191070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 417191070
		arg_292_1.duration_ = 3.7

		local var_292_0 = {
			zh = 3.2,
			ja = 3.7
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play417191071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0.2

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_1 = arg_292_1:GetWordFromCfg(417191070)
				local var_295_2 = arg_292_1:FormatText(var_295_1.content)

				arg_292_1.text_.text = var_295_2

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_4 = 8 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 8)

				if (8 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 8)) > 0 and var_295_0 < var_295_4 then
					arg_292_1.talkMaxDuration = var_295_4

					if var_295_4 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_4 + 0
					end
				end

				arg_292_1.text_.text = var_295_2
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191070", "story_v_out_417191.awb") ~= 0 then
					local var_295_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191070", "story_v_out_417191.awb") / 1000

					if var_295_5 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + 0
					end

					if var_295_1.prefab_name ~= "" and arg_292_1.actors_[var_295_1.prefab_name] ~= nil then
						local var_295_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_1.prefab_name].transform, "story_v_out_417191", "417191070", "story_v_out_417191.awb")

						arg_292_1:RecordAudio("417191070", var_295_6)
						arg_292_1:RecordAudio("417191070", var_295_6)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_417191", "417191070", "story_v_out_417191.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_417191", "417191070", "story_v_out_417191.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_7 and arg_292_1.time_ < 0 + var_295_7 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play417191071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 417191071
		arg_296_1.duration_ = 16.37

		local var_296_0 = {
			zh = 9.366,
			ja = 16.366
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play417191072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0.8

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_1 = arg_296_1:GetWordFromCfg(417191071)
				local var_299_2 = arg_296_1:FormatText(var_299_1.content)

				arg_296_1.text_.text = var_299_2

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_4 = 32 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 32)

				if (32 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 32)) > 0 and var_299_0 < var_299_4 then
					arg_296_1.talkMaxDuration = var_299_4

					if var_299_4 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_4 + 0
					end
				end

				arg_296_1.text_.text = var_299_2
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191071", "story_v_out_417191.awb") ~= 0 then
					local var_299_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191071", "story_v_out_417191.awb") / 1000

					if var_299_5 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + 0
					end

					if var_299_1.prefab_name ~= "" and arg_296_1.actors_[var_299_1.prefab_name] ~= nil then
						local var_299_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_1.prefab_name].transform, "story_v_out_417191", "417191071", "story_v_out_417191.awb")

						arg_296_1:RecordAudio("417191071", var_299_6)
						arg_296_1:RecordAudio("417191071", var_299_6)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_417191", "417191071", "story_v_out_417191.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_417191", "417191071", "story_v_out_417191.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_7 = math.max(var_299_0, arg_296_1.talkMaxDuration)

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_7 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - 0) / var_299_7

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= 0 + var_299_7 and arg_296_1.time_ < 0 + var_299_7 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play417191072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 417191072
		arg_300_1.duration_ = 5.77

		local var_300_0 = {
			zh = 4.4,
			ja = 5.766
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play417191073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.45

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_1 = arg_300_1:GetWordFromCfg(417191072)
				local var_303_2 = arg_300_1:FormatText(var_303_1.content)

				arg_300_1.text_.text = var_303_2

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 18 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 18)

				if (18 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 18)) > 0 and var_303_0 < var_303_4 then
					arg_300_1.talkMaxDuration = var_303_4

					if var_303_4 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_4 + 0
					end
				end

				arg_300_1.text_.text = var_303_2
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191072", "story_v_out_417191.awb") ~= 0 then
					local var_303_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191072", "story_v_out_417191.awb") / 1000

					if var_303_5 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + 0
					end

					if var_303_1.prefab_name ~= "" and arg_300_1.actors_[var_303_1.prefab_name] ~= nil then
						local var_303_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_1.prefab_name].transform, "story_v_out_417191", "417191072", "story_v_out_417191.awb")

						arg_300_1:RecordAudio("417191072", var_303_6)
						arg_300_1:RecordAudio("417191072", var_303_6)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_417191", "417191072", "story_v_out_417191.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_417191", "417191072", "story_v_out_417191.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_7 and arg_300_1.time_ < 0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play417191073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 417191073
		arg_304_1.duration_ = 1.83

		local var_304_0 = {
			zh = 0.999999999999,
			ja = 1.833
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play417191074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0.166666666666667

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_1 = arg_304_1:GetWordFromCfg(417191073)
				local var_307_2 = arg_304_1:FormatText(var_307_1.content)

				arg_304_1.text_.text = var_307_2

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 2 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 2)

				if (2 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 2)) > 0 and var_307_0 < var_307_4 then
					arg_304_1.talkMaxDuration = var_307_4

					if var_307_4 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_4 + 0
					end
				end

				arg_304_1.text_.text = var_307_2
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191073", "story_v_out_417191.awb") ~= 0 then
					local var_307_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191073", "story_v_out_417191.awb") / 1000

					if var_307_5 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + 0
					end

					if var_307_1.prefab_name ~= "" and arg_304_1.actors_[var_307_1.prefab_name] ~= nil then
						local var_307_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_1.prefab_name].transform, "story_v_out_417191", "417191073", "story_v_out_417191.awb")

						arg_304_1:RecordAudio("417191073", var_307_6)
						arg_304_1:RecordAudio("417191073", var_307_6)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_417191", "417191073", "story_v_out_417191.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_417191", "417191073", "story_v_out_417191.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_7 and arg_304_1.time_ < 0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play417191074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 417191074
		arg_308_1.duration_ = 14.77

		local var_308_0 = {
			zh = 12.6,
			ja = 14.766
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play417191075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 1.075

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_1 = arg_308_1:GetWordFromCfg(417191074)
				local var_311_2 = arg_308_1:FormatText(var_311_1.content)

				arg_308_1.text_.text = var_311_2

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 43 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_2) / 43)

				if (43 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_2) / 43)) > 0 and var_311_0 < var_311_4 then
					arg_308_1.talkMaxDuration = var_311_4

					if var_311_4 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_4 + 0
					end
				end

				arg_308_1.text_.text = var_311_2
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191074", "story_v_out_417191.awb") ~= 0 then
					local var_311_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191074", "story_v_out_417191.awb") / 1000

					if var_311_5 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_5 + 0
					end

					if var_311_1.prefab_name ~= "" and arg_308_1.actors_[var_311_1.prefab_name] ~= nil then
						local var_311_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_1.prefab_name].transform, "story_v_out_417191", "417191074", "story_v_out_417191.awb")

						arg_308_1:RecordAudio("417191074", var_311_6)
						arg_308_1:RecordAudio("417191074", var_311_6)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_417191", "417191074", "story_v_out_417191.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_417191", "417191074", "story_v_out_417191.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_7 and arg_308_1.time_ < 0 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play417191075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 417191075
		arg_312_1.duration_ = 9.1

		local var_312_0 = {
			zh = 5.366,
			ja = 9.1
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play417191076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0.5

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_1 = arg_312_1:GetWordFromCfg(417191075)
				local var_315_2 = arg_312_1:FormatText(var_315_1.content)

				arg_312_1.text_.text = var_315_2

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 20 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 20)

				if (20 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 20)) > 0 and var_315_0 < var_315_4 then
					arg_312_1.talkMaxDuration = var_315_4

					if var_315_4 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_4 + 0
					end
				end

				arg_312_1.text_.text = var_315_2
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191075", "story_v_out_417191.awb") ~= 0 then
					local var_315_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191075", "story_v_out_417191.awb") / 1000

					if var_315_5 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_5 + 0
					end

					if var_315_1.prefab_name ~= "" and arg_312_1.actors_[var_315_1.prefab_name] ~= nil then
						local var_315_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_1.prefab_name].transform, "story_v_out_417191", "417191075", "story_v_out_417191.awb")

						arg_312_1:RecordAudio("417191075", var_315_6)
						arg_312_1:RecordAudio("417191075", var_315_6)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_417191", "417191075", "story_v_out_417191.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_417191", "417191075", "story_v_out_417191.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_0, arg_312_1.talkMaxDuration)

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - 0) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= 0 + var_315_7 and arg_312_1.time_ < 0 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play417191076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 417191076
		arg_316_1.duration_ = 12.53

		local var_316_0 = {
			zh = 10.433,
			ja = 12.533
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play417191077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 1.1

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_1 = arg_316_1:GetWordFromCfg(417191076)
				local var_319_2 = arg_316_1:FormatText(var_319_1.content)

				arg_316_1.text_.text = var_319_2

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 44 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 44)

				if (44 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 44)) > 0 and var_319_0 < var_319_4 then
					arg_316_1.talkMaxDuration = var_319_4

					if var_319_4 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_4 + 0
					end
				end

				arg_316_1.text_.text = var_319_2
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191076", "story_v_out_417191.awb") ~= 0 then
					local var_319_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191076", "story_v_out_417191.awb") / 1000

					if var_319_5 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + 0
					end

					if var_319_1.prefab_name ~= "" and arg_316_1.actors_[var_319_1.prefab_name] ~= nil then
						local var_319_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_1.prefab_name].transform, "story_v_out_417191", "417191076", "story_v_out_417191.awb")

						arg_316_1:RecordAudio("417191076", var_319_6)
						arg_316_1:RecordAudio("417191076", var_319_6)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_417191", "417191076", "story_v_out_417191.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_417191", "417191076", "story_v_out_417191.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play417191077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 417191077
		arg_320_1.duration_ = 15.4

		local var_320_0 = {
			zh = 12.233,
			ja = 15.4
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play417191078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.95

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_1 = arg_320_1:GetWordFromCfg(417191077)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 38 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 38)

				if (38 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 38)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191077", "story_v_out_417191.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191077", "story_v_out_417191.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_out_417191", "417191077", "story_v_out_417191.awb")

						arg_320_1:RecordAudio("417191077", var_323_6)
						arg_320_1:RecordAudio("417191077", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_417191", "417191077", "story_v_out_417191.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_417191", "417191077", "story_v_out_417191.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play417191078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 417191078
		arg_324_1.duration_ = 3.77

		local var_324_0 = {
			zh = 2.333,
			ja = 3.766
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play417191079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0.35

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_1 = arg_324_1:GetWordFromCfg(417191078)
				local var_327_2 = arg_324_1:FormatText(var_327_1.content)

				arg_324_1.text_.text = var_327_2

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 14 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 14)

				if (14 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 14)) > 0 and var_327_0 < var_327_4 then
					arg_324_1.talkMaxDuration = var_327_4

					if var_327_4 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_4 + 0
					end
				end

				arg_324_1.text_.text = var_327_2
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191078", "story_v_out_417191.awb") ~= 0 then
					local var_327_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191078", "story_v_out_417191.awb") / 1000

					if var_327_5 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_5 + 0
					end

					if var_327_1.prefab_name ~= "" and arg_324_1.actors_[var_327_1.prefab_name] ~= nil then
						local var_327_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_1.prefab_name].transform, "story_v_out_417191", "417191078", "story_v_out_417191.awb")

						arg_324_1:RecordAudio("417191078", var_327_6)
						arg_324_1:RecordAudio("417191078", var_327_6)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_417191", "417191078", "story_v_out_417191.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_417191", "417191078", "story_v_out_417191.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_7 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_7 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_7

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_7 and arg_324_1.time_ < 0 + var_327_7 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play417191079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 417191079
		arg_328_1.duration_ = 4.17

		local var_328_0 = {
			zh = 2.3,
			ja = 4.166
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play417191080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0.2

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_1 = arg_328_1:GetWordFromCfg(417191079)
				local var_331_2 = arg_328_1:FormatText(var_331_1.content)

				arg_328_1.text_.text = var_331_2

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_4 = 8 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 8)

				if (8 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 8)) > 0 and var_331_0 < var_331_4 then
					arg_328_1.talkMaxDuration = var_331_4

					if var_331_4 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_4 + 0
					end
				end

				arg_328_1.text_.text = var_331_2
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191079", "story_v_out_417191.awb") ~= 0 then
					local var_331_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191079", "story_v_out_417191.awb") / 1000

					if var_331_5 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_5 + 0
					end

					if var_331_1.prefab_name ~= "" and arg_328_1.actors_[var_331_1.prefab_name] ~= nil then
						local var_331_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_1.prefab_name].transform, "story_v_out_417191", "417191079", "story_v_out_417191.awb")

						arg_328_1:RecordAudio("417191079", var_331_6)
						arg_328_1:RecordAudio("417191079", var_331_6)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_417191", "417191079", "story_v_out_417191.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_417191", "417191079", "story_v_out_417191.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_7 = math.max(var_331_0, arg_328_1.talkMaxDuration)

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_7 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - 0) / var_331_7

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= 0 + var_331_7 and arg_328_1.time_ < 0 + var_331_7 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play417191080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 417191080
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play417191081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0.725

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_1 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(417191080).content)

				arg_332_1.text_.text = var_335_1

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_3 = 29 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_1) / 29)

				if (29 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_1) / 29)) > 0 and var_335_0 < var_335_3 then
					arg_332_1.talkMaxDuration = var_335_3

					if var_335_3 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_3 + 0
					end
				end

				arg_332_1.text_.text = var_335_1
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_4 = math.max(var_335_0, arg_332_1.talkMaxDuration)

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_4 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - 0) / var_335_4

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= 0 + var_335_4 and arg_332_1.time_ < 0 + var_335_4 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play417191081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 417191081
		arg_336_1.duration_ = 10.7

		local var_336_0 = {
			zh = 7.4,
			ja = 10.7
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play417191082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0.65

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_1 = arg_336_1:GetWordFromCfg(417191081)
				local var_339_2 = arg_336_1:FormatText(var_339_1.content)

				arg_336_1.text_.text = var_339_2

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_4 = 26 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 26)

				if (26 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 26)) > 0 and var_339_0 < var_339_4 then
					arg_336_1.talkMaxDuration = var_339_4

					if var_339_4 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_4 + 0
					end
				end

				arg_336_1.text_.text = var_339_2
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191081", "story_v_out_417191.awb") ~= 0 then
					local var_339_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191081", "story_v_out_417191.awb") / 1000

					if var_339_5 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + 0
					end

					if var_339_1.prefab_name ~= "" and arg_336_1.actors_[var_339_1.prefab_name] ~= nil then
						local var_339_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_1.prefab_name].transform, "story_v_out_417191", "417191081", "story_v_out_417191.awb")

						arg_336_1:RecordAudio("417191081", var_339_6)
						arg_336_1:RecordAudio("417191081", var_339_6)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_417191", "417191081", "story_v_out_417191.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_417191", "417191081", "story_v_out_417191.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_7 = math.max(var_339_0, arg_336_1.talkMaxDuration)

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_7 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - 0) / var_339_7

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= 0 + var_339_7 and arg_336_1.time_ < 0 + var_339_7 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play417191082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 417191082
		arg_340_1.duration_ = 10.9

		local var_340_0 = {
			zh = 10.9,
			ja = 10.333
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play417191083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 1.05

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_1 = arg_340_1:GetWordFromCfg(417191082)
				local var_343_2 = arg_340_1:FormatText(var_343_1.content)

				arg_340_1.text_.text = var_343_2

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 42 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 42)

				if (42 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 42)) > 0 and var_343_0 < var_343_4 then
					arg_340_1.talkMaxDuration = var_343_4

					if var_343_4 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_4 + 0
					end
				end

				arg_340_1.text_.text = var_343_2
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191082", "story_v_out_417191.awb") ~= 0 then
					local var_343_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191082", "story_v_out_417191.awb") / 1000

					if var_343_5 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_5 + 0
					end

					if var_343_1.prefab_name ~= "" and arg_340_1.actors_[var_343_1.prefab_name] ~= nil then
						local var_343_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_1.prefab_name].transform, "story_v_out_417191", "417191082", "story_v_out_417191.awb")

						arg_340_1:RecordAudio("417191082", var_343_6)
						arg_340_1:RecordAudio("417191082", var_343_6)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_417191", "417191082", "story_v_out_417191.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_417191", "417191082", "story_v_out_417191.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_7 = math.max(var_343_0, arg_340_1.talkMaxDuration)

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_7 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - 0) / var_343_7

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= 0 + var_343_7 and arg_340_1.time_ < 0 + var_343_7 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play417191083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 417191083
		arg_344_1.duration_ = 9

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play417191084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 1.999999999999 < arg_344_1.time_ and arg_344_1.time_ <= 1.999999999999 + arg_347_0 then
				local var_347_0 = arg_344_1.bgs_.ST21

				arg_344_1.bgs_.ST21.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_347_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_347_1 = var_347_0:GetComponent("SpriteRenderer")

				if var_347_1 and var_347_1.sprite then
					local var_347_2 = 2 * (var_347_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_347_0.transform.localScale = Vector3.New(var_347_2 / var_347_1.sprite.bounds.size.y < var_347_2 * manager.ui.mainCameraCom_.aspect / var_347_1.sprite.bounds.size.x and var_347_2 * manager.ui.mainCameraCom_.aspect / var_347_1.sprite.bounds.size.x or var_347_2 / var_347_1.sprite.bounds.size.y, var_347_2 / var_347_1.sprite.bounds.size.y < var_347_2 * manager.ui.mainCameraCom_.aspect / var_347_1.sprite.bounds.size.x and var_347_2 * manager.ui.mainCameraCom_.aspect / var_347_1.sprite.bounds.size.x or var_347_2 / var_347_1.sprite.bounds.size.y, 0)
				end

				for iter_347_0, iter_347_1 in pairs(arg_344_1.bgs_) do
					if iter_347_0 ~= "ST21" then
						iter_347_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_347_3 = 3.999999999999

			if 3.999999999999 < arg_344_1.time_ and arg_344_1.time_ <= var_347_3 + arg_347_0 then
				arg_344_1.allBtn_.enabled = false
			end

			if arg_344_1.time_ >= var_347_3 + 0.6 and arg_344_1.time_ < var_347_3 + 0.6 + arg_347_0 then
				arg_344_1.allBtn_.enabled = true
			end

			local var_347_4 = 0

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_4 + arg_347_0 then
				arg_344_1.mask_.enabled = true
				arg_344_1.mask_.raycastTarget = true

				arg_344_1:SetGaussion(false)
			end

			local var_347_5 = 2

			if var_347_4 <= arg_344_1.time_ and arg_344_1.time_ < var_347_4 + var_347_5 then
				local var_347_6 = Color.New(0, 0, 0)

				var_347_6.a = Mathf.Lerp(0, 1, (arg_344_1.time_ - var_347_4) / var_347_5)
				arg_344_1.mask_.color = var_347_6
			end

			if arg_344_1.time_ >= var_347_4 + var_347_5 and arg_344_1.time_ < var_347_4 + var_347_5 + arg_347_0 then
				local var_347_7 = Color.New(0, 0, 0)

				var_347_7.a = 1
				arg_344_1.mask_.color = var_347_7
			end

			local var_347_8 = 2

			if 2 < arg_344_1.time_ and arg_344_1.time_ <= var_347_8 + arg_347_0 then
				arg_344_1.mask_.enabled = true
				arg_344_1.mask_.raycastTarget = true

				arg_344_1:SetGaussion(false)
			end

			local var_347_9 = 2

			if var_347_8 <= arg_344_1.time_ and arg_344_1.time_ < var_347_8 + var_347_9 then
				local var_347_10 = Color.New(0, 0, 0)

				var_347_10.a = Mathf.Lerp(1, 0, (arg_344_1.time_ - var_347_8) / var_347_9)
				arg_344_1.mask_.color = var_347_10
			end

			if arg_344_1.time_ >= var_347_8 + var_347_9 and arg_344_1.time_ < var_347_8 + var_347_9 + arg_347_0 then
				local var_347_11 = Color.New(0, 0, 0)

				arg_344_1.mask_.enabled = false
				var_347_11.a = 0
				arg_344_1.mask_.color = var_347_11
			end

			if 3.8 < arg_344_1.time_ and arg_344_1.time_ <= 3.8 + arg_347_0 then
				arg_344_1:AudioAction("play", "effect", "se_story_side_1042", "se_story_1042_doorbell", "")
			end

			if 4.599999999999 < arg_344_1.time_ and arg_344_1.time_ <= 4.599999999999 + arg_347_0 then
				arg_344_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_gun01", "")
			end

			if arg_344_1.frameCnt_ <= 1 then
				arg_344_1.dialog_:SetActive(false)
			end

			local var_347_14 = 3.999999999999
			local var_347_15 = 1

			if 3.999999999999 < arg_344_1.time_ and arg_344_1.time_ <= var_347_14 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0

				arg_344_1.dialog_:SetActive(true)

				arg_344_1.dialogCg_.alpha = 0

				local var_347_16 = LeanTween.value(arg_344_1.dialog_, 0, 1, 0.3)

				var_347_16:setOnUpdate(LuaHelper.FloatAction(function(arg_348_0)
					arg_344_1.dialogCg_.alpha = arg_348_0
				end))
				var_347_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_344_1.dialog_)
					var_347_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_344_1.duration_ = arg_344_1.duration_ + 0.3

				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_17 = arg_344_1:FormatText(arg_344_1:GetWordFromCfg(417191083).content)

				arg_344_1.text_.text = var_347_17

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_19 = 40 <= 0 and var_347_15 or var_347_15 * (utf8.len(var_347_17) / 40)

				if (40 <= 0 and var_347_15 or var_347_15 * (utf8.len(var_347_17) / 40)) > 0 and var_347_15 < var_347_19 then
					arg_344_1.talkMaxDuration = var_347_19
					var_347_14 = var_347_14 + 0.3

					if var_347_19 + var_347_14 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_19 + var_347_14
					end
				end

				arg_344_1.text_.text = var_347_17
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_20 = var_347_14 + 0.3
			local var_347_21 = math.max(var_347_15, arg_344_1.talkMaxDuration)

			if var_347_14 + 0.3 <= arg_344_1.time_ and arg_344_1.time_ < var_347_20 + var_347_21 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_20) / var_347_21

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_20 + var_347_21 and arg_344_1.time_ < var_347_20 + var_347_21 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play417191084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 417191084
		arg_350_1.duration_ = 1.37

		local var_350_0 = {
			zh = 0.999999999999,
			ja = 1.366
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play417191085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos10128 = arg_350_1.actors_["10128"].transform.localPosition
				arg_350_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("10128", 3)

				for iter_353_0 = 0, arg_350_1.actors_["10128"].transform.childCount - 1 do
					local var_353_0 = arg_350_1.actors_["10128"].transform:GetChild(iter_353_0)

					if var_353_0.name == "split_6" or not string.find(var_353_0.name, "split") then
						var_353_0.gameObject:SetActive(true)
					else
						var_353_0.gameObject:SetActive(false)
					end
				end
			end

			local var_353_1 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_1 then
				arg_350_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_350_1.time_ - 0) / var_353_1)
			end

			if arg_350_1.time_ >= 0 + var_353_1 and arg_350_1.time_ < 0 + var_353_1 + arg_353_0 then
				arg_350_1.actors_["10128"].transform.localPosition = Vector3.New(0, -347, -300)
			end

			local var_353_2 = arg_350_1.actors_["10128"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.actorSpriteComps10128 == nil then
				arg_350_1.var_.actorSpriteComps10128 = var_353_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_3 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_3 and not isNil(var_353_2) then
				if arg_350_1.var_.actorSpriteComps10128 then
					for iter_353_1, iter_353_2 in pairs(arg_350_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_353_2 then
							if arg_350_1.isInRecall_ then
								iter_353_2.color = Color.New(Mathf.Lerp(iter_353_2.color.r, arg_350_1.hightColor1.r, (arg_350_1.time_ - 0) / var_353_3), Mathf.Lerp(iter_353_2.color.g, arg_350_1.hightColor1.g, (arg_350_1.time_ - 0) / var_353_3), (Mathf.Lerp(iter_353_2.color.b, arg_350_1.hightColor1.b, (arg_350_1.time_ - 0) / var_353_3)))
							else
								local var_353_4 = Mathf.Lerp(iter_353_2.color.r, 1, (arg_350_1.time_ - 0) / var_353_3)

								iter_353_2.color = Color.New(var_353_4, var_353_4, var_353_4)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_3 and arg_350_1.time_ < 0 + var_353_3 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.actorSpriteComps10128 then
				for iter_353_3, iter_353_4 in pairs(arg_350_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_353_4 then
						iter_353_4.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_350_1.var_.actorSpriteComps10128 = nil
			end

			local var_353_5 = 0
			local var_353_6 = 0.05

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_5 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_7 = arg_350_1:GetWordFromCfg(417191084)
				local var_353_8 = arg_350_1:FormatText(var_353_7.content)

				arg_350_1.text_.text = var_353_8

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_10 = 2 <= 0 and var_353_6 or var_353_6 * (utf8.len(var_353_8) / 2)

				if (2 <= 0 and var_353_6 or var_353_6 * (utf8.len(var_353_8) / 2)) > 0 and var_353_6 < var_353_10 then
					arg_350_1.talkMaxDuration = var_353_10

					if var_353_10 + var_353_5 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_10 + var_353_5
					end
				end

				arg_350_1.text_.text = var_353_8
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191084", "story_v_out_417191.awb") ~= 0 then
					local var_353_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191084", "story_v_out_417191.awb") / 1000

					if var_353_11 + var_353_5 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_11 + var_353_5
					end

					if var_353_7.prefab_name ~= "" and arg_350_1.actors_[var_353_7.prefab_name] ~= nil then
						local var_353_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_7.prefab_name].transform, "story_v_out_417191", "417191084", "story_v_out_417191.awb")

						arg_350_1:RecordAudio("417191084", var_353_12)
						arg_350_1:RecordAudio("417191084", var_353_12)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_417191", "417191084", "story_v_out_417191.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_417191", "417191084", "story_v_out_417191.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_13 = math.max(var_353_6, arg_350_1.talkMaxDuration)

			if var_353_5 <= arg_350_1.time_ and arg_350_1.time_ < var_353_5 + var_353_13 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_5) / var_353_13

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_5 + var_353_13 and arg_350_1.time_ < var_353_5 + var_353_13 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
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

		arg_350_1:InitPlayNodeList()
	end,
	Play417191085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 417191085
		arg_354_1.duration_ = 5.1

		local var_354_0 = {
			zh = 5.1,
			ja = 4.766
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play417191086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos10128 = arg_354_1.actors_["10128"].transform.localPosition
				arg_354_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("10128", 7)

				for iter_357_0 = 0, arg_354_1.actors_["10128"].transform.childCount - 1 do
					local var_357_0 = arg_354_1.actors_["10128"].transform:GetChild(iter_357_0)

					if var_357_0.name == "" or not string.find(var_357_0.name, "split") then
						var_357_0.gameObject:SetActive(true)
					else
						var_357_0.gameObject:SetActive(false)
					end
				end
			end

			local var_357_1 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_1 then
				arg_354_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_354_1.time_ - 0) / var_357_1)
			end

			if arg_354_1.time_ >= 0 + var_357_1 and arg_354_1.time_ < 0 + var_357_1 + arg_357_0 then
				arg_354_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_357_2 = arg_354_1.actors_["10110"].transform

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos10110 = var_357_2.localPosition
				var_357_2.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("10110", 3)

				for iter_357_1 = 0, var_357_2.childCount - 1 do
					local var_357_3 = var_357_2:GetChild(iter_357_1)

					if var_357_3.name == "" or not string.find(var_357_3.name, "split") then
						var_357_3.gameObject:SetActive(true)
					else
						var_357_3.gameObject:SetActive(false)
					end
				end
			end

			local var_357_4 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				var_357_2.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10110, Vector3.New(0, -402.7, -156.1), (arg_354_1.time_ - 0) / var_357_4)
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				var_357_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_357_5 = arg_354_1.actors_["10110"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_5) and arg_354_1.var_.actorSpriteComps10110 == nil then
				arg_354_1.var_.actorSpriteComps10110 = var_357_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_6 = 0.2

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_6 and not isNil(var_357_5) then
				if arg_354_1.var_.actorSpriteComps10110 then
					for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_357_3 then
							if arg_354_1.isInRecall_ then
								iter_357_3.color = Color.New(Mathf.Lerp(iter_357_3.color.r, arg_354_1.hightColor1.r, (arg_354_1.time_ - 0) / var_357_6), Mathf.Lerp(iter_357_3.color.g, arg_354_1.hightColor1.g, (arg_354_1.time_ - 0) / var_357_6), (Mathf.Lerp(iter_357_3.color.b, arg_354_1.hightColor1.b, (arg_354_1.time_ - 0) / var_357_6)))
							else
								local var_357_7 = Mathf.Lerp(iter_357_3.color.r, 1, (arg_354_1.time_ - 0) / var_357_6)

								iter_357_3.color = Color.New(var_357_7, var_357_7, var_357_7)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= 0 + var_357_6 and arg_354_1.time_ < 0 + var_357_6 + arg_357_0 and not isNil(var_357_5) and arg_354_1.var_.actorSpriteComps10110 then
				for iter_357_4, iter_357_5 in pairs(arg_354_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_357_5 then
						iter_357_5.color = arg_354_1.isInRecall_ and (arg_354_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_354_1.var_.actorSpriteComps10110 = nil
			end

			local var_357_8 = 0
			local var_357_9 = 0.5

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_8 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_10 = arg_354_1:GetWordFromCfg(417191085)
				local var_357_11 = arg_354_1:FormatText(var_357_10.content)

				arg_354_1.text_.text = var_357_11

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_13 = 20 <= 0 and var_357_9 or var_357_9 * (utf8.len(var_357_11) / 20)

				if (20 <= 0 and var_357_9 or var_357_9 * (utf8.len(var_357_11) / 20)) > 0 and var_357_9 < var_357_13 then
					arg_354_1.talkMaxDuration = var_357_13

					if var_357_13 + var_357_8 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_13 + var_357_8
					end
				end

				arg_354_1.text_.text = var_357_11
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191085", "story_v_out_417191.awb") ~= 0 then
					local var_357_14 = manager.audio:GetVoiceLength("story_v_out_417191", "417191085", "story_v_out_417191.awb") / 1000

					if var_357_14 + var_357_8 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_14 + var_357_8
					end

					if var_357_10.prefab_name ~= "" and arg_354_1.actors_[var_357_10.prefab_name] ~= nil then
						local var_357_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_10.prefab_name].transform, "story_v_out_417191", "417191085", "story_v_out_417191.awb")

						arg_354_1:RecordAudio("417191085", var_357_15)
						arg_354_1:RecordAudio("417191085", var_357_15)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_417191", "417191085", "story_v_out_417191.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_417191", "417191085", "story_v_out_417191.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_16 = math.max(var_357_9, arg_354_1.talkMaxDuration)

			if var_357_8 <= arg_354_1.time_ and arg_354_1.time_ < var_357_8 + var_357_16 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_8) / var_357_16

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_8 + var_357_16 and arg_354_1.time_ < var_357_8 + var_357_16 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
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
				actorName = "10110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play417191086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 417191086
		arg_358_1.duration_ = 2.37

		local var_358_0 = {
			zh = 2.066,
			ja = 2.366
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play417191087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["10110"]) and arg_358_1.var_.actorSpriteComps10110 == nil then
				arg_358_1.var_.actorSpriteComps10110 = arg_358_1.actors_["10110"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_0 = 0.2

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["10110"]) then
				if arg_358_1.var_.actorSpriteComps10110 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_361_1 then
							if arg_358_1.isInRecall_ then
								iter_361_1.color = Color.New(Mathf.Lerp(iter_361_1.color.r, arg_358_1.hightColor2.r, (arg_358_1.time_ - 0) / var_361_0), Mathf.Lerp(iter_361_1.color.g, arg_358_1.hightColor2.g, (arg_358_1.time_ - 0) / var_361_0), (Mathf.Lerp(iter_361_1.color.b, arg_358_1.hightColor2.b, (arg_358_1.time_ - 0) / var_361_0)))
							else
								local var_361_1 = Mathf.Lerp(iter_361_1.color.r, 0.5, (arg_358_1.time_ - 0) / var_361_0)

								iter_361_1.color = Color.New(var_361_1, var_361_1, var_361_1)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["10110"]) and arg_358_1.var_.actorSpriteComps10110 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_361_3 then
						iter_361_3.color = arg_358_1.isInRecall_ and (arg_358_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_358_1.var_.actorSpriteComps10110 = nil
			end

			local var_361_2 = arg_358_1.actors_["10128"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_2) and arg_358_1.var_.actorSpriteComps10128 == nil then
				arg_358_1.var_.actorSpriteComps10128 = var_361_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_3 = 0.2

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_3 and not isNil(var_361_2) then
				if arg_358_1.var_.actorSpriteComps10128 then
					for iter_361_4, iter_361_5 in pairs(arg_358_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_361_5 then
							if arg_358_1.isInRecall_ then
								iter_361_5.color = Color.New(Mathf.Lerp(iter_361_5.color.r, arg_358_1.hightColor1.r, (arg_358_1.time_ - 0) / var_361_3), Mathf.Lerp(iter_361_5.color.g, arg_358_1.hightColor1.g, (arg_358_1.time_ - 0) / var_361_3), (Mathf.Lerp(iter_361_5.color.b, arg_358_1.hightColor1.b, (arg_358_1.time_ - 0) / var_361_3)))
							else
								local var_361_4 = Mathf.Lerp(iter_361_5.color.r, 1, (arg_358_1.time_ - 0) / var_361_3)

								iter_361_5.color = Color.New(var_361_4, var_361_4, var_361_4)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= 0 + var_361_3 and arg_358_1.time_ < 0 + var_361_3 + arg_361_0 and not isNil(var_361_2) and arg_358_1.var_.actorSpriteComps10128 then
				for iter_361_6, iter_361_7 in pairs(arg_358_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_361_7 then
						iter_361_7.color = arg_358_1.isInRecall_ and (arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_358_1.var_.actorSpriteComps10128 = nil
			end

			local var_361_5 = arg_358_1.actors_["10128"].transform

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos10128 = var_361_5.localPosition
				var_361_5.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("10128", 4)

				for iter_361_8 = 0, var_361_5.childCount - 1 do
					local var_361_6 = var_361_5:GetChild(iter_361_8)

					if var_361_6.name == "" or not string.find(var_361_6.name, "split") then
						var_361_6.gameObject:SetActive(true)
					else
						var_361_6.gameObject:SetActive(false)
					end
				end
			end

			local var_361_7 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_7 then
				var_361_5.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_358_1.time_ - 0) / var_361_7)
			end

			if arg_358_1.time_ >= 0 + var_361_7 and arg_358_1.time_ < 0 + var_361_7 + arg_361_0 then
				var_361_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_361_8 = arg_358_1.actors_["10110"].transform

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos10110 = var_361_8.localPosition
				var_361_8.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("10110", 2)

				for iter_361_9 = 0, var_361_8.childCount - 1 do
					local var_361_9 = var_361_8:GetChild(iter_361_9)

					if var_361_9.name == "" or not string.find(var_361_9.name, "split") then
						var_361_9.gameObject:SetActive(true)
					else
						var_361_9.gameObject:SetActive(false)
					end
				end
			end

			local var_361_10 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_10 then
				var_361_8.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos10110, Vector3.New(-390, -402.7, -156.1), (arg_358_1.time_ - 0) / var_361_10)
			end

			if arg_358_1.time_ >= 0 + var_361_10 and arg_358_1.time_ < 0 + var_361_10 + arg_361_0 then
				var_361_8.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_361_11 = 0
			local var_361_12 = 0.275

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_11 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_13 = arg_358_1:GetWordFromCfg(417191086)
				local var_361_14 = arg_358_1:FormatText(var_361_13.content)

				arg_358_1.text_.text = var_361_14

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_16 = 11 <= 0 and var_361_12 or var_361_12 * (utf8.len(var_361_14) / 11)

				if (11 <= 0 and var_361_12 or var_361_12 * (utf8.len(var_361_14) / 11)) > 0 and var_361_12 < var_361_16 then
					arg_358_1.talkMaxDuration = var_361_16

					if var_361_16 + var_361_11 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_16 + var_361_11
					end
				end

				arg_358_1.text_.text = var_361_14
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191086", "story_v_out_417191.awb") ~= 0 then
					local var_361_17 = manager.audio:GetVoiceLength("story_v_out_417191", "417191086", "story_v_out_417191.awb") / 1000

					if var_361_17 + var_361_11 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_17 + var_361_11
					end

					if var_361_13.prefab_name ~= "" and arg_358_1.actors_[var_361_13.prefab_name] ~= nil then
						local var_361_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_13.prefab_name].transform, "story_v_out_417191", "417191086", "story_v_out_417191.awb")

						arg_358_1:RecordAudio("417191086", var_361_18)
						arg_358_1:RecordAudio("417191086", var_361_18)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_417191", "417191086", "story_v_out_417191.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_417191", "417191086", "story_v_out_417191.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_19 = math.max(var_361_12, arg_358_1.talkMaxDuration)

			if var_361_11 <= arg_358_1.time_ and arg_358_1.time_ < var_361_11 + var_361_19 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_11) / var_361_19

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_11 + var_361_19 and arg_358_1.time_ < var_361_11 + var_361_19 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
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
				actorName = "10110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play417191087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 417191087
		arg_362_1.duration_ = 3.67

		local var_362_0 = {
			zh = 3.466,
			ja = 3.666
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play417191088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["10110"]) and arg_362_1.var_.actorSpriteComps10110 == nil then
				arg_362_1.var_.actorSpriteComps10110 = arg_362_1.actors_["10110"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_0 = 0.2

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["10110"]) then
				if arg_362_1.var_.actorSpriteComps10110 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_365_1 then
							if arg_362_1.isInRecall_ then
								iter_365_1.color = Color.New(Mathf.Lerp(iter_365_1.color.r, arg_362_1.hightColor1.r, (arg_362_1.time_ - 0) / var_365_0), Mathf.Lerp(iter_365_1.color.g, arg_362_1.hightColor1.g, (arg_362_1.time_ - 0) / var_365_0), (Mathf.Lerp(iter_365_1.color.b, arg_362_1.hightColor1.b, (arg_362_1.time_ - 0) / var_365_0)))
							else
								local var_365_1 = Mathf.Lerp(iter_365_1.color.r, 1, (arg_362_1.time_ - 0) / var_365_0)

								iter_365_1.color = Color.New(var_365_1, var_365_1, var_365_1)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["10110"]) and arg_362_1.var_.actorSpriteComps10110 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_365_3 then
						iter_365_3.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_362_1.var_.actorSpriteComps10110 = nil
			end

			local var_365_2 = arg_362_1.actors_["10128"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_2) and arg_362_1.var_.actorSpriteComps10128 == nil then
				arg_362_1.var_.actorSpriteComps10128 = var_365_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_3 = 0.2

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_3 and not isNil(var_365_2) then
				if arg_362_1.var_.actorSpriteComps10128 then
					for iter_365_4, iter_365_5 in pairs(arg_362_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_365_5 then
							if arg_362_1.isInRecall_ then
								iter_365_5.color = Color.New(Mathf.Lerp(iter_365_5.color.r, arg_362_1.hightColor2.r, (arg_362_1.time_ - 0) / var_365_3), Mathf.Lerp(iter_365_5.color.g, arg_362_1.hightColor2.g, (arg_362_1.time_ - 0) / var_365_3), (Mathf.Lerp(iter_365_5.color.b, arg_362_1.hightColor2.b, (arg_362_1.time_ - 0) / var_365_3)))
							else
								local var_365_4 = Mathf.Lerp(iter_365_5.color.r, 0.5, (arg_362_1.time_ - 0) / var_365_3)

								iter_365_5.color = Color.New(var_365_4, var_365_4, var_365_4)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 0 + var_365_3 and arg_362_1.time_ < 0 + var_365_3 + arg_365_0 and not isNil(var_365_2) and arg_362_1.var_.actorSpriteComps10128 then
				for iter_365_6, iter_365_7 in pairs(arg_362_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_365_7 then
						iter_365_7.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_362_1.var_.actorSpriteComps10128 = nil
			end

			local var_365_5 = 0
			local var_365_6 = 0.4

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_5 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_7 = arg_362_1:GetWordFromCfg(417191087)
				local var_365_8 = arg_362_1:FormatText(var_365_7.content)

				arg_362_1.text_.text = var_365_8

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_10 = 16 <= 0 and var_365_6 or var_365_6 * (utf8.len(var_365_8) / 16)

				if (16 <= 0 and var_365_6 or var_365_6 * (utf8.len(var_365_8) / 16)) > 0 and var_365_6 < var_365_10 then
					arg_362_1.talkMaxDuration = var_365_10

					if var_365_10 + var_365_5 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_10 + var_365_5
					end
				end

				arg_362_1.text_.text = var_365_8
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191087", "story_v_out_417191.awb") ~= 0 then
					local var_365_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191087", "story_v_out_417191.awb") / 1000

					if var_365_11 + var_365_5 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_11 + var_365_5
					end

					if var_365_7.prefab_name ~= "" and arg_362_1.actors_[var_365_7.prefab_name] ~= nil then
						local var_365_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_7.prefab_name].transform, "story_v_out_417191", "417191087", "story_v_out_417191.awb")

						arg_362_1:RecordAudio("417191087", var_365_12)
						arg_362_1:RecordAudio("417191087", var_365_12)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_417191", "417191087", "story_v_out_417191.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_417191", "417191087", "story_v_out_417191.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_13 = math.max(var_365_6, arg_362_1.talkMaxDuration)

			if var_365_5 <= arg_362_1.time_ and arg_362_1.time_ < var_365_5 + var_365_13 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_5) / var_365_13

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_5 + var_365_13 and arg_362_1.time_ < var_365_5 + var_365_13 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play417191088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 417191088
		arg_366_1.duration_ = 7.63

		local var_366_0 = {
			zh = 5.133,
			ja = 7.633
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play417191089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0.55

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_1 = arg_366_1:GetWordFromCfg(417191088)
				local var_369_2 = arg_366_1:FormatText(var_369_1.content)

				arg_366_1.text_.text = var_369_2

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_4 = 22 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_2) / 22)

				if (22 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_2) / 22)) > 0 and var_369_0 < var_369_4 then
					arg_366_1.talkMaxDuration = var_369_4

					if var_369_4 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_4 + 0
					end
				end

				arg_366_1.text_.text = var_369_2
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191088", "story_v_out_417191.awb") ~= 0 then
					local var_369_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191088", "story_v_out_417191.awb") / 1000

					if var_369_5 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_5 + 0
					end

					if var_369_1.prefab_name ~= "" and arg_366_1.actors_[var_369_1.prefab_name] ~= nil then
						local var_369_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_1.prefab_name].transform, "story_v_out_417191", "417191088", "story_v_out_417191.awb")

						arg_366_1:RecordAudio("417191088", var_369_6)
						arg_366_1:RecordAudio("417191088", var_369_6)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_417191", "417191088", "story_v_out_417191.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_417191", "417191088", "story_v_out_417191.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_7 = math.max(var_369_0, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_7 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - 0) / var_369_7

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play417191089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 417191089
		arg_370_1.duration_ = 9.87

		local var_370_0 = {
			zh = 9.3,
			ja = 9.866
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play417191090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0.925

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_1 = arg_370_1:GetWordFromCfg(417191089)
				local var_373_2 = arg_370_1:FormatText(var_373_1.content)

				arg_370_1.text_.text = var_373_2

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_4 = 37 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_2) / 37)

				if (37 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_2) / 37)) > 0 and var_373_0 < var_373_4 then
					arg_370_1.talkMaxDuration = var_373_4

					if var_373_4 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_4 + 0
					end
				end

				arg_370_1.text_.text = var_373_2
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191089", "story_v_out_417191.awb") ~= 0 then
					local var_373_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191089", "story_v_out_417191.awb") / 1000

					if var_373_5 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + 0
					end

					if var_373_1.prefab_name ~= "" and arg_370_1.actors_[var_373_1.prefab_name] ~= nil then
						local var_373_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_1.prefab_name].transform, "story_v_out_417191", "417191089", "story_v_out_417191.awb")

						arg_370_1:RecordAudio("417191089", var_373_6)
						arg_370_1:RecordAudio("417191089", var_373_6)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_417191", "417191089", "story_v_out_417191.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_417191", "417191089", "story_v_out_417191.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_7 = math.max(var_373_0, arg_370_1.talkMaxDuration)

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_7 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - 0) / var_373_7

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= 0 + var_373_7 and arg_370_1.time_ < 0 + var_373_7 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play417191090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 417191090
		arg_374_1.duration_ = 6.83

		local var_374_0 = {
			zh = 4.366,
			ja = 6.833
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play417191091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.45

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:GetWordFromCfg(417191090)
				local var_377_2 = arg_374_1:FormatText(var_377_1.content)

				arg_374_1.text_.text = var_377_2

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 18 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 18)

				if (18 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 18)) > 0 and var_377_0 < var_377_4 then
					arg_374_1.talkMaxDuration = var_377_4

					if var_377_4 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_4 + 0
					end
				end

				arg_374_1.text_.text = var_377_2
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191090", "story_v_out_417191.awb") ~= 0 then
					local var_377_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191090", "story_v_out_417191.awb") / 1000

					if var_377_5 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + 0
					end

					if var_377_1.prefab_name ~= "" and arg_374_1.actors_[var_377_1.prefab_name] ~= nil then
						local var_377_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_1.prefab_name].transform, "story_v_out_417191", "417191090", "story_v_out_417191.awb")

						arg_374_1:RecordAudio("417191090", var_377_6)
						arg_374_1:RecordAudio("417191090", var_377_6)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_417191", "417191090", "story_v_out_417191.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_417191", "417191090", "story_v_out_417191.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play417191091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 417191091
		arg_378_1.duration_ = 9

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play417191092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 4 < arg_378_1.time_ and arg_378_1.time_ <= 4 + arg_381_0 then
				arg_378_1.allBtn_.enabled = false
			end

			if arg_378_1.time_ >= 4 + 0.833333333333333 and arg_378_1.time_ < 4 + 0.833333333333333 + arg_381_0 then
				arg_378_1.allBtn_.enabled = true
			end

			if 2 < arg_378_1.time_ and arg_378_1.time_ <= 2 + arg_381_0 then
				local var_381_0 = arg_378_1.bgs_.I11o

				arg_378_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_381_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_381_1 = var_381_0:GetComponent("SpriteRenderer")

				if var_381_1 and var_381_1.sprite then
					local var_381_2 = 2 * (var_381_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_381_0.transform.localScale = Vector3.New(var_381_2 / var_381_1.sprite.bounds.size.y < var_381_2 * manager.ui.mainCameraCom_.aspect / var_381_1.sprite.bounds.size.x and var_381_2 * manager.ui.mainCameraCom_.aspect / var_381_1.sprite.bounds.size.x or var_381_2 / var_381_1.sprite.bounds.size.y, var_381_2 / var_381_1.sprite.bounds.size.y < var_381_2 * manager.ui.mainCameraCom_.aspect / var_381_1.sprite.bounds.size.x and var_381_2 * manager.ui.mainCameraCom_.aspect / var_381_1.sprite.bounds.size.x or var_381_2 / var_381_1.sprite.bounds.size.y, 0)
				end

				for iter_381_0, iter_381_1 in pairs(arg_378_1.bgs_) do
					if iter_381_0 ~= "I11o" then
						iter_381_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_381_3 = 0

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_3 + arg_381_0 then
				arg_378_1.mask_.enabled = true
				arg_378_1.mask_.raycastTarget = true

				arg_378_1:SetGaussion(false)
			end

			local var_381_4 = 2

			if var_381_3 <= arg_378_1.time_ and arg_378_1.time_ < var_381_3 + var_381_4 then
				local var_381_5 = Color.New(0, 0, 0)

				var_381_5.a = Mathf.Lerp(0, 1, (arg_378_1.time_ - var_381_3) / var_381_4)
				arg_378_1.mask_.color = var_381_5
			end

			if arg_378_1.time_ >= var_381_3 + var_381_4 and arg_378_1.time_ < var_381_3 + var_381_4 + arg_381_0 then
				local var_381_6 = Color.New(0, 0, 0)

				var_381_6.a = 1
				arg_378_1.mask_.color = var_381_6
			end

			local var_381_7 = 2

			if 2 < arg_378_1.time_ and arg_378_1.time_ <= var_381_7 + arg_381_0 then
				arg_378_1.mask_.enabled = true
				arg_378_1.mask_.raycastTarget = true

				arg_378_1:SetGaussion(false)
			end

			local var_381_8 = 2

			if var_381_7 <= arg_378_1.time_ and arg_378_1.time_ < var_381_7 + var_381_8 then
				local var_381_9 = Color.New(0, 0, 0)

				var_381_9.a = Mathf.Lerp(1, 0, (arg_378_1.time_ - var_381_7) / var_381_8)
				arg_378_1.mask_.color = var_381_9
			end

			if arg_378_1.time_ >= var_381_7 + var_381_8 and arg_378_1.time_ < var_381_7 + var_381_8 + arg_381_0 then
				local var_381_10 = Color.New(0, 0, 0)

				arg_378_1.mask_.enabled = false
				var_381_10.a = 0
				arg_378_1.mask_.color = var_381_10
			end

			local var_381_11 = arg_378_1.actors_["10128"].transform

			if 1.966 < arg_378_1.time_ and arg_378_1.time_ <= 1.966 + arg_381_0 then
				arg_378_1.var_.moveOldPos10128 = var_381_11.localPosition
				var_381_11.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("10128", 7)

				for iter_381_2 = 0, var_381_11.childCount - 1 do
					local var_381_12 = var_381_11:GetChild(iter_381_2)

					if var_381_12.name == "" or not string.find(var_381_12.name, "split") then
						var_381_12.gameObject:SetActive(true)
					else
						var_381_12.gameObject:SetActive(false)
					end
				end
			end

			local var_381_13 = 0.001

			if 1.966 <= arg_378_1.time_ and arg_378_1.time_ < 1.966 + var_381_13 then
				var_381_11.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_378_1.time_ - 1.966) / var_381_13)
			end

			if arg_378_1.time_ >= 1.966 + var_381_13 and arg_378_1.time_ < 1.966 + var_381_13 + arg_381_0 then
				var_381_11.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_381_14 = arg_378_1.actors_["10110"].transform

			if 1.966 < arg_378_1.time_ and arg_378_1.time_ <= 1.966 + arg_381_0 then
				arg_378_1.var_.moveOldPos10110 = var_381_14.localPosition
				var_381_14.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("10110", 7)

				for iter_381_3 = 0, var_381_14.childCount - 1 do
					local var_381_15 = var_381_14:GetChild(iter_381_3)

					if var_381_15.name == "" or not string.find(var_381_15.name, "split") then
						var_381_15.gameObject:SetActive(true)
					else
						var_381_15.gameObject:SetActive(false)
					end
				end
			end

			local var_381_16 = 0.001

			if 1.966 <= arg_378_1.time_ and arg_378_1.time_ < 1.966 + var_381_16 then
				var_381_14.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos10110, Vector3.New(0, -2000, 0), (arg_378_1.time_ - 1.966) / var_381_16)
			end

			if arg_378_1.time_ >= 1.966 + var_381_16 and arg_378_1.time_ < 1.966 + var_381_16 + arg_381_0 then
				var_381_14.localPosition = Vector3.New(0, -2000, 0)
			end

			if 4 < arg_378_1.time_ and arg_378_1.time_ <= 4 + arg_381_0 then
				arg_378_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_door", "")
			end

			if arg_378_1.frameCnt_ <= 1 then
				arg_378_1.dialog_:SetActive(false)
			end

			local var_381_18 = 4
			local var_381_19 = 1.1

			if 4 < arg_378_1.time_ and arg_378_1.time_ <= var_381_18 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0

				arg_378_1.dialog_:SetActive(true)

				arg_378_1.dialogCg_.alpha = 0

				local var_381_20 = LeanTween.value(arg_378_1.dialog_, 0, 1, 0.3)

				var_381_20:setOnUpdate(LuaHelper.FloatAction(function(arg_382_0)
					arg_378_1.dialogCg_.alpha = arg_382_0
				end))
				var_381_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_378_1.dialog_)
					var_381_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_378_1.duration_ = arg_378_1.duration_ + 0.3

				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_21 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(417191091).content)

				arg_378_1.text_.text = var_381_21

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_23 = 44 <= 0 and var_381_19 or var_381_19 * (utf8.len(var_381_21) / 44)

				if (44 <= 0 and var_381_19 or var_381_19 * (utf8.len(var_381_21) / 44)) > 0 and var_381_19 < var_381_23 then
					arg_378_1.talkMaxDuration = var_381_23
					var_381_18 = var_381_18 + 0.3

					if var_381_23 + var_381_18 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_23 + var_381_18
					end
				end

				arg_378_1.text_.text = var_381_21
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_24 = var_381_18 + 0.3
			local var_381_25 = math.max(var_381_19, arg_378_1.talkMaxDuration)

			if var_381_18 + 0.3 <= arg_378_1.time_ and arg_378_1.time_ < var_381_24 + var_381_25 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_24) / var_381_25

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_24 + var_381_25 and arg_378_1.time_ < var_381_24 + var_381_25 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play417191092 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 417191092
		arg_384_1.duration_ = 1.37

		local var_384_0 = {
			zh = 1,
			ja = 1.366
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play417191093(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(arg_384_1.actors_["10128"]) and arg_384_1.var_.actorSpriteComps10128 == nil then
				arg_384_1.var_.actorSpriteComps10128 = arg_384_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_0 = 0.2

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 and not isNil(arg_384_1.actors_["10128"]) then
				if arg_384_1.var_.actorSpriteComps10128 then
					for iter_387_0, iter_387_1 in pairs(arg_384_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_387_1 then
							if arg_384_1.isInRecall_ then
								iter_387_1.color = Color.New(Mathf.Lerp(iter_387_1.color.r, arg_384_1.hightColor1.r, (arg_384_1.time_ - 0) / var_387_0), Mathf.Lerp(iter_387_1.color.g, arg_384_1.hightColor1.g, (arg_384_1.time_ - 0) / var_387_0), (Mathf.Lerp(iter_387_1.color.b, arg_384_1.hightColor1.b, (arg_384_1.time_ - 0) / var_387_0)))
							else
								local var_387_1 = Mathf.Lerp(iter_387_1.color.r, 1, (arg_384_1.time_ - 0) / var_387_0)

								iter_387_1.color = Color.New(var_387_1, var_387_1, var_387_1)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 and not isNil(arg_384_1.actors_["10128"]) and arg_384_1.var_.actorSpriteComps10128 then
				for iter_387_2, iter_387_3 in pairs(arg_384_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_387_3 then
						iter_387_3.color = arg_384_1.isInRecall_ and (arg_384_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_384_1.var_.actorSpriteComps10128 = nil
			end

			local var_387_2 = arg_384_1.actors_["10128"].transform

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos10128 = var_387_2.localPosition
				var_387_2.localScale = Vector3.New(1, 1, 1)

				arg_384_1:CheckSpriteTmpPos("10128", 3)

				for iter_387_4 = 0, var_387_2.childCount - 1 do
					local var_387_3 = var_387_2:GetChild(iter_387_4)

					if var_387_3.name == "" or not string.find(var_387_3.name, "split") then
						var_387_3.gameObject:SetActive(true)
					else
						var_387_3.gameObject:SetActive(false)
					end
				end
			end

			local var_387_4 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_4 then
				var_387_2.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_384_1.time_ - 0) / var_387_4)
			end

			if arg_384_1.time_ >= 0 + var_387_4 and arg_384_1.time_ < 0 + var_387_4 + arg_387_0 then
				var_387_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_387_5 = 0
			local var_387_6 = 0.075

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_5 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_7 = arg_384_1:GetWordFromCfg(417191092)
				local var_387_8 = arg_384_1:FormatText(var_387_7.content)

				arg_384_1.text_.text = var_387_8

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_10 = 3 <= 0 and var_387_6 or var_387_6 * (utf8.len(var_387_8) / 3)

				if (3 <= 0 and var_387_6 or var_387_6 * (utf8.len(var_387_8) / 3)) > 0 and var_387_6 < var_387_10 then
					arg_384_1.talkMaxDuration = var_387_10

					if var_387_10 + var_387_5 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_10 + var_387_5
					end
				end

				arg_384_1.text_.text = var_387_8
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191092", "story_v_out_417191.awb") ~= 0 then
					local var_387_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191092", "story_v_out_417191.awb") / 1000

					if var_387_11 + var_387_5 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_11 + var_387_5
					end

					if var_387_7.prefab_name ~= "" and arg_384_1.actors_[var_387_7.prefab_name] ~= nil then
						local var_387_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_7.prefab_name].transform, "story_v_out_417191", "417191092", "story_v_out_417191.awb")

						arg_384_1:RecordAudio("417191092", var_387_12)
						arg_384_1:RecordAudio("417191092", var_387_12)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_417191", "417191092", "story_v_out_417191.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_417191", "417191092", "story_v_out_417191.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_13 = math.max(var_387_6, arg_384_1.talkMaxDuration)

			if var_387_5 <= arg_384_1.time_ and arg_384_1.time_ < var_387_5 + var_387_13 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_5) / var_387_13

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_5 + var_387_13 and arg_384_1.time_ < var_387_5 + var_387_13 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
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

		arg_384_1:InitPlayNodeList()
	end,
	Play417191093 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 417191093
		arg_388_1.duration_ = 7.7

		local var_388_0 = {
			zh = 6.233,
			ja = 7.7
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
				arg_388_0:Play417191094(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["10110"]) and arg_388_1.var_.actorSpriteComps10110 == nil then
				arg_388_1.var_.actorSpriteComps10110 = arg_388_1.actors_["10110"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_0 = 0.2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["10110"]) then
				if arg_388_1.var_.actorSpriteComps10110 then
					for iter_391_0, iter_391_1 in pairs(arg_388_1.var_.actorSpriteComps10110:ToTable()) do
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

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["10110"]) and arg_388_1.var_.actorSpriteComps10110 then
				for iter_391_2, iter_391_3 in pairs(arg_388_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_391_3 then
						iter_391_3.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_388_1.var_.actorSpriteComps10110 = nil
			end

			local var_391_2 = arg_388_1.actors_["10128"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.actorSpriteComps10128 == nil then
				arg_388_1.var_.actorSpriteComps10128 = var_391_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_3 = 0.2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_3 and not isNil(var_391_2) then
				if arg_388_1.var_.actorSpriteComps10128 then
					for iter_391_4, iter_391_5 in pairs(arg_388_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_391_5 then
							if arg_388_1.isInRecall_ then
								iter_391_5.color = Color.New(Mathf.Lerp(iter_391_5.color.r, arg_388_1.hightColor2.r, (arg_388_1.time_ - 0) / var_391_3), Mathf.Lerp(iter_391_5.color.g, arg_388_1.hightColor2.g, (arg_388_1.time_ - 0) / var_391_3), (Mathf.Lerp(iter_391_5.color.b, arg_388_1.hightColor2.b, (arg_388_1.time_ - 0) / var_391_3)))
							else
								local var_391_4 = Mathf.Lerp(iter_391_5.color.r, 0.5, (arg_388_1.time_ - 0) / var_391_3)

								iter_391_5.color = Color.New(var_391_4, var_391_4, var_391_4)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= 0 + var_391_3 and arg_388_1.time_ < 0 + var_391_3 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.actorSpriteComps10128 then
				for iter_391_6, iter_391_7 in pairs(arg_388_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_391_7 then
						iter_391_7.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_388_1.var_.actorSpriteComps10128 = nil
			end

			local var_391_5 = arg_388_1.actors_["10128"].transform

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos10128 = var_391_5.localPosition
				var_391_5.localScale = Vector3.New(1, 1, 1)

				arg_388_1:CheckSpriteTmpPos("10128", 7)

				for iter_391_8 = 0, var_391_5.childCount - 1 do
					local var_391_6 = var_391_5:GetChild(iter_391_8)

					if var_391_6.name == "" or not string.find(var_391_6.name, "split") then
						var_391_6.gameObject:SetActive(true)
					else
						var_391_6.gameObject:SetActive(false)
					end
				end
			end

			local var_391_7 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_7 then
				var_391_5.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_388_1.time_ - 0) / var_391_7)
			end

			if arg_388_1.time_ >= 0 + var_391_7 and arg_388_1.time_ < 0 + var_391_7 + arg_391_0 then
				var_391_5.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_391_8 = arg_388_1.actors_["10110"].transform

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos10110 = var_391_8.localPosition
				var_391_8.localScale = Vector3.New(1, 1, 1)

				arg_388_1:CheckSpriteTmpPos("10110", 3)

				for iter_391_9 = 0, var_391_8.childCount - 1 do
					local var_391_9 = var_391_8:GetChild(iter_391_9)

					if var_391_9.name == "" or not string.find(var_391_9.name, "split") then
						var_391_9.gameObject:SetActive(true)
					else
						var_391_9.gameObject:SetActive(false)
					end
				end
			end

			local var_391_10 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_10 then
				var_391_8.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10110, Vector3.New(0, -413.3, -241.3), (arg_388_1.time_ - 0) / var_391_10)
			end

			if arg_388_1.time_ >= 0 + var_391_10 and arg_388_1.time_ < 0 + var_391_10 + arg_391_0 then
				var_391_8.localPosition = Vector3.New(0, -413.3, -241.3)
			end

			local var_391_11 = 0
			local var_391_12 = 0.65

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_11 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_13 = arg_388_1:GetWordFromCfg(417191093)
				local var_391_14 = arg_388_1:FormatText(var_391_13.content)

				arg_388_1.text_.text = var_391_14

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_16 = 26 <= 0 and var_391_12 or var_391_12 * (utf8.len(var_391_14) / 26)

				if (26 <= 0 and var_391_12 or var_391_12 * (utf8.len(var_391_14) / 26)) > 0 and var_391_12 < var_391_16 then
					arg_388_1.talkMaxDuration = var_391_16

					if var_391_16 + var_391_11 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_16 + var_391_11
					end
				end

				arg_388_1.text_.text = var_391_14
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191093", "story_v_out_417191.awb") ~= 0 then
					local var_391_17 = manager.audio:GetVoiceLength("story_v_out_417191", "417191093", "story_v_out_417191.awb") / 1000

					if var_391_17 + var_391_11 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_17 + var_391_11
					end

					if var_391_13.prefab_name ~= "" and arg_388_1.actors_[var_391_13.prefab_name] ~= nil then
						local var_391_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_13.prefab_name].transform, "story_v_out_417191", "417191093", "story_v_out_417191.awb")

						arg_388_1:RecordAudio("417191093", var_391_18)
						arg_388_1:RecordAudio("417191093", var_391_18)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_417191", "417191093", "story_v_out_417191.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_417191", "417191093", "story_v_out_417191.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_19 = math.max(var_391_12, arg_388_1.talkMaxDuration)

			if var_391_11 <= arg_388_1.time_ and arg_388_1.time_ < var_391_11 + var_391_19 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_11) / var_391_19

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_11 + var_391_19 and arg_388_1.time_ < var_391_11 + var_391_19 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
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
				actorName = "10110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play417191094 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 417191094
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play417191095(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["10110"]) and arg_392_1.var_.actorSpriteComps10110 == nil then
				arg_392_1.var_.actorSpriteComps10110 = arg_392_1.actors_["10110"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_0 = 0.2

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["10110"]) then
				if arg_392_1.var_.actorSpriteComps10110 then
					for iter_395_0, iter_395_1 in pairs(arg_392_1.var_.actorSpriteComps10110:ToTable()) do
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

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["10110"]) and arg_392_1.var_.actorSpriteComps10110 then
				for iter_395_2, iter_395_3 in pairs(arg_392_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_395_3 then
						iter_395_3.color = arg_392_1.isInRecall_ and (arg_392_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_392_1.var_.actorSpriteComps10110 = nil
			end

			local var_395_2 = arg_392_1.actors_["10128"].transform

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos10128 = var_395_2.localPosition
				var_395_2.localScale = Vector3.New(1, 1, 1)

				arg_392_1:CheckSpriteTmpPos("10128", 7)

				for iter_395_4 = 0, var_395_2.childCount - 1 do
					local var_395_3 = var_395_2:GetChild(iter_395_4)

					if var_395_3.name == "" or not string.find(var_395_3.name, "split") then
						var_395_3.gameObject:SetActive(true)
					else
						var_395_3.gameObject:SetActive(false)
					end
				end
			end

			local var_395_4 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_4 then
				var_395_2.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_392_1.time_ - 0) / var_395_4)
			end

			if arg_392_1.time_ >= 0 + var_395_4 and arg_392_1.time_ < 0 + var_395_4 + arg_395_0 then
				var_395_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_395_5 = arg_392_1.actors_["10110"].transform

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos10110 = var_395_5.localPosition
				var_395_5.localScale = Vector3.New(1, 1, 1)

				arg_392_1:CheckSpriteTmpPos("10110", 7)

				for iter_395_5 = 0, var_395_5.childCount - 1 do
					local var_395_6 = var_395_5:GetChild(iter_395_5)

					if var_395_6.name == "" or not string.find(var_395_6.name, "split") then
						var_395_6.gameObject:SetActive(true)
					else
						var_395_6.gameObject:SetActive(false)
					end
				end
			end

			local var_395_7 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_7 then
				var_395_5.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos10110, Vector3.New(0, -2000, 0), (arg_392_1.time_ - 0) / var_395_7)
			end

			if arg_392_1.time_ >= 0 + var_395_7 and arg_392_1.time_ < 0 + var_395_7 + arg_395_0 then
				var_395_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_395_8 = 0
			local var_395_9 = 1.075

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_8 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, false)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_10 = arg_392_1:FormatText(arg_392_1:GetWordFromCfg(417191094).content)

				arg_392_1.text_.text = var_395_10

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_12 = 43 <= 0 and var_395_9 or var_395_9 * (utf8.len(var_395_10) / 43)

				if (43 <= 0 and var_395_9 or var_395_9 * (utf8.len(var_395_10) / 43)) > 0 and var_395_9 < var_395_12 then
					arg_392_1.talkMaxDuration = var_395_12

					if var_395_12 + var_395_8 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_12 + var_395_8
					end
				end

				arg_392_1.text_.text = var_395_10
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_13 = math.max(var_395_9, arg_392_1.talkMaxDuration)

			if var_395_8 <= arg_392_1.time_ and arg_392_1.time_ < var_395_8 + var_395_13 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_8) / var_395_13

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_8 + var_395_13 and arg_392_1.time_ < var_395_8 + var_395_13 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
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
				actorName = "10110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play417191095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 417191095
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play417191096(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 1.25

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_1 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(417191095).content)

				arg_396_1.text_.text = var_399_1

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_3 = 50 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 50)

				if (50 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 50)) > 0 and var_399_0 < var_399_3 then
					arg_396_1.talkMaxDuration = var_399_3

					if var_399_3 + 0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_3 + 0
					end
				end

				arg_396_1.text_.text = var_399_1
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_4 = math.max(var_399_0, arg_396_1.talkMaxDuration)

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_4 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - 0) / var_399_4

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= 0 + var_399_4 and arg_396_1.time_ < 0 + var_399_4 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play417191096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 417191096
		arg_400_1.duration_ = 9

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play417191097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if arg_400_1.bgs_.ST04b == nil then
				local var_403_0 = Object.Instantiate(arg_400_1.paintGo_)

				var_403_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST04b")
				var_403_0.name = "ST04b"
				var_403_0.transform.parent = arg_400_1.stage_.transform
				var_403_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_400_1.bgs_.ST04b = var_403_0
			end

			if 1.999999999999 < arg_400_1.time_ and arg_400_1.time_ <= 1.999999999999 + arg_403_0 then
				local var_403_1 = arg_400_1.bgs_.ST04b

				arg_400_1.bgs_.ST04b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_403_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_403_2 = var_403_1:GetComponent("SpriteRenderer")

				if var_403_2 and var_403_2.sprite then
					local var_403_3 = 2 * (var_403_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_403_1.transform.localScale = Vector3.New(var_403_3 / var_403_2.sprite.bounds.size.y < var_403_3 * manager.ui.mainCameraCom_.aspect / var_403_2.sprite.bounds.size.x and var_403_3 * manager.ui.mainCameraCom_.aspect / var_403_2.sprite.bounds.size.x or var_403_3 / var_403_2.sprite.bounds.size.y, var_403_3 / var_403_2.sprite.bounds.size.y < var_403_3 * manager.ui.mainCameraCom_.aspect / var_403_2.sprite.bounds.size.x and var_403_3 * manager.ui.mainCameraCom_.aspect / var_403_2.sprite.bounds.size.x or var_403_3 / var_403_2.sprite.bounds.size.y, 0)
				end

				for iter_403_0, iter_403_1 in pairs(arg_400_1.bgs_) do
					if iter_403_0 ~= "ST04b" then
						iter_403_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_403_4 = 3.999999999999

			if 3.999999999999 < arg_400_1.time_ and arg_400_1.time_ <= var_403_4 + arg_403_0 then
				arg_400_1.allBtn_.enabled = false
			end

			if arg_400_1.time_ >= var_403_4 + 0.3 and arg_400_1.time_ < var_403_4 + 0.3 + arg_403_0 then
				arg_400_1.allBtn_.enabled = true
			end

			local var_403_5 = 0

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_5 + arg_403_0 then
				arg_400_1.mask_.enabled = true
				arg_400_1.mask_.raycastTarget = true

				arg_400_1:SetGaussion(false)
			end

			local var_403_6 = 2

			if var_403_5 <= arg_400_1.time_ and arg_400_1.time_ < var_403_5 + var_403_6 then
				local var_403_7 = Color.New(0, 0, 0)

				var_403_7.a = Mathf.Lerp(0, 1, (arg_400_1.time_ - var_403_5) / var_403_6)
				arg_400_1.mask_.color = var_403_7
			end

			if arg_400_1.time_ >= var_403_5 + var_403_6 and arg_400_1.time_ < var_403_5 + var_403_6 + arg_403_0 then
				local var_403_8 = Color.New(0, 0, 0)

				var_403_8.a = 1
				arg_400_1.mask_.color = var_403_8
			end

			local var_403_9 = 2

			if 2 < arg_400_1.time_ and arg_400_1.time_ <= var_403_9 + arg_403_0 then
				arg_400_1.mask_.enabled = true
				arg_400_1.mask_.raycastTarget = true

				arg_400_1:SetGaussion(false)
			end

			local var_403_10 = 2

			if var_403_9 <= arg_400_1.time_ and arg_400_1.time_ < var_403_9 + var_403_10 then
				local var_403_11 = Color.New(0, 0, 0)

				var_403_11.a = Mathf.Lerp(1, 0, (arg_400_1.time_ - var_403_9) / var_403_10)
				arg_400_1.mask_.color = var_403_11
			end

			if arg_400_1.time_ >= var_403_9 + var_403_10 and arg_400_1.time_ < var_403_9 + var_403_10 + arg_403_0 then
				local var_403_12 = Color.New(0, 0, 0)

				arg_400_1.mask_.enabled = false
				var_403_12.a = 0
				arg_400_1.mask_.color = var_403_12
			end

			if 5.3 < arg_400_1.time_ and arg_400_1.time_ <= 5.3 + arg_403_0 then
				arg_400_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_clap01", "")
			end

			if arg_400_1.frameCnt_ <= 1 then
				arg_400_1.dialog_:SetActive(false)
			end

			local var_403_14 = 3.999999999999
			local var_403_15 = 1.2

			if 3.999999999999 < arg_400_1.time_ and arg_400_1.time_ <= var_403_14 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0

				arg_400_1.dialog_:SetActive(true)

				arg_400_1.dialogCg_.alpha = 0

				local var_403_16 = LeanTween.value(arg_400_1.dialog_, 0, 1, 0.3)

				var_403_16:setOnUpdate(LuaHelper.FloatAction(function(arg_404_0)
					arg_400_1.dialogCg_.alpha = arg_404_0
				end))
				var_403_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_400_1.dialog_)
					var_403_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_400_1.duration_ = arg_400_1.duration_ + 0.3

				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_17 = arg_400_1:FormatText(arg_400_1:GetWordFromCfg(417191096).content)

				arg_400_1.text_.text = var_403_17

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_19 = 48 <= 0 and var_403_15 or var_403_15 * (utf8.len(var_403_17) / 48)

				if (48 <= 0 and var_403_15 or var_403_15 * (utf8.len(var_403_17) / 48)) > 0 and var_403_15 < var_403_19 then
					arg_400_1.talkMaxDuration = var_403_19
					var_403_14 = var_403_14 + 0.3

					if var_403_19 + var_403_14 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_19 + var_403_14
					end
				end

				arg_400_1.text_.text = var_403_17
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_20 = var_403_14 + 0.3
			local var_403_21 = math.max(var_403_15, arg_400_1.talkMaxDuration)

			if var_403_14 + 0.3 <= arg_400_1.time_ and arg_400_1.time_ < var_403_20 + var_403_21 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_20) / var_403_21

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_20 + var_403_21 and arg_400_1.time_ < var_403_20 + var_403_21 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play417191097 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 417191097
		arg_406_1.duration_ = 4.1

		local var_406_0 = {
			zh = 3.733,
			ja = 4.1
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play417191098(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if arg_406_1.actors_["1060"] == nil then
				local var_409_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_409_0) then
					local var_409_1 = Object.Instantiate(var_409_0, arg_406_1.canvasGo_.transform)

					var_409_1.transform:SetSiblingIndex(1)

					var_409_1.name = "1060"
					var_409_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_406_1.actors_["1060"] = var_409_1

					if arg_406_1.isInRecall_ then
						for iter_409_0, iter_409_1 in ipairs((var_409_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_409_1.color = arg_406_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_409_2 = arg_406_1.actors_["1060"]

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(var_409_2) and arg_406_1.var_.actorSpriteComps1060 == nil then
				arg_406_1.var_.actorSpriteComps1060 = var_409_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_409_3 = 0.2

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_3 and not isNil(var_409_2) then
				if arg_406_1.var_.actorSpriteComps1060 then
					for iter_409_2, iter_409_3 in pairs(arg_406_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_409_3 then
							if arg_406_1.isInRecall_ then
								iter_409_3.color = Color.New(Mathf.Lerp(iter_409_3.color.r, arg_406_1.hightColor1.r, (arg_406_1.time_ - 0) / var_409_3), Mathf.Lerp(iter_409_3.color.g, arg_406_1.hightColor1.g, (arg_406_1.time_ - 0) / var_409_3), (Mathf.Lerp(iter_409_3.color.b, arg_406_1.hightColor1.b, (arg_406_1.time_ - 0) / var_409_3)))
							else
								local var_409_4 = Mathf.Lerp(iter_409_3.color.r, 1, (arg_406_1.time_ - 0) / var_409_3)

								iter_409_3.color = Color.New(var_409_4, var_409_4, var_409_4)
							end
						end
					end
				end
			end

			if arg_406_1.time_ >= 0 + var_409_3 and arg_406_1.time_ < 0 + var_409_3 + arg_409_0 and not isNil(var_409_2) and arg_406_1.var_.actorSpriteComps1060 then
				for iter_409_4, iter_409_5 in pairs(arg_406_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_409_5 then
						iter_409_5.color = arg_406_1.isInRecall_ and (arg_406_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_406_1.var_.actorSpriteComps1060 = nil
			end

			local var_409_5 = arg_406_1.actors_["1060"].transform

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos1060 = var_409_5.localPosition
				var_409_5.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("1060", 3)

				for iter_409_6 = 0, var_409_5.childCount - 1 do
					local var_409_6 = var_409_5:GetChild(iter_409_6)

					if var_409_6.name == "" or not string.find(var_409_6.name, "split") then
						var_409_6.gameObject:SetActive(true)
					else
						var_409_6.gameObject:SetActive(false)
					end
				end
			end

			local var_409_7 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_7 then
				var_409_5.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_406_1.time_ - 0) / var_409_7)
			end

			if arg_406_1.time_ >= 0 + var_409_7 and arg_406_1.time_ < 0 + var_409_7 + arg_409_0 then
				var_409_5.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_409_8 = 0
			local var_409_9 = 0.425

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_8 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_10 = arg_406_1:GetWordFromCfg(417191097)
				local var_409_11 = arg_406_1:FormatText(var_409_10.content)

				arg_406_1.text_.text = var_409_11

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_13 = 17 <= 0 and var_409_9 or var_409_9 * (utf8.len(var_409_11) / 17)

				if (17 <= 0 and var_409_9 or var_409_9 * (utf8.len(var_409_11) / 17)) > 0 and var_409_9 < var_409_13 then
					arg_406_1.talkMaxDuration = var_409_13

					if var_409_13 + var_409_8 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_13 + var_409_8
					end
				end

				arg_406_1.text_.text = var_409_11
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191097", "story_v_out_417191.awb") ~= 0 then
					local var_409_14 = manager.audio:GetVoiceLength("story_v_out_417191", "417191097", "story_v_out_417191.awb") / 1000

					if var_409_14 + var_409_8 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_14 + var_409_8
					end

					if var_409_10.prefab_name ~= "" and arg_406_1.actors_[var_409_10.prefab_name] ~= nil then
						local var_409_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_10.prefab_name].transform, "story_v_out_417191", "417191097", "story_v_out_417191.awb")

						arg_406_1:RecordAudio("417191097", var_409_15)
						arg_406_1:RecordAudio("417191097", var_409_15)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_417191", "417191097", "story_v_out_417191.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_417191", "417191097", "story_v_out_417191.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_16 = math.max(var_409_9, arg_406_1.talkMaxDuration)

			if var_409_8 <= arg_406_1.time_ and arg_406_1.time_ < var_409_8 + var_409_16 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_8) / var_409_16

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_8 + var_409_16 and arg_406_1.time_ < var_409_8 + var_409_16 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
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

		arg_406_1:InitPlayNodeList()
	end,
	Play417191098 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 417191098
		arg_410_1.duration_ = 5.5

		local var_410_0 = {
			zh = 3.266,
			ja = 5.5
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play417191099(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["10128"]) and arg_410_1.var_.actorSpriteComps10128 == nil then
				arg_410_1.var_.actorSpriteComps10128 = arg_410_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_0 = 0.2

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["10128"]) then
				if arg_410_1.var_.actorSpriteComps10128 then
					for iter_413_0, iter_413_1 in pairs(arg_410_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_413_1 then
							if arg_410_1.isInRecall_ then
								iter_413_1.color = Color.New(Mathf.Lerp(iter_413_1.color.r, arg_410_1.hightColor1.r, (arg_410_1.time_ - 0) / var_413_0), Mathf.Lerp(iter_413_1.color.g, arg_410_1.hightColor1.g, (arg_410_1.time_ - 0) / var_413_0), (Mathf.Lerp(iter_413_1.color.b, arg_410_1.hightColor1.b, (arg_410_1.time_ - 0) / var_413_0)))
							else
								local var_413_1 = Mathf.Lerp(iter_413_1.color.r, 1, (arg_410_1.time_ - 0) / var_413_0)

								iter_413_1.color = Color.New(var_413_1, var_413_1, var_413_1)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["10128"]) and arg_410_1.var_.actorSpriteComps10128 then
				for iter_413_2, iter_413_3 in pairs(arg_410_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_413_3 then
						iter_413_3.color = arg_410_1.isInRecall_ and (arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_410_1.var_.actorSpriteComps10128 = nil
			end

			local var_413_2 = arg_410_1.actors_["1060"]

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.actorSpriteComps1060 == nil then
				arg_410_1.var_.actorSpriteComps1060 = var_413_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_3 = 0.2

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_3 and not isNil(var_413_2) then
				if arg_410_1.var_.actorSpriteComps1060 then
					for iter_413_4, iter_413_5 in pairs(arg_410_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_413_5 then
							if arg_410_1.isInRecall_ then
								iter_413_5.color = Color.New(Mathf.Lerp(iter_413_5.color.r, arg_410_1.hightColor2.r, (arg_410_1.time_ - 0) / var_413_3), Mathf.Lerp(iter_413_5.color.g, arg_410_1.hightColor2.g, (arg_410_1.time_ - 0) / var_413_3), (Mathf.Lerp(iter_413_5.color.b, arg_410_1.hightColor2.b, (arg_410_1.time_ - 0) / var_413_3)))
							else
								local var_413_4 = Mathf.Lerp(iter_413_5.color.r, 0.5, (arg_410_1.time_ - 0) / var_413_3)

								iter_413_5.color = Color.New(var_413_4, var_413_4, var_413_4)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= 0 + var_413_3 and arg_410_1.time_ < 0 + var_413_3 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.actorSpriteComps1060 then
				for iter_413_6, iter_413_7 in pairs(arg_410_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_413_7 then
						iter_413_7.color = arg_410_1.isInRecall_ and (arg_410_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_410_1.var_.actorSpriteComps1060 = nil
			end

			local var_413_5 = arg_410_1.actors_["1060"].transform

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos1060 = var_413_5.localPosition
				var_413_5.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1060", 2)

				for iter_413_8 = 0, var_413_5.childCount - 1 do
					local var_413_6 = var_413_5:GetChild(iter_413_8)

					if var_413_6.name == "" or not string.find(var_413_6.name, "split") then
						var_413_6.gameObject:SetActive(true)
					else
						var_413_6.gameObject:SetActive(false)
					end
				end
			end

			local var_413_7 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_7 then
				var_413_5.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_410_1.time_ - 0) / var_413_7)
			end

			if arg_410_1.time_ >= 0 + var_413_7 and arg_410_1.time_ < 0 + var_413_7 + arg_413_0 then
				var_413_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_413_8 = arg_410_1.actors_["10128"].transform

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos10128 = var_413_8.localPosition
				var_413_8.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("10128", 4)

				for iter_413_9 = 0, var_413_8.childCount - 1 do
					local var_413_9 = var_413_8:GetChild(iter_413_9)

					if var_413_9.name == "" or not string.find(var_413_9.name, "split") then
						var_413_9.gameObject:SetActive(true)
					else
						var_413_9.gameObject:SetActive(false)
					end
				end
			end

			local var_413_10 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_10 then
				var_413_8.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_410_1.time_ - 0) / var_413_10)
			end

			if arg_410_1.time_ >= 0 + var_413_10 and arg_410_1.time_ < 0 + var_413_10 + arg_413_0 then
				var_413_8.localPosition = Vector3.New(390, -347, -300)
			end

			local var_413_11 = 0
			local var_413_12 = 0.45

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_11 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_13 = arg_410_1:GetWordFromCfg(417191098)
				local var_413_14 = arg_410_1:FormatText(var_413_13.content)

				arg_410_1.text_.text = var_413_14

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_16 = 18 <= 0 and var_413_12 or var_413_12 * (utf8.len(var_413_14) / 18)

				if (18 <= 0 and var_413_12 or var_413_12 * (utf8.len(var_413_14) / 18)) > 0 and var_413_12 < var_413_16 then
					arg_410_1.talkMaxDuration = var_413_16

					if var_413_16 + var_413_11 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_16 + var_413_11
					end
				end

				arg_410_1.text_.text = var_413_14
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191098", "story_v_out_417191.awb") ~= 0 then
					local var_413_17 = manager.audio:GetVoiceLength("story_v_out_417191", "417191098", "story_v_out_417191.awb") / 1000

					if var_413_17 + var_413_11 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_17 + var_413_11
					end

					if var_413_13.prefab_name ~= "" and arg_410_1.actors_[var_413_13.prefab_name] ~= nil then
						local var_413_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_13.prefab_name].transform, "story_v_out_417191", "417191098", "story_v_out_417191.awb")

						arg_410_1:RecordAudio("417191098", var_413_18)
						arg_410_1:RecordAudio("417191098", var_413_18)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_417191", "417191098", "story_v_out_417191.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_417191", "417191098", "story_v_out_417191.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_19 = math.max(var_413_12, arg_410_1.talkMaxDuration)

			if var_413_11 <= arg_410_1.time_ and arg_410_1.time_ < var_413_11 + var_413_19 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_11) / var_413_19

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_11 + var_413_19 and arg_410_1.time_ < var_413_11 + var_413_19 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
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
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play417191099 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 417191099
		arg_414_1.duration_ = 2.57

		local var_414_0 = {
			zh = 1.366,
			ja = 2.566
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play417191100(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.15

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_1 = arg_414_1:GetWordFromCfg(417191099)
				local var_417_2 = arg_414_1:FormatText(var_417_1.content)

				arg_414_1.text_.text = var_417_2

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_4 = 6 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 6)

				if (6 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 6)) > 0 and var_417_0 < var_417_4 then
					arg_414_1.talkMaxDuration = var_417_4

					if var_417_4 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_4 + 0
					end
				end

				arg_414_1.text_.text = var_417_2
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191099", "story_v_out_417191.awb") ~= 0 then
					local var_417_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191099", "story_v_out_417191.awb") / 1000

					if var_417_5 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_5 + 0
					end

					if var_417_1.prefab_name ~= "" and arg_414_1.actors_[var_417_1.prefab_name] ~= nil then
						local var_417_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_1.prefab_name].transform, "story_v_out_417191", "417191099", "story_v_out_417191.awb")

						arg_414_1:RecordAudio("417191099", var_417_6)
						arg_414_1:RecordAudio("417191099", var_417_6)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_417191", "417191099", "story_v_out_417191.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_417191", "417191099", "story_v_out_417191.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_7 and arg_414_1.time_ < 0 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play417191100 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 417191100
		arg_418_1.duration_ = 8.1

		local var_418_0 = {
			zh = 7.6,
			ja = 8.1
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play417191101(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["1060"]) and arg_418_1.var_.actorSpriteComps1060 == nil then
				arg_418_1.var_.actorSpriteComps1060 = arg_418_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_421_0 = 0.2

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["1060"]) then
				if arg_418_1.var_.actorSpriteComps1060 then
					for iter_421_0, iter_421_1 in pairs(arg_418_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_421_1 then
							if arg_418_1.isInRecall_ then
								iter_421_1.color = Color.New(Mathf.Lerp(iter_421_1.color.r, arg_418_1.hightColor1.r, (arg_418_1.time_ - 0) / var_421_0), Mathf.Lerp(iter_421_1.color.g, arg_418_1.hightColor1.g, (arg_418_1.time_ - 0) / var_421_0), (Mathf.Lerp(iter_421_1.color.b, arg_418_1.hightColor1.b, (arg_418_1.time_ - 0) / var_421_0)))
							else
								local var_421_1 = Mathf.Lerp(iter_421_1.color.r, 1, (arg_418_1.time_ - 0) / var_421_0)

								iter_421_1.color = Color.New(var_421_1, var_421_1, var_421_1)
							end
						end
					end
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["1060"]) and arg_418_1.var_.actorSpriteComps1060 then
				for iter_421_2, iter_421_3 in pairs(arg_418_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_421_3 then
						iter_421_3.color = arg_418_1.isInRecall_ and (arg_418_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_418_1.var_.actorSpriteComps1060 = nil
			end

			local var_421_2 = arg_418_1.actors_["10128"]

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(var_421_2) and arg_418_1.var_.actorSpriteComps10128 == nil then
				arg_418_1.var_.actorSpriteComps10128 = var_421_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_421_3 = 0.2

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_3 and not isNil(var_421_2) then
				if arg_418_1.var_.actorSpriteComps10128 then
					for iter_421_4, iter_421_5 in pairs(arg_418_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_421_5 then
							if arg_418_1.isInRecall_ then
								iter_421_5.color = Color.New(Mathf.Lerp(iter_421_5.color.r, arg_418_1.hightColor2.r, (arg_418_1.time_ - 0) / var_421_3), Mathf.Lerp(iter_421_5.color.g, arg_418_1.hightColor2.g, (arg_418_1.time_ - 0) / var_421_3), (Mathf.Lerp(iter_421_5.color.b, arg_418_1.hightColor2.b, (arg_418_1.time_ - 0) / var_421_3)))
							else
								local var_421_4 = Mathf.Lerp(iter_421_5.color.r, 0.5, (arg_418_1.time_ - 0) / var_421_3)

								iter_421_5.color = Color.New(var_421_4, var_421_4, var_421_4)
							end
						end
					end
				end
			end

			if arg_418_1.time_ >= 0 + var_421_3 and arg_418_1.time_ < 0 + var_421_3 + arg_421_0 and not isNil(var_421_2) and arg_418_1.var_.actorSpriteComps10128 then
				for iter_421_6, iter_421_7 in pairs(arg_418_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_421_7 then
						iter_421_7.color = arg_418_1.isInRecall_ and (arg_418_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_418_1.var_.actorSpriteComps10128 = nil
			end

			local var_421_5 = 0
			local var_421_6 = 1.025

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_5 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_7 = arg_418_1:GetWordFromCfg(417191100)
				local var_421_8 = arg_418_1:FormatText(var_421_7.content)

				arg_418_1.text_.text = var_421_8

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_10 = 41 <= 0 and var_421_6 or var_421_6 * (utf8.len(var_421_8) / 41)

				if (41 <= 0 and var_421_6 or var_421_6 * (utf8.len(var_421_8) / 41)) > 0 and var_421_6 < var_421_10 then
					arg_418_1.talkMaxDuration = var_421_10

					if var_421_10 + var_421_5 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_10 + var_421_5
					end
				end

				arg_418_1.text_.text = var_421_8
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191100", "story_v_out_417191.awb") ~= 0 then
					local var_421_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191100", "story_v_out_417191.awb") / 1000

					if var_421_11 + var_421_5 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_11 + var_421_5
					end

					if var_421_7.prefab_name ~= "" and arg_418_1.actors_[var_421_7.prefab_name] ~= nil then
						local var_421_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_7.prefab_name].transform, "story_v_out_417191", "417191100", "story_v_out_417191.awb")

						arg_418_1:RecordAudio("417191100", var_421_12)
						arg_418_1:RecordAudio("417191100", var_421_12)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_417191", "417191100", "story_v_out_417191.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_417191", "417191100", "story_v_out_417191.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_13 = math.max(var_421_6, arg_418_1.talkMaxDuration)

			if var_421_5 <= arg_418_1.time_ and arg_418_1.time_ < var_421_5 + var_421_13 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_5) / var_421_13

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_5 + var_421_13 and arg_418_1.time_ < var_421_5 + var_421_13 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play417191101 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 417191101
		arg_422_1.duration_ = 1.7

		local var_422_0 = {
			zh = 1.266,
			ja = 1.7
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play417191102(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["10128"]) and arg_422_1.var_.actorSpriteComps10128 == nil then
				arg_422_1.var_.actorSpriteComps10128 = arg_422_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_0 = 0.2

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["10128"]) then
				if arg_422_1.var_.actorSpriteComps10128 then
					for iter_425_0, iter_425_1 in pairs(arg_422_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_425_1 then
							if arg_422_1.isInRecall_ then
								iter_425_1.color = Color.New(Mathf.Lerp(iter_425_1.color.r, arg_422_1.hightColor1.r, (arg_422_1.time_ - 0) / var_425_0), Mathf.Lerp(iter_425_1.color.g, arg_422_1.hightColor1.g, (arg_422_1.time_ - 0) / var_425_0), (Mathf.Lerp(iter_425_1.color.b, arg_422_1.hightColor1.b, (arg_422_1.time_ - 0) / var_425_0)))
							else
								local var_425_1 = Mathf.Lerp(iter_425_1.color.r, 1, (arg_422_1.time_ - 0) / var_425_0)

								iter_425_1.color = Color.New(var_425_1, var_425_1, var_425_1)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["10128"]) and arg_422_1.var_.actorSpriteComps10128 then
				for iter_425_2, iter_425_3 in pairs(arg_422_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_425_3 then
						iter_425_3.color = arg_422_1.isInRecall_ and (arg_422_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_422_1.var_.actorSpriteComps10128 = nil
			end

			local var_425_2 = arg_422_1.actors_["1060"]

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(var_425_2) and arg_422_1.var_.actorSpriteComps1060 == nil then
				arg_422_1.var_.actorSpriteComps1060 = var_425_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_3 = 0.2

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_3 and not isNil(var_425_2) then
				if arg_422_1.var_.actorSpriteComps1060 then
					for iter_425_4, iter_425_5 in pairs(arg_422_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_425_5 then
							if arg_422_1.isInRecall_ then
								iter_425_5.color = Color.New(Mathf.Lerp(iter_425_5.color.r, arg_422_1.hightColor2.r, (arg_422_1.time_ - 0) / var_425_3), Mathf.Lerp(iter_425_5.color.g, arg_422_1.hightColor2.g, (arg_422_1.time_ - 0) / var_425_3), (Mathf.Lerp(iter_425_5.color.b, arg_422_1.hightColor2.b, (arg_422_1.time_ - 0) / var_425_3)))
							else
								local var_425_4 = Mathf.Lerp(iter_425_5.color.r, 0.5, (arg_422_1.time_ - 0) / var_425_3)

								iter_425_5.color = Color.New(var_425_4, var_425_4, var_425_4)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= 0 + var_425_3 and arg_422_1.time_ < 0 + var_425_3 + arg_425_0 and not isNil(var_425_2) and arg_422_1.var_.actorSpriteComps1060 then
				for iter_425_6, iter_425_7 in pairs(arg_422_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_425_7 then
						iter_425_7.color = arg_422_1.isInRecall_ and (arg_422_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_422_1.var_.actorSpriteComps1060 = nil
			end

			local var_425_5 = 0
			local var_425_6 = 0.125

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_5 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_7 = arg_422_1:GetWordFromCfg(417191101)
				local var_425_8 = arg_422_1:FormatText(var_425_7.content)

				arg_422_1.text_.text = var_425_8

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_10 = 5 <= 0 and var_425_6 or var_425_6 * (utf8.len(var_425_8) / 5)

				if (5 <= 0 and var_425_6 or var_425_6 * (utf8.len(var_425_8) / 5)) > 0 and var_425_6 < var_425_10 then
					arg_422_1.talkMaxDuration = var_425_10

					if var_425_10 + var_425_5 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_10 + var_425_5
					end
				end

				arg_422_1.text_.text = var_425_8
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191101", "story_v_out_417191.awb") ~= 0 then
					local var_425_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191101", "story_v_out_417191.awb") / 1000

					if var_425_11 + var_425_5 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_11 + var_425_5
					end

					if var_425_7.prefab_name ~= "" and arg_422_1.actors_[var_425_7.prefab_name] ~= nil then
						local var_425_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_7.prefab_name].transform, "story_v_out_417191", "417191101", "story_v_out_417191.awb")

						arg_422_1:RecordAudio("417191101", var_425_12)
						arg_422_1:RecordAudio("417191101", var_425_12)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_417191", "417191101", "story_v_out_417191.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_417191", "417191101", "story_v_out_417191.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_13 = math.max(var_425_6, arg_422_1.talkMaxDuration)

			if var_425_5 <= arg_422_1.time_ and arg_422_1.time_ < var_425_5 + var_425_13 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_5) / var_425_13

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_5 + var_425_13 and arg_422_1.time_ < var_425_5 + var_425_13 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play417191102 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 417191102
		arg_426_1.duration_ = 1.3

		local var_426_0 = {
			zh = 0.999999999999,
			ja = 1.3
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play417191103(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(arg_426_1.actors_["1060"]) and arg_426_1.var_.actorSpriteComps1060 == nil then
				arg_426_1.var_.actorSpriteComps1060 = arg_426_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_429_0 = 0.2

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 and not isNil(arg_426_1.actors_["1060"]) then
				if arg_426_1.var_.actorSpriteComps1060 then
					for iter_429_0, iter_429_1 in pairs(arg_426_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_429_1 then
							if arg_426_1.isInRecall_ then
								iter_429_1.color = Color.New(Mathf.Lerp(iter_429_1.color.r, arg_426_1.hightColor1.r, (arg_426_1.time_ - 0) / var_429_0), Mathf.Lerp(iter_429_1.color.g, arg_426_1.hightColor1.g, (arg_426_1.time_ - 0) / var_429_0), (Mathf.Lerp(iter_429_1.color.b, arg_426_1.hightColor1.b, (arg_426_1.time_ - 0) / var_429_0)))
							else
								local var_429_1 = Mathf.Lerp(iter_429_1.color.r, 1, (arg_426_1.time_ - 0) / var_429_0)

								iter_429_1.color = Color.New(var_429_1, var_429_1, var_429_1)
							end
						end
					end
				end
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 and not isNil(arg_426_1.actors_["1060"]) and arg_426_1.var_.actorSpriteComps1060 then
				for iter_429_2, iter_429_3 in pairs(arg_426_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_429_3 then
						iter_429_3.color = arg_426_1.isInRecall_ and (arg_426_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_426_1.var_.actorSpriteComps1060 = nil
			end

			local var_429_2 = arg_426_1.actors_["10128"]

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(var_429_2) and arg_426_1.var_.actorSpriteComps10128 == nil then
				arg_426_1.var_.actorSpriteComps10128 = var_429_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_429_3 = 0.2

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_3 and not isNil(var_429_2) then
				if arg_426_1.var_.actorSpriteComps10128 then
					for iter_429_4, iter_429_5 in pairs(arg_426_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_429_5 then
							if arg_426_1.isInRecall_ then
								iter_429_5.color = Color.New(Mathf.Lerp(iter_429_5.color.r, arg_426_1.hightColor2.r, (arg_426_1.time_ - 0) / var_429_3), Mathf.Lerp(iter_429_5.color.g, arg_426_1.hightColor2.g, (arg_426_1.time_ - 0) / var_429_3), (Mathf.Lerp(iter_429_5.color.b, arg_426_1.hightColor2.b, (arg_426_1.time_ - 0) / var_429_3)))
							else
								local var_429_4 = Mathf.Lerp(iter_429_5.color.r, 0.5, (arg_426_1.time_ - 0) / var_429_3)

								iter_429_5.color = Color.New(var_429_4, var_429_4, var_429_4)
							end
						end
					end
				end
			end

			if arg_426_1.time_ >= 0 + var_429_3 and arg_426_1.time_ < 0 + var_429_3 + arg_429_0 and not isNil(var_429_2) and arg_426_1.var_.actorSpriteComps10128 then
				for iter_429_6, iter_429_7 in pairs(arg_426_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_429_7 then
						iter_429_7.color = arg_426_1.isInRecall_ and (arg_426_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_426_1.var_.actorSpriteComps10128 = nil
			end

			local var_429_5 = 0
			local var_429_6 = 0.075

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_5 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_7 = arg_426_1:GetWordFromCfg(417191102)
				local var_429_8 = arg_426_1:FormatText(var_429_7.content)

				arg_426_1.text_.text = var_429_8

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_10 = 3 <= 0 and var_429_6 or var_429_6 * (utf8.len(var_429_8) / 3)

				if (3 <= 0 and var_429_6 or var_429_6 * (utf8.len(var_429_8) / 3)) > 0 and var_429_6 < var_429_10 then
					arg_426_1.talkMaxDuration = var_429_10

					if var_429_10 + var_429_5 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_10 + var_429_5
					end
				end

				arg_426_1.text_.text = var_429_8
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191102", "story_v_out_417191.awb") ~= 0 then
					local var_429_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191102", "story_v_out_417191.awb") / 1000

					if var_429_11 + var_429_5 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_11 + var_429_5
					end

					if var_429_7.prefab_name ~= "" and arg_426_1.actors_[var_429_7.prefab_name] ~= nil then
						local var_429_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_7.prefab_name].transform, "story_v_out_417191", "417191102", "story_v_out_417191.awb")

						arg_426_1:RecordAudio("417191102", var_429_12)
						arg_426_1:RecordAudio("417191102", var_429_12)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_417191", "417191102", "story_v_out_417191.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_417191", "417191102", "story_v_out_417191.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_13 = math.max(var_429_6, arg_426_1.talkMaxDuration)

			if var_429_5 <= arg_426_1.time_ and arg_426_1.time_ < var_429_5 + var_429_13 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_5) / var_429_13

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_5 + var_429_13 and arg_426_1.time_ < var_429_5 + var_429_13 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play417191103 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 417191103
		arg_430_1.duration_ = 8.03

		local var_430_0 = {
			zh = 5.533,
			ja = 8.033
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play417191104(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(arg_430_1.actors_["10128"]) and arg_430_1.var_.actorSpriteComps10128 == nil then
				arg_430_1.var_.actorSpriteComps10128 = arg_430_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_433_0 = 0.2

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 and not isNil(arg_430_1.actors_["10128"]) then
				if arg_430_1.var_.actorSpriteComps10128 then
					for iter_433_0, iter_433_1 in pairs(arg_430_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_433_1 then
							if arg_430_1.isInRecall_ then
								iter_433_1.color = Color.New(Mathf.Lerp(iter_433_1.color.r, arg_430_1.hightColor1.r, (arg_430_1.time_ - 0) / var_433_0), Mathf.Lerp(iter_433_1.color.g, arg_430_1.hightColor1.g, (arg_430_1.time_ - 0) / var_433_0), (Mathf.Lerp(iter_433_1.color.b, arg_430_1.hightColor1.b, (arg_430_1.time_ - 0) / var_433_0)))
							else
								local var_433_1 = Mathf.Lerp(iter_433_1.color.r, 1, (arg_430_1.time_ - 0) / var_433_0)

								iter_433_1.color = Color.New(var_433_1, var_433_1, var_433_1)
							end
						end
					end
				end
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 and not isNil(arg_430_1.actors_["10128"]) and arg_430_1.var_.actorSpriteComps10128 then
				for iter_433_2, iter_433_3 in pairs(arg_430_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_433_3 then
						iter_433_3.color = arg_430_1.isInRecall_ and (arg_430_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_430_1.var_.actorSpriteComps10128 = nil
			end

			local var_433_2 = arg_430_1.actors_["1060"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_2) and arg_430_1.var_.actorSpriteComps1060 == nil then
				arg_430_1.var_.actorSpriteComps1060 = var_433_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_433_3 = 0.2

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_3 and not isNil(var_433_2) then
				if arg_430_1.var_.actorSpriteComps1060 then
					for iter_433_4, iter_433_5 in pairs(arg_430_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_433_5 then
							if arg_430_1.isInRecall_ then
								iter_433_5.color = Color.New(Mathf.Lerp(iter_433_5.color.r, arg_430_1.hightColor2.r, (arg_430_1.time_ - 0) / var_433_3), Mathf.Lerp(iter_433_5.color.g, arg_430_1.hightColor2.g, (arg_430_1.time_ - 0) / var_433_3), (Mathf.Lerp(iter_433_5.color.b, arg_430_1.hightColor2.b, (arg_430_1.time_ - 0) / var_433_3)))
							else
								local var_433_4 = Mathf.Lerp(iter_433_5.color.r, 0.5, (arg_430_1.time_ - 0) / var_433_3)

								iter_433_5.color = Color.New(var_433_4, var_433_4, var_433_4)
							end
						end
					end
				end
			end

			if arg_430_1.time_ >= 0 + var_433_3 and arg_430_1.time_ < 0 + var_433_3 + arg_433_0 and not isNil(var_433_2) and arg_430_1.var_.actorSpriteComps1060 then
				for iter_433_6, iter_433_7 in pairs(arg_430_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_433_7 then
						iter_433_7.color = arg_430_1.isInRecall_ and (arg_430_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_430_1.var_.actorSpriteComps1060 = nil
			end

			local var_433_5 = 0
			local var_433_6 = 0.725

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_5 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_7 = arg_430_1:GetWordFromCfg(417191103)
				local var_433_8 = arg_430_1:FormatText(var_433_7.content)

				arg_430_1.text_.text = var_433_8

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_10 = 29 <= 0 and var_433_6 or var_433_6 * (utf8.len(var_433_8) / 29)

				if (29 <= 0 and var_433_6 or var_433_6 * (utf8.len(var_433_8) / 29)) > 0 and var_433_6 < var_433_10 then
					arg_430_1.talkMaxDuration = var_433_10

					if var_433_10 + var_433_5 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_10 + var_433_5
					end
				end

				arg_430_1.text_.text = var_433_8
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191103", "story_v_out_417191.awb") ~= 0 then
					local var_433_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191103", "story_v_out_417191.awb") / 1000

					if var_433_11 + var_433_5 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_11 + var_433_5
					end

					if var_433_7.prefab_name ~= "" and arg_430_1.actors_[var_433_7.prefab_name] ~= nil then
						local var_433_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_7.prefab_name].transform, "story_v_out_417191", "417191103", "story_v_out_417191.awb")

						arg_430_1:RecordAudio("417191103", var_433_12)
						arg_430_1:RecordAudio("417191103", var_433_12)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_417191", "417191103", "story_v_out_417191.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_417191", "417191103", "story_v_out_417191.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_13 = math.max(var_433_6, arg_430_1.talkMaxDuration)

			if var_433_5 <= arg_430_1.time_ and arg_430_1.time_ < var_433_5 + var_433_13 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_5) / var_433_13

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_5 + var_433_13 and arg_430_1.time_ < var_433_5 + var_433_13 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play417191104 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 417191104
		arg_434_1.duration_ = 5.6

		local var_434_0 = {
			zh = 4.666,
			ja = 5.6
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play417191105(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(arg_434_1.actors_["1060"]) and arg_434_1.var_.actorSpriteComps1060 == nil then
				arg_434_1.var_.actorSpriteComps1060 = arg_434_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_437_0 = 0.2

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 and not isNil(arg_434_1.actors_["1060"]) then
				if arg_434_1.var_.actorSpriteComps1060 then
					for iter_437_0, iter_437_1 in pairs(arg_434_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_437_1 then
							if arg_434_1.isInRecall_ then
								iter_437_1.color = Color.New(Mathf.Lerp(iter_437_1.color.r, arg_434_1.hightColor1.r, (arg_434_1.time_ - 0) / var_437_0), Mathf.Lerp(iter_437_1.color.g, arg_434_1.hightColor1.g, (arg_434_1.time_ - 0) / var_437_0), (Mathf.Lerp(iter_437_1.color.b, arg_434_1.hightColor1.b, (arg_434_1.time_ - 0) / var_437_0)))
							else
								local var_437_1 = Mathf.Lerp(iter_437_1.color.r, 1, (arg_434_1.time_ - 0) / var_437_0)

								iter_437_1.color = Color.New(var_437_1, var_437_1, var_437_1)
							end
						end
					end
				end
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 and not isNil(arg_434_1.actors_["1060"]) and arg_434_1.var_.actorSpriteComps1060 then
				for iter_437_2, iter_437_3 in pairs(arg_434_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_437_3 then
						iter_437_3.color = arg_434_1.isInRecall_ and (arg_434_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_434_1.var_.actorSpriteComps1060 = nil
			end

			local var_437_2 = arg_434_1.actors_["10128"]

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(var_437_2) and arg_434_1.var_.actorSpriteComps10128 == nil then
				arg_434_1.var_.actorSpriteComps10128 = var_437_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_437_3 = 0.2

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_3 and not isNil(var_437_2) then
				if arg_434_1.var_.actorSpriteComps10128 then
					for iter_437_4, iter_437_5 in pairs(arg_434_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_437_5 then
							if arg_434_1.isInRecall_ then
								iter_437_5.color = Color.New(Mathf.Lerp(iter_437_5.color.r, arg_434_1.hightColor2.r, (arg_434_1.time_ - 0) / var_437_3), Mathf.Lerp(iter_437_5.color.g, arg_434_1.hightColor2.g, (arg_434_1.time_ - 0) / var_437_3), (Mathf.Lerp(iter_437_5.color.b, arg_434_1.hightColor2.b, (arg_434_1.time_ - 0) / var_437_3)))
							else
								local var_437_4 = Mathf.Lerp(iter_437_5.color.r, 0.5, (arg_434_1.time_ - 0) / var_437_3)

								iter_437_5.color = Color.New(var_437_4, var_437_4, var_437_4)
							end
						end
					end
				end
			end

			if arg_434_1.time_ >= 0 + var_437_3 and arg_434_1.time_ < 0 + var_437_3 + arg_437_0 and not isNil(var_437_2) and arg_434_1.var_.actorSpriteComps10128 then
				for iter_437_6, iter_437_7 in pairs(arg_434_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_437_7 then
						iter_437_7.color = arg_434_1.isInRecall_ and (arg_434_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_434_1.var_.actorSpriteComps10128 = nil
			end

			local var_437_5 = 0
			local var_437_6 = 0.3

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_5 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_7 = arg_434_1:GetWordFromCfg(417191104)
				local var_437_8 = arg_434_1:FormatText(var_437_7.content)

				arg_434_1.text_.text = var_437_8

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_10 = 12 <= 0 and var_437_6 or var_437_6 * (utf8.len(var_437_8) / 12)

				if (12 <= 0 and var_437_6 or var_437_6 * (utf8.len(var_437_8) / 12)) > 0 and var_437_6 < var_437_10 then
					arg_434_1.talkMaxDuration = var_437_10

					if var_437_10 + var_437_5 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_10 + var_437_5
					end
				end

				arg_434_1.text_.text = var_437_8
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191104", "story_v_out_417191.awb") ~= 0 then
					local var_437_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191104", "story_v_out_417191.awb") / 1000

					if var_437_11 + var_437_5 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_11 + var_437_5
					end

					if var_437_7.prefab_name ~= "" and arg_434_1.actors_[var_437_7.prefab_name] ~= nil then
						local var_437_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_7.prefab_name].transform, "story_v_out_417191", "417191104", "story_v_out_417191.awb")

						arg_434_1:RecordAudio("417191104", var_437_12)
						arg_434_1:RecordAudio("417191104", var_437_12)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_417191", "417191104", "story_v_out_417191.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_417191", "417191104", "story_v_out_417191.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_13 = math.max(var_437_6, arg_434_1.talkMaxDuration)

			if var_437_5 <= arg_434_1.time_ and arg_434_1.time_ < var_437_5 + var_437_13 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_5) / var_437_13

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_5 + var_437_13 and arg_434_1.time_ < var_437_5 + var_437_13 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play417191105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 417191105
		arg_438_1.duration_ = 6.63

		local var_438_0 = {
			zh = 3.866,
			ja = 6.633
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play417191106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(arg_438_1.actors_["10128"]) and arg_438_1.var_.actorSpriteComps10128 == nil then
				arg_438_1.var_.actorSpriteComps10128 = arg_438_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_0 = 0.2

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 and not isNil(arg_438_1.actors_["10128"]) then
				if arg_438_1.var_.actorSpriteComps10128 then
					for iter_441_0, iter_441_1 in pairs(arg_438_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_441_1 then
							if arg_438_1.isInRecall_ then
								iter_441_1.color = Color.New(Mathf.Lerp(iter_441_1.color.r, arg_438_1.hightColor1.r, (arg_438_1.time_ - 0) / var_441_0), Mathf.Lerp(iter_441_1.color.g, arg_438_1.hightColor1.g, (arg_438_1.time_ - 0) / var_441_0), (Mathf.Lerp(iter_441_1.color.b, arg_438_1.hightColor1.b, (arg_438_1.time_ - 0) / var_441_0)))
							else
								local var_441_1 = Mathf.Lerp(iter_441_1.color.r, 1, (arg_438_1.time_ - 0) / var_441_0)

								iter_441_1.color = Color.New(var_441_1, var_441_1, var_441_1)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 and not isNil(arg_438_1.actors_["10128"]) and arg_438_1.var_.actorSpriteComps10128 then
				for iter_441_2, iter_441_3 in pairs(arg_438_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_441_3 then
						iter_441_3.color = arg_438_1.isInRecall_ and (arg_438_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_438_1.var_.actorSpriteComps10128 = nil
			end

			local var_441_2 = arg_438_1.actors_["1060"]

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(var_441_2) and arg_438_1.var_.actorSpriteComps1060 == nil then
				arg_438_1.var_.actorSpriteComps1060 = var_441_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_3 = 0.2

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_3 and not isNil(var_441_2) then
				if arg_438_1.var_.actorSpriteComps1060 then
					for iter_441_4, iter_441_5 in pairs(arg_438_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_441_5 then
							if arg_438_1.isInRecall_ then
								iter_441_5.color = Color.New(Mathf.Lerp(iter_441_5.color.r, arg_438_1.hightColor2.r, (arg_438_1.time_ - 0) / var_441_3), Mathf.Lerp(iter_441_5.color.g, arg_438_1.hightColor2.g, (arg_438_1.time_ - 0) / var_441_3), (Mathf.Lerp(iter_441_5.color.b, arg_438_1.hightColor2.b, (arg_438_1.time_ - 0) / var_441_3)))
							else
								local var_441_4 = Mathf.Lerp(iter_441_5.color.r, 0.5, (arg_438_1.time_ - 0) / var_441_3)

								iter_441_5.color = Color.New(var_441_4, var_441_4, var_441_4)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= 0 + var_441_3 and arg_438_1.time_ < 0 + var_441_3 + arg_441_0 and not isNil(var_441_2) and arg_438_1.var_.actorSpriteComps1060 then
				for iter_441_6, iter_441_7 in pairs(arg_438_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_441_7 then
						iter_441_7.color = arg_438_1.isInRecall_ and (arg_438_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_438_1.var_.actorSpriteComps1060 = nil
			end

			local var_441_5 = 0
			local var_441_6 = 0.5

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_5 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_7 = arg_438_1:GetWordFromCfg(417191105)
				local var_441_8 = arg_438_1:FormatText(var_441_7.content)

				arg_438_1.text_.text = var_441_8

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_10 = 20 <= 0 and var_441_6 or var_441_6 * (utf8.len(var_441_8) / 20)

				if (20 <= 0 and var_441_6 or var_441_6 * (utf8.len(var_441_8) / 20)) > 0 and var_441_6 < var_441_10 then
					arg_438_1.talkMaxDuration = var_441_10

					if var_441_10 + var_441_5 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_10 + var_441_5
					end
				end

				arg_438_1.text_.text = var_441_8
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191105", "story_v_out_417191.awb") ~= 0 then
					local var_441_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191105", "story_v_out_417191.awb") / 1000

					if var_441_11 + var_441_5 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_11 + var_441_5
					end

					if var_441_7.prefab_name ~= "" and arg_438_1.actors_[var_441_7.prefab_name] ~= nil then
						local var_441_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_7.prefab_name].transform, "story_v_out_417191", "417191105", "story_v_out_417191.awb")

						arg_438_1:RecordAudio("417191105", var_441_12)
						arg_438_1:RecordAudio("417191105", var_441_12)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_417191", "417191105", "story_v_out_417191.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_417191", "417191105", "story_v_out_417191.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_13 = math.max(var_441_6, arg_438_1.talkMaxDuration)

			if var_441_5 <= arg_438_1.time_ and arg_438_1.time_ < var_441_5 + var_441_13 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_5) / var_441_13

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_5 + var_441_13 and arg_438_1.time_ < var_441_5 + var_441_13 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play417191106 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 417191106
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play417191107(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(arg_442_1.actors_["10128"]) and arg_442_1.var_.actorSpriteComps10128 == nil then
				arg_442_1.var_.actorSpriteComps10128 = arg_442_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_0 = 0.2

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 and not isNil(arg_442_1.actors_["10128"]) then
				if arg_442_1.var_.actorSpriteComps10128 then
					for iter_445_0, iter_445_1 in pairs(arg_442_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_445_1 then
							if arg_442_1.isInRecall_ then
								iter_445_1.color = Color.New(Mathf.Lerp(iter_445_1.color.r, arg_442_1.hightColor2.r, (arg_442_1.time_ - 0) / var_445_0), Mathf.Lerp(iter_445_1.color.g, arg_442_1.hightColor2.g, (arg_442_1.time_ - 0) / var_445_0), (Mathf.Lerp(iter_445_1.color.b, arg_442_1.hightColor2.b, (arg_442_1.time_ - 0) / var_445_0)))
							else
								local var_445_1 = Mathf.Lerp(iter_445_1.color.r, 0.5, (arg_442_1.time_ - 0) / var_445_0)

								iter_445_1.color = Color.New(var_445_1, var_445_1, var_445_1)
							end
						end
					end
				end
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 and not isNil(arg_442_1.actors_["10128"]) and arg_442_1.var_.actorSpriteComps10128 then
				for iter_445_2, iter_445_3 in pairs(arg_442_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_445_3 then
						iter_445_3.color = arg_442_1.isInRecall_ and (arg_442_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_442_1.var_.actorSpriteComps10128 = nil
			end

			if 1 < arg_442_1.time_ and arg_442_1.time_ <= 1 + arg_445_0 then
				arg_442_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_clap01", "")
			end

			local var_445_3 = 0
			local var_445_4 = 1.025

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_3 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, false)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_5 = arg_442_1:FormatText(arg_442_1:GetWordFromCfg(417191106).content)

				arg_442_1.text_.text = var_445_5

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_7 = 41 <= 0 and var_445_4 or var_445_4 * (utf8.len(var_445_5) / 41)

				if (41 <= 0 and var_445_4 or var_445_4 * (utf8.len(var_445_5) / 41)) > 0 and var_445_4 < var_445_7 then
					arg_442_1.talkMaxDuration = var_445_7

					if var_445_7 + var_445_3 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_7 + var_445_3
					end
				end

				arg_442_1.text_.text = var_445_5
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_8 = math.max(var_445_4, arg_442_1.talkMaxDuration)

			if var_445_3 <= arg_442_1.time_ and arg_442_1.time_ < var_445_3 + var_445_8 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_3) / var_445_8

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_3 + var_445_8 and arg_442_1.time_ < var_445_3 + var_445_8 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play417191107 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 417191107
		arg_446_1.duration_ = 6.77

		local var_446_0 = {
			zh = 5.733,
			ja = 6.766
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play417191108(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(arg_446_1.actors_["10128"]) and arg_446_1.var_.actorSpriteComps10128 == nil then
				arg_446_1.var_.actorSpriteComps10128 = arg_446_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_0 = 0.2

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 and not isNil(arg_446_1.actors_["10128"]) then
				if arg_446_1.var_.actorSpriteComps10128 then
					for iter_449_0, iter_449_1 in pairs(arg_446_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_449_1 then
							if arg_446_1.isInRecall_ then
								iter_449_1.color = Color.New(Mathf.Lerp(iter_449_1.color.r, arg_446_1.hightColor1.r, (arg_446_1.time_ - 0) / var_449_0), Mathf.Lerp(iter_449_1.color.g, arg_446_1.hightColor1.g, (arg_446_1.time_ - 0) / var_449_0), (Mathf.Lerp(iter_449_1.color.b, arg_446_1.hightColor1.b, (arg_446_1.time_ - 0) / var_449_0)))
							else
								local var_449_1 = Mathf.Lerp(iter_449_1.color.r, 1, (arg_446_1.time_ - 0) / var_449_0)

								iter_449_1.color = Color.New(var_449_1, var_449_1, var_449_1)
							end
						end
					end
				end
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 and not isNil(arg_446_1.actors_["10128"]) and arg_446_1.var_.actorSpriteComps10128 then
				for iter_449_2, iter_449_3 in pairs(arg_446_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_449_3 then
						iter_449_3.color = arg_446_1.isInRecall_ and (arg_446_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_446_1.var_.actorSpriteComps10128 = nil
			end

			local var_449_2 = 0
			local var_449_3 = 0.8

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_2 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_4 = arg_446_1:GetWordFromCfg(417191107)
				local var_449_5 = arg_446_1:FormatText(var_449_4.content)

				arg_446_1.text_.text = var_449_5

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_7 = 32 <= 0 and var_449_3 or var_449_3 * (utf8.len(var_449_5) / 32)

				if (32 <= 0 and var_449_3 or var_449_3 * (utf8.len(var_449_5) / 32)) > 0 and var_449_3 < var_449_7 then
					arg_446_1.talkMaxDuration = var_449_7

					if var_449_7 + var_449_2 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_7 + var_449_2
					end
				end

				arg_446_1.text_.text = var_449_5
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191107", "story_v_out_417191.awb") ~= 0 then
					local var_449_8 = manager.audio:GetVoiceLength("story_v_out_417191", "417191107", "story_v_out_417191.awb") / 1000

					if var_449_8 + var_449_2 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_8 + var_449_2
					end

					if var_449_4.prefab_name ~= "" and arg_446_1.actors_[var_449_4.prefab_name] ~= nil then
						local var_449_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_4.prefab_name].transform, "story_v_out_417191", "417191107", "story_v_out_417191.awb")

						arg_446_1:RecordAudio("417191107", var_449_9)
						arg_446_1:RecordAudio("417191107", var_449_9)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_417191", "417191107", "story_v_out_417191.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_417191", "417191107", "story_v_out_417191.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_10 = math.max(var_449_3, arg_446_1.talkMaxDuration)

			if var_449_2 <= arg_446_1.time_ and arg_446_1.time_ < var_449_2 + var_449_10 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_2) / var_449_10

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_2 + var_449_10 and arg_446_1.time_ < var_449_2 + var_449_10 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play417191108 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 417191108
		arg_450_1.duration_ = 10.77

		local var_450_0 = {
			zh = 9.3,
			ja = 10.766
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
				arg_450_0:Play417191109(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 1.175

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_1 = arg_450_1:GetWordFromCfg(417191108)
				local var_453_2 = arg_450_1:FormatText(var_453_1.content)

				arg_450_1.text_.text = var_453_2

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_4 = 47 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 47)

				if (47 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 47)) > 0 and var_453_0 < var_453_4 then
					arg_450_1.talkMaxDuration = var_453_4

					if var_453_4 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_4 + 0
					end
				end

				arg_450_1.text_.text = var_453_2
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191108", "story_v_out_417191.awb") ~= 0 then
					local var_453_5 = manager.audio:GetVoiceLength("story_v_out_417191", "417191108", "story_v_out_417191.awb") / 1000

					if var_453_5 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + 0
					end

					if var_453_1.prefab_name ~= "" and arg_450_1.actors_[var_453_1.prefab_name] ~= nil then
						local var_453_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_1.prefab_name].transform, "story_v_out_417191", "417191108", "story_v_out_417191.awb")

						arg_450_1:RecordAudio("417191108", var_453_6)
						arg_450_1:RecordAudio("417191108", var_453_6)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_417191", "417191108", "story_v_out_417191.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_417191", "417191108", "story_v_out_417191.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_7 = math.max(var_453_0, arg_450_1.talkMaxDuration)

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_7 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - 0) / var_453_7

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= 0 + var_453_7 and arg_450_1.time_ < 0 + var_453_7 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play417191109 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 417191109
		arg_454_1.duration_ = 4.07

		local var_454_0 = {
			zh = 2.2,
			ja = 4.066
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play417191110(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(arg_454_1.actors_["1060"]) and arg_454_1.var_.actorSpriteComps1060 == nil then
				arg_454_1.var_.actorSpriteComps1060 = arg_454_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_457_0 = 0.2

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 and not isNil(arg_454_1.actors_["1060"]) then
				if arg_454_1.var_.actorSpriteComps1060 then
					for iter_457_0, iter_457_1 in pairs(arg_454_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_457_1 then
							if arg_454_1.isInRecall_ then
								iter_457_1.color = Color.New(Mathf.Lerp(iter_457_1.color.r, arg_454_1.hightColor1.r, (arg_454_1.time_ - 0) / var_457_0), Mathf.Lerp(iter_457_1.color.g, arg_454_1.hightColor1.g, (arg_454_1.time_ - 0) / var_457_0), (Mathf.Lerp(iter_457_1.color.b, arg_454_1.hightColor1.b, (arg_454_1.time_ - 0) / var_457_0)))
							else
								local var_457_1 = Mathf.Lerp(iter_457_1.color.r, 1, (arg_454_1.time_ - 0) / var_457_0)

								iter_457_1.color = Color.New(var_457_1, var_457_1, var_457_1)
							end
						end
					end
				end
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 and not isNil(arg_454_1.actors_["1060"]) and arg_454_1.var_.actorSpriteComps1060 then
				for iter_457_2, iter_457_3 in pairs(arg_454_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_457_3 then
						iter_457_3.color = arg_454_1.isInRecall_ and (arg_454_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_454_1.var_.actorSpriteComps1060 = nil
			end

			local var_457_2 = arg_454_1.actors_["10128"]

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(var_457_2) and arg_454_1.var_.actorSpriteComps10128 == nil then
				arg_454_1.var_.actorSpriteComps10128 = var_457_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_457_3 = 0.2

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_3 and not isNil(var_457_2) then
				if arg_454_1.var_.actorSpriteComps10128 then
					for iter_457_4, iter_457_5 in pairs(arg_454_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_457_5 then
							if arg_454_1.isInRecall_ then
								iter_457_5.color = Color.New(Mathf.Lerp(iter_457_5.color.r, arg_454_1.hightColor2.r, (arg_454_1.time_ - 0) / var_457_3), Mathf.Lerp(iter_457_5.color.g, arg_454_1.hightColor2.g, (arg_454_1.time_ - 0) / var_457_3), (Mathf.Lerp(iter_457_5.color.b, arg_454_1.hightColor2.b, (arg_454_1.time_ - 0) / var_457_3)))
							else
								local var_457_4 = Mathf.Lerp(iter_457_5.color.r, 0.5, (arg_454_1.time_ - 0) / var_457_3)

								iter_457_5.color = Color.New(var_457_4, var_457_4, var_457_4)
							end
						end
					end
				end
			end

			if arg_454_1.time_ >= 0 + var_457_3 and arg_454_1.time_ < 0 + var_457_3 + arg_457_0 and not isNil(var_457_2) and arg_454_1.var_.actorSpriteComps10128 then
				for iter_457_6, iter_457_7 in pairs(arg_454_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_457_7 then
						iter_457_7.color = arg_454_1.isInRecall_ and (arg_454_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_454_1.var_.actorSpriteComps10128 = nil
			end

			local var_457_5 = 0
			local var_457_6 = 0.35

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_5 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_7 = arg_454_1:GetWordFromCfg(417191109)
				local var_457_8 = arg_454_1:FormatText(var_457_7.content)

				arg_454_1.text_.text = var_457_8

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_10 = 14 <= 0 and var_457_6 or var_457_6 * (utf8.len(var_457_8) / 14)

				if (14 <= 0 and var_457_6 or var_457_6 * (utf8.len(var_457_8) / 14)) > 0 and var_457_6 < var_457_10 then
					arg_454_1.talkMaxDuration = var_457_10

					if var_457_10 + var_457_5 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_10 + var_457_5
					end
				end

				arg_454_1.text_.text = var_457_8
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191109", "story_v_out_417191.awb") ~= 0 then
					local var_457_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191109", "story_v_out_417191.awb") / 1000

					if var_457_11 + var_457_5 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_11 + var_457_5
					end

					if var_457_7.prefab_name ~= "" and arg_454_1.actors_[var_457_7.prefab_name] ~= nil then
						local var_457_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_7.prefab_name].transform, "story_v_out_417191", "417191109", "story_v_out_417191.awb")

						arg_454_1:RecordAudio("417191109", var_457_12)
						arg_454_1:RecordAudio("417191109", var_457_12)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_417191", "417191109", "story_v_out_417191.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_417191", "417191109", "story_v_out_417191.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_13 = math.max(var_457_6, arg_454_1.talkMaxDuration)

			if var_457_5 <= arg_454_1.time_ and arg_454_1.time_ < var_457_5 + var_457_13 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_5) / var_457_13

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_5 + var_457_13 and arg_454_1.time_ < var_457_5 + var_457_13 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play417191110 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 417191110
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play417191111(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.var_.moveOldPos1060 = arg_458_1.actors_["1060"].transform.localPosition
				arg_458_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_458_1:CheckSpriteTmpPos("1060", 7)

				for iter_461_0 = 0, arg_458_1.actors_["1060"].transform.childCount - 1 do
					local var_461_0 = arg_458_1.actors_["1060"].transform:GetChild(iter_461_0)

					if var_461_0.name == "" or not string.find(var_461_0.name, "split") then
						var_461_0.gameObject:SetActive(true)
					else
						var_461_0.gameObject:SetActive(false)
					end
				end
			end

			local var_461_1 = 0.001

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_1 then
				arg_458_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_458_1.time_ - 0) / var_461_1)
			end

			if arg_458_1.time_ >= 0 + var_461_1 and arg_458_1.time_ < 0 + var_461_1 + arg_461_0 then
				arg_458_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_461_2 = arg_458_1.actors_["10128"].transform

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.var_.moveOldPos10128 = var_461_2.localPosition
				var_461_2.localScale = Vector3.New(1, 1, 1)

				arg_458_1:CheckSpriteTmpPos("10128", 7)

				for iter_461_1 = 0, var_461_2.childCount - 1 do
					local var_461_3 = var_461_2:GetChild(iter_461_1)

					if var_461_3.name == "" or not string.find(var_461_3.name, "split") then
						var_461_3.gameObject:SetActive(true)
					else
						var_461_3.gameObject:SetActive(false)
					end
				end
			end

			local var_461_4 = 0.001

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_4 then
				var_461_2.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_458_1.time_ - 0) / var_461_4)
			end

			if arg_458_1.time_ >= 0 + var_461_4 and arg_458_1.time_ < 0 + var_461_4 + arg_461_0 then
				var_461_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_461_5 = 0
			local var_461_6 = 0.575

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_5 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_7 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(417191110).content)

				arg_458_1.text_.text = var_461_7

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_9 = 23 <= 0 and var_461_6 or var_461_6 * (utf8.len(var_461_7) / 23)

				if (23 <= 0 and var_461_6 or var_461_6 * (utf8.len(var_461_7) / 23)) > 0 and var_461_6 < var_461_9 then
					arg_458_1.talkMaxDuration = var_461_9

					if var_461_9 + var_461_5 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_9 + var_461_5
					end
				end

				arg_458_1.text_.text = var_461_7
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_10 = math.max(var_461_6, arg_458_1.talkMaxDuration)

			if var_461_5 <= arg_458_1.time_ and arg_458_1.time_ < var_461_5 + var_461_10 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_5) / var_461_10

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_5 + var_461_10 and arg_458_1.time_ < var_461_5 + var_461_10 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
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
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play417191111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 417191111
		arg_462_1.duration_ = 4.7

		local var_462_0 = {
			zh = 4.7,
			ja = 3.6
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
			arg_462_1.auto_ = false
		end

		function arg_462_1.playNext_(arg_464_0)
			arg_462_1.onStoryFinished_()
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(arg_462_1.actors_["10128"]) and arg_462_1.var_.actorSpriteComps10128 == nil then
				arg_462_1.var_.actorSpriteComps10128 = arg_462_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_465_0 = 0.2

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 and not isNil(arg_462_1.actors_["10128"]) then
				if arg_462_1.var_.actorSpriteComps10128 then
					for iter_465_0, iter_465_1 in pairs(arg_462_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_465_1 then
							if arg_462_1.isInRecall_ then
								iter_465_1.color = Color.New(Mathf.Lerp(iter_465_1.color.r, arg_462_1.hightColor1.r, (arg_462_1.time_ - 0) / var_465_0), Mathf.Lerp(iter_465_1.color.g, arg_462_1.hightColor1.g, (arg_462_1.time_ - 0) / var_465_0), (Mathf.Lerp(iter_465_1.color.b, arg_462_1.hightColor1.b, (arg_462_1.time_ - 0) / var_465_0)))
							else
								local var_465_1 = Mathf.Lerp(iter_465_1.color.r, 1, (arg_462_1.time_ - 0) / var_465_0)

								iter_465_1.color = Color.New(var_465_1, var_465_1, var_465_1)
							end
						end
					end
				end
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 and not isNil(arg_462_1.actors_["10128"]) and arg_462_1.var_.actorSpriteComps10128 then
				for iter_465_2, iter_465_3 in pairs(arg_462_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_465_3 then
						iter_465_3.color = arg_462_1.isInRecall_ and (arg_462_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_462_1.var_.actorSpriteComps10128 = nil
			end

			local var_465_2 = arg_462_1.actors_["10128"].transform

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.var_.moveOldPos10128 = var_465_2.localPosition
				var_465_2.localScale = Vector3.New(1, 1, 1)

				arg_462_1:CheckSpriteTmpPos("10128", 3)

				for iter_465_4 = 0, var_465_2.childCount - 1 do
					local var_465_3 = var_465_2:GetChild(iter_465_4)

					if var_465_3.name == "" or not string.find(var_465_3.name, "split") then
						var_465_3.gameObject:SetActive(true)
					else
						var_465_3.gameObject:SetActive(false)
					end
				end
			end

			local var_465_4 = 0.001

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_4 then
				var_465_2.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_462_1.time_ - 0) / var_465_4)
			end

			if arg_462_1.time_ >= 0 + var_465_4 and arg_462_1.time_ < 0 + var_465_4 + arg_465_0 then
				var_465_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_465_5 = 0
			local var_465_6 = 0.3

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_5 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_7 = arg_462_1:GetWordFromCfg(417191111)
				local var_465_8 = arg_462_1:FormatText(var_465_7.content)

				arg_462_1.text_.text = var_465_8

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_10 = 12 <= 0 and var_465_6 or var_465_6 * (utf8.len(var_465_8) / 12)

				if (12 <= 0 and var_465_6 or var_465_6 * (utf8.len(var_465_8) / 12)) > 0 and var_465_6 < var_465_10 then
					arg_462_1.talkMaxDuration = var_465_10

					if var_465_10 + var_465_5 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_10 + var_465_5
					end
				end

				arg_462_1.text_.text = var_465_8
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417191", "417191111", "story_v_out_417191.awb") ~= 0 then
					local var_465_11 = manager.audio:GetVoiceLength("story_v_out_417191", "417191111", "story_v_out_417191.awb") / 1000

					if var_465_11 + var_465_5 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_11 + var_465_5
					end

					if var_465_7.prefab_name ~= "" and arg_462_1.actors_[var_465_7.prefab_name] ~= nil then
						local var_465_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_7.prefab_name].transform, "story_v_out_417191", "417191111", "story_v_out_417191.awb")

						arg_462_1:RecordAudio("417191111", var_465_12)
						arg_462_1:RecordAudio("417191111", var_465_12)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_417191", "417191111", "story_v_out_417191.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_417191", "417191111", "story_v_out_417191.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_13 = math.max(var_465_6, arg_462_1.talkMaxDuration)

			if var_465_5 <= arg_462_1.time_ and arg_462_1.time_ < var_465_5 + var_465_13 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_5) / var_465_13

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_5 + var_465_13 and arg_462_1.time_ < var_465_5 + var_465_13 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
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

		arg_462_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/I16g",
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/ST21",
		"TextureConfig/Background/SS1707",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST04b"
	},
	voices = {
		"story_v_out_417191.awb"
	}
}
