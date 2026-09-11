return {
	Play417171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417171001
		arg_1_1.duration_ = 9.83

		local var_1_0 = {
			zh = 9.166,
			ja = 9.833
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
				arg_1_0:Play417171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 7.4 < arg_1_1.time_ and arg_1_1.time_ <= 7.4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 7.4 + 0.0666666666666667 and arg_1_1.time_ < 7.4 + 0.0666666666666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I16h")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501053).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501054).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_0 + 5 and arg_1_1.time_ < var_4_0 + 5 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_1 = 5

			if 5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_1 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_2 = 1.2

			if var_4_1 <= arg_1_1.time_ and arg_1_1.time_ < var_4_1 + var_4_2 then
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_1) / var_4_2)
				arg_1_1.mask_.color = var_4_3
			end

			if arg_1_1.time_ >= var_4_1 + var_4_2 and arg_1_1.time_ < var_4_1 + var_4_2 + arg_4_0 then
				local var_4_4 = Color.New(0, 0, 0)

				var_4_4.a = 1
				arg_1_1.mask_.color = var_4_4
			end

			local var_4_5 = 6.2

			if 6.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 1.2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "I16h"

			if arg_1_1.bgs_.I16h == nil then
				local var_4_10 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_9)
				var_4_10.name = var_4_9
				var_4_10.transform.parent = arg_1_1.stage_.transform
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_9] = var_4_10
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_11 = arg_1_1.bgs_.I16h

				arg_1_1.bgs_.I16h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = 2 * (var_4_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_11.transform.localScale = Vector3.New(var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I16h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_14 = "10128"

			if arg_1_1.actors_["10128"] == nil then
				local var_4_15 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

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

			if 7.06666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 7.06666666666667 + arg_4_0 then
				local var_4_17 = arg_1_1.actors_["10128"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_17 then
					arg_1_1.var_.alphaOldValue10128 = var_4_17.alpha
					arg_1_1.var_.characterEffect10128 = var_4_17
				end

				arg_1_1.var_.alphaOldValue10128 = 0
			end

			local var_4_18 = 0.333333333333333

			if 7.06666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 7.06666666666667 + var_4_18 then
				if arg_1_1.var_.characterEffect10128 then
					arg_1_1.var_.characterEffect10128.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10128, 1, (arg_1_1.time_ - 7.06666666666667) / var_4_18)
				end
			end

			if arg_1_1.time_ >= 7.06666666666667 + var_4_18 and arg_1_1.time_ < 7.06666666666667 + var_4_18 + arg_4_0 and arg_1_1.var_.characterEffect10128 then
				arg_1_1.var_.characterEffect10128.alpha = 1
			end

			local var_4_19 = arg_1_1.actors_["10128"]

			if 7.06666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 7.06666666666667 + arg_4_0 and not isNil(var_4_19) and arg_1_1.var_.actorSpriteComps10128 == nil then
				arg_1_1.var_.actorSpriteComps10128 = var_4_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_20 = 0.2

			if 7.06666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 7.06666666666667 + var_4_20 and not isNil(var_4_19) then
				if arg_1_1.var_.actorSpriteComps10128 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 7.06666666666667) / var_4_20), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 7.06666666666667) / var_4_20), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 7.06666666666667) / var_4_20)))
							else
								local var_4_21 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 7.06666666666667) / var_4_20)

								iter_4_5.color = Color.New(var_4_21, var_4_21, var_4_21)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 7.06666666666667 + var_4_20 and arg_1_1.time_ < 7.06666666666667 + var_4_20 + arg_4_0 and not isNil(var_4_19) and arg_1_1.var_.actorSpriteComps10128 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10128 = nil
			end

			local var_4_22 = arg_1_1.actors_["10128"].transform

			if 7.06666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 7.06666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos10128 = var_4_22.localPosition
				var_4_22.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10128", 3)

				for iter_4_8 = 0, var_4_22.childCount - 1 do
					local var_4_23 = var_4_22:GetChild(iter_4_8)

					if var_4_23.name == "" or not string.find(var_4_23.name, "split") then
						var_4_23.gameObject:SetActive(true)
					else
						var_4_23.gameObject:SetActive(false)
					end
				end
			end

			local var_4_24 = 0.001

			if 7.06666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 7.06666666666667 + var_4_24 then
				var_4_22.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_1_1.time_ - 7.06666666666667) / var_4_24)
			end

			if arg_1_1.time_ >= 7.06666666666667 + var_4_24 and arg_1_1.time_ < 7.06666666666667 + var_4_24 + arg_4_0 then
				var_4_22.localPosition = Vector3.New(0, -347, -300)
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

			if 5.4 < arg_1_1.time_ and arg_1_1.time_ <= 5.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_4_34 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

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
			local var_4_36 = 0.15

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_38 = arg_1_1:GetWordFromCfg(417171001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 6 <= 0 and var_4_36 or var_4_36 * (utf8.len(var_4_39) / 6)

				if (6 <= 0 and var_4_36 or var_4_36 * (utf8.len(var_4_39) / 6)) > 0 and var_4_36 < var_4_41 then
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

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171001", "story_v_out_417171.awb") ~= 0 then
					local var_4_42 = manager.audio:GetVoiceLength("story_v_out_417171", "417171001", "story_v_out_417171.awb") / 1000

					if var_4_42 + var_4_35 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_35
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_417171", "417171001", "story_v_out_417171.awb")

						arg_1_1:RecordAudio("417171001", var_4_43)
						arg_1_1:RecordAudio("417171001", var_4_43)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417171", "417171001", "story_v_out_417171.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417171", "417171001", "story_v_out_417171.awb")
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
				actorName = "10128",
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
	Play417171002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417171002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417171003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos10128 = arg_10_1.actors_["10128"].transform.localPosition
				arg_10_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("10128", 7)

				for iter_13_0 = 0, arg_10_1.actors_["10128"].transform.childCount - 1 do
					local var_13_0 = arg_10_1.actors_["10128"].transform:GetChild(iter_13_0)

					if var_13_0.name == "" or not string.find(var_13_0.name, "split") then
						var_13_0.gameObject:SetActive(true)
					else
						var_13_0.gameObject:SetActive(false)
					end
				end
			end

			local var_13_1 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_1 then
				arg_10_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_10_1.time_ - 0) / var_13_1)
			end

			if arg_10_1.time_ >= 0 + var_13_1 and arg_10_1.time_ < 0 + var_13_1 + arg_13_0 then
				arg_10_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_13_2 = 0
			local var_13_3 = 1.325

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_2 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_4 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(417171002).content)

				arg_10_1.text_.text = var_13_4

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_6 = 53 <= 0 and var_13_3 or var_13_3 * (utf8.len(var_13_4) / 53)

				if (53 <= 0 and var_13_3 or var_13_3 * (utf8.len(var_13_4) / 53)) > 0 and var_13_3 < var_13_6 then
					arg_10_1.talkMaxDuration = var_13_6

					if var_13_6 + var_13_2 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_6 + var_13_2
					end
				end

				arg_10_1.text_.text = var_13_4
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_7 = math.max(var_13_3, arg_10_1.talkMaxDuration)

			if var_13_2 <= arg_10_1.time_ and arg_10_1.time_ < var_13_2 + var_13_7 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_2) / var_13_7

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_2 + var_13_7 and arg_10_1.time_ < var_13_2 + var_13_7 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
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

		arg_10_1:InitPlayNodeList()
	end,
	Play417171003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417171003
		arg_14_1.duration_ = 5.05

		local var_14_0 = {
			zh = 5.05,
			ja = 4.15
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
				arg_14_0:Play417171004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_0 = 0.5

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 then
				local var_17_1 = Color.New(0, 0, 0)

				var_17_1.a = Mathf.Lerp(0, 1, (arg_14_1.time_ - 0) / var_17_0)
				arg_14_1.mask_.color = var_17_1
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 then
				local var_17_2 = Color.New(0, 0, 0)

				var_17_2.a = 1
				arg_14_1.mask_.color = var_17_2
			end

			local var_17_3 = 0.5

			if 0.5 < arg_14_1.time_ and arg_14_1.time_ <= var_17_3 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_4 = 0.849999999999

			if var_17_3 <= arg_14_1.time_ and arg_14_1.time_ < var_17_3 + var_17_4 then
				local var_17_5 = Color.New(0, 0, 0)

				var_17_5.a = Mathf.Lerp(1, 0, (arg_14_1.time_ - var_17_3) / var_17_4)
				arg_14_1.mask_.color = var_17_5
			end

			if arg_14_1.time_ >= var_17_3 + var_17_4 and arg_14_1.time_ < var_17_3 + var_17_4 + arg_17_0 then
				local var_17_6 = Color.New(0, 0, 0)

				arg_14_1.mask_.enabled = false
				var_17_6.a = 0
				arg_14_1.mask_.color = var_17_6
			end

			if 0.5 < arg_14_1.time_ and arg_14_1.time_ <= 0.5 + arg_17_0 then
				local var_17_7 = arg_14_1.bgs_.I16h

				arg_14_1.bgs_.I16h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_17_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_17_8 = var_17_7:GetComponent("SpriteRenderer")

				if var_17_8 and var_17_8.sprite then
					local var_17_9 = 2 * (var_17_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_17_7.transform.localScale = Vector3.New(var_17_9 / var_17_8.sprite.bounds.size.y < var_17_9 * manager.ui.mainCameraCom_.aspect / var_17_8.sprite.bounds.size.x and var_17_9 * manager.ui.mainCameraCom_.aspect / var_17_8.sprite.bounds.size.x or var_17_9 / var_17_8.sprite.bounds.size.y, var_17_9 / var_17_8.sprite.bounds.size.y < var_17_9 * manager.ui.mainCameraCom_.aspect / var_17_8.sprite.bounds.size.x and var_17_9 * manager.ui.mainCameraCom_.aspect / var_17_8.sprite.bounds.size.x or var_17_9 / var_17_8.sprite.bounds.size.y, 0)
				end

				for iter_17_0, iter_17_1 in pairs(arg_14_1.bgs_) do
					if iter_17_0 ~= "I16h" then
						iter_17_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_17_10 = 0.5

			arg_14_1.isInRecall_ = true

			if var_17_10 < arg_14_1.time_ and arg_14_1.time_ <= var_17_10 + arg_17_0 then
				arg_14_1.screenFilterGo_:SetActive(true)

				arg_14_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_14_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_14_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_17_2, iter_17_3 in pairs(arg_14_1.actors_) do
					for iter_17_4, iter_17_5 in ipairs((iter_17_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_17_5.color = iter_17_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_17_11 = 0.0333333333333333

			if var_17_10 <= arg_14_1.time_ and arg_14_1.time_ < var_17_10 + var_17_11 then
				arg_14_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_14_1.time_ - var_17_10) / var_17_11)
			end

			if arg_14_1.time_ >= var_17_10 + var_17_11 and arg_14_1.time_ < var_17_10 + var_17_11 + arg_17_0 then
				arg_14_1.screenFilterEffect_.weight = 1
			end

			local var_17_12 = 1.35

			if 1.35 < arg_14_1.time_ and arg_14_1.time_ <= var_17_12 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			if arg_14_1.time_ >= var_17_12 + 0.216666666666666 and arg_14_1.time_ < var_17_12 + 0.216666666666666 + arg_17_0 then
				arg_14_1.allBtn_.enabled = true
			end

			if arg_14_1.frameCnt_ <= 1 then
				arg_14_1.dialog_:SetActive(false)
			end

			local var_17_13 = 1.35
			local var_17_14 = 0.35

			if 1.35 < arg_14_1.time_ and arg_14_1.time_ <= var_17_13 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				arg_14_1.dialog_:SetActive(true)

				arg_14_1.dialogCg_.alpha = 0

				local var_17_15 = LeanTween.value(arg_14_1.dialog_, 0, 1, 0.3)

				var_17_15:setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
					arg_14_1.dialogCg_.alpha = arg_18_0
				end))
				var_17_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_14_1.dialog_)
					var_17_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_14_1.duration_ = arg_14_1.duration_ + 0.3

				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_14_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_17_16 = arg_14_1:GetWordFromCfg(417171003)
				local var_17_17 = arg_14_1:FormatText(var_17_16.content)

				arg_14_1.text_.text = var_17_17

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_19 = 14 <= 0 and var_17_14 or var_17_14 * (utf8.len(var_17_17) / 14)

				if (14 <= 0 and var_17_14 or var_17_14 * (utf8.len(var_17_17) / 14)) > 0 and var_17_14 < var_17_19 then
					arg_14_1.talkMaxDuration = var_17_19
					var_17_13 = var_17_13 + 0.3

					if var_17_19 + var_17_13 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_19 + var_17_13
					end
				end

				arg_14_1.text_.text = var_17_17
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171003", "story_v_out_417171.awb") ~= 0 then
					local var_17_20 = manager.audio:GetVoiceLength("story_v_out_417171", "417171003", "story_v_out_417171.awb") / 1000

					if var_17_20 + var_17_13 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_20 + var_17_13
					end

					if var_17_16.prefab_name ~= "" and arg_14_1.actors_[var_17_16.prefab_name] ~= nil then
						local var_17_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_16.prefab_name].transform, "story_v_out_417171", "417171003", "story_v_out_417171.awb")

						arg_14_1:RecordAudio("417171003", var_17_21)
						arg_14_1:RecordAudio("417171003", var_17_21)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417171", "417171003", "story_v_out_417171.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417171", "417171003", "story_v_out_417171.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_22 = var_17_13 + 0.3
			local var_17_23 = math.max(var_17_14, arg_14_1.talkMaxDuration)

			if var_17_13 + 0.3 <= arg_14_1.time_ and arg_14_1.time_ < var_17_22 + var_17_23 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_22) / var_17_23

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_22 + var_17_23 and arg_14_1.time_ < var_17_22 + var_17_23 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417171004 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 417171004
		arg_20_1.duration_ = 10.1

		local var_20_0 = {
			zh = 8.433,
			ja = 10.1
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play417171005(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.775

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_20_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_23_1 = arg_20_1:GetWordFromCfg(417171004)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 31 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 31)

				if (31 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 31)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171004", "story_v_out_417171.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_417171", "417171004", "story_v_out_417171.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_417171", "417171004", "story_v_out_417171.awb")

						arg_20_1:RecordAudio("417171004", var_23_6)
						arg_20_1:RecordAudio("417171004", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_417171", "417171004", "story_v_out_417171.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_417171", "417171004", "story_v_out_417171.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play417171005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 417171005
		arg_24_1.duration_ = 5.5

		local var_24_0 = {
			zh = 4.766,
			ja = 5.5
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play417171006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_0 = 0.5

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 then
				local var_27_1 = Color.New(0, 0, 0)

				var_27_1.a = Mathf.Lerp(0, 1, (arg_24_1.time_ - 0) / var_27_0)
				arg_24_1.mask_.color = var_27_1
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 then
				local var_27_2 = Color.New(0, 0, 0)

				var_27_2.a = 1
				arg_24_1.mask_.color = var_27_2
			end

			local var_27_3 = 0.5

			if 0.5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_3 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_4 = 0.9

			if var_27_3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_3 + var_27_4 then
				local var_27_5 = Color.New(0, 0, 0)

				var_27_5.a = Mathf.Lerp(1, 0, (arg_24_1.time_ - var_27_3) / var_27_4)
				arg_24_1.mask_.color = var_27_5
			end

			if arg_24_1.time_ >= var_27_3 + var_27_4 and arg_24_1.time_ < var_27_3 + var_27_4 + arg_27_0 then
				local var_27_6 = Color.New(0, 0, 0)

				arg_24_1.mask_.enabled = false
				var_27_6.a = 0
				arg_24_1.mask_.color = var_27_6
			end

			if 0.5 < arg_24_1.time_ and arg_24_1.time_ <= 0.5 + arg_27_0 then
				local var_27_7 = arg_24_1.bgs_.I16h

				arg_24_1.bgs_.I16h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_27_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_8 = var_27_7:GetComponent("SpriteRenderer")

				if var_27_8 and var_27_8.sprite then
					local var_27_9 = 2 * (var_27_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_27_7.transform.localScale = Vector3.New(var_27_9 / var_27_8.sprite.bounds.size.y < var_27_9 * manager.ui.mainCameraCom_.aspect / var_27_8.sprite.bounds.size.x and var_27_9 * manager.ui.mainCameraCom_.aspect / var_27_8.sprite.bounds.size.x or var_27_9 / var_27_8.sprite.bounds.size.y, var_27_9 / var_27_8.sprite.bounds.size.y < var_27_9 * manager.ui.mainCameraCom_.aspect / var_27_8.sprite.bounds.size.x and var_27_9 * manager.ui.mainCameraCom_.aspect / var_27_8.sprite.bounds.size.x or var_27_9 / var_27_8.sprite.bounds.size.y, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "I16h" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_10 = 0.483333333333333

			arg_24_1.isInRecall_ = false

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.screenFilterGo_:SetActive(false)

				for iter_27_2, iter_27_3 in pairs(arg_24_1.actors_) do
					for iter_27_4, iter_27_5 in ipairs((iter_27_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_27_5.color = iter_27_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_27_11 = 0.0166666666666667

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 then
				arg_24_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_24_1.time_ - var_27_10) / var_27_11)
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 then
				arg_24_1.screenFilterEffect_.weight = 0
			end

			local var_27_12 = arg_24_1.actors_["10128"]

			if 1.2 < arg_24_1.time_ and arg_24_1.time_ <= 1.2 + arg_27_0 and not isNil(var_27_12) and arg_24_1.var_.actorSpriteComps10128 == nil then
				arg_24_1.var_.actorSpriteComps10128 = var_27_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_13 = 0.2

			if 1.2 <= arg_24_1.time_ and arg_24_1.time_ < 1.2 + var_27_13 and not isNil(var_27_12) then
				if arg_24_1.var_.actorSpriteComps10128 then
					for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_27_7 then
							if arg_24_1.isInRecall_ then
								iter_27_7.color = Color.New(Mathf.Lerp(iter_27_7.color.r, arg_24_1.hightColor1.r, (arg_24_1.time_ - 1.2) / var_27_13), Mathf.Lerp(iter_27_7.color.g, arg_24_1.hightColor1.g, (arg_24_1.time_ - 1.2) / var_27_13), (Mathf.Lerp(iter_27_7.color.b, arg_24_1.hightColor1.b, (arg_24_1.time_ - 1.2) / var_27_13)))
							else
								local var_27_14 = Mathf.Lerp(iter_27_7.color.r, 1, (arg_24_1.time_ - 1.2) / var_27_13)

								iter_27_7.color = Color.New(var_27_14, var_27_14, var_27_14)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= 1.2 + var_27_13 and arg_24_1.time_ < 1.2 + var_27_13 + arg_27_0 and not isNil(var_27_12) and arg_24_1.var_.actorSpriteComps10128 then
				for iter_27_8, iter_27_9 in pairs(arg_24_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_27_9 then
						iter_27_9.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_24_1.var_.actorSpriteComps10128 = nil
			end

			local var_27_15 = arg_24_1.actors_["10128"].transform

			if 1.2 < arg_24_1.time_ and arg_24_1.time_ <= 1.2 + arg_27_0 then
				arg_24_1.var_.moveOldPos10128 = var_27_15.localPosition
				var_27_15.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("10128", 3)

				for iter_27_10 = 0, var_27_15.childCount - 1 do
					local var_27_16 = var_27_15:GetChild(iter_27_10)

					if var_27_16.name == "" or not string.find(var_27_16.name, "split") then
						var_27_16.gameObject:SetActive(true)
					else
						var_27_16.gameObject:SetActive(false)
					end
				end
			end

			local var_27_17 = 0.001

			if 1.2 <= arg_24_1.time_ and arg_24_1.time_ < 1.2 + var_27_17 then
				var_27_15.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_24_1.time_ - 1.2) / var_27_17)
			end

			if arg_24_1.time_ >= 1.2 + var_27_17 and arg_24_1.time_ < 1.2 + var_27_17 + arg_27_0 then
				var_27_15.localPosition = Vector3.New(0, -347, -300)
			end

			if 1.2 < arg_24_1.time_ and arg_24_1.time_ <= 1.2 + arg_27_0 then
				local var_27_18 = arg_24_1.actors_["10128"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_27_18 then
					arg_24_1.var_.alphaOldValue10128 = var_27_18.alpha
					arg_24_1.var_.characterEffect10128 = var_27_18
				end

				arg_24_1.var_.alphaOldValue10128 = 0
			end

			local var_27_19 = 0.2

			if 1.2 <= arg_24_1.time_ and arg_24_1.time_ < 1.2 + var_27_19 then
				if arg_24_1.var_.characterEffect10128 then
					arg_24_1.var_.characterEffect10128.alpha = Mathf.Lerp(arg_24_1.var_.alphaOldValue10128, 1, (arg_24_1.time_ - 1.2) / var_27_19)
				end
			end

			if arg_24_1.time_ >= 1.2 + var_27_19 and arg_24_1.time_ < 1.2 + var_27_19 + arg_27_0 and arg_24_1.var_.characterEffect10128 then
				arg_24_1.var_.characterEffect10128.alpha = 1
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_20 = 1.4
			local var_27_21 = 0.4

			if 1.4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_20 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_22 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_22:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_24_1.dialogCg_.alpha = arg_28_0
				end))
				var_27_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_23 = arg_24_1:GetWordFromCfg(417171005)
				local var_27_24 = arg_24_1:FormatText(var_27_23.content)

				arg_24_1.text_.text = var_27_24

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_26 = 16 <= 0 and var_27_21 or var_27_21 * (utf8.len(var_27_24) / 16)

				if (16 <= 0 and var_27_21 or var_27_21 * (utf8.len(var_27_24) / 16)) > 0 and var_27_21 < var_27_26 then
					arg_24_1.talkMaxDuration = var_27_26
					var_27_20 = var_27_20 + 0.3

					if var_27_26 + var_27_20 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_26 + var_27_20
					end
				end

				arg_24_1.text_.text = var_27_24
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171005", "story_v_out_417171.awb") ~= 0 then
					local var_27_27 = manager.audio:GetVoiceLength("story_v_out_417171", "417171005", "story_v_out_417171.awb") / 1000

					if var_27_27 + var_27_20 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_27 + var_27_20
					end

					if var_27_23.prefab_name ~= "" and arg_24_1.actors_[var_27_23.prefab_name] ~= nil then
						local var_27_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_23.prefab_name].transform, "story_v_out_417171", "417171005", "story_v_out_417171.awb")

						arg_24_1:RecordAudio("417171005", var_27_28)
						arg_24_1:RecordAudio("417171005", var_27_28)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_417171", "417171005", "story_v_out_417171.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_417171", "417171005", "story_v_out_417171.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_29 = var_27_20 + 0.3
			local var_27_30 = math.max(var_27_21, arg_24_1.talkMaxDuration)

			if var_27_20 + 0.3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_29 + var_27_30 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_29) / var_27_30

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_29 + var_27_30 and arg_24_1.time_ < var_27_29 + var_27_30 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play417171006 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417171006
		arg_30_1.duration_ = 1.53

		local var_30_0 = {
			zh = 1.366,
			ja = 1.533
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
				arg_30_0:Play417171007(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos10128 = arg_30_1.actors_["10128"].transform.localPosition
				arg_30_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("10128", 7)

				for iter_33_0 = 0, arg_30_1.actors_["10128"].transform.childCount - 1 do
					local var_33_0 = arg_30_1.actors_["10128"].transform:GetChild(iter_33_0)

					if var_33_0.name == "" or not string.find(var_33_0.name, "split") then
						var_33_0.gameObject:SetActive(true)
					else
						var_33_0.gameObject:SetActive(false)
					end
				end
			end

			local var_33_1 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_1 then
				arg_30_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_30_1.time_ - 0) / var_33_1)
			end

			if arg_30_1.time_ >= 0 + var_33_1 and arg_30_1.time_ < 0 + var_33_1 + arg_33_0 then
				arg_30_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_33_2 = 0
			local var_33_3 = 0.2

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_1")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_4 = arg_30_1:GetWordFromCfg(417171006)
				local var_33_5 = arg_30_1:FormatText(var_33_4.content)

				arg_30_1.text_.text = var_33_5

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_7 = 5 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 5)

				if (5 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 5)) > 0 and var_33_3 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_2
					end
				end

				arg_30_1.text_.text = var_33_5
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171006", "story_v_out_417171.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_417171", "417171006", "story_v_out_417171.awb") / 1000

					if var_33_8 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_2
					end

					if var_33_4.prefab_name ~= "" and arg_30_1.actors_[var_33_4.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_4.prefab_name].transform, "story_v_out_417171", "417171006", "story_v_out_417171.awb")

						arg_30_1:RecordAudio("417171006", var_33_9)
						arg_30_1:RecordAudio("417171006", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417171", "417171006", "story_v_out_417171.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417171", "417171006", "story_v_out_417171.awb")
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

		arg_30_1.nodeConfigList_ = {
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

		arg_30_1:InitPlayNodeList()
	end,
	Play417171007 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417171007
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417171008(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0.3 < arg_34_1.time_ and arg_34_1.time_ <= 0.3 + arg_37_0 then
				arg_34_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_footsteps", "")
			end

			local var_37_1 = 0
			local var_37_2 = 1.175

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_3 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(417171007).content)

				arg_34_1.text_.text = var_37_3

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_5 = 47 <= 0 and var_37_2 or var_37_2 * (utf8.len(var_37_3) / 47)

				if (47 <= 0 and var_37_2 or var_37_2 * (utf8.len(var_37_3) / 47)) > 0 and var_37_2 < var_37_5 then
					arg_34_1.talkMaxDuration = var_37_5

					if var_37_5 + var_37_1 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_5 + var_37_1
					end
				end

				arg_34_1.text_.text = var_37_3
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_6 = math.max(var_37_2, arg_34_1.talkMaxDuration)

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_6 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_1) / var_37_6

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_1 + var_37_6 and arg_34_1.time_ < var_37_1 + var_37_6 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417171008 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417171008
		arg_38_1.duration_ = 5.2

		local var_38_0 = {
			zh = 3.4,
			ja = 5.2
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
				arg_38_0:Play417171009(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["10128"]) and arg_38_1.var_.actorSpriteComps10128 == nil then
				arg_38_1.var_.actorSpriteComps10128 = arg_38_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["10128"]) then
				if arg_38_1.var_.actorSpriteComps10128 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								iter_41_1.color = Color.New(Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor1.r, (arg_38_1.time_ - 0) / var_41_0), Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor1.g, (arg_38_1.time_ - 0) / var_41_0), (Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor1.b, (arg_38_1.time_ - 0) / var_41_0)))
							else
								local var_41_1 = Mathf.Lerp(iter_41_1.color.r, 1, (arg_38_1.time_ - 0) / var_41_0)

								iter_41_1.color = Color.New(var_41_1, var_41_1, var_41_1)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["10128"]) and arg_38_1.var_.actorSpriteComps10128 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_41_3 then
						iter_41_3.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_38_1.var_.actorSpriteComps10128 = nil
			end

			local var_41_2 = arg_38_1.actors_["10128"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos10128 = var_41_2.localPosition
				var_41_2.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("10128", 3)

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
				var_41_2.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_38_1.time_ - 0) / var_41_4)
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 then
				var_41_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_41_5 = 0
			local var_41_6 = 0.35

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_7 = arg_38_1:GetWordFromCfg(417171008)
				local var_41_8 = arg_38_1:FormatText(var_41_7.content)

				arg_38_1.text_.text = var_41_8

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_10 = 14 <= 0 and var_41_6 or var_41_6 * (utf8.len(var_41_8) / 14)

				if (14 <= 0 and var_41_6 or var_41_6 * (utf8.len(var_41_8) / 14)) > 0 and var_41_6 < var_41_10 then
					arg_38_1.talkMaxDuration = var_41_10

					if var_41_10 + var_41_5 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_5
					end
				end

				arg_38_1.text_.text = var_41_8
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171008", "story_v_out_417171.awb") ~= 0 then
					local var_41_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171008", "story_v_out_417171.awb") / 1000

					if var_41_11 + var_41_5 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_11 + var_41_5
					end

					if var_41_7.prefab_name ~= "" and arg_38_1.actors_[var_41_7.prefab_name] ~= nil then
						local var_41_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_7.prefab_name].transform, "story_v_out_417171", "417171008", "story_v_out_417171.awb")

						arg_38_1:RecordAudio("417171008", var_41_12)
						arg_38_1:RecordAudio("417171008", var_41_12)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417171", "417171008", "story_v_out_417171.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417171", "417171008", "story_v_out_417171.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_13 = math.max(var_41_6, arg_38_1.talkMaxDuration)

			if var_41_5 <= arg_38_1.time_ and arg_38_1.time_ < var_41_5 + var_41_13 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_5) / var_41_13

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_5 + var_41_13 and arg_38_1.time_ < var_41_5 + var_41_13 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
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

		arg_38_1:InitPlayNodeList()
	end,
	Play417171009 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417171009
		arg_42_1.duration_ = 7.6

		local var_42_0 = {
			zh = 6.2,
			ja = 7.6
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
				arg_42_0:Play417171010(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if arg_42_1.actors_["10113"] == nil then
				local var_45_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_45_0) then
					local var_45_1 = Object.Instantiate(var_45_0, arg_42_1.canvasGo_.transform)

					var_45_1.transform:SetSiblingIndex(1)

					var_45_1.name = "10113"
					var_45_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_42_1.actors_["10113"] = var_45_1

					if arg_42_1.isInRecall_ then
						for iter_45_0, iter_45_1 in ipairs((var_45_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_45_1.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_45_2 = arg_42_1.actors_["10113"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps10113 == nil then
				arg_42_1.var_.actorSpriteComps10113 = var_45_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_3 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_3 and not isNil(var_45_2) then
				if arg_42_1.var_.actorSpriteComps10113 then
					for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_45_3 then
							if arg_42_1.isInRecall_ then
								iter_45_3.color = Color.New(Mathf.Lerp(iter_45_3.color.r, arg_42_1.hightColor1.r, (arg_42_1.time_ - 0) / var_45_3), Mathf.Lerp(iter_45_3.color.g, arg_42_1.hightColor1.g, (arg_42_1.time_ - 0) / var_45_3), (Mathf.Lerp(iter_45_3.color.b, arg_42_1.hightColor1.b, (arg_42_1.time_ - 0) / var_45_3)))
							else
								local var_45_4 = Mathf.Lerp(iter_45_3.color.r, 1, (arg_42_1.time_ - 0) / var_45_3)

								iter_45_3.color = Color.New(var_45_4, var_45_4, var_45_4)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_3 and arg_42_1.time_ < 0 + var_45_3 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps10113 then
				for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_45_5 then
						iter_45_5.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_42_1.var_.actorSpriteComps10113 = nil
			end

			local var_45_5 = arg_42_1.actors_["10128"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.actorSpriteComps10128 == nil then
				arg_42_1.var_.actorSpriteComps10128 = var_45_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_6 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_6 and not isNil(var_45_5) then
				if arg_42_1.var_.actorSpriteComps10128 then
					for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_45_7 then
							if arg_42_1.isInRecall_ then
								iter_45_7.color = Color.New(Mathf.Lerp(iter_45_7.color.r, arg_42_1.hightColor2.r, (arg_42_1.time_ - 0) / var_45_6), Mathf.Lerp(iter_45_7.color.g, arg_42_1.hightColor2.g, (arg_42_1.time_ - 0) / var_45_6), (Mathf.Lerp(iter_45_7.color.b, arg_42_1.hightColor2.b, (arg_42_1.time_ - 0) / var_45_6)))
							else
								local var_45_7 = Mathf.Lerp(iter_45_7.color.r, 0.5, (arg_42_1.time_ - 0) / var_45_6)

								iter_45_7.color = Color.New(var_45_7, var_45_7, var_45_7)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_6 and arg_42_1.time_ < 0 + var_45_6 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.actorSpriteComps10128 then
				for iter_45_8, iter_45_9 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_45_9 then
						iter_45_9.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_42_1.var_.actorSpriteComps10128 = nil
			end

			local var_45_8 = arg_42_1.actors_["10128"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10128 = var_45_8.localPosition
				var_45_8.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10128", 2)

				for iter_45_10 = 0, var_45_8.childCount - 1 do
					local var_45_9 = var_45_8:GetChild(iter_45_10)

					if var_45_9.name == "" or not string.find(var_45_9.name, "split") then
						var_45_9.gameObject:SetActive(true)
					else
						var_45_9.gameObject:SetActive(false)
					end
				end
			end

			local var_45_10 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_10 then
				var_45_8.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_42_1.time_ - 0) / var_45_10)
			end

			if arg_42_1.time_ >= 0 + var_45_10 and arg_42_1.time_ < 0 + var_45_10 + arg_45_0 then
				var_45_8.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_45_11 = arg_42_1.actors_["10113"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10113 = var_45_11.localPosition
				var_45_11.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10113", 4)

				for iter_45_11 = 0, var_45_11.childCount - 1 do
					local var_45_12 = var_45_11:GetChild(iter_45_11)

					if var_45_12.name == "" or not string.find(var_45_12.name, "split") then
						var_45_12.gameObject:SetActive(true)
					else
						var_45_12.gameObject:SetActive(false)
					end
				end
			end

			local var_45_13 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_13 then
				var_45_11.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10113, Vector3.New(377.3, -328.4, -517.4), (arg_42_1.time_ - 0) / var_45_13)
			end

			if arg_42_1.time_ >= 0 + var_45_13 and arg_42_1.time_ < 0 + var_45_13 + arg_45_0 then
				var_45_11.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_45_14 = 0
			local var_45_15 = 0.925

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_14 + arg_45_0 then
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

				local var_45_16 = arg_42_1:GetWordFromCfg(417171009)
				local var_45_17 = arg_42_1:FormatText(var_45_16.content)

				arg_42_1.text_.text = var_45_17

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_19 = 37 <= 0 and var_45_15 or var_45_15 * (utf8.len(var_45_17) / 37)

				if (37 <= 0 and var_45_15 or var_45_15 * (utf8.len(var_45_17) / 37)) > 0 and var_45_15 < var_45_19 then
					arg_42_1.talkMaxDuration = var_45_19

					if var_45_19 + var_45_14 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_19 + var_45_14
					end
				end

				arg_42_1.text_.text = var_45_17
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171009", "story_v_out_417171.awb") ~= 0 then
					local var_45_20 = manager.audio:GetVoiceLength("story_v_out_417171", "417171009", "story_v_out_417171.awb") / 1000

					if var_45_20 + var_45_14 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_20 + var_45_14
					end

					if var_45_16.prefab_name ~= "" and arg_42_1.actors_[var_45_16.prefab_name] ~= nil then
						local var_45_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_16.prefab_name].transform, "story_v_out_417171", "417171009", "story_v_out_417171.awb")

						arg_42_1:RecordAudio("417171009", var_45_21)
						arg_42_1:RecordAudio("417171009", var_45_21)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417171", "417171009", "story_v_out_417171.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417171", "417171009", "story_v_out_417171.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_22 = math.max(var_45_15, arg_42_1.talkMaxDuration)

			if var_45_14 <= arg_42_1.time_ and arg_42_1.time_ < var_45_14 + var_45_22 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_14) / var_45_22

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_14 + var_45_22 and arg_42_1.time_ < var_45_14 + var_45_22 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play417171010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417171010
		arg_46_1.duration_ = 9.97

		local var_46_0 = {
			zh = 5.933,
			ja = 9.966
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
				arg_46_0:Play417171011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.85

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:GetWordFromCfg(417171010)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 34 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 34)

				if (34 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 34)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171010", "story_v_out_417171.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_417171", "417171010", "story_v_out_417171.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_417171", "417171010", "story_v_out_417171.awb")

						arg_46_1:RecordAudio("417171010", var_49_6)
						arg_46_1:RecordAudio("417171010", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417171", "417171010", "story_v_out_417171.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417171", "417171010", "story_v_out_417171.awb")
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
	Play417171011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417171011
		arg_50_1.duration_ = 3.9

		local var_50_0 = {
			zh = 3.766,
			ja = 3.9
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
				arg_50_0:Play417171012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["10128"]) and arg_50_1.var_.actorSpriteComps10128 == nil then
				arg_50_1.var_.actorSpriteComps10128 = arg_50_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["10128"]) then
				if arg_50_1.var_.actorSpriteComps10128 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["10128"]) and arg_50_1.var_.actorSpriteComps10128 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_53_3 then
						iter_53_3.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_50_1.var_.actorSpriteComps10128 = nil
			end

			local var_53_2 = arg_50_1.actors_["10113"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.actorSpriteComps10113 == nil then
				arg_50_1.var_.actorSpriteComps10113 = var_53_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_3 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 and not isNil(var_53_2) then
				if arg_50_1.var_.actorSpriteComps10113 then
					for iter_53_4, iter_53_5 in pairs(arg_50_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_53_5 then
							if arg_50_1.isInRecall_ then
								iter_53_5.color = Color.New(Mathf.Lerp(iter_53_5.color.r, arg_50_1.hightColor2.r, (arg_50_1.time_ - 0) / var_53_3), Mathf.Lerp(iter_53_5.color.g, arg_50_1.hightColor2.g, (arg_50_1.time_ - 0) / var_53_3), (Mathf.Lerp(iter_53_5.color.b, arg_50_1.hightColor2.b, (arg_50_1.time_ - 0) / var_53_3)))
							else
								local var_53_4 = Mathf.Lerp(iter_53_5.color.r, 0.5, (arg_50_1.time_ - 0) / var_53_3)

								iter_53_5.color = Color.New(var_53_4, var_53_4, var_53_4)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.actorSpriteComps10113 then
				for iter_53_6, iter_53_7 in pairs(arg_50_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_53_7 then
						iter_53_7.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_50_1.var_.actorSpriteComps10113 = nil
			end

			local var_53_5 = 0
			local var_53_6 = 0.425

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_7 = arg_50_1:GetWordFromCfg(417171011)
				local var_53_8 = arg_50_1:FormatText(var_53_7.content)

				arg_50_1.text_.text = var_53_8

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_10 = 17 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 17)

				if (17 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 17)) > 0 and var_53_6 < var_53_10 then
					arg_50_1.talkMaxDuration = var_53_10

					if var_53_10 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_5
					end
				end

				arg_50_1.text_.text = var_53_8
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171011", "story_v_out_417171.awb") ~= 0 then
					local var_53_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171011", "story_v_out_417171.awb") / 1000

					if var_53_11 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_11 + var_53_5
					end

					if var_53_7.prefab_name ~= "" and arg_50_1.actors_[var_53_7.prefab_name] ~= nil then
						local var_53_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_7.prefab_name].transform, "story_v_out_417171", "417171011", "story_v_out_417171.awb")

						arg_50_1:RecordAudio("417171011", var_53_12)
						arg_50_1:RecordAudio("417171011", var_53_12)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417171", "417171011", "story_v_out_417171.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417171", "417171011", "story_v_out_417171.awb")
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

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play417171012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417171012
		arg_54_1.duration_ = 5.77

		local var_54_0 = {
			zh = 3.3,
			ja = 5.766
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
				arg_54_0:Play417171013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["10113"]) and arg_54_1.var_.actorSpriteComps10113 == nil then
				arg_54_1.var_.actorSpriteComps10113 = arg_54_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_0 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["10113"]) then
				if arg_54_1.var_.actorSpriteComps10113 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["10113"]) and arg_54_1.var_.actorSpriteComps10113 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_57_3 then
						iter_57_3.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_54_1.var_.actorSpriteComps10113 = nil
			end

			local var_57_2 = arg_54_1.actors_["10128"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.actorSpriteComps10128 == nil then
				arg_54_1.var_.actorSpriteComps10128 = var_57_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_3 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_3 and not isNil(var_57_2) then
				if arg_54_1.var_.actorSpriteComps10128 then
					for iter_57_4, iter_57_5 in pairs(arg_54_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_57_5 then
							if arg_54_1.isInRecall_ then
								iter_57_5.color = Color.New(Mathf.Lerp(iter_57_5.color.r, arg_54_1.hightColor2.r, (arg_54_1.time_ - 0) / var_57_3), Mathf.Lerp(iter_57_5.color.g, arg_54_1.hightColor2.g, (arg_54_1.time_ - 0) / var_57_3), (Mathf.Lerp(iter_57_5.color.b, arg_54_1.hightColor2.b, (arg_54_1.time_ - 0) / var_57_3)))
							else
								local var_57_4 = Mathf.Lerp(iter_57_5.color.r, 0.5, (arg_54_1.time_ - 0) / var_57_3)

								iter_57_5.color = Color.New(var_57_4, var_57_4, var_57_4)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= 0 + var_57_3 and arg_54_1.time_ < 0 + var_57_3 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.actorSpriteComps10128 then
				for iter_57_6, iter_57_7 in pairs(arg_54_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_57_7 then
						iter_57_7.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_54_1.var_.actorSpriteComps10128 = nil
			end

			local var_57_5 = 0
			local var_57_6 = 0.4

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 then
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

				local var_57_7 = arg_54_1:GetWordFromCfg(417171012)
				local var_57_8 = arg_54_1:FormatText(var_57_7.content)

				arg_54_1.text_.text = var_57_8

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_10 = 16 <= 0 and var_57_6 or var_57_6 * (utf8.len(var_57_8) / 16)

				if (16 <= 0 and var_57_6 or var_57_6 * (utf8.len(var_57_8) / 16)) > 0 and var_57_6 < var_57_10 then
					arg_54_1.talkMaxDuration = var_57_10

					if var_57_10 + var_57_5 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_5
					end
				end

				arg_54_1.text_.text = var_57_8
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171012", "story_v_out_417171.awb") ~= 0 then
					local var_57_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171012", "story_v_out_417171.awb") / 1000

					if var_57_11 + var_57_5 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_11 + var_57_5
					end

					if var_57_7.prefab_name ~= "" and arg_54_1.actors_[var_57_7.prefab_name] ~= nil then
						local var_57_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_7.prefab_name].transform, "story_v_out_417171", "417171012", "story_v_out_417171.awb")

						arg_54_1:RecordAudio("417171012", var_57_12)
						arg_54_1:RecordAudio("417171012", var_57_12)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417171", "417171012", "story_v_out_417171.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417171", "417171012", "story_v_out_417171.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_13 = math.max(var_57_6, arg_54_1.talkMaxDuration)

			if var_57_5 <= arg_54_1.time_ and arg_54_1.time_ < var_57_5 + var_57_13 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_5) / var_57_13

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_5 + var_57_13 and arg_54_1.time_ < var_57_5 + var_57_13 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play417171013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417171013
		arg_58_1.duration_ = 7.63

		local var_58_0 = {
			zh = 7.033,
			ja = 7.633
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
				arg_58_0:Play417171014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["10128"]) and arg_58_1.var_.actorSpriteComps10128 == nil then
				arg_58_1.var_.actorSpriteComps10128 = arg_58_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["10128"]) then
				if arg_58_1.var_.actorSpriteComps10128 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								iter_61_1.color = Color.New(Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor1.r, (arg_58_1.time_ - 0) / var_61_0), Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor1.g, (arg_58_1.time_ - 0) / var_61_0), (Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor1.b, (arg_58_1.time_ - 0) / var_61_0)))
							else
								local var_61_1 = Mathf.Lerp(iter_61_1.color.r, 1, (arg_58_1.time_ - 0) / var_61_0)

								iter_61_1.color = Color.New(var_61_1, var_61_1, var_61_1)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["10128"]) and arg_58_1.var_.actorSpriteComps10128 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_58_1.var_.actorSpriteComps10128 = nil
			end

			local var_61_2 = arg_58_1.actors_["10113"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.actorSpriteComps10113 == nil then
				arg_58_1.var_.actorSpriteComps10113 = var_61_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_3 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_3 and not isNil(var_61_2) then
				if arg_58_1.var_.actorSpriteComps10113 then
					for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_61_5 then
							if arg_58_1.isInRecall_ then
								iter_61_5.color = Color.New(Mathf.Lerp(iter_61_5.color.r, arg_58_1.hightColor2.r, (arg_58_1.time_ - 0) / var_61_3), Mathf.Lerp(iter_61_5.color.g, arg_58_1.hightColor2.g, (arg_58_1.time_ - 0) / var_61_3), (Mathf.Lerp(iter_61_5.color.b, arg_58_1.hightColor2.b, (arg_58_1.time_ - 0) / var_61_3)))
							else
								local var_61_4 = Mathf.Lerp(iter_61_5.color.r, 0.5, (arg_58_1.time_ - 0) / var_61_3)

								iter_61_5.color = Color.New(var_61_4, var_61_4, var_61_4)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_3 and arg_58_1.time_ < 0 + var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.actorSpriteComps10113 then
				for iter_61_6, iter_61_7 in pairs(arg_58_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_61_7 then
						iter_61_7.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps10113 = nil
			end

			local var_61_5 = 0
			local var_61_6 = 0.8

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_7 = arg_58_1:GetWordFromCfg(417171013)
				local var_61_8 = arg_58_1:FormatText(var_61_7.content)

				arg_58_1.text_.text = var_61_8

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_10 = 32 <= 0 and var_61_6 or var_61_6 * (utf8.len(var_61_8) / 32)

				if (32 <= 0 and var_61_6 or var_61_6 * (utf8.len(var_61_8) / 32)) > 0 and var_61_6 < var_61_10 then
					arg_58_1.talkMaxDuration = var_61_10

					if var_61_10 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_10 + var_61_5
					end
				end

				arg_58_1.text_.text = var_61_8
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171013", "story_v_out_417171.awb") ~= 0 then
					local var_61_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171013", "story_v_out_417171.awb") / 1000

					if var_61_11 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_11 + var_61_5
					end

					if var_61_7.prefab_name ~= "" and arg_58_1.actors_[var_61_7.prefab_name] ~= nil then
						local var_61_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_7.prefab_name].transform, "story_v_out_417171", "417171013", "story_v_out_417171.awb")

						arg_58_1:RecordAudio("417171013", var_61_12)
						arg_58_1:RecordAudio("417171013", var_61_12)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417171", "417171013", "story_v_out_417171.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417171", "417171013", "story_v_out_417171.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_13 = math.max(var_61_6, arg_58_1.talkMaxDuration)

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_13 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_5) / var_61_13

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_5 + var_61_13 and arg_58_1.time_ < var_61_5 + var_61_13 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417171014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417171014
		arg_62_1.duration_ = 6.77

		local var_62_0 = {
			zh = 3.933,
			ja = 6.766
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
				arg_62_0:Play417171015(arg_62_1)
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
								iter_65_1.color = Color.New(Mathf.Lerp(iter_65_1.color.r, arg_62_1.hightColor1.r, (arg_62_1.time_ - 0) / var_65_0), Mathf.Lerp(iter_65_1.color.g, arg_62_1.hightColor1.g, (arg_62_1.time_ - 0) / var_65_0), (Mathf.Lerp(iter_65_1.color.b, arg_62_1.hightColor1.b, (arg_62_1.time_ - 0) / var_65_0)))
							else
								local var_65_1 = Mathf.Lerp(iter_65_1.color.r, 1, (arg_62_1.time_ - 0) / var_65_0)

								iter_65_1.color = Color.New(var_65_1, var_65_1, var_65_1)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["10113"]) and arg_62_1.var_.actorSpriteComps10113 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_65_3 then
						iter_65_3.color = arg_62_1.isInRecall_ and (arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_62_1.var_.actorSpriteComps10113 = nil
			end

			local var_65_2 = arg_62_1.actors_["10128"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.actorSpriteComps10128 == nil then
				arg_62_1.var_.actorSpriteComps10128 = var_65_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_3 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_3 and not isNil(var_65_2) then
				if arg_62_1.var_.actorSpriteComps10128 then
					for iter_65_4, iter_65_5 in pairs(arg_62_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_65_5 then
							if arg_62_1.isInRecall_ then
								iter_65_5.color = Color.New(Mathf.Lerp(iter_65_5.color.r, arg_62_1.hightColor2.r, (arg_62_1.time_ - 0) / var_65_3), Mathf.Lerp(iter_65_5.color.g, arg_62_1.hightColor2.g, (arg_62_1.time_ - 0) / var_65_3), (Mathf.Lerp(iter_65_5.color.b, arg_62_1.hightColor2.b, (arg_62_1.time_ - 0) / var_65_3)))
							else
								local var_65_4 = Mathf.Lerp(iter_65_5.color.r, 0.5, (arg_62_1.time_ - 0) / var_65_3)

								iter_65_5.color = Color.New(var_65_4, var_65_4, var_65_4)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= 0 + var_65_3 and arg_62_1.time_ < 0 + var_65_3 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.actorSpriteComps10128 then
				for iter_65_6, iter_65_7 in pairs(arg_62_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_65_7 then
						iter_65_7.color = arg_62_1.isInRecall_ and (arg_62_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_62_1.var_.actorSpriteComps10128 = nil
			end

			local var_65_5 = 0
			local var_65_6 = 0.475

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_7 = arg_62_1:GetWordFromCfg(417171014)
				local var_65_8 = arg_62_1:FormatText(var_65_7.content)

				arg_62_1.text_.text = var_65_8

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_10 = 19 <= 0 and var_65_6 or var_65_6 * (utf8.len(var_65_8) / 19)

				if (19 <= 0 and var_65_6 or var_65_6 * (utf8.len(var_65_8) / 19)) > 0 and var_65_6 < var_65_10 then
					arg_62_1.talkMaxDuration = var_65_10

					if var_65_10 + var_65_5 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_5
					end
				end

				arg_62_1.text_.text = var_65_8
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171014", "story_v_out_417171.awb") ~= 0 then
					local var_65_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171014", "story_v_out_417171.awb") / 1000

					if var_65_11 + var_65_5 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_11 + var_65_5
					end

					if var_65_7.prefab_name ~= "" and arg_62_1.actors_[var_65_7.prefab_name] ~= nil then
						local var_65_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_7.prefab_name].transform, "story_v_out_417171", "417171014", "story_v_out_417171.awb")

						arg_62_1:RecordAudio("417171014", var_65_12)
						arg_62_1:RecordAudio("417171014", var_65_12)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417171", "417171014", "story_v_out_417171.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417171", "417171014", "story_v_out_417171.awb")
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

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play417171015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417171015
		arg_66_1.duration_ = 1.5

		local var_66_0 = {
			zh = 1.233,
			ja = 1.5
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
				arg_66_0:Play417171016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["10128"]) and arg_66_1.var_.actorSpriteComps10128 == nil then
				arg_66_1.var_.actorSpriteComps10128 = arg_66_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["10128"]) then
				if arg_66_1.var_.actorSpriteComps10128 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["10128"]) and arg_66_1.var_.actorSpriteComps10128 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_69_3 then
						iter_69_3.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_66_1.var_.actorSpriteComps10128 = nil
			end

			local var_69_2 = arg_66_1.actors_["10113"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.actorSpriteComps10113 == nil then
				arg_66_1.var_.actorSpriteComps10113 = var_69_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_3 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 and not isNil(var_69_2) then
				if arg_66_1.var_.actorSpriteComps10113 then
					for iter_69_4, iter_69_5 in pairs(arg_66_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_69_5 then
							if arg_66_1.isInRecall_ then
								iter_69_5.color = Color.New(Mathf.Lerp(iter_69_5.color.r, arg_66_1.hightColor2.r, (arg_66_1.time_ - 0) / var_69_3), Mathf.Lerp(iter_69_5.color.g, arg_66_1.hightColor2.g, (arg_66_1.time_ - 0) / var_69_3), (Mathf.Lerp(iter_69_5.color.b, arg_66_1.hightColor2.b, (arg_66_1.time_ - 0) / var_69_3)))
							else
								local var_69_4 = Mathf.Lerp(iter_69_5.color.r, 0.5, (arg_66_1.time_ - 0) / var_69_3)

								iter_69_5.color = Color.New(var_69_4, var_69_4, var_69_4)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.actorSpriteComps10113 then
				for iter_69_6, iter_69_7 in pairs(arg_66_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_69_7 then
						iter_69_7.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_66_1.var_.actorSpriteComps10113 = nil
			end

			local var_69_5 = 0
			local var_69_6 = 0.125

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_7 = arg_66_1:GetWordFromCfg(417171015)
				local var_69_8 = arg_66_1:FormatText(var_69_7.content)

				arg_66_1.text_.text = var_69_8

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_10 = 5 <= 0 and var_69_6 or var_69_6 * (utf8.len(var_69_8) / 5)

				if (5 <= 0 and var_69_6 or var_69_6 * (utf8.len(var_69_8) / 5)) > 0 and var_69_6 < var_69_10 then
					arg_66_1.talkMaxDuration = var_69_10

					if var_69_10 + var_69_5 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_5
					end
				end

				arg_66_1.text_.text = var_69_8
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171015", "story_v_out_417171.awb") ~= 0 then
					local var_69_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171015", "story_v_out_417171.awb") / 1000

					if var_69_11 + var_69_5 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_11 + var_69_5
					end

					if var_69_7.prefab_name ~= "" and arg_66_1.actors_[var_69_7.prefab_name] ~= nil then
						local var_69_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_7.prefab_name].transform, "story_v_out_417171", "417171015", "story_v_out_417171.awb")

						arg_66_1:RecordAudio("417171015", var_69_12)
						arg_66_1:RecordAudio("417171015", var_69_12)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417171", "417171015", "story_v_out_417171.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417171", "417171015", "story_v_out_417171.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_13 = math.max(var_69_6, arg_66_1.talkMaxDuration)

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_13 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_5) / var_69_13

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_5 + var_69_13 and arg_66_1.time_ < var_69_5 + var_69_13 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play417171016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417171016
		arg_70_1.duration_ = 9.2

		local var_70_0 = {
			zh = 6.933,
			ja = 9.2
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
				arg_70_0:Play417171017(arg_70_1)
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
								iter_73_1.color = Color.New(Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor1.r, (arg_70_1.time_ - 0) / var_73_0), Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor1.g, (arg_70_1.time_ - 0) / var_73_0), (Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor1.b, (arg_70_1.time_ - 0) / var_73_0)))
							else
								local var_73_1 = Mathf.Lerp(iter_73_1.color.r, 1, (arg_70_1.time_ - 0) / var_73_0)

								iter_73_1.color = Color.New(var_73_1, var_73_1, var_73_1)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["10113"]) and arg_70_1.var_.actorSpriteComps10113 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_73_3 then
						iter_73_3.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_70_1.var_.actorSpriteComps10113 = nil
			end

			local var_73_2 = arg_70_1.actors_["10128"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps10128 == nil then
				arg_70_1.var_.actorSpriteComps10128 = var_73_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_3 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.actorSpriteComps10128 then
					for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_73_5 then
							if arg_70_1.isInRecall_ then
								iter_73_5.color = Color.New(Mathf.Lerp(iter_73_5.color.r, arg_70_1.hightColor2.r, (arg_70_1.time_ - 0) / var_73_3), Mathf.Lerp(iter_73_5.color.g, arg_70_1.hightColor2.g, (arg_70_1.time_ - 0) / var_73_3), (Mathf.Lerp(iter_73_5.color.b, arg_70_1.hightColor2.b, (arg_70_1.time_ - 0) / var_73_3)))
							else
								local var_73_4 = Mathf.Lerp(iter_73_5.color.r, 0.5, (arg_70_1.time_ - 0) / var_73_3)

								iter_73_5.color = Color.New(var_73_4, var_73_4, var_73_4)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps10128 then
				for iter_73_6, iter_73_7 in pairs(arg_70_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_73_7 then
						iter_73_7.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_70_1.var_.actorSpriteComps10128 = nil
			end

			local var_73_5 = 0
			local var_73_6 = 0.9

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_7 = arg_70_1:GetWordFromCfg(417171016)
				local var_73_8 = arg_70_1:FormatText(var_73_7.content)

				arg_70_1.text_.text = var_73_8

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_10 = 36 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_8) / 36)

				if (36 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_8) / 36)) > 0 and var_73_6 < var_73_10 then
					arg_70_1.talkMaxDuration = var_73_10

					if var_73_10 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_5
					end
				end

				arg_70_1.text_.text = var_73_8
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171016", "story_v_out_417171.awb") ~= 0 then
					local var_73_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171016", "story_v_out_417171.awb") / 1000

					if var_73_11 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_5
					end

					if var_73_7.prefab_name ~= "" and arg_70_1.actors_[var_73_7.prefab_name] ~= nil then
						local var_73_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_7.prefab_name].transform, "story_v_out_417171", "417171016", "story_v_out_417171.awb")

						arg_70_1:RecordAudio("417171016", var_73_12)
						arg_70_1:RecordAudio("417171016", var_73_12)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417171", "417171016", "story_v_out_417171.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417171", "417171016", "story_v_out_417171.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_13 = math.max(var_73_6, arg_70_1.talkMaxDuration)

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_13 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_5) / var_73_13

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_5 + var_73_13 and arg_70_1.time_ < var_73_5 + var_73_13 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417171017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417171017
		arg_74_1.duration_ = 3.7

		local var_74_0 = {
			zh = 2.2,
			ja = 3.7
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
				arg_74_0:Play417171018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["10128"]) and arg_74_1.var_.actorSpriteComps10128 == nil then
				arg_74_1.var_.actorSpriteComps10128 = arg_74_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_0 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["10128"]) then
				if arg_74_1.var_.actorSpriteComps10128 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["10128"]) and arg_74_1.var_.actorSpriteComps10128 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_77_3 then
						iter_77_3.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_74_1.var_.actorSpriteComps10128 = nil
			end

			local var_77_2 = arg_74_1.actors_["10113"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.actorSpriteComps10113 == nil then
				arg_74_1.var_.actorSpriteComps10113 = var_77_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_3 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_3 and not isNil(var_77_2) then
				if arg_74_1.var_.actorSpriteComps10113 then
					for iter_77_4, iter_77_5 in pairs(arg_74_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_77_5 then
							if arg_74_1.isInRecall_ then
								iter_77_5.color = Color.New(Mathf.Lerp(iter_77_5.color.r, arg_74_1.hightColor2.r, (arg_74_1.time_ - 0) / var_77_3), Mathf.Lerp(iter_77_5.color.g, arg_74_1.hightColor2.g, (arg_74_1.time_ - 0) / var_77_3), (Mathf.Lerp(iter_77_5.color.b, arg_74_1.hightColor2.b, (arg_74_1.time_ - 0) / var_77_3)))
							else
								local var_77_4 = Mathf.Lerp(iter_77_5.color.r, 0.5, (arg_74_1.time_ - 0) / var_77_3)

								iter_77_5.color = Color.New(var_77_4, var_77_4, var_77_4)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= 0 + var_77_3 and arg_74_1.time_ < 0 + var_77_3 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.actorSpriteComps10113 then
				for iter_77_6, iter_77_7 in pairs(arg_74_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_77_7 then
						iter_77_7.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_74_1.var_.actorSpriteComps10113 = nil
			end

			local var_77_5 = 0
			local var_77_6 = 0.3

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_7 = arg_74_1:GetWordFromCfg(417171017)
				local var_77_8 = arg_74_1:FormatText(var_77_7.content)

				arg_74_1.text_.text = var_77_8

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_10 = 12 <= 0 and var_77_6 or var_77_6 * (utf8.len(var_77_8) / 12)

				if (12 <= 0 and var_77_6 or var_77_6 * (utf8.len(var_77_8) / 12)) > 0 and var_77_6 < var_77_10 then
					arg_74_1.talkMaxDuration = var_77_10

					if var_77_10 + var_77_5 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_5
					end
				end

				arg_74_1.text_.text = var_77_8
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171017", "story_v_out_417171.awb") ~= 0 then
					local var_77_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171017", "story_v_out_417171.awb") / 1000

					if var_77_11 + var_77_5 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_11 + var_77_5
					end

					if var_77_7.prefab_name ~= "" and arg_74_1.actors_[var_77_7.prefab_name] ~= nil then
						local var_77_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_7.prefab_name].transform, "story_v_out_417171", "417171017", "story_v_out_417171.awb")

						arg_74_1:RecordAudio("417171017", var_77_12)
						arg_74_1:RecordAudio("417171017", var_77_12)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_417171", "417171017", "story_v_out_417171.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_417171", "417171017", "story_v_out_417171.awb")
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

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play417171018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417171018
		arg_78_1.duration_ = 9.17

		local var_78_0 = {
			zh = 9.166,
			ja = 8.033
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
				arg_78_0:Play417171019(arg_78_1)
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

			local var_81_2 = arg_78_1.actors_["10128"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.actorSpriteComps10128 == nil then
				arg_78_1.var_.actorSpriteComps10128 = var_81_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_3 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 and not isNil(var_81_2) then
				if arg_78_1.var_.actorSpriteComps10128 then
					for iter_81_4, iter_81_5 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_81_5 then
							if arg_78_1.isInRecall_ then
								iter_81_5.color = Color.New(Mathf.Lerp(iter_81_5.color.r, arg_78_1.hightColor2.r, (arg_78_1.time_ - 0) / var_81_3), Mathf.Lerp(iter_81_5.color.g, arg_78_1.hightColor2.g, (arg_78_1.time_ - 0) / var_81_3), (Mathf.Lerp(iter_81_5.color.b, arg_78_1.hightColor2.b, (arg_78_1.time_ - 0) / var_81_3)))
							else
								local var_81_4 = Mathf.Lerp(iter_81_5.color.r, 0.5, (arg_78_1.time_ - 0) / var_81_3)

								iter_81_5.color = Color.New(var_81_4, var_81_4, var_81_4)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.actorSpriteComps10128 then
				for iter_81_6, iter_81_7 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_81_7 then
						iter_81_7.color = arg_78_1.isInRecall_ and (arg_78_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_78_1.var_.actorSpriteComps10128 = nil
			end

			local var_81_5 = 0
			local var_81_6 = 1.15

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
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

				local var_81_7 = arg_78_1:GetWordFromCfg(417171018)
				local var_81_8 = arg_78_1:FormatText(var_81_7.content)

				arg_78_1.text_.text = var_81_8

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_10 = 46 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_8) / 46)

				if (46 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_8) / 46)) > 0 and var_81_6 < var_81_10 then
					arg_78_1.talkMaxDuration = var_81_10

					if var_81_10 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_5
					end
				end

				arg_78_1.text_.text = var_81_8
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171018", "story_v_out_417171.awb") ~= 0 then
					local var_81_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171018", "story_v_out_417171.awb") / 1000

					if var_81_11 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_11 + var_81_5
					end

					if var_81_7.prefab_name ~= "" and arg_78_1.actors_[var_81_7.prefab_name] ~= nil then
						local var_81_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_7.prefab_name].transform, "story_v_out_417171", "417171018", "story_v_out_417171.awb")

						arg_78_1:RecordAudio("417171018", var_81_12)
						arg_78_1:RecordAudio("417171018", var_81_12)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417171", "417171018", "story_v_out_417171.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417171", "417171018", "story_v_out_417171.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_13 = math.max(var_81_6, arg_78_1.talkMaxDuration)

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_13 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_5) / var_81_13

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_5 + var_81_13 and arg_78_1.time_ < var_81_5 + var_81_13 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play417171019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417171019
		arg_82_1.duration_ = 5.03

		local var_82_0 = {
			zh = 3.166,
			ja = 5.033
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
				arg_82_0:Play417171020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["10128"]) and arg_82_1.var_.actorSpriteComps10128 == nil then
				arg_82_1.var_.actorSpriteComps10128 = arg_82_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_0 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["10128"]) then
				if arg_82_1.var_.actorSpriteComps10128 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								iter_85_1.color = Color.New(Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor1.r, (arg_82_1.time_ - 0) / var_85_0), Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor1.g, (arg_82_1.time_ - 0) / var_85_0), (Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor1.b, (arg_82_1.time_ - 0) / var_85_0)))
							else
								local var_85_1 = Mathf.Lerp(iter_85_1.color.r, 1, (arg_82_1.time_ - 0) / var_85_0)

								iter_85_1.color = Color.New(var_85_1, var_85_1, var_85_1)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["10128"]) and arg_82_1.var_.actorSpriteComps10128 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_85_3 then
						iter_85_3.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_82_1.var_.actorSpriteComps10128 = nil
			end

			local var_85_2 = arg_82_1.actors_["10113"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.actorSpriteComps10113 == nil then
				arg_82_1.var_.actorSpriteComps10113 = var_85_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_3 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_3 and not isNil(var_85_2) then
				if arg_82_1.var_.actorSpriteComps10113 then
					for iter_85_4, iter_85_5 in pairs(arg_82_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_85_5 then
							if arg_82_1.isInRecall_ then
								iter_85_5.color = Color.New(Mathf.Lerp(iter_85_5.color.r, arg_82_1.hightColor2.r, (arg_82_1.time_ - 0) / var_85_3), Mathf.Lerp(iter_85_5.color.g, arg_82_1.hightColor2.g, (arg_82_1.time_ - 0) / var_85_3), (Mathf.Lerp(iter_85_5.color.b, arg_82_1.hightColor2.b, (arg_82_1.time_ - 0) / var_85_3)))
							else
								local var_85_4 = Mathf.Lerp(iter_85_5.color.r, 0.5, (arg_82_1.time_ - 0) / var_85_3)

								iter_85_5.color = Color.New(var_85_4, var_85_4, var_85_4)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= 0 + var_85_3 and arg_82_1.time_ < 0 + var_85_3 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.actorSpriteComps10113 then
				for iter_85_6, iter_85_7 in pairs(arg_82_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_85_7 then
						iter_85_7.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_82_1.var_.actorSpriteComps10113 = nil
			end

			local var_85_5 = 0
			local var_85_6 = 0.35

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_7 = arg_82_1:GetWordFromCfg(417171019)
				local var_85_8 = arg_82_1:FormatText(var_85_7.content)

				arg_82_1.text_.text = var_85_8

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_10 = 14 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_8) / 14)

				if (14 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_8) / 14)) > 0 and var_85_6 < var_85_10 then
					arg_82_1.talkMaxDuration = var_85_10

					if var_85_10 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_5
					end
				end

				arg_82_1.text_.text = var_85_8
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171019", "story_v_out_417171.awb") ~= 0 then
					local var_85_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171019", "story_v_out_417171.awb") / 1000

					if var_85_11 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_5
					end

					if var_85_7.prefab_name ~= "" and arg_82_1.actors_[var_85_7.prefab_name] ~= nil then
						local var_85_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_7.prefab_name].transform, "story_v_out_417171", "417171019", "story_v_out_417171.awb")

						arg_82_1:RecordAudio("417171019", var_85_12)
						arg_82_1:RecordAudio("417171019", var_85_12)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417171", "417171019", "story_v_out_417171.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417171", "417171019", "story_v_out_417171.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_13 = math.max(var_85_6, arg_82_1.talkMaxDuration)

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_13 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_5) / var_85_13

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_5 + var_85_13 and arg_82_1.time_ < var_85_5 + var_85_13 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417171020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417171020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play417171021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["10128"]) and arg_86_1.var_.actorSpriteComps10128 == nil then
				arg_86_1.var_.actorSpriteComps10128 = arg_86_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["10128"]) then
				if arg_86_1.var_.actorSpriteComps10128 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								iter_89_1.color = Color.New(Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor2.r, (arg_86_1.time_ - 0) / var_89_0), Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor2.g, (arg_86_1.time_ - 0) / var_89_0), (Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor2.b, (arg_86_1.time_ - 0) / var_89_0)))
							else
								local var_89_1 = Mathf.Lerp(iter_89_1.color.r, 0.5, (arg_86_1.time_ - 0) / var_89_0)

								iter_89_1.color = Color.New(var_89_1, var_89_1, var_89_1)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["10128"]) and arg_86_1.var_.actorSpriteComps10128 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_89_3 then
						iter_89_3.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_86_1.var_.actorSpriteComps10128 = nil
			end

			if 0.05 < arg_86_1.time_ and arg_86_1.time_ <= 0.05 + arg_89_0 then
				arg_86_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_car01", "")
			end

			local var_89_3 = 0
			local var_89_4 = 0.775

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_3 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_5 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(417171020).content)

				arg_86_1.text_.text = var_89_5

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_7 = 31 <= 0 and var_89_4 or var_89_4 * (utf8.len(var_89_5) / 31)

				if (31 <= 0 and var_89_4 or var_89_4 * (utf8.len(var_89_5) / 31)) > 0 and var_89_4 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_3 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_3
					end
				end

				arg_86_1.text_.text = var_89_5
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_8 = math.max(var_89_4, arg_86_1.talkMaxDuration)

			if var_89_3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_3 + var_89_8 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_3) / var_89_8

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_3 + var_89_8 and arg_86_1.time_ < var_89_3 + var_89_8 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play417171021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417171021
		arg_90_1.duration_ = 2.63

		local var_90_0 = {
			zh = 1.9,
			ja = 2.633
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
				arg_90_0:Play417171022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["10113"]) and arg_90_1.var_.actorSpriteComps10113 == nil then
				arg_90_1.var_.actorSpriteComps10113 = arg_90_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["10113"]) then
				if arg_90_1.var_.actorSpriteComps10113 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								iter_93_1.color = Color.New(Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, (arg_90_1.time_ - 0) / var_93_0), Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, (arg_90_1.time_ - 0) / var_93_0), (Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, (arg_90_1.time_ - 0) / var_93_0)))
							else
								local var_93_1 = Mathf.Lerp(iter_93_1.color.r, 1, (arg_90_1.time_ - 0) / var_93_0)

								iter_93_1.color = Color.New(var_93_1, var_93_1, var_93_1)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["10113"]) and arg_90_1.var_.actorSpriteComps10113 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_90_1.var_.actorSpriteComps10113 = nil
			end

			local var_93_2 = 0
			local var_93_3 = 0.25

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_4 = arg_90_1:GetWordFromCfg(417171021)
				local var_93_5 = arg_90_1:FormatText(var_93_4.content)

				arg_90_1.text_.text = var_93_5

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_7 = 10 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 10)

				if (10 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 10)) > 0 and var_93_3 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_2
					end
				end

				arg_90_1.text_.text = var_93_5
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171021", "story_v_out_417171.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_417171", "417171021", "story_v_out_417171.awb") / 1000

					if var_93_8 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_2
					end

					if var_93_4.prefab_name ~= "" and arg_90_1.actors_[var_93_4.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_4.prefab_name].transform, "story_v_out_417171", "417171021", "story_v_out_417171.awb")

						arg_90_1:RecordAudio("417171021", var_93_9)
						arg_90_1:RecordAudio("417171021", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417171", "417171021", "story_v_out_417171.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417171", "417171021", "story_v_out_417171.awb")
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
	Play417171022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417171022
		arg_94_1.duration_ = 8.6

		local var_94_0 = {
			zh = 7.833,
			ja = 8.6
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
				arg_94_0:Play417171023(arg_94_1)
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

			local var_97_2 = arg_94_1.actors_["10113"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.actorSpriteComps10113 == nil then
				arg_94_1.var_.actorSpriteComps10113 = var_97_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_3 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.actorSpriteComps10113 then
					for iter_97_4, iter_97_5 in pairs(arg_94_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_97_5 then
							if arg_94_1.isInRecall_ then
								iter_97_5.color = Color.New(Mathf.Lerp(iter_97_5.color.r, arg_94_1.hightColor2.r, (arg_94_1.time_ - 0) / var_97_3), Mathf.Lerp(iter_97_5.color.g, arg_94_1.hightColor2.g, (arg_94_1.time_ - 0) / var_97_3), (Mathf.Lerp(iter_97_5.color.b, arg_94_1.hightColor2.b, (arg_94_1.time_ - 0) / var_97_3)))
							else
								local var_97_4 = Mathf.Lerp(iter_97_5.color.r, 0.5, (arg_94_1.time_ - 0) / var_97_3)

								iter_97_5.color = Color.New(var_97_4, var_97_4, var_97_4)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.actorSpriteComps10113 then
				for iter_97_6, iter_97_7 in pairs(arg_94_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_97_7 then
						iter_97_7.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_94_1.var_.actorSpriteComps10113 = nil
			end

			local var_97_5 = 0
			local var_97_6 = 0.775

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

				local var_97_7 = arg_94_1:GetWordFromCfg(417171022)
				local var_97_8 = arg_94_1:FormatText(var_97_7.content)

				arg_94_1.text_.text = var_97_8

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_10 = 31 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_8) / 31)

				if (31 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_8) / 31)) > 0 and var_97_6 < var_97_10 then
					arg_94_1.talkMaxDuration = var_97_10

					if var_97_10 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_5
					end
				end

				arg_94_1.text_.text = var_97_8
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171022", "story_v_out_417171.awb") ~= 0 then
					local var_97_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171022", "story_v_out_417171.awb") / 1000

					if var_97_11 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_11 + var_97_5
					end

					if var_97_7.prefab_name ~= "" and arg_94_1.actors_[var_97_7.prefab_name] ~= nil then
						local var_97_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_7.prefab_name].transform, "story_v_out_417171", "417171022", "story_v_out_417171.awb")

						arg_94_1:RecordAudio("417171022", var_97_12)
						arg_94_1:RecordAudio("417171022", var_97_12)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417171", "417171022", "story_v_out_417171.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417171", "417171022", "story_v_out_417171.awb")
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

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play417171023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417171023
		arg_98_1.duration_ = 12.1

		local var_98_0 = {
			zh = 10.033,
			ja = 12.1
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
				arg_98_0:Play417171024(arg_98_1)
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
								iter_101_1.color = Color.New(Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor1.r, (arg_98_1.time_ - 0) / var_101_0), Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor1.g, (arg_98_1.time_ - 0) / var_101_0), (Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor1.b, (arg_98_1.time_ - 0) / var_101_0)))
							else
								local var_101_1 = Mathf.Lerp(iter_101_1.color.r, 1, (arg_98_1.time_ - 0) / var_101_0)

								iter_101_1.color = Color.New(var_101_1, var_101_1, var_101_1)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["10113"]) and arg_98_1.var_.actorSpriteComps10113 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_101_3 then
						iter_101_3.color = arg_98_1.isInRecall_ and (arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_98_1.var_.actorSpriteComps10113 = nil
			end

			local var_101_2 = arg_98_1.actors_["10128"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.actorSpriteComps10128 == nil then
				arg_98_1.var_.actorSpriteComps10128 = var_101_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_3 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 and not isNil(var_101_2) then
				if arg_98_1.var_.actorSpriteComps10128 then
					for iter_101_4, iter_101_5 in pairs(arg_98_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_101_5 then
							if arg_98_1.isInRecall_ then
								iter_101_5.color = Color.New(Mathf.Lerp(iter_101_5.color.r, arg_98_1.hightColor2.r, (arg_98_1.time_ - 0) / var_101_3), Mathf.Lerp(iter_101_5.color.g, arg_98_1.hightColor2.g, (arg_98_1.time_ - 0) / var_101_3), (Mathf.Lerp(iter_101_5.color.b, arg_98_1.hightColor2.b, (arg_98_1.time_ - 0) / var_101_3)))
							else
								local var_101_4 = Mathf.Lerp(iter_101_5.color.r, 0.5, (arg_98_1.time_ - 0) / var_101_3)

								iter_101_5.color = Color.New(var_101_4, var_101_4, var_101_4)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.actorSpriteComps10128 then
				for iter_101_6, iter_101_7 in pairs(arg_98_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_101_7 then
						iter_101_7.color = arg_98_1.isInRecall_ and (arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_98_1.var_.actorSpriteComps10128 = nil
			end

			local var_101_5 = 0
			local var_101_6 = 1.275

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_7 = arg_98_1:GetWordFromCfg(417171023)
				local var_101_8 = arg_98_1:FormatText(var_101_7.content)

				arg_98_1.text_.text = var_101_8

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_10 = 51 <= 0 and var_101_6 or var_101_6 * (utf8.len(var_101_8) / 51)

				if (51 <= 0 and var_101_6 or var_101_6 * (utf8.len(var_101_8) / 51)) > 0 and var_101_6 < var_101_10 then
					arg_98_1.talkMaxDuration = var_101_10

					if var_101_10 + var_101_5 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_5
					end
				end

				arg_98_1.text_.text = var_101_8
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171023", "story_v_out_417171.awb") ~= 0 then
					local var_101_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171023", "story_v_out_417171.awb") / 1000

					if var_101_11 + var_101_5 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_11 + var_101_5
					end

					if var_101_7.prefab_name ~= "" and arg_98_1.actors_[var_101_7.prefab_name] ~= nil then
						local var_101_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_7.prefab_name].transform, "story_v_out_417171", "417171023", "story_v_out_417171.awb")

						arg_98_1:RecordAudio("417171023", var_101_12)
						arg_98_1:RecordAudio("417171023", var_101_12)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_417171", "417171023", "story_v_out_417171.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_417171", "417171023", "story_v_out_417171.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_13 = math.max(var_101_6, arg_98_1.talkMaxDuration)

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_13 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_5) / var_101_13

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_5 + var_101_13 and arg_98_1.time_ < var_101_5 + var_101_13 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play417171024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417171024
		arg_102_1.duration_ = 7.93

		local var_102_0 = {
			zh = 6.466,
			ja = 7.933
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
				arg_102_0:Play417171025(arg_102_1)
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

			local var_105_2 = arg_102_1.actors_["10113"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.actorSpriteComps10113 == nil then
				arg_102_1.var_.actorSpriteComps10113 = var_105_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_3 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.actorSpriteComps10113 then
					for iter_105_4, iter_105_5 in pairs(arg_102_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_105_5 then
							if arg_102_1.isInRecall_ then
								iter_105_5.color = Color.New(Mathf.Lerp(iter_105_5.color.r, arg_102_1.hightColor2.r, (arg_102_1.time_ - 0) / var_105_3), Mathf.Lerp(iter_105_5.color.g, arg_102_1.hightColor2.g, (arg_102_1.time_ - 0) / var_105_3), (Mathf.Lerp(iter_105_5.color.b, arg_102_1.hightColor2.b, (arg_102_1.time_ - 0) / var_105_3)))
							else
								local var_105_4 = Mathf.Lerp(iter_105_5.color.r, 0.5, (arg_102_1.time_ - 0) / var_105_3)

								iter_105_5.color = Color.New(var_105_4, var_105_4, var_105_4)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.actorSpriteComps10113 then
				for iter_105_6, iter_105_7 in pairs(arg_102_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_105_7 then
						iter_105_7.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_102_1.var_.actorSpriteComps10113 = nil
			end

			local var_105_5 = 0
			local var_105_6 = 0.7

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

				local var_105_7 = arg_102_1:GetWordFromCfg(417171024)
				local var_105_8 = arg_102_1:FormatText(var_105_7.content)

				arg_102_1.text_.text = var_105_8

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_10 = 28 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_8) / 28)

				if (28 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_8) / 28)) > 0 and var_105_6 < var_105_10 then
					arg_102_1.talkMaxDuration = var_105_10

					if var_105_10 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_5
					end
				end

				arg_102_1.text_.text = var_105_8
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171024", "story_v_out_417171.awb") ~= 0 then
					local var_105_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171024", "story_v_out_417171.awb") / 1000

					if var_105_11 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_11 + var_105_5
					end

					if var_105_7.prefab_name ~= "" and arg_102_1.actors_[var_105_7.prefab_name] ~= nil then
						local var_105_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_7.prefab_name].transform, "story_v_out_417171", "417171024", "story_v_out_417171.awb")

						arg_102_1:RecordAudio("417171024", var_105_12)
						arg_102_1:RecordAudio("417171024", var_105_12)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_417171", "417171024", "story_v_out_417171.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_417171", "417171024", "story_v_out_417171.awb")
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

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play417171025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417171025
		arg_106_1.duration_ = 6.33

		local var_106_0 = {
			zh = 4.033,
			ja = 6.333
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
				arg_106_0:Play417171026(arg_106_1)
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
								iter_109_1.color = Color.New(Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor1.r, (arg_106_1.time_ - 0) / var_109_0), Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor1.g, (arg_106_1.time_ - 0) / var_109_0), (Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor1.b, (arg_106_1.time_ - 0) / var_109_0)))
							else
								local var_109_1 = Mathf.Lerp(iter_109_1.color.r, 1, (arg_106_1.time_ - 0) / var_109_0)

								iter_109_1.color = Color.New(var_109_1, var_109_1, var_109_1)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["10113"]) and arg_106_1.var_.actorSpriteComps10113 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_109_3 then
						iter_109_3.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_106_1.var_.actorSpriteComps10113 = nil
			end

			local var_109_2 = arg_106_1.actors_["10128"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.actorSpriteComps10128 == nil then
				arg_106_1.var_.actorSpriteComps10128 = var_109_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_3 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.actorSpriteComps10128 then
					for iter_109_4, iter_109_5 in pairs(arg_106_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_109_5 then
							if arg_106_1.isInRecall_ then
								iter_109_5.color = Color.New(Mathf.Lerp(iter_109_5.color.r, arg_106_1.hightColor2.r, (arg_106_1.time_ - 0) / var_109_3), Mathf.Lerp(iter_109_5.color.g, arg_106_1.hightColor2.g, (arg_106_1.time_ - 0) / var_109_3), (Mathf.Lerp(iter_109_5.color.b, arg_106_1.hightColor2.b, (arg_106_1.time_ - 0) / var_109_3)))
							else
								local var_109_4 = Mathf.Lerp(iter_109_5.color.r, 0.5, (arg_106_1.time_ - 0) / var_109_3)

								iter_109_5.color = Color.New(var_109_4, var_109_4, var_109_4)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.actorSpriteComps10128 then
				for iter_109_6, iter_109_7 in pairs(arg_106_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_109_7 then
						iter_109_7.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_106_1.var_.actorSpriteComps10128 = nil
			end

			local var_109_5 = arg_106_1.actors_["10113"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos10113 = var_109_5.localPosition
				var_109_5.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("10113", 4)

				for iter_109_8 = 0, var_109_5.childCount - 1 do
					local var_109_6 = var_109_5:GetChild(iter_109_8)

					if var_109_6.name == "split_6" or not string.find(var_109_6.name, "split") then
						var_109_6.gameObject:SetActive(true)
					else
						var_109_6.gameObject:SetActive(false)
					end
				end
			end

			local var_109_7 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				var_109_5.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10113, Vector3.New(377.3, -328.4, -517.4), (arg_106_1.time_ - 0) / var_109_7)
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				var_109_5.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_109_8 = 0
			local var_109_9 = 0.5

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_10 = arg_106_1:GetWordFromCfg(417171025)
				local var_109_11 = arg_106_1:FormatText(var_109_10.content)

				arg_106_1.text_.text = var_109_11

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_13 = 20 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_11) / 20)

				if (20 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_11) / 20)) > 0 and var_109_9 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_8
					end
				end

				arg_106_1.text_.text = var_109_11
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171025", "story_v_out_417171.awb") ~= 0 then
					local var_109_14 = manager.audio:GetVoiceLength("story_v_out_417171", "417171025", "story_v_out_417171.awb") / 1000

					if var_109_14 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_14 + var_109_8
					end

					if var_109_10.prefab_name ~= "" and arg_106_1.actors_[var_109_10.prefab_name] ~= nil then
						local var_109_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_10.prefab_name].transform, "story_v_out_417171", "417171025", "story_v_out_417171.awb")

						arg_106_1:RecordAudio("417171025", var_109_15)
						arg_106_1:RecordAudio("417171025", var_109_15)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_417171", "417171025", "story_v_out_417171.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_417171", "417171025", "story_v_out_417171.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_16 = math.max(var_109_9, arg_106_1.talkMaxDuration)

			if var_109_8 <= arg_106_1.time_ and arg_106_1.time_ < var_109_8 + var_109_16 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_8) / var_109_16

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_8 + var_109_16 and arg_106_1.time_ < var_109_8 + var_109_16 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play417171026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 417171026
		arg_110_1.duration_ = 5.5

		local var_110_0 = {
			zh = 3.933,
			ja = 5.5
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
				arg_110_0:Play417171027(arg_110_1)
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

			local var_113_2 = arg_110_1.actors_["10113"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.actorSpriteComps10113 == nil then
				arg_110_1.var_.actorSpriteComps10113 = var_113_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_3 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 and not isNil(var_113_2) then
				if arg_110_1.var_.actorSpriteComps10113 then
					for iter_113_4, iter_113_5 in pairs(arg_110_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_113_5 then
							if arg_110_1.isInRecall_ then
								iter_113_5.color = Color.New(Mathf.Lerp(iter_113_5.color.r, arg_110_1.hightColor2.r, (arg_110_1.time_ - 0) / var_113_3), Mathf.Lerp(iter_113_5.color.g, arg_110_1.hightColor2.g, (arg_110_1.time_ - 0) / var_113_3), (Mathf.Lerp(iter_113_5.color.b, arg_110_1.hightColor2.b, (arg_110_1.time_ - 0) / var_113_3)))
							else
								local var_113_4 = Mathf.Lerp(iter_113_5.color.r, 0.5, (arg_110_1.time_ - 0) / var_113_3)

								iter_113_5.color = Color.New(var_113_4, var_113_4, var_113_4)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.actorSpriteComps10113 then
				for iter_113_6, iter_113_7 in pairs(arg_110_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_113_7 then
						iter_113_7.color = arg_110_1.isInRecall_ and (arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_110_1.var_.actorSpriteComps10113 = nil
			end

			local var_113_5 = 0
			local var_113_6 = 0.45

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

				local var_113_7 = arg_110_1:GetWordFromCfg(417171026)
				local var_113_8 = arg_110_1:FormatText(var_113_7.content)

				arg_110_1.text_.text = var_113_8

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_10 = 18 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_8) / 18)

				if (18 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_8) / 18)) > 0 and var_113_6 < var_113_10 then
					arg_110_1.talkMaxDuration = var_113_10

					if var_113_10 + var_113_5 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_5
					end
				end

				arg_110_1.text_.text = var_113_8
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171026", "story_v_out_417171.awb") ~= 0 then
					local var_113_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171026", "story_v_out_417171.awb") / 1000

					if var_113_11 + var_113_5 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_11 + var_113_5
					end

					if var_113_7.prefab_name ~= "" and arg_110_1.actors_[var_113_7.prefab_name] ~= nil then
						local var_113_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_7.prefab_name].transform, "story_v_out_417171", "417171026", "story_v_out_417171.awb")

						arg_110_1:RecordAudio("417171026", var_113_12)
						arg_110_1:RecordAudio("417171026", var_113_12)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_417171", "417171026", "story_v_out_417171.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_417171", "417171026", "story_v_out_417171.awb")
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

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play417171027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 417171027
		arg_114_1.duration_ = 9

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play417171028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 4 < arg_114_1.time_ and arg_114_1.time_ <= 4 + arg_117_0 then
				arg_114_1.allBtn_.enabled = false
			end

			if arg_114_1.time_ >= 4 + 0.666666666666667 and arg_114_1.time_ < 4 + 0.666666666666667 + arg_117_0 then
				arg_114_1.allBtn_.enabled = true
			end

			local var_117_0 = "I17f"

			if arg_114_1.bgs_.I17f == nil then
				local var_117_1 = Object.Instantiate(arg_114_1.paintGo_)

				var_117_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_117_0)
				var_117_1.name = var_117_0
				var_117_1.transform.parent = arg_114_1.stage_.transform
				var_117_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.bgs_[var_117_0] = var_117_1
			end

			if 2 < arg_114_1.time_ and arg_114_1.time_ <= 2 + arg_117_0 then
				local var_117_2 = arg_114_1.bgs_.I17f

				arg_114_1.bgs_.I17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_117_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_3 = var_117_2:GetComponent("SpriteRenderer")

				if var_117_3 and var_117_3.sprite then
					local var_117_4 = 2 * (var_117_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_117_2.transform.localScale = Vector3.New(var_117_4 / var_117_3.sprite.bounds.size.y < var_117_4 * manager.ui.mainCameraCom_.aspect / var_117_3.sprite.bounds.size.x and var_117_4 * manager.ui.mainCameraCom_.aspect / var_117_3.sprite.bounds.size.x or var_117_4 / var_117_3.sprite.bounds.size.y, var_117_4 / var_117_3.sprite.bounds.size.y < var_117_4 * manager.ui.mainCameraCom_.aspect / var_117_3.sprite.bounds.size.x and var_117_4 * manager.ui.mainCameraCom_.aspect / var_117_3.sprite.bounds.size.x or var_117_4 / var_117_3.sprite.bounds.size.y, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "I17f" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_5 = 0

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_6 = 2

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 then
				local var_117_7 = Color.New(0, 0, 0)

				var_117_7.a = Mathf.Lerp(0, 1, (arg_114_1.time_ - var_117_5) / var_117_6)
				arg_114_1.mask_.color = var_117_7
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 then
				local var_117_8 = Color.New(0, 0, 0)

				var_117_8.a = 1
				arg_114_1.mask_.color = var_117_8
			end

			local var_117_9 = 2

			if 2 < arg_114_1.time_ and arg_114_1.time_ <= var_117_9 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_10 = 2

			if var_117_9 <= arg_114_1.time_ and arg_114_1.time_ < var_117_9 + var_117_10 then
				local var_117_11 = Color.New(0, 0, 0)

				var_117_11.a = Mathf.Lerp(1, 0, (arg_114_1.time_ - var_117_9) / var_117_10)
				arg_114_1.mask_.color = var_117_11
			end

			if arg_114_1.time_ >= var_117_9 + var_117_10 and arg_114_1.time_ < var_117_9 + var_117_10 + arg_117_0 then
				local var_117_12 = Color.New(0, 0, 0)

				arg_114_1.mask_.enabled = false
				var_117_12.a = 0
				arg_114_1.mask_.color = var_117_12
			end

			local var_117_13 = arg_114_1.actors_["10128"].transform

			if 1.966 < arg_114_1.time_ and arg_114_1.time_ <= 1.966 + arg_117_0 then
				arg_114_1.var_.moveOldPos10128 = var_117_13.localPosition
				var_117_13.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("10128", 7)

				for iter_117_2 = 0, var_117_13.childCount - 1 do
					local var_117_14 = var_117_13:GetChild(iter_117_2)

					if var_117_14.name == "" or not string.find(var_117_14.name, "split") then
						var_117_14.gameObject:SetActive(true)
					else
						var_117_14.gameObject:SetActive(false)
					end
				end
			end

			local var_117_15 = 0.001

			if 1.966 <= arg_114_1.time_ and arg_114_1.time_ < 1.966 + var_117_15 then
				var_117_13.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_114_1.time_ - 1.966) / var_117_15)
			end

			if arg_114_1.time_ >= 1.966 + var_117_15 and arg_114_1.time_ < 1.966 + var_117_15 + arg_117_0 then
				var_117_13.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_117_16 = arg_114_1.actors_["10113"].transform

			if 1.966 < arg_114_1.time_ and arg_114_1.time_ <= 1.966 + arg_117_0 then
				arg_114_1.var_.moveOldPos10113 = var_117_16.localPosition
				var_117_16.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("10113", 7)

				for iter_117_3 = 0, var_117_16.childCount - 1 do
					local var_117_17 = var_117_16:GetChild(iter_117_3)

					if var_117_17.name == "" or not string.find(var_117_17.name, "split") then
						var_117_17.gameObject:SetActive(true)
					else
						var_117_17.gameObject:SetActive(false)
					end
				end
			end

			local var_117_18 = 0.001

			if 1.966 <= arg_114_1.time_ and arg_114_1.time_ < 1.966 + var_117_18 then
				var_117_16.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_114_1.time_ - 1.966) / var_117_18)
			end

			if arg_114_1.time_ >= 1.966 + var_117_18 and arg_114_1.time_ < 1.966 + var_117_18 + arg_117_0 then
				var_117_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 4 < arg_114_1.time_ and arg_114_1.time_ <= 4 + arg_117_0 then
				arg_114_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_car02", "")
			end

			if 1.7 < arg_114_1.time_ and arg_114_1.time_ <= 1.7 + arg_117_0 then
				arg_114_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_117_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
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

			if 1.7 < arg_114_1.time_ and arg_114_1.time_ <= 1.7 + arg_117_0 then
				arg_114_1:AudioAction("play", "music", "bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain.awb")

				local var_117_26 = manager.audio:GetAudioName("bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain")

				if "" ~= "" then
					if arg_114_1.bgmTxt_.text ~= var_117_26 and arg_114_1.bgmTxt_.text ~= "" then
						if arg_114_1.bgmTxt2_.text ~= "" then
							arg_114_1.bgmTxt_.text = arg_114_1.bgmTxt2_.text
						end

						arg_114_1.bgmTxt2_.text = var_117_26

						arg_114_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_114_1.bgmTxt_.text = var_117_26
						arg_114_1.bgmTxt2_.text = var_117_26
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

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_27 = 3.999999999999
			local var_117_28 = 1.225

			if 3.999999999999 < arg_114_1.time_ and arg_114_1.time_ <= var_117_27 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_29 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_29:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_114_1.dialogCg_.alpha = arg_120_0
				end))
				var_117_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_30 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(417171027).content)

				arg_114_1.text_.text = var_117_30

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_32 = 49 <= 0 and var_117_28 or var_117_28 * (utf8.len(var_117_30) / 49)

				if (49 <= 0 and var_117_28 or var_117_28 * (utf8.len(var_117_30) / 49)) > 0 and var_117_28 < var_117_32 then
					arg_114_1.talkMaxDuration = var_117_32
					var_117_27 = var_117_27 + 0.3

					if var_117_32 + var_117_27 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_32 + var_117_27
					end
				end

				arg_114_1.text_.text = var_117_30
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_33 = var_117_27 + 0.3
			local var_117_34 = math.max(var_117_28, arg_114_1.talkMaxDuration)

			if var_117_27 + 0.3 <= arg_114_1.time_ and arg_114_1.time_ < var_117_33 + var_117_34 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_33) / var_117_34

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_33 + var_117_34 and arg_114_1.time_ < var_117_33 + var_117_34 + arg_117_0 then
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
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play417171028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 417171028
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play417171029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 1.4

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_1 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(417171028).content)

				arg_122_1.text_.text = var_125_1

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_3 = 56 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 56)

				if (56 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 56)) > 0 and var_125_0 < var_125_3 then
					arg_122_1.talkMaxDuration = var_125_3

					if var_125_3 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_3 + 0
					end
				end

				arg_122_1.text_.text = var_125_1
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_4 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_4

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play417171029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 417171029
		arg_126_1.duration_ = 5.83

		local var_126_0 = {
			zh = 2.733,
			ja = 5.833
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
				arg_126_0:Play417171030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if arg_126_1.actors_["10120"] == nil then
				local var_129_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10120")

				if not isNil(var_129_0) then
					local var_129_1 = Object.Instantiate(var_129_0, arg_126_1.canvasGo_.transform)

					var_129_1.transform:SetSiblingIndex(1)

					var_129_1.name = "10120"
					var_129_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_126_1.actors_["10120"] = var_129_1

					if arg_126_1.isInRecall_ then
						for iter_129_0, iter_129_1 in ipairs((var_129_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_129_1.color = arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_129_2 = arg_126_1.actors_["10120"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.actorSpriteComps10120 == nil then
				arg_126_1.var_.actorSpriteComps10120 = var_129_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_3 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_3 and not isNil(var_129_2) then
				if arg_126_1.var_.actorSpriteComps10120 then
					for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_129_3 then
							if arg_126_1.isInRecall_ then
								iter_129_3.color = Color.New(Mathf.Lerp(iter_129_3.color.r, arg_126_1.hightColor1.r, (arg_126_1.time_ - 0) / var_129_3), Mathf.Lerp(iter_129_3.color.g, arg_126_1.hightColor1.g, (arg_126_1.time_ - 0) / var_129_3), (Mathf.Lerp(iter_129_3.color.b, arg_126_1.hightColor1.b, (arg_126_1.time_ - 0) / var_129_3)))
							else
								local var_129_4 = Mathf.Lerp(iter_129_3.color.r, 1, (arg_126_1.time_ - 0) / var_129_3)

								iter_129_3.color = Color.New(var_129_4, var_129_4, var_129_4)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_3 and arg_126_1.time_ < 0 + var_129_3 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.actorSpriteComps10120 then
				for iter_129_4, iter_129_5 in pairs(arg_126_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_129_5 then
						iter_129_5.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_126_1.var_.actorSpriteComps10120 = nil
			end

			local var_129_5 = arg_126_1.actors_["10120"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos10120 = var_129_5.localPosition
				var_129_5.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("10120", 3)

				for iter_129_6 = 0, var_129_5.childCount - 1 do
					local var_129_6 = var_129_5:GetChild(iter_129_6)

					if var_129_6.name == "" or not string.find(var_129_6.name, "split") then
						var_129_6.gameObject:SetActive(true)
					else
						var_129_6.gameObject:SetActive(false)
					end
				end
			end

			local var_129_7 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 then
				var_129_5.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10120, Vector3.New(0, -260.5, -275), (arg_126_1.time_ - 0) / var_129_7)
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 then
				var_129_5.localPosition = Vector3.New(0, -260.5, -275)
			end

			local var_129_8 = 0
			local var_129_9 = 0.3

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1141].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_10 = arg_126_1:GetWordFromCfg(417171029)
				local var_129_11 = arg_126_1:FormatText(var_129_10.content)

				arg_126_1.text_.text = var_129_11

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_13 = 12 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 12)

				if (12 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 12)) > 0 and var_129_9 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_8
					end
				end

				arg_126_1.text_.text = var_129_11
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171029", "story_v_out_417171.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_417171", "417171029", "story_v_out_417171.awb") / 1000

					if var_129_14 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_8
					end

					if var_129_10.prefab_name ~= "" and arg_126_1.actors_[var_129_10.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_10.prefab_name].transform, "story_v_out_417171", "417171029", "story_v_out_417171.awb")

						arg_126_1:RecordAudio("417171029", var_129_15)
						arg_126_1:RecordAudio("417171029", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_417171", "417171029", "story_v_out_417171.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_417171", "417171029", "story_v_out_417171.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_9, arg_126_1.talkMaxDuration)

			if var_129_8 <= arg_126_1.time_ and arg_126_1.time_ < var_129_8 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_8) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_8 + var_129_16 and arg_126_1.time_ < var_129_8 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10120",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play417171030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 417171030
		arg_130_1.duration_ = 2.23

		local var_130_0 = {
			zh = 1.766,
			ja = 2.233
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
				arg_130_0:Play417171031(arg_130_1)
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

					if var_133_3.name == "" or not string.find(var_133_3.name, "split") then
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
			local var_133_6 = 0.225

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

				local var_133_7 = arg_130_1:GetWordFromCfg(417171030)
				local var_133_8 = arg_130_1:FormatText(var_133_7.content)

				arg_130_1.text_.text = var_133_8

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_10 = 9 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_8) / 9)

				if (9 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_8) / 9)) > 0 and var_133_6 < var_133_10 then
					arg_130_1.talkMaxDuration = var_133_10

					if var_133_10 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_5
					end
				end

				arg_130_1.text_.text = var_133_8
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171030", "story_v_out_417171.awb") ~= 0 then
					local var_133_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171030", "story_v_out_417171.awb") / 1000

					if var_133_11 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_5
					end

					if var_133_7.prefab_name ~= "" and arg_130_1.actors_[var_133_7.prefab_name] ~= nil then
						local var_133_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_7.prefab_name].transform, "story_v_out_417171", "417171030", "story_v_out_417171.awb")

						arg_130_1:RecordAudio("417171030", var_133_12)
						arg_130_1:RecordAudio("417171030", var_133_12)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_417171", "417171030", "story_v_out_417171.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_417171", "417171030", "story_v_out_417171.awb")
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
	Play417171031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 417171031
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play417171032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["10128"]) and arg_134_1.var_.actorSpriteComps10128 == nil then
				arg_134_1.var_.actorSpriteComps10128 = arg_134_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_0 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["10128"]) then
				if arg_134_1.var_.actorSpriteComps10128 then
					for iter_137_0, iter_137_1 in pairs(arg_134_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_137_1 then
							if arg_134_1.isInRecall_ then
								iter_137_1.color = Color.New(Mathf.Lerp(iter_137_1.color.r, arg_134_1.hightColor2.r, (arg_134_1.time_ - 0) / var_137_0), Mathf.Lerp(iter_137_1.color.g, arg_134_1.hightColor2.g, (arg_134_1.time_ - 0) / var_137_0), (Mathf.Lerp(iter_137_1.color.b, arg_134_1.hightColor2.b, (arg_134_1.time_ - 0) / var_137_0)))
							else
								local var_137_1 = Mathf.Lerp(iter_137_1.color.r, 0.5, (arg_134_1.time_ - 0) / var_137_0)

								iter_137_1.color = Color.New(var_137_1, var_137_1, var_137_1)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["10128"]) and arg_134_1.var_.actorSpriteComps10128 then
				for iter_137_2, iter_137_3 in pairs(arg_134_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_137_3 then
						iter_137_3.color = arg_134_1.isInRecall_ and (arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_134_1.var_.actorSpriteComps10128 = nil
			end

			if 1.63333333333333 < arg_134_1.time_ and arg_134_1.time_ <= 1.63333333333333 + arg_137_0 then
				arg_134_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_knockcar", "")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_cardoor03", "")
			end

			local var_137_4 = 0
			local var_137_5 = 0.9

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(417171031).content)

				arg_134_1.text_.text = var_137_6

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_8 = 36 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_6) / 36)

				if (36 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_6) / 36)) > 0 and var_137_5 < var_137_8 then
					arg_134_1.talkMaxDuration = var_137_8

					if var_137_8 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_6
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_9 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_9 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_9

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_9 and arg_134_1.time_ < var_137_4 + var_137_9 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play417171032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 417171032
		arg_138_1.duration_ = 4.9

		local var_138_0 = {
			zh = 1.866,
			ja = 4.9
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
				arg_138_0:Play417171033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["10120"]) and arg_138_1.var_.actorSpriteComps10120 == nil then
				arg_138_1.var_.actorSpriteComps10120 = arg_138_1.actors_["10120"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_0 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["10120"]) then
				if arg_138_1.var_.actorSpriteComps10120 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								iter_141_1.color = Color.New(Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor1.r, (arg_138_1.time_ - 0) / var_141_0), Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor1.g, (arg_138_1.time_ - 0) / var_141_0), (Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor1.b, (arg_138_1.time_ - 0) / var_141_0)))
							else
								local var_141_1 = Mathf.Lerp(iter_141_1.color.r, 1, (arg_138_1.time_ - 0) / var_141_0)

								iter_141_1.color = Color.New(var_141_1, var_141_1, var_141_1)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["10120"]) and arg_138_1.var_.actorSpriteComps10120 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_141_3 then
						iter_141_3.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_138_1.var_.actorSpriteComps10120 = nil
			end

			local var_141_2 = arg_138_1.actors_["10120"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos10120 = var_141_2.localPosition
				var_141_2.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("10120", 4)

				for iter_141_4 = 0, var_141_2.childCount - 1 do
					local var_141_3 = var_141_2:GetChild(iter_141_4)

					if var_141_3.name == "" or not string.find(var_141_3.name, "split") then
						var_141_3.gameObject:SetActive(true)
					else
						var_141_3.gameObject:SetActive(false)
					end
				end
			end

			local var_141_4 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 then
				var_141_2.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10120, Vector3.New(390, -260.5, -275), (arg_138_1.time_ - 0) / var_141_4)
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 then
				var_141_2.localPosition = Vector3.New(390, -260.5, -275)
			end

			local var_141_5 = arg_138_1.actors_["10128"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos10128 = var_141_5.localPosition
				var_141_5.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("10128", 2)

				for iter_141_5 = 0, var_141_5.childCount - 1 do
					local var_141_6 = var_141_5:GetChild(iter_141_5)

					if var_141_6.name == "" or not string.find(var_141_6.name, "split") then
						var_141_6.gameObject:SetActive(true)
					else
						var_141_6.gameObject:SetActive(false)
					end
				end
			end

			local var_141_7 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_7 then
				var_141_5.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_138_1.time_ - 0) / var_141_7)
			end

			if arg_138_1.time_ >= 0 + var_141_7 and arg_138_1.time_ < 0 + var_141_7 + arg_141_0 then
				var_141_5.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_141_8 = arg_138_1.actors_["10128"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_8) and arg_138_1.var_.actorSpriteComps10128 == nil then
				arg_138_1.var_.actorSpriteComps10128 = var_141_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_9 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_9 and not isNil(var_141_8) then
				if arg_138_1.var_.actorSpriteComps10128 then
					for iter_141_6, iter_141_7 in pairs(arg_138_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_141_7 then
							if arg_138_1.isInRecall_ then
								iter_141_7.color = Color.New(Mathf.Lerp(iter_141_7.color.r, arg_138_1.hightColor2.r, (arg_138_1.time_ - 0) / var_141_9), Mathf.Lerp(iter_141_7.color.g, arg_138_1.hightColor2.g, (arg_138_1.time_ - 0) / var_141_9), (Mathf.Lerp(iter_141_7.color.b, arg_138_1.hightColor2.b, (arg_138_1.time_ - 0) / var_141_9)))
							else
								local var_141_10 = Mathf.Lerp(iter_141_7.color.r, 0.5, (arg_138_1.time_ - 0) / var_141_9)

								iter_141_7.color = Color.New(var_141_10, var_141_10, var_141_10)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_9 and arg_138_1.time_ < 0 + var_141_9 + arg_141_0 and not isNil(var_141_8) and arg_138_1.var_.actorSpriteComps10128 then
				for iter_141_8, iter_141_9 in pairs(arg_138_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_141_9 then
						iter_141_9.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_138_1.var_.actorSpriteComps10128 = nil
			end

			local var_141_11 = 0
			local var_141_12 = 0.225

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_11 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1141].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_13 = arg_138_1:GetWordFromCfg(417171032)
				local var_141_14 = arg_138_1:FormatText(var_141_13.content)

				arg_138_1.text_.text = var_141_14

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_16 = 9 <= 0 and var_141_12 or var_141_12 * (utf8.len(var_141_14) / 9)

				if (9 <= 0 and var_141_12 or var_141_12 * (utf8.len(var_141_14) / 9)) > 0 and var_141_12 < var_141_16 then
					arg_138_1.talkMaxDuration = var_141_16

					if var_141_16 + var_141_11 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_16 + var_141_11
					end
				end

				arg_138_1.text_.text = var_141_14
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171032", "story_v_out_417171.awb") ~= 0 then
					local var_141_17 = manager.audio:GetVoiceLength("story_v_out_417171", "417171032", "story_v_out_417171.awb") / 1000

					if var_141_17 + var_141_11 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_17 + var_141_11
					end

					if var_141_13.prefab_name ~= "" and arg_138_1.actors_[var_141_13.prefab_name] ~= nil then
						local var_141_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_13.prefab_name].transform, "story_v_out_417171", "417171032", "story_v_out_417171.awb")

						arg_138_1:RecordAudio("417171032", var_141_18)
						arg_138_1:RecordAudio("417171032", var_141_18)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_417171", "417171032", "story_v_out_417171.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_417171", "417171032", "story_v_out_417171.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_19 = math.max(var_141_12, arg_138_1.talkMaxDuration)

			if var_141_11 <= arg_138_1.time_ and arg_138_1.time_ < var_141_11 + var_141_19 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_11) / var_141_19

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_11 + var_141_19 and arg_138_1.time_ < var_141_11 + var_141_19 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10120",
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

		arg_138_1:InitPlayNodeList()
	end,
	Play417171033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 417171033
		arg_142_1.duration_ = 8.47

		local var_142_0 = {
			zh = 6.766,
			ja = 8.466
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
				arg_142_0:Play417171034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["10128"]) and arg_142_1.var_.actorSpriteComps10128 == nil then
				arg_142_1.var_.actorSpriteComps10128 = arg_142_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_0 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["10128"]) then
				if arg_142_1.var_.actorSpriteComps10128 then
					for iter_145_0, iter_145_1 in pairs(arg_142_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["10128"]) and arg_142_1.var_.actorSpriteComps10128 then
				for iter_145_2, iter_145_3 in pairs(arg_142_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_145_3 then
						iter_145_3.color = arg_142_1.isInRecall_ and (arg_142_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_142_1.var_.actorSpriteComps10128 = nil
			end

			local var_145_2 = arg_142_1.actors_["10120"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.actorSpriteComps10120 == nil then
				arg_142_1.var_.actorSpriteComps10120 = var_145_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_3 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_3 and not isNil(var_145_2) then
				if arg_142_1.var_.actorSpriteComps10120 then
					for iter_145_4, iter_145_5 in pairs(arg_142_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_145_5 then
							if arg_142_1.isInRecall_ then
								iter_145_5.color = Color.New(Mathf.Lerp(iter_145_5.color.r, arg_142_1.hightColor2.r, (arg_142_1.time_ - 0) / var_145_3), Mathf.Lerp(iter_145_5.color.g, arg_142_1.hightColor2.g, (arg_142_1.time_ - 0) / var_145_3), (Mathf.Lerp(iter_145_5.color.b, arg_142_1.hightColor2.b, (arg_142_1.time_ - 0) / var_145_3)))
							else
								local var_145_4 = Mathf.Lerp(iter_145_5.color.r, 0.5, (arg_142_1.time_ - 0) / var_145_3)

								iter_145_5.color = Color.New(var_145_4, var_145_4, var_145_4)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= 0 + var_145_3 and arg_142_1.time_ < 0 + var_145_3 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.actorSpriteComps10120 then
				for iter_145_6, iter_145_7 in pairs(arg_142_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_145_7 then
						iter_145_7.color = arg_142_1.isInRecall_ and (arg_142_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_142_1.var_.actorSpriteComps10120 = nil
			end

			local var_145_5 = 0
			local var_145_6 = 0.95

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_7 = arg_142_1:GetWordFromCfg(417171033)
				local var_145_8 = arg_142_1:FormatText(var_145_7.content)

				arg_142_1.text_.text = var_145_8

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_10 = 38 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_8) / 38)

				if (38 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_8) / 38)) > 0 and var_145_6 < var_145_10 then
					arg_142_1.talkMaxDuration = var_145_10

					if var_145_10 + var_145_5 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_5
					end
				end

				arg_142_1.text_.text = var_145_8
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171033", "story_v_out_417171.awb") ~= 0 then
					local var_145_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171033", "story_v_out_417171.awb") / 1000

					if var_145_11 + var_145_5 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_11 + var_145_5
					end

					if var_145_7.prefab_name ~= "" and arg_142_1.actors_[var_145_7.prefab_name] ~= nil then
						local var_145_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_7.prefab_name].transform, "story_v_out_417171", "417171033", "story_v_out_417171.awb")

						arg_142_1:RecordAudio("417171033", var_145_12)
						arg_142_1:RecordAudio("417171033", var_145_12)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_417171", "417171033", "story_v_out_417171.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_417171", "417171033", "story_v_out_417171.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_13 = math.max(var_145_6, arg_142_1.talkMaxDuration)

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_13 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_5) / var_145_13

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_5 + var_145_13 and arg_142_1.time_ < var_145_5 + var_145_13 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play417171034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417171034
		arg_146_1.duration_ = 3.73

		local var_146_0 = {
			zh = 2.133,
			ja = 3.733
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
				arg_146_0:Play417171035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["10128"]) and arg_146_1.var_.actorSpriteComps10128 == nil then
				arg_146_1.var_.actorSpriteComps10128 = arg_146_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_0 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["10128"]) then
				if arg_146_1.var_.actorSpriteComps10128 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_149_1 then
							if arg_146_1.isInRecall_ then
								iter_149_1.color = Color.New(Mathf.Lerp(iter_149_1.color.r, arg_146_1.hightColor2.r, (arg_146_1.time_ - 0) / var_149_0), Mathf.Lerp(iter_149_1.color.g, arg_146_1.hightColor2.g, (arg_146_1.time_ - 0) / var_149_0), (Mathf.Lerp(iter_149_1.color.b, arg_146_1.hightColor2.b, (arg_146_1.time_ - 0) / var_149_0)))
							else
								local var_149_1 = Mathf.Lerp(iter_149_1.color.r, 0.5, (arg_146_1.time_ - 0) / var_149_0)

								iter_149_1.color = Color.New(var_149_1, var_149_1, var_149_1)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["10128"]) and arg_146_1.var_.actorSpriteComps10128 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_149_3 then
						iter_149_3.color = arg_146_1.isInRecall_ and (arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_146_1.var_.actorSpriteComps10128 = nil
			end

			local var_149_2 = arg_146_1.actors_["10120"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.actorSpriteComps10120 == nil then
				arg_146_1.var_.actorSpriteComps10120 = var_149_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_3 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_3 and not isNil(var_149_2) then
				if arg_146_1.var_.actorSpriteComps10120 then
					for iter_149_4, iter_149_5 in pairs(arg_146_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_149_5 then
							if arg_146_1.isInRecall_ then
								iter_149_5.color = Color.New(Mathf.Lerp(iter_149_5.color.r, arg_146_1.hightColor1.r, (arg_146_1.time_ - 0) / var_149_3), Mathf.Lerp(iter_149_5.color.g, arg_146_1.hightColor1.g, (arg_146_1.time_ - 0) / var_149_3), (Mathf.Lerp(iter_149_5.color.b, arg_146_1.hightColor1.b, (arg_146_1.time_ - 0) / var_149_3)))
							else
								local var_149_4 = Mathf.Lerp(iter_149_5.color.r, 1, (arg_146_1.time_ - 0) / var_149_3)

								iter_149_5.color = Color.New(var_149_4, var_149_4, var_149_4)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= 0 + var_149_3 and arg_146_1.time_ < 0 + var_149_3 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.actorSpriteComps10120 then
				for iter_149_6, iter_149_7 in pairs(arg_146_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_149_7 then
						iter_149_7.color = arg_146_1.isInRecall_ and (arg_146_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_146_1.var_.actorSpriteComps10120 = nil
			end

			local var_149_5 = 0
			local var_149_6 = 0.25

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[1141].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_7 = arg_146_1:GetWordFromCfg(417171034)
				local var_149_8 = arg_146_1:FormatText(var_149_7.content)

				arg_146_1.text_.text = var_149_8

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_10 = 10 <= 0 and var_149_6 or var_149_6 * (utf8.len(var_149_8) / 10)

				if (10 <= 0 and var_149_6 or var_149_6 * (utf8.len(var_149_8) / 10)) > 0 and var_149_6 < var_149_10 then
					arg_146_1.talkMaxDuration = var_149_10

					if var_149_10 + var_149_5 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_5
					end
				end

				arg_146_1.text_.text = var_149_8
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171034", "story_v_out_417171.awb") ~= 0 then
					local var_149_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171034", "story_v_out_417171.awb") / 1000

					if var_149_11 + var_149_5 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_11 + var_149_5
					end

					if var_149_7.prefab_name ~= "" and arg_146_1.actors_[var_149_7.prefab_name] ~= nil then
						local var_149_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_7.prefab_name].transform, "story_v_out_417171", "417171034", "story_v_out_417171.awb")

						arg_146_1:RecordAudio("417171034", var_149_12)
						arg_146_1:RecordAudio("417171034", var_149_12)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_417171", "417171034", "story_v_out_417171.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_417171", "417171034", "story_v_out_417171.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_13 = math.max(var_149_6, arg_146_1.talkMaxDuration)

			if var_149_5 <= arg_146_1.time_ and arg_146_1.time_ < var_149_5 + var_149_13 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_5) / var_149_13

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_5 + var_149_13 and arg_146_1.time_ < var_149_5 + var_149_13 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play417171035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 417171035
		arg_150_1.duration_ = 7

		local var_150_0 = {
			zh = 5.1,
			ja = 7
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
				arg_150_0:Play417171036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["10128"]) and arg_150_1.var_.actorSpriteComps10128 == nil then
				arg_150_1.var_.actorSpriteComps10128 = arg_150_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_0 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["10128"]) then
				if arg_150_1.var_.actorSpriteComps10128 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								iter_153_1.color = Color.New(Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor1.r, (arg_150_1.time_ - 0) / var_153_0), Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor1.g, (arg_150_1.time_ - 0) / var_153_0), (Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor1.b, (arg_150_1.time_ - 0) / var_153_0)))
							else
								local var_153_1 = Mathf.Lerp(iter_153_1.color.r, 1, (arg_150_1.time_ - 0) / var_153_0)

								iter_153_1.color = Color.New(var_153_1, var_153_1, var_153_1)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["10128"]) and arg_150_1.var_.actorSpriteComps10128 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_153_3 then
						iter_153_3.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_150_1.var_.actorSpriteComps10128 = nil
			end

			local var_153_2 = arg_150_1.actors_["10120"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.actorSpriteComps10120 == nil then
				arg_150_1.var_.actorSpriteComps10120 = var_153_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_3 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 and not isNil(var_153_2) then
				if arg_150_1.var_.actorSpriteComps10120 then
					for iter_153_4, iter_153_5 in pairs(arg_150_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_153_5 then
							if arg_150_1.isInRecall_ then
								iter_153_5.color = Color.New(Mathf.Lerp(iter_153_5.color.r, arg_150_1.hightColor2.r, (arg_150_1.time_ - 0) / var_153_3), Mathf.Lerp(iter_153_5.color.g, arg_150_1.hightColor2.g, (arg_150_1.time_ - 0) / var_153_3), (Mathf.Lerp(iter_153_5.color.b, arg_150_1.hightColor2.b, (arg_150_1.time_ - 0) / var_153_3)))
							else
								local var_153_4 = Mathf.Lerp(iter_153_5.color.r, 0.5, (arg_150_1.time_ - 0) / var_153_3)

								iter_153_5.color = Color.New(var_153_4, var_153_4, var_153_4)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.actorSpriteComps10120 then
				for iter_153_6, iter_153_7 in pairs(arg_150_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_153_7 then
						iter_153_7.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_150_1.var_.actorSpriteComps10120 = nil
			end

			local var_153_5 = arg_150_1.actors_["10128"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos10128 = var_153_5.localPosition
				var_153_5.localScale = Vector3.New(1, 1, 1)

				arg_150_1:CheckSpriteTmpPos("10128", 2)

				for iter_153_8 = 0, var_153_5.childCount - 1 do
					local var_153_6 = var_153_5:GetChild(iter_153_8)

					if var_153_6.name == "split_6" or not string.find(var_153_6.name, "split") then
						var_153_6.gameObject:SetActive(true)
					else
						var_153_6.gameObject:SetActive(false)
					end
				end
			end

			local var_153_7 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				var_153_5.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_150_1.time_ - 0) / var_153_7)
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				var_153_5.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_153_8 = 0
			local var_153_9 = 0.7

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_8 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_10 = arg_150_1:GetWordFromCfg(417171035)
				local var_153_11 = arg_150_1:FormatText(var_153_10.content)

				arg_150_1.text_.text = var_153_11

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_13 = 28 <= 0 and var_153_9 or var_153_9 * (utf8.len(var_153_11) / 28)

				if (28 <= 0 and var_153_9 or var_153_9 * (utf8.len(var_153_11) / 28)) > 0 and var_153_9 < var_153_13 then
					arg_150_1.talkMaxDuration = var_153_13

					if var_153_13 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_13 + var_153_8
					end
				end

				arg_150_1.text_.text = var_153_11
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171035", "story_v_out_417171.awb") ~= 0 then
					local var_153_14 = manager.audio:GetVoiceLength("story_v_out_417171", "417171035", "story_v_out_417171.awb") / 1000

					if var_153_14 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_14 + var_153_8
					end

					if var_153_10.prefab_name ~= "" and arg_150_1.actors_[var_153_10.prefab_name] ~= nil then
						local var_153_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_10.prefab_name].transform, "story_v_out_417171", "417171035", "story_v_out_417171.awb")

						arg_150_1:RecordAudio("417171035", var_153_15)
						arg_150_1:RecordAudio("417171035", var_153_15)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_417171", "417171035", "story_v_out_417171.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_417171", "417171035", "story_v_out_417171.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_16 = math.max(var_153_9, arg_150_1.talkMaxDuration)

			if var_153_8 <= arg_150_1.time_ and arg_150_1.time_ < var_153_8 + var_153_16 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_8) / var_153_16

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_8 + var_153_16 and arg_150_1.time_ < var_153_8 + var_153_16 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
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

		arg_150_1:InitPlayNodeList()
	end,
	Play417171036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 417171036
		arg_154_1.duration_ = 5.1

		local var_154_0 = {
			zh = 3.366,
			ja = 5.1
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
				arg_154_0:Play417171037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["10128"]) and arg_154_1.var_.actorSpriteComps10128 == nil then
				arg_154_1.var_.actorSpriteComps10128 = arg_154_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_0 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["10128"]) then
				if arg_154_1.var_.actorSpriteComps10128 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								iter_157_1.color = Color.New(Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor2.r, (arg_154_1.time_ - 0) / var_157_0), Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor2.g, (arg_154_1.time_ - 0) / var_157_0), (Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor2.b, (arg_154_1.time_ - 0) / var_157_0)))
							else
								local var_157_1 = Mathf.Lerp(iter_157_1.color.r, 0.5, (arg_154_1.time_ - 0) / var_157_0)

								iter_157_1.color = Color.New(var_157_1, var_157_1, var_157_1)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["10128"]) and arg_154_1.var_.actorSpriteComps10128 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_157_3 then
						iter_157_3.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_154_1.var_.actorSpriteComps10128 = nil
			end

			local var_157_2 = arg_154_1.actors_["10120"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.actorSpriteComps10120 == nil then
				arg_154_1.var_.actorSpriteComps10120 = var_157_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_3 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_3 and not isNil(var_157_2) then
				if arg_154_1.var_.actorSpriteComps10120 then
					for iter_157_4, iter_157_5 in pairs(arg_154_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_157_5 then
							if arg_154_1.isInRecall_ then
								iter_157_5.color = Color.New(Mathf.Lerp(iter_157_5.color.r, arg_154_1.hightColor1.r, (arg_154_1.time_ - 0) / var_157_3), Mathf.Lerp(iter_157_5.color.g, arg_154_1.hightColor1.g, (arg_154_1.time_ - 0) / var_157_3), (Mathf.Lerp(iter_157_5.color.b, arg_154_1.hightColor1.b, (arg_154_1.time_ - 0) / var_157_3)))
							else
								local var_157_4 = Mathf.Lerp(iter_157_5.color.r, 1, (arg_154_1.time_ - 0) / var_157_3)

								iter_157_5.color = Color.New(var_157_4, var_157_4, var_157_4)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_3 and arg_154_1.time_ < 0 + var_157_3 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.actorSpriteComps10120 then
				for iter_157_6, iter_157_7 in pairs(arg_154_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_157_7 then
						iter_157_7.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_154_1.var_.actorSpriteComps10120 = nil
			end

			local var_157_5 = 0
			local var_157_6 = 0.425

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[1141].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_7 = arg_154_1:GetWordFromCfg(417171036)
				local var_157_8 = arg_154_1:FormatText(var_157_7.content)

				arg_154_1.text_.text = var_157_8

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_10 = 17 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_8) / 17)

				if (17 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_8) / 17)) > 0 and var_157_6 < var_157_10 then
					arg_154_1.talkMaxDuration = var_157_10

					if var_157_10 + var_157_5 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_5
					end
				end

				arg_154_1.text_.text = var_157_8
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171036", "story_v_out_417171.awb") ~= 0 then
					local var_157_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171036", "story_v_out_417171.awb") / 1000

					if var_157_11 + var_157_5 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_11 + var_157_5
					end

					if var_157_7.prefab_name ~= "" and arg_154_1.actors_[var_157_7.prefab_name] ~= nil then
						local var_157_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_7.prefab_name].transform, "story_v_out_417171", "417171036", "story_v_out_417171.awb")

						arg_154_1:RecordAudio("417171036", var_157_12)
						arg_154_1:RecordAudio("417171036", var_157_12)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_417171", "417171036", "story_v_out_417171.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_417171", "417171036", "story_v_out_417171.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_13 = math.max(var_157_6, arg_154_1.talkMaxDuration)

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_13 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_5) / var_157_13

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_5 + var_157_13 and arg_154_1.time_ < var_157_5 + var_157_13 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play417171037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 417171037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play417171038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["10120"]) and arg_158_1.var_.actorSpriteComps10120 == nil then
				arg_158_1.var_.actorSpriteComps10120 = arg_158_1.actors_["10120"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_0 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["10120"]) then
				if arg_158_1.var_.actorSpriteComps10120 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_161_1 then
							if arg_158_1.isInRecall_ then
								iter_161_1.color = Color.New(Mathf.Lerp(iter_161_1.color.r, arg_158_1.hightColor2.r, (arg_158_1.time_ - 0) / var_161_0), Mathf.Lerp(iter_161_1.color.g, arg_158_1.hightColor2.g, (arg_158_1.time_ - 0) / var_161_0), (Mathf.Lerp(iter_161_1.color.b, arg_158_1.hightColor2.b, (arg_158_1.time_ - 0) / var_161_0)))
							else
								local var_161_1 = Mathf.Lerp(iter_161_1.color.r, 0.5, (arg_158_1.time_ - 0) / var_161_0)

								iter_161_1.color = Color.New(var_161_1, var_161_1, var_161_1)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["10120"]) and arg_158_1.var_.actorSpriteComps10120 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_161_3 then
						iter_161_3.color = arg_158_1.isInRecall_ and (arg_158_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_158_1.var_.actorSpriteComps10120 = nil
			end

			local var_161_2 = 0
			local var_161_3 = 0.775

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_4 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(417171037).content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_6 = 31 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_4) / 31)

				if (31 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_4) / 31)) > 0 and var_161_3 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_2
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_3, arg_158_1.talkMaxDuration)

			if var_161_2 <= arg_158_1.time_ and arg_158_1.time_ < var_161_2 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_2) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_2 + var_161_7 and arg_158_1.time_ < var_161_2 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play417171038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 417171038
		arg_162_1.duration_ = 5.13

		local var_162_0 = {
			zh = 2.266,
			ja = 5.133
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
				arg_162_0:Play417171039(arg_162_1)
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
								iter_165_1.color = Color.New(Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor1.r, (arg_162_1.time_ - 0) / var_165_0), Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor1.g, (arg_162_1.time_ - 0) / var_165_0), (Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor1.b, (arg_162_1.time_ - 0) / var_165_0)))
							else
								local var_165_1 = Mathf.Lerp(iter_165_1.color.r, 1, (arg_162_1.time_ - 0) / var_165_0)

								iter_165_1.color = Color.New(var_165_1, var_165_1, var_165_1)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["10128"]) and arg_162_1.var_.actorSpriteComps10128 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_165_3 then
						iter_165_3.color = arg_162_1.isInRecall_ and (arg_162_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_162_1.var_.actorSpriteComps10128 = nil
			end

			local var_165_2 = 0
			local var_165_3 = 0.225

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_2 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_4 = arg_162_1:GetWordFromCfg(417171038)
				local var_165_5 = arg_162_1:FormatText(var_165_4.content)

				arg_162_1.text_.text = var_165_5

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_7 = 9 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_5) / 9)

				if (9 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_5) / 9)) > 0 and var_165_3 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_2 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_2
					end
				end

				arg_162_1.text_.text = var_165_5
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171038", "story_v_out_417171.awb") ~= 0 then
					local var_165_8 = manager.audio:GetVoiceLength("story_v_out_417171", "417171038", "story_v_out_417171.awb") / 1000

					if var_165_8 + var_165_2 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_8 + var_165_2
					end

					if var_165_4.prefab_name ~= "" and arg_162_1.actors_[var_165_4.prefab_name] ~= nil then
						local var_165_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_4.prefab_name].transform, "story_v_out_417171", "417171038", "story_v_out_417171.awb")

						arg_162_1:RecordAudio("417171038", var_165_9)
						arg_162_1:RecordAudio("417171038", var_165_9)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_417171", "417171038", "story_v_out_417171.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_417171", "417171038", "story_v_out_417171.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_10 = math.max(var_165_3, arg_162_1.talkMaxDuration)

			if var_165_2 <= arg_162_1.time_ and arg_162_1.time_ < var_165_2 + var_165_10 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_2) / var_165_10

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_2 + var_165_10 and arg_162_1.time_ < var_165_2 + var_165_10 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play417171039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 417171039
		arg_166_1.duration_ = 3.1

		local var_166_0 = {
			zh = 3.1,
			ja = 3.033
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
				arg_166_0:Play417171040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["10128"]) and arg_166_1.var_.actorSpriteComps10128 == nil then
				arg_166_1.var_.actorSpriteComps10128 = arg_166_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["10128"]) then
				if arg_166_1.var_.actorSpriteComps10128 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								iter_169_1.color = Color.New(Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor2.r, (arg_166_1.time_ - 0) / var_169_0), Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor2.g, (arg_166_1.time_ - 0) / var_169_0), (Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor2.b, (arg_166_1.time_ - 0) / var_169_0)))
							else
								local var_169_1 = Mathf.Lerp(iter_169_1.color.r, 0.5, (arg_166_1.time_ - 0) / var_169_0)

								iter_169_1.color = Color.New(var_169_1, var_169_1, var_169_1)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["10128"]) and arg_166_1.var_.actorSpriteComps10128 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_169_3 then
						iter_169_3.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_166_1.var_.actorSpriteComps10128 = nil
			end

			local var_169_2 = arg_166_1.actors_["10120"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.actorSpriteComps10120 == nil then
				arg_166_1.var_.actorSpriteComps10120 = var_169_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_3 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_3 and not isNil(var_169_2) then
				if arg_166_1.var_.actorSpriteComps10120 then
					for iter_169_4, iter_169_5 in pairs(arg_166_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_169_5 then
							if arg_166_1.isInRecall_ then
								iter_169_5.color = Color.New(Mathf.Lerp(iter_169_5.color.r, arg_166_1.hightColor1.r, (arg_166_1.time_ - 0) / var_169_3), Mathf.Lerp(iter_169_5.color.g, arg_166_1.hightColor1.g, (arg_166_1.time_ - 0) / var_169_3), (Mathf.Lerp(iter_169_5.color.b, arg_166_1.hightColor1.b, (arg_166_1.time_ - 0) / var_169_3)))
							else
								local var_169_4 = Mathf.Lerp(iter_169_5.color.r, 1, (arg_166_1.time_ - 0) / var_169_3)

								iter_169_5.color = Color.New(var_169_4, var_169_4, var_169_4)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_3 and arg_166_1.time_ < 0 + var_169_3 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.actorSpriteComps10120 then
				for iter_169_6, iter_169_7 in pairs(arg_166_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_169_7 then
						iter_169_7.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_166_1.var_.actorSpriteComps10120 = nil
			end

			local var_169_5 = 0
			local var_169_6 = 0.35

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1141].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_7 = arg_166_1:GetWordFromCfg(417171039)
				local var_169_8 = arg_166_1:FormatText(var_169_7.content)

				arg_166_1.text_.text = var_169_8

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_10 = 14 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_8) / 14)

				if (14 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_8) / 14)) > 0 and var_169_6 < var_169_10 then
					arg_166_1.talkMaxDuration = var_169_10

					if var_169_10 + var_169_5 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_5
					end
				end

				arg_166_1.text_.text = var_169_8
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171039", "story_v_out_417171.awb") ~= 0 then
					local var_169_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171039", "story_v_out_417171.awb") / 1000

					if var_169_11 + var_169_5 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_11 + var_169_5
					end

					if var_169_7.prefab_name ~= "" and arg_166_1.actors_[var_169_7.prefab_name] ~= nil then
						local var_169_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_7.prefab_name].transform, "story_v_out_417171", "417171039", "story_v_out_417171.awb")

						arg_166_1:RecordAudio("417171039", var_169_12)
						arg_166_1:RecordAudio("417171039", var_169_12)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_417171", "417171039", "story_v_out_417171.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_417171", "417171039", "story_v_out_417171.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_13 = math.max(var_169_6, arg_166_1.talkMaxDuration)

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_13 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_5) / var_169_13

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_5 + var_169_13 and arg_166_1.time_ < var_169_5 + var_169_13 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play417171040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417171040
		arg_170_1.duration_ = 1.83

		local var_170_0 = {
			zh = 1,
			ja = 1.833
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
				arg_170_0:Play417171041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["10128"]) and arg_170_1.var_.actorSpriteComps10128 == nil then
				arg_170_1.var_.actorSpriteComps10128 = arg_170_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_0 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["10128"]) then
				if arg_170_1.var_.actorSpriteComps10128 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								iter_173_1.color = Color.New(Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor1.r, (arg_170_1.time_ - 0) / var_173_0), Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor1.g, (arg_170_1.time_ - 0) / var_173_0), (Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor1.b, (arg_170_1.time_ - 0) / var_173_0)))
							else
								local var_173_1 = Mathf.Lerp(iter_173_1.color.r, 1, (arg_170_1.time_ - 0) / var_173_0)

								iter_173_1.color = Color.New(var_173_1, var_173_1, var_173_1)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["10128"]) and arg_170_1.var_.actorSpriteComps10128 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_173_3 then
						iter_173_3.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_170_1.var_.actorSpriteComps10128 = nil
			end

			local var_173_2 = arg_170_1.actors_["10120"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.actorSpriteComps10120 == nil then
				arg_170_1.var_.actorSpriteComps10120 = var_173_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_3 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_3 and not isNil(var_173_2) then
				if arg_170_1.var_.actorSpriteComps10120 then
					for iter_173_4, iter_173_5 in pairs(arg_170_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_173_5 then
							if arg_170_1.isInRecall_ then
								iter_173_5.color = Color.New(Mathf.Lerp(iter_173_5.color.r, arg_170_1.hightColor2.r, (arg_170_1.time_ - 0) / var_173_3), Mathf.Lerp(iter_173_5.color.g, arg_170_1.hightColor2.g, (arg_170_1.time_ - 0) / var_173_3), (Mathf.Lerp(iter_173_5.color.b, arg_170_1.hightColor2.b, (arg_170_1.time_ - 0) / var_173_3)))
							else
								local var_173_4 = Mathf.Lerp(iter_173_5.color.r, 0.5, (arg_170_1.time_ - 0) / var_173_3)

								iter_173_5.color = Color.New(var_173_4, var_173_4, var_173_4)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_3 and arg_170_1.time_ < 0 + var_173_3 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.actorSpriteComps10120 then
				for iter_173_6, iter_173_7 in pairs(arg_170_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_173_7 then
						iter_173_7.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_170_1.var_.actorSpriteComps10120 = nil
			end

			local var_173_5 = 0
			local var_173_6 = 0.05

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_5 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_7 = arg_170_1:GetWordFromCfg(417171040)
				local var_173_8 = arg_170_1:FormatText(var_173_7.content)

				arg_170_1.text_.text = var_173_8

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_10 = 2 <= 0 and var_173_6 or var_173_6 * (utf8.len(var_173_8) / 2)

				if (2 <= 0 and var_173_6 or var_173_6 * (utf8.len(var_173_8) / 2)) > 0 and var_173_6 < var_173_10 then
					arg_170_1.talkMaxDuration = var_173_10

					if var_173_10 + var_173_5 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_5
					end
				end

				arg_170_1.text_.text = var_173_8
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171040", "story_v_out_417171.awb") ~= 0 then
					local var_173_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171040", "story_v_out_417171.awb") / 1000

					if var_173_11 + var_173_5 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_11 + var_173_5
					end

					if var_173_7.prefab_name ~= "" and arg_170_1.actors_[var_173_7.prefab_name] ~= nil then
						local var_173_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_7.prefab_name].transform, "story_v_out_417171", "417171040", "story_v_out_417171.awb")

						arg_170_1:RecordAudio("417171040", var_173_12)
						arg_170_1:RecordAudio("417171040", var_173_12)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_417171", "417171040", "story_v_out_417171.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_417171", "417171040", "story_v_out_417171.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_13 = math.max(var_173_6, arg_170_1.talkMaxDuration)

			if var_173_5 <= arg_170_1.time_ and arg_170_1.time_ < var_173_5 + var_173_13 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_5) / var_173_13

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_5 + var_173_13 and arg_170_1.time_ < var_173_5 + var_173_13 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play417171041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417171041
		arg_174_1.duration_ = 1.3

		local var_174_0 = {
			zh = 1.3,
			ja = 1.066
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
				arg_174_0:Play417171042(arg_174_1)
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
								iter_177_1.color = Color.New(Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor2.r, (arg_174_1.time_ - 0) / var_177_0), Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor2.g, (arg_174_1.time_ - 0) / var_177_0), (Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor2.b, (arg_174_1.time_ - 0) / var_177_0)))
							else
								local var_177_1 = Mathf.Lerp(iter_177_1.color.r, 0.5, (arg_174_1.time_ - 0) / var_177_0)

								iter_177_1.color = Color.New(var_177_1, var_177_1, var_177_1)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["10128"]) and arg_174_1.var_.actorSpriteComps10128 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_177_3 then
						iter_177_3.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_174_1.var_.actorSpriteComps10128 = nil
			end

			local var_177_2 = arg_174_1.actors_["10120"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps10120 == nil then
				arg_174_1.var_.actorSpriteComps10120 = var_177_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_3 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_3 and not isNil(var_177_2) then
				if arg_174_1.var_.actorSpriteComps10120 then
					for iter_177_4, iter_177_5 in pairs(arg_174_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_177_5 then
							if arg_174_1.isInRecall_ then
								iter_177_5.color = Color.New(Mathf.Lerp(iter_177_5.color.r, arg_174_1.hightColor1.r, (arg_174_1.time_ - 0) / var_177_3), Mathf.Lerp(iter_177_5.color.g, arg_174_1.hightColor1.g, (arg_174_1.time_ - 0) / var_177_3), (Mathf.Lerp(iter_177_5.color.b, arg_174_1.hightColor1.b, (arg_174_1.time_ - 0) / var_177_3)))
							else
								local var_177_4 = Mathf.Lerp(iter_177_5.color.r, 1, (arg_174_1.time_ - 0) / var_177_3)

								iter_177_5.color = Color.New(var_177_4, var_177_4, var_177_4)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_3 and arg_174_1.time_ < 0 + var_177_3 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps10120 then
				for iter_177_6, iter_177_7 in pairs(arg_174_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_177_7 then
						iter_177_7.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_174_1.var_.actorSpriteComps10120 = nil
			end

			local var_177_5 = 0
			local var_177_6 = 0.1

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1141].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_7 = arg_174_1:GetWordFromCfg(417171041)
				local var_177_8 = arg_174_1:FormatText(var_177_7.content)

				arg_174_1.text_.text = var_177_8

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_10 = 4 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_8) / 4)

				if (4 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_8) / 4)) > 0 and var_177_6 < var_177_10 then
					arg_174_1.talkMaxDuration = var_177_10

					if var_177_10 + var_177_5 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_10 + var_177_5
					end
				end

				arg_174_1.text_.text = var_177_8
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171041", "story_v_out_417171.awb") ~= 0 then
					local var_177_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171041", "story_v_out_417171.awb") / 1000

					if var_177_11 + var_177_5 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_11 + var_177_5
					end

					if var_177_7.prefab_name ~= "" and arg_174_1.actors_[var_177_7.prefab_name] ~= nil then
						local var_177_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_7.prefab_name].transform, "story_v_out_417171", "417171041", "story_v_out_417171.awb")

						arg_174_1:RecordAudio("417171041", var_177_12)
						arg_174_1:RecordAudio("417171041", var_177_12)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_417171", "417171041", "story_v_out_417171.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_417171", "417171041", "story_v_out_417171.awb")
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

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play417171042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417171042
		arg_178_1.duration_ = 9

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play417171043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 4 < arg_178_1.time_ and arg_178_1.time_ <= 4 + arg_181_0 then
				arg_178_1.allBtn_.enabled = false
			end

			if arg_178_1.time_ >= 4 + 0.3 and arg_178_1.time_ < 4 + 0.3 + arg_181_0 then
				arg_178_1.allBtn_.enabled = true
			end

			if 2 < arg_178_1.time_ and arg_178_1.time_ <= 2 + arg_181_0 then
				local var_181_0 = arg_178_1.bgs_.I17f

				arg_178_1.bgs_.I17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_181_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_181_1 = var_181_0:GetComponent("SpriteRenderer")

				if var_181_1 and var_181_1.sprite then
					local var_181_2 = 2 * (var_181_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_181_0.transform.localScale = Vector3.New(var_181_2 / var_181_1.sprite.bounds.size.y < var_181_2 * manager.ui.mainCameraCom_.aspect / var_181_1.sprite.bounds.size.x and var_181_2 * manager.ui.mainCameraCom_.aspect / var_181_1.sprite.bounds.size.x or var_181_2 / var_181_1.sprite.bounds.size.y, var_181_2 / var_181_1.sprite.bounds.size.y < var_181_2 * manager.ui.mainCameraCom_.aspect / var_181_1.sprite.bounds.size.x and var_181_2 * manager.ui.mainCameraCom_.aspect / var_181_1.sprite.bounds.size.x or var_181_2 / var_181_1.sprite.bounds.size.y, 0)
				end

				for iter_181_0, iter_181_1 in pairs(arg_178_1.bgs_) do
					if iter_181_0 ~= "I17f" then
						iter_181_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_181_3 = 0

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_3 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_4 = 2

			if var_181_3 <= arg_178_1.time_ and arg_178_1.time_ < var_181_3 + var_181_4 then
				local var_181_5 = Color.New(0, 0, 0)

				var_181_5.a = Mathf.Lerp(0, 1, (arg_178_1.time_ - var_181_3) / var_181_4)
				arg_178_1.mask_.color = var_181_5
			end

			if arg_178_1.time_ >= var_181_3 + var_181_4 and arg_178_1.time_ < var_181_3 + var_181_4 + arg_181_0 then
				local var_181_6 = Color.New(0, 0, 0)

				var_181_6.a = 1
				arg_178_1.mask_.color = var_181_6
			end

			local var_181_7 = 2

			if 2 < arg_178_1.time_ and arg_178_1.time_ <= var_181_7 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_8 = 2

			if var_181_7 <= arg_178_1.time_ and arg_178_1.time_ < var_181_7 + var_181_8 then
				local var_181_9 = Color.New(0, 0, 0)

				var_181_9.a = Mathf.Lerp(1, 0, (arg_178_1.time_ - var_181_7) / var_181_8)
				arg_178_1.mask_.color = var_181_9
			end

			if arg_178_1.time_ >= var_181_7 + var_181_8 and arg_178_1.time_ < var_181_7 + var_181_8 + arg_181_0 then
				local var_181_10 = Color.New(0, 0, 0)

				arg_178_1.mask_.enabled = false
				var_181_10.a = 0
				arg_178_1.mask_.color = var_181_10
			end

			local var_181_11 = arg_178_1.actors_["10128"].transform

			if 1.966 < arg_178_1.time_ and arg_178_1.time_ <= 1.966 + arg_181_0 then
				arg_178_1.var_.moveOldPos10128 = var_181_11.localPosition
				var_181_11.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10128", 7)

				for iter_181_2 = 0, var_181_11.childCount - 1 do
					local var_181_12 = var_181_11:GetChild(iter_181_2)

					if var_181_12.name == "" or not string.find(var_181_12.name, "split") then
						var_181_12.gameObject:SetActive(true)
					else
						var_181_12.gameObject:SetActive(false)
					end
				end
			end

			local var_181_13 = 0.001

			if 1.966 <= arg_178_1.time_ and arg_178_1.time_ < 1.966 + var_181_13 then
				var_181_11.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_178_1.time_ - 1.966) / var_181_13)
			end

			if arg_178_1.time_ >= 1.966 + var_181_13 and arg_178_1.time_ < 1.966 + var_181_13 + arg_181_0 then
				var_181_11.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_181_14 = arg_178_1.actors_["10120"].transform

			if 1.966 < arg_178_1.time_ and arg_178_1.time_ <= 1.966 + arg_181_0 then
				arg_178_1.var_.moveOldPos10120 = var_181_14.localPosition
				var_181_14.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10120", 7)

				for iter_181_3 = 0, var_181_14.childCount - 1 do
					local var_181_15 = var_181_14:GetChild(iter_181_3)

					if var_181_15.name == "" or not string.find(var_181_15.name, "split") then
						var_181_15.gameObject:SetActive(true)
					else
						var_181_15.gameObject:SetActive(false)
					end
				end
			end

			local var_181_16 = 0.001

			if 1.966 <= arg_178_1.time_ and arg_178_1.time_ < 1.966 + var_181_16 then
				var_181_14.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10120, Vector3.New(0, -2000, 0), (arg_178_1.time_ - 1.966) / var_181_16)
			end

			if arg_178_1.time_ >= 1.966 + var_181_16 and arg_178_1.time_ < 1.966 + var_181_16 + arg_181_0 then
				var_181_14.localPosition = Vector3.New(0, -2000, 0)
			end

			if 4 < arg_178_1.time_ and arg_178_1.time_ <= 4 + arg_181_0 then
				arg_178_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_machine01", "")
			end

			if arg_178_1.frameCnt_ <= 1 then
				arg_178_1.dialog_:SetActive(false)
			end

			local var_181_18 = 4
			local var_181_19 = 0.925

			if 4 < arg_178_1.time_ and arg_178_1.time_ <= var_181_18 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0

				arg_178_1.dialog_:SetActive(true)

				arg_178_1.dialogCg_.alpha = 0

				local var_181_20 = LeanTween.value(arg_178_1.dialog_, 0, 1, 0.3)

				var_181_20:setOnUpdate(LuaHelper.FloatAction(function(arg_182_0)
					arg_178_1.dialogCg_.alpha = arg_182_0
				end))
				var_181_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_178_1.dialog_)
					var_181_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_178_1.duration_ = arg_178_1.duration_ + 0.3

				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_21 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(417171042).content)

				arg_178_1.text_.text = var_181_21

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_23 = 37 <= 0 and var_181_19 or var_181_19 * (utf8.len(var_181_21) / 37)

				if (37 <= 0 and var_181_19 or var_181_19 * (utf8.len(var_181_21) / 37)) > 0 and var_181_19 < var_181_23 then
					arg_178_1.talkMaxDuration = var_181_23
					var_181_18 = var_181_18 + 0.3

					if var_181_23 + var_181_18 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_23 + var_181_18
					end
				end

				arg_178_1.text_.text = var_181_21
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_24 = var_181_18 + 0.3
			local var_181_25 = math.max(var_181_19, arg_178_1.talkMaxDuration)

			if var_181_18 + 0.3 <= arg_178_1.time_ and arg_178_1.time_ < var_181_24 + var_181_25 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_24) / var_181_25

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_24 + var_181_25 and arg_178_1.time_ < var_181_24 + var_181_25 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
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
				actorName = "10120",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play417171043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417171043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play417171044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0.1 < arg_184_1.time_ and arg_184_1.time_ <= 0.1 + arg_187_0 then
				arg_184_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_truck01", "")
			end

			local var_187_1 = 0
			local var_187_2 = 1.35

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_3 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(417171043).content)

				arg_184_1.text_.text = var_187_3

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 54 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 54)

				if (54 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 54)) > 0 and var_187_2 < var_187_5 then
					arg_184_1.talkMaxDuration = var_187_5

					if var_187_5 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + var_187_1
					end
				end

				arg_184_1.text_.text = var_187_3
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_6 = math.max(var_187_2, arg_184_1.talkMaxDuration)

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_6 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_1) / var_187_6

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_1 + var_187_6 and arg_184_1.time_ < var_187_1 + var_187_6 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play417171044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417171044
		arg_188_1.duration_ = 7.37

		local var_188_0 = {
			zh = 5.8,
			ja = 7.366
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
				arg_188_0:Play417171045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 4 < arg_188_1.time_ and arg_188_1.time_ <= 4 + arg_191_0 then
				arg_188_1.allBtn_.enabled = false
			end

			if arg_188_1.time_ >= 4 + 0.1 and arg_188_1.time_ < 4 + 0.1 + arg_191_0 then
				arg_188_1.allBtn_.enabled = true
			end

			local var_191_0 = "ST75"

			if arg_188_1.bgs_.ST75 == nil then
				local var_191_1 = Object.Instantiate(arg_188_1.paintGo_)

				var_191_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_191_0)
				var_191_1.name = var_191_0
				var_191_1.transform.parent = arg_188_1.stage_.transform
				var_191_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.bgs_[var_191_0] = var_191_1
			end

			if 2 < arg_188_1.time_ and arg_188_1.time_ <= 2 + arg_191_0 then
				local var_191_2 = arg_188_1.bgs_.ST75

				arg_188_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_191_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_191_3 = var_191_2:GetComponent("SpriteRenderer")

				if var_191_3 and var_191_3.sprite then
					local var_191_4 = 2 * (var_191_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_191_2.transform.localScale = Vector3.New(var_191_4 / var_191_3.sprite.bounds.size.y < var_191_4 * manager.ui.mainCameraCom_.aspect / var_191_3.sprite.bounds.size.x and var_191_4 * manager.ui.mainCameraCom_.aspect / var_191_3.sprite.bounds.size.x or var_191_4 / var_191_3.sprite.bounds.size.y, var_191_4 / var_191_3.sprite.bounds.size.y < var_191_4 * manager.ui.mainCameraCom_.aspect / var_191_3.sprite.bounds.size.x and var_191_4 * manager.ui.mainCameraCom_.aspect / var_191_3.sprite.bounds.size.x or var_191_4 / var_191_3.sprite.bounds.size.y, 0)
				end

				for iter_191_0, iter_191_1 in pairs(arg_188_1.bgs_) do
					if iter_191_0 ~= "ST75" then
						iter_191_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_191_5 = 0

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_6 = 2

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_6 then
				local var_191_7 = Color.New(0, 0, 0)

				var_191_7.a = Mathf.Lerp(0, 1, (arg_188_1.time_ - var_191_5) / var_191_6)
				arg_188_1.mask_.color = var_191_7
			end

			if arg_188_1.time_ >= var_191_5 + var_191_6 and arg_188_1.time_ < var_191_5 + var_191_6 + arg_191_0 then
				local var_191_8 = Color.New(0, 0, 0)

				var_191_8.a = 1
				arg_188_1.mask_.color = var_191_8
			end

			local var_191_9 = 2

			if 2 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_10 = 2

			if var_191_9 <= arg_188_1.time_ and arg_188_1.time_ < var_191_9 + var_191_10 then
				local var_191_11 = Color.New(0, 0, 0)

				var_191_11.a = Mathf.Lerp(1, 0, (arg_188_1.time_ - var_191_9) / var_191_10)
				arg_188_1.mask_.color = var_191_11
			end

			if arg_188_1.time_ >= var_191_9 + var_191_10 and arg_188_1.time_ < var_191_9 + var_191_10 + arg_191_0 then
				local var_191_12 = Color.New(0, 0, 0)

				arg_188_1.mask_.enabled = false
				var_191_12.a = 0
				arg_188_1.mask_.color = var_191_12
			end

			if 1.46666666666667 < arg_188_1.time_ and arg_188_1.time_ <= 1.46666666666667 + arg_191_0 then
				arg_188_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 1.46666666666667 < arg_188_1.time_ and arg_188_1.time_ <= 1.46666666666667 + arg_191_0 then
				arg_188_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_truck_loop", "")
			end

			if arg_188_1.frameCnt_ <= 1 then
				arg_188_1.dialog_:SetActive(false)
			end

			local var_191_15 = 4
			local var_191_16 = 0.225

			if 4 < arg_188_1.time_ and arg_188_1.time_ <= var_191_15 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				arg_188_1.dialog_:SetActive(true)

				arg_188_1.dialogCg_.alpha = 0

				local var_191_17 = LeanTween.value(arg_188_1.dialog_, 0, 1, 0.3)

				var_191_17:setOnUpdate(LuaHelper.FloatAction(function(arg_192_0)
					arg_188_1.dialogCg_.alpha = arg_192_0
				end))
				var_191_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_188_1.dialog_)
					var_191_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_188_1.duration_ = arg_188_1.duration_ + 0.3

				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1142].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_18 = arg_188_1:GetWordFromCfg(417171044)
				local var_191_19 = arg_188_1:FormatText(var_191_18.content)

				arg_188_1.text_.text = var_191_19

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_21 = 9 <= 0 and var_191_16 or var_191_16 * (utf8.len(var_191_19) / 9)

				if (9 <= 0 and var_191_16 or var_191_16 * (utf8.len(var_191_19) / 9)) > 0 and var_191_16 < var_191_21 then
					arg_188_1.talkMaxDuration = var_191_21
					var_191_15 = var_191_15 + 0.3

					if var_191_21 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_21 + var_191_15
					end
				end

				arg_188_1.text_.text = var_191_19
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171044", "story_v_out_417171.awb") ~= 0 then
					local var_191_22 = manager.audio:GetVoiceLength("story_v_out_417171", "417171044", "story_v_out_417171.awb") / 1000

					if var_191_22 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_22 + var_191_15
					end

					if var_191_18.prefab_name ~= "" and arg_188_1.actors_[var_191_18.prefab_name] ~= nil then
						local var_191_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_18.prefab_name].transform, "story_v_out_417171", "417171044", "story_v_out_417171.awb")

						arg_188_1:RecordAudio("417171044", var_191_23)
						arg_188_1:RecordAudio("417171044", var_191_23)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417171", "417171044", "story_v_out_417171.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417171", "417171044", "story_v_out_417171.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_24 = var_191_15 + 0.3
			local var_191_25 = math.max(var_191_16, arg_188_1.talkMaxDuration)

			if var_191_15 + 0.3 <= arg_188_1.time_ and arg_188_1.time_ < var_191_24 + var_191_25 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_24) / var_191_25

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_24 + var_191_25 and arg_188_1.time_ < var_191_24 + var_191_25 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play417171045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 417171045
		arg_194_1.duration_ = 7.37

		local var_194_0 = {
			zh = 5.6,
			ja = 7.366
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
				arg_194_0:Play417171046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.825

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1142].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_1 = arg_194_1:GetWordFromCfg(417171045)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 33 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 33)

				if (33 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 33)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171045", "story_v_out_417171.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_out_417171", "417171045", "story_v_out_417171.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_out_417171", "417171045", "story_v_out_417171.awb")

						arg_194_1:RecordAudio("417171045", var_197_6)
						arg_194_1:RecordAudio("417171045", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_417171", "417171045", "story_v_out_417171.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_417171", "417171045", "story_v_out_417171.awb")
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
	Play417171046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417171046
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play417171047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0.85

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_1 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(417171046).content)

				arg_198_1.text_.text = var_201_1

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_3 = 34 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 34)

				if (34 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 34)) > 0 and var_201_0 < var_201_3 then
					arg_198_1.talkMaxDuration = var_201_3

					if var_201_3 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_3 + 0
					end
				end

				arg_198_1.text_.text = var_201_1
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_4 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_4

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play417171047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417171047
		arg_202_1.duration_ = 3.8

		local var_202_0 = {
			zh = 3.166,
			ja = 3.8
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
				arg_202_0:Play417171048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.4

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1142].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_1 = arg_202_1:GetWordFromCfg(417171047)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.text_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 16 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 16)

				if (16 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 16)) > 0 and var_205_0 < var_205_4 then
					arg_202_1.talkMaxDuration = var_205_4

					if var_205_4 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_4 + 0
					end
				end

				arg_202_1.text_.text = var_205_2
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171047", "story_v_out_417171.awb") ~= 0 then
					local var_205_5 = manager.audio:GetVoiceLength("story_v_out_417171", "417171047", "story_v_out_417171.awb") / 1000

					if var_205_5 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + 0
					end

					if var_205_1.prefab_name ~= "" and arg_202_1.actors_[var_205_1.prefab_name] ~= nil then
						local var_205_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_1.prefab_name].transform, "story_v_out_417171", "417171047", "story_v_out_417171.awb")

						arg_202_1:RecordAudio("417171047", var_205_6)
						arg_202_1:RecordAudio("417171047", var_205_6)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417171", "417171047", "story_v_out_417171.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417171", "417171047", "story_v_out_417171.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play417171048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417171048
		arg_206_1.duration_ = 2.5

		local var_206_0 = {
			zh = 1.266,
			ja = 2.5
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
				arg_206_0:Play417171049(arg_206_1)
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

			local var_209_2 = arg_206_1.actors_["10128"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos10128 = var_209_2.localPosition
				var_209_2.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("10128", 3)

				for iter_209_4 = 0, var_209_2.childCount - 1 do
					local var_209_3 = var_209_2:GetChild(iter_209_4)

					if var_209_3.name == "" or not string.find(var_209_3.name, "split") then
						var_209_3.gameObject:SetActive(true)
					else
						var_209_3.gameObject:SetActive(false)
					end
				end
			end

			local var_209_4 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				var_209_2.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_206_1.time_ - 0) / var_209_4)
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				var_209_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_209_5 = 0
			local var_209_6 = 0.125

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_5 + arg_209_0 then
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

				local var_209_7 = arg_206_1:GetWordFromCfg(417171048)
				local var_209_8 = arg_206_1:FormatText(var_209_7.content)

				arg_206_1.text_.text = var_209_8

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_10 = 5 <= 0 and var_209_6 or var_209_6 * (utf8.len(var_209_8) / 5)

				if (5 <= 0 and var_209_6 or var_209_6 * (utf8.len(var_209_8) / 5)) > 0 and var_209_6 < var_209_10 then
					arg_206_1.talkMaxDuration = var_209_10

					if var_209_10 + var_209_5 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_10 + var_209_5
					end
				end

				arg_206_1.text_.text = var_209_8
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171048", "story_v_out_417171.awb") ~= 0 then
					local var_209_11 = manager.audio:GetVoiceLength("story_v_out_417171", "417171048", "story_v_out_417171.awb") / 1000

					if var_209_11 + var_209_5 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_11 + var_209_5
					end

					if var_209_7.prefab_name ~= "" and arg_206_1.actors_[var_209_7.prefab_name] ~= nil then
						local var_209_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_7.prefab_name].transform, "story_v_out_417171", "417171048", "story_v_out_417171.awb")

						arg_206_1:RecordAudio("417171048", var_209_12)
						arg_206_1:RecordAudio("417171048", var_209_12)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417171", "417171048", "story_v_out_417171.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417171", "417171048", "story_v_out_417171.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_13 = math.max(var_209_6, arg_206_1.talkMaxDuration)

			if var_209_5 <= arg_206_1.time_ and arg_206_1.time_ < var_209_5 + var_209_13 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_5) / var_209_13

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_5 + var_209_13 and arg_206_1.time_ < var_209_5 + var_209_13 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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

		arg_206_1:InitPlayNodeList()
	end,
	Play417171049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417171049
		arg_210_1.duration_ = 11.73

		local var_210_0 = {
			zh = 9.5,
			ja = 11.733
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play417171050(arg_210_1)
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
			local var_213_3 = 1.05

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1142].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_4 = arg_210_1:GetWordFromCfg(417171049)
				local var_213_5 = arg_210_1:FormatText(var_213_4.content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_7 = 42 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 42)

				if (42 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 42)) > 0 and var_213_3 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_2
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171049", "story_v_out_417171.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_417171", "417171049", "story_v_out_417171.awb") / 1000

					if var_213_8 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_2
					end

					if var_213_4.prefab_name ~= "" and arg_210_1.actors_[var_213_4.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_4.prefab_name].transform, "story_v_out_417171", "417171049", "story_v_out_417171.awb")

						arg_210_1:RecordAudio("417171049", var_213_9)
						arg_210_1:RecordAudio("417171049", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_417171", "417171049", "story_v_out_417171.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_417171", "417171049", "story_v_out_417171.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_3, arg_210_1.talkMaxDuration)

			if var_213_2 <= arg_210_1.time_ and arg_210_1.time_ < var_213_2 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_2) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_2 + var_213_10 and arg_210_1.time_ < var_213_2 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play417171050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417171050
		arg_214_1.duration_ = 8.03

		local var_214_0 = {
			zh = 7.6,
			ja = 8.033
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
				arg_214_0:Play417171051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.975

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1142].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:GetWordFromCfg(417171050)
				local var_217_2 = arg_214_1:FormatText(var_217_1.content)

				arg_214_1.text_.text = var_217_2

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 39 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 39)

				if (39 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 39)) > 0 and var_217_0 < var_217_4 then
					arg_214_1.talkMaxDuration = var_217_4

					if var_217_4 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_4 + 0
					end
				end

				arg_214_1.text_.text = var_217_2
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171050", "story_v_out_417171.awb") ~= 0 then
					local var_217_5 = manager.audio:GetVoiceLength("story_v_out_417171", "417171050", "story_v_out_417171.awb") / 1000

					if var_217_5 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + 0
					end

					if var_217_1.prefab_name ~= "" and arg_214_1.actors_[var_217_1.prefab_name] ~= nil then
						local var_217_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_1.prefab_name].transform, "story_v_out_417171", "417171050", "story_v_out_417171.awb")

						arg_214_1:RecordAudio("417171050", var_217_6)
						arg_214_1:RecordAudio("417171050", var_217_6)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417171", "417171050", "story_v_out_417171.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417171", "417171050", "story_v_out_417171.awb")
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
	Play417171051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417171051
		arg_218_1.duration_ = 4.3

		local var_218_0 = {
			zh = 3.733,
			ja = 4.3
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
				arg_218_0:Play417171052(arg_218_1)
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

			local var_221_2 = 0
			local var_221_3 = 0.3

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_2 + arg_221_0 then
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

				local var_221_4 = arg_218_1:GetWordFromCfg(417171051)
				local var_221_5 = arg_218_1:FormatText(var_221_4.content)

				arg_218_1.text_.text = var_221_5

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_7 = 12 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_5) / 12)

				if (12 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_5) / 12)) > 0 and var_221_3 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_2
					end
				end

				arg_218_1.text_.text = var_221_5
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171051", "story_v_out_417171.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_out_417171", "417171051", "story_v_out_417171.awb") / 1000

					if var_221_8 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_2
					end

					if var_221_4.prefab_name ~= "" and arg_218_1.actors_[var_221_4.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_4.prefab_name].transform, "story_v_out_417171", "417171051", "story_v_out_417171.awb")

						arg_218_1:RecordAudio("417171051", var_221_9)
						arg_218_1:RecordAudio("417171051", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417171", "417171051", "story_v_out_417171.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417171", "417171051", "story_v_out_417171.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_3, arg_218_1.talkMaxDuration)

			if var_221_2 <= arg_218_1.time_ and arg_218_1.time_ < var_221_2 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_2) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_2 + var_221_10 and arg_218_1.time_ < var_221_2 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play417171052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417171052
		arg_222_1.duration_ = 5.17

		local var_222_0 = {
			zh = 3.466,
			ja = 5.166
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
				arg_222_0:Play417171053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.375

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:GetWordFromCfg(417171052)
				local var_225_2 = arg_222_1:FormatText(var_225_1.content)

				arg_222_1.text_.text = var_225_2

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 15 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 15)

				if (15 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 15)) > 0 and var_225_0 < var_225_4 then
					arg_222_1.talkMaxDuration = var_225_4

					if var_225_4 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_4 + 0
					end
				end

				arg_222_1.text_.text = var_225_2
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171052", "story_v_out_417171.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_out_417171", "417171052", "story_v_out_417171.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_out_417171", "417171052", "story_v_out_417171.awb")

						arg_222_1:RecordAudio("417171052", var_225_6)
						arg_222_1:RecordAudio("417171052", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_417171", "417171052", "story_v_out_417171.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_417171", "417171052", "story_v_out_417171.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play417171053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417171053
		arg_226_1.duration_ = 4.7

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play417171054(arg_226_1)
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
								iter_229_1.color = Color.New(Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor2.r, (arg_226_1.time_ - 0) / var_229_0), Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor2.g, (arg_226_1.time_ - 0) / var_229_0), (Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor2.b, (arg_226_1.time_ - 0) / var_229_0)))
							else
								local var_229_1 = Mathf.Lerp(iter_229_1.color.r, 0.5, (arg_226_1.time_ - 0) / var_229_0)

								iter_229_1.color = Color.New(var_229_1, var_229_1, var_229_1)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["10128"]) and arg_226_1.var_.actorSpriteComps10128 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_229_3 then
						iter_229_3.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_226_1.var_.actorSpriteComps10128 = nil
			end

			local var_229_2 = 0
			local var_229_3 = 0.6

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1142].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_4 = arg_226_1:GetWordFromCfg(417171053)
				local var_229_5 = arg_226_1:FormatText(var_229_4.content)

				arg_226_1.text_.text = var_229_5

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_7 = 24 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_5) / 24)

				if (24 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_5) / 24)) > 0 and var_229_3 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_2
					end
				end

				arg_226_1.text_.text = var_229_5
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171053", "story_v_out_417171.awb") ~= 0 then
					local var_229_8 = manager.audio:GetVoiceLength("story_v_out_417171", "417171053", "story_v_out_417171.awb") / 1000

					if var_229_8 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_2
					end

					if var_229_4.prefab_name ~= "" and arg_226_1.actors_[var_229_4.prefab_name] ~= nil then
						local var_229_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_4.prefab_name].transform, "story_v_out_417171", "417171053", "story_v_out_417171.awb")

						arg_226_1:RecordAudio("417171053", var_229_9)
						arg_226_1:RecordAudio("417171053", var_229_9)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_417171", "417171053", "story_v_out_417171.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_417171", "417171053", "story_v_out_417171.awb")
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
	Play417171054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 417171054
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play417171055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos10128 = arg_230_1.actors_["10128"].transform.localPosition
				arg_230_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("10128", 7)

				for iter_233_0 = 0, arg_230_1.actors_["10128"].transform.childCount - 1 do
					local var_233_0 = arg_230_1.actors_["10128"].transform:GetChild(iter_233_0)

					if var_233_0.name == "" or not string.find(var_233_0.name, "split") then
						var_233_0.gameObject:SetActive(true)
					else
						var_233_0.gameObject:SetActive(false)
					end
				end
			end

			local var_233_1 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_1 then
				arg_230_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_230_1.time_ - 0) / var_233_1)
			end

			if arg_230_1.time_ >= 0 + var_233_1 and arg_230_1.time_ < 0 + var_233_1 + arg_233_0 then
				arg_230_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_233_2 = 0
			local var_233_3 = 0.775

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_4 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(417171054).content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_6 = 31 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_4) / 31)

				if (31 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_4) / 31)) > 0 and var_233_3 < var_233_6 then
					arg_230_1.talkMaxDuration = var_233_6

					if var_233_6 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_6 + var_233_2
					end
				end

				arg_230_1.text_.text = var_233_4
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_3, arg_230_1.talkMaxDuration)

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_2) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_2 + var_233_7 and arg_230_1.time_ < var_233_2 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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

		arg_230_1:InitPlayNodeList()
	end,
	Play417171055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 417171055
		arg_234_1.duration_ = 6.9

		local var_234_0 = {
			zh = 5.3,
			ja = 6.9
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play417171056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 4 < arg_234_1.time_ and arg_234_1.time_ <= 4 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			if arg_234_1.time_ >= 4 + 0.0666666666666664 and arg_234_1.time_ < 4 + 0.0666666666666664 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end

			local var_237_0 = "SS1706"

			if arg_234_1.bgs_.SS1706 == nil then
				local var_237_1 = Object.Instantiate(arg_234_1.paintGo_)

				var_237_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_237_0)
				var_237_1.name = var_237_0
				var_237_1.transform.parent = arg_234_1.stage_.transform
				var_237_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.bgs_[var_237_0] = var_237_1
			end

			if 2 < arg_234_1.time_ and arg_234_1.time_ <= 2 + arg_237_0 then
				local var_237_2 = arg_234_1.bgs_.SS1706

				arg_234_1.bgs_.SS1706.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_237_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_237_3 = var_237_2:GetComponent("SpriteRenderer")

				if var_237_3 and var_237_3.sprite then
					local var_237_4 = 2 * (var_237_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_237_2.transform.localScale = Vector3.New(var_237_4 / var_237_3.sprite.bounds.size.y < var_237_4 * manager.ui.mainCameraCom_.aspect / var_237_3.sprite.bounds.size.x and var_237_4 * manager.ui.mainCameraCom_.aspect / var_237_3.sprite.bounds.size.x or var_237_4 / var_237_3.sprite.bounds.size.y, var_237_4 / var_237_3.sprite.bounds.size.y < var_237_4 * manager.ui.mainCameraCom_.aspect / var_237_3.sprite.bounds.size.x and var_237_4 * manager.ui.mainCameraCom_.aspect / var_237_3.sprite.bounds.size.x or var_237_4 / var_237_3.sprite.bounds.size.y, 0)
				end

				for iter_237_0, iter_237_1 in pairs(arg_234_1.bgs_) do
					if iter_237_0 ~= "SS1706" then
						iter_237_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_237_5 = 0

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_5 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_6 = 2

			if var_237_5 <= arg_234_1.time_ and arg_234_1.time_ < var_237_5 + var_237_6 then
				local var_237_7 = Color.New(0, 0, 0)

				var_237_7.a = Mathf.Lerp(0, 1, (arg_234_1.time_ - var_237_5) / var_237_6)
				arg_234_1.mask_.color = var_237_7
			end

			if arg_234_1.time_ >= var_237_5 + var_237_6 and arg_234_1.time_ < var_237_5 + var_237_6 + arg_237_0 then
				local var_237_8 = Color.New(0, 0, 0)

				var_237_8.a = 1
				arg_234_1.mask_.color = var_237_8
			end

			local var_237_9 = 2

			if 2 < arg_234_1.time_ and arg_234_1.time_ <= var_237_9 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_10 = 2

			if var_237_9 <= arg_234_1.time_ and arg_234_1.time_ < var_237_9 + var_237_10 then
				local var_237_11 = Color.New(0, 0, 0)

				var_237_11.a = Mathf.Lerp(1, 0, (arg_234_1.time_ - var_237_9) / var_237_10)
				arg_234_1.mask_.color = var_237_11
			end

			if arg_234_1.time_ >= var_237_9 + var_237_10 and arg_234_1.time_ < var_237_9 + var_237_10 + arg_237_0 then
				local var_237_12 = Color.New(0, 0, 0)

				arg_234_1.mask_.enabled = false
				var_237_12.a = 0
				arg_234_1.mask_.color = var_237_12
			end

			local var_237_13 = 2

			arg_234_1.isInRecall_ = true

			if var_237_13 < arg_234_1.time_ and arg_234_1.time_ <= var_237_13 + arg_237_0 then
				arg_234_1.screenFilterGo_:SetActive(true)

				arg_234_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_234_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_234_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_237_2, iter_237_3 in pairs(arg_234_1.actors_) do
					for iter_237_4, iter_237_5 in ipairs((iter_237_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_237_5.color = iter_237_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_237_14 = 0.0666666666666667

			if var_237_13 <= arg_234_1.time_ and arg_234_1.time_ < var_237_13 + var_237_14 then
				arg_234_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_234_1.time_ - var_237_13) / var_237_14)
			end

			if arg_234_1.time_ >= var_237_13 + var_237_14 and arg_234_1.time_ < var_237_13 + var_237_14 + arg_237_0 then
				arg_234_1.screenFilterEffect_.weight = 1
			end

			if 0.5 < arg_234_1.time_ and arg_234_1.time_ <= 0.5 + arg_237_0 then
				arg_234_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_truck_loop", "")
			end

			if arg_234_1.frameCnt_ <= 1 then
				arg_234_1.dialog_:SetActive(false)
			end

			local var_237_16 = 4
			local var_237_17 = 0.125

			if 4 < arg_234_1.time_ and arg_234_1.time_ <= var_237_16 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0

				arg_234_1.dialog_:SetActive(true)

				arg_234_1.dialogCg_.alpha = 0

				local var_237_18 = LeanTween.value(arg_234_1.dialog_, 0, 1, 0.3)

				var_237_18:setOnUpdate(LuaHelper.FloatAction(function(arg_238_0)
					arg_234_1.dialogCg_.alpha = arg_238_0
				end))
				var_237_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_234_1.dialog_)
					var_237_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_234_1.duration_ = arg_234_1.duration_ + 0.3

				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_19 = arg_234_1:GetWordFromCfg(417171055)
				local var_237_20 = arg_234_1:FormatText(var_237_19.content)

				arg_234_1.text_.text = var_237_20

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_22 = 5 <= 0 and var_237_17 or var_237_17 * (utf8.len(var_237_20) / 5)

				if (5 <= 0 and var_237_17 or var_237_17 * (utf8.len(var_237_20) / 5)) > 0 and var_237_17 < var_237_22 then
					arg_234_1.talkMaxDuration = var_237_22
					var_237_16 = var_237_16 + 0.3

					if var_237_22 + var_237_16 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_22 + var_237_16
					end
				end

				arg_234_1.text_.text = var_237_20
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171055", "story_v_out_417171.awb") ~= 0 then
					local var_237_23 = manager.audio:GetVoiceLength("story_v_out_417171", "417171055", "story_v_out_417171.awb") / 1000

					if var_237_23 + var_237_16 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_23 + var_237_16
					end

					if var_237_19.prefab_name ~= "" and arg_234_1.actors_[var_237_19.prefab_name] ~= nil then
						local var_237_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_19.prefab_name].transform, "story_v_out_417171", "417171055", "story_v_out_417171.awb")

						arg_234_1:RecordAudio("417171055", var_237_24)
						arg_234_1:RecordAudio("417171055", var_237_24)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_417171", "417171055", "story_v_out_417171.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_417171", "417171055", "story_v_out_417171.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_25 = var_237_16 + 0.3
			local var_237_26 = math.max(var_237_17, arg_234_1.talkMaxDuration)

			if var_237_16 + 0.3 <= arg_234_1.time_ and arg_234_1.time_ < var_237_25 + var_237_26 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_25) / var_237_26

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_25 + var_237_26 and arg_234_1.time_ < var_237_25 + var_237_26 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play417171056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 417171056
		arg_240_1.duration_ = 7.93

		local var_240_0 = {
			zh = 3.933,
			ja = 7.933
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
				arg_240_0:Play417171057(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.425

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_1 = arg_240_1:GetWordFromCfg(417171056)
				local var_243_2 = arg_240_1:FormatText(var_243_1.content)

				arg_240_1.text_.text = var_243_2

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 17 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 17)

				if (17 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 17)) > 0 and var_243_0 < var_243_4 then
					arg_240_1.talkMaxDuration = var_243_4

					if var_243_4 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_4 + 0
					end
				end

				arg_240_1.text_.text = var_243_2
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171056", "story_v_out_417171.awb") ~= 0 then
					local var_243_5 = manager.audio:GetVoiceLength("story_v_out_417171", "417171056", "story_v_out_417171.awb") / 1000

					if var_243_5 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + 0
					end

					if var_243_1.prefab_name ~= "" and arg_240_1.actors_[var_243_1.prefab_name] ~= nil then
						local var_243_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_1.prefab_name].transform, "story_v_out_417171", "417171056", "story_v_out_417171.awb")

						arg_240_1:RecordAudio("417171056", var_243_6)
						arg_240_1:RecordAudio("417171056", var_243_6)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_417171", "417171056", "story_v_out_417171.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_417171", "417171056", "story_v_out_417171.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play417171057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 417171057
		arg_244_1.duration_ = 4.07

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play417171058(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 1.96666666666667 < arg_244_1.time_ and arg_244_1.time_ <= 1.96666666666667 + arg_247_0 then
				arg_244_1.allBtn_.enabled = false
			end

			if arg_244_1.time_ >= 1.96666666666667 + 0.0166666666666667 and arg_244_1.time_ < 1.96666666666667 + 0.0166666666666667 + arg_247_0 then
				arg_244_1.allBtn_.enabled = true
			end

			if 1 < arg_244_1.time_ and arg_244_1.time_ <= 1 + arg_247_0 then
				local var_247_0 = arg_244_1.bgs_.I16h

				arg_244_1.bgs_.I16h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_247_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_247_1 = var_247_0:GetComponent("SpriteRenderer")

				if var_247_1 and var_247_1.sprite then
					local var_247_2 = 2 * (var_247_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_247_0.transform.localScale = Vector3.New(var_247_2 / var_247_1.sprite.bounds.size.y < var_247_2 * manager.ui.mainCameraCom_.aspect / var_247_1.sprite.bounds.size.x and var_247_2 * manager.ui.mainCameraCom_.aspect / var_247_1.sprite.bounds.size.x or var_247_2 / var_247_1.sprite.bounds.size.y, var_247_2 / var_247_1.sprite.bounds.size.y < var_247_2 * manager.ui.mainCameraCom_.aspect / var_247_1.sprite.bounds.size.x and var_247_2 * manager.ui.mainCameraCom_.aspect / var_247_1.sprite.bounds.size.x or var_247_2 / var_247_1.sprite.bounds.size.y, 0)
				end

				for iter_247_0, iter_247_1 in pairs(arg_244_1.bgs_) do
					if iter_247_0 ~= "I16h" then
						iter_247_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_247_3 = 0

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_3 + arg_247_0 then
				arg_244_1.mask_.enabled = true
				arg_244_1.mask_.raycastTarget = true

				arg_244_1:SetGaussion(false)
			end

			local var_247_4 = 1

			if var_247_3 <= arg_244_1.time_ and arg_244_1.time_ < var_247_3 + var_247_4 then
				local var_247_5 = Color.New(0, 0, 0)

				var_247_5.a = Mathf.Lerp(0, 1, (arg_244_1.time_ - var_247_3) / var_247_4)
				arg_244_1.mask_.color = var_247_5
			end

			if arg_244_1.time_ >= var_247_3 + var_247_4 and arg_244_1.time_ < var_247_3 + var_247_4 + arg_247_0 then
				local var_247_6 = Color.New(0, 0, 0)

				var_247_6.a = 1
				arg_244_1.mask_.color = var_247_6
			end

			local var_247_7 = 1

			if 1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_7 + arg_247_0 then
				arg_244_1.mask_.enabled = true
				arg_244_1.mask_.raycastTarget = true

				arg_244_1:SetGaussion(false)
			end

			local var_247_8 = 0.966666666666667

			if var_247_7 <= arg_244_1.time_ and arg_244_1.time_ < var_247_7 + var_247_8 then
				local var_247_9 = Color.New(0, 0, 0)

				var_247_9.a = Mathf.Lerp(1, 0, (arg_244_1.time_ - var_247_7) / var_247_8)
				arg_244_1.mask_.color = var_247_9
			end

			if arg_244_1.time_ >= var_247_7 + var_247_8 and arg_244_1.time_ < var_247_7 + var_247_8 + arg_247_0 then
				local var_247_10 = Color.New(0, 0, 0)

				arg_244_1.mask_.enabled = false
				var_247_10.a = 0
				arg_244_1.mask_.color = var_247_10
			end

			local var_247_11 = arg_244_1.actors_["10128"].transform

			if 1.76666666666667 < arg_244_1.time_ and arg_244_1.time_ <= 1.76666666666667 + arg_247_0 then
				arg_244_1.var_.moveOldPos10128 = var_247_11.localPosition
				var_247_11.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("10128", 3)

				for iter_247_2 = 0, var_247_11.childCount - 1 do
					local var_247_12 = var_247_11:GetChild(iter_247_2)

					if var_247_12.name == "split_6" or not string.find(var_247_12.name, "split") then
						var_247_12.gameObject:SetActive(true)
					else
						var_247_12.gameObject:SetActive(false)
					end
				end
			end

			local var_247_13 = 0.001

			if 1.76666666666667 <= arg_244_1.time_ and arg_244_1.time_ < 1.76666666666667 + var_247_13 then
				var_247_11.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_244_1.time_ - 1.76666666666667) / var_247_13)
			end

			if arg_244_1.time_ >= 1.76666666666667 + var_247_13 and arg_244_1.time_ < 1.76666666666667 + var_247_13 + arg_247_0 then
				var_247_11.localPosition = Vector3.New(0, -347, -300)
			end

			local var_247_14 = arg_244_1.actors_["10128"]

			if 1.76733333333333 < arg_244_1.time_ and arg_244_1.time_ <= 1.76733333333333 + arg_247_0 and not isNil(var_247_14) and arg_244_1.var_.actorSpriteComps10128 == nil then
				arg_244_1.var_.actorSpriteComps10128 = var_247_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_15 = 0.0999999999999999

			if 1.76733333333333 <= arg_244_1.time_ and arg_244_1.time_ < 1.76733333333333 + var_247_15 and not isNil(var_247_14) then
				if arg_244_1.var_.actorSpriteComps10128 then
					for iter_247_3, iter_247_4 in pairs(arg_244_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_247_4 then
							if arg_244_1.isInRecall_ then
								iter_247_4.color = Color.New(Mathf.Lerp(iter_247_4.color.r, arg_244_1.hightColor1.r, (arg_244_1.time_ - 1.76733333333333) / var_247_15), Mathf.Lerp(iter_247_4.color.g, arg_244_1.hightColor1.g, (arg_244_1.time_ - 1.76733333333333) / var_247_15), (Mathf.Lerp(iter_247_4.color.b, arg_244_1.hightColor1.b, (arg_244_1.time_ - 1.76733333333333) / var_247_15)))
							else
								local var_247_16 = Mathf.Lerp(iter_247_4.color.r, 1, (arg_244_1.time_ - 1.76733333333333) / var_247_15)

								iter_247_4.color = Color.New(var_247_16, var_247_16, var_247_16)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= 1.76733333333333 + var_247_15 and arg_244_1.time_ < 1.76733333333333 + var_247_15 + arg_247_0 and not isNil(var_247_14) and arg_244_1.var_.actorSpriteComps10128 then
				for iter_247_5, iter_247_6 in pairs(arg_244_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_247_6 then
						iter_247_6.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_244_1.var_.actorSpriteComps10128 = nil
			end

			if 1.76666666666667 < arg_244_1.time_ and arg_244_1.time_ <= 1.76666666666667 + arg_247_0 then
				local var_247_17 = arg_244_1.actors_["10128"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_247_17 then
					arg_244_1.var_.alphaOldValue10128 = var_247_17.alpha
					arg_244_1.var_.characterEffect10128 = var_247_17
				end

				arg_244_1.var_.alphaOldValue10128 = 0
			end

			local var_247_18 = 0.2

			if 1.76666666666667 <= arg_244_1.time_ and arg_244_1.time_ < 1.76666666666667 + var_247_18 then
				if arg_244_1.var_.characterEffect10128 then
					arg_244_1.var_.characterEffect10128.alpha = Mathf.Lerp(arg_244_1.var_.alphaOldValue10128, 1, (arg_244_1.time_ - 1.76666666666667) / var_247_18)
				end
			end

			if arg_244_1.time_ >= 1.76666666666667 + var_247_18 and arg_244_1.time_ < 1.76666666666667 + var_247_18 + arg_247_0 and arg_244_1.var_.characterEffect10128 then
				arg_244_1.var_.characterEffect10128.alpha = 1
			end

			if arg_244_1.frameCnt_ <= 1 then
				arg_244_1.dialog_:SetActive(false)
			end

			local var_247_19 = 1.96666666666667
			local var_247_20 = 0.075

			if 1.96666666666667 < arg_244_1.time_ and arg_244_1.time_ <= var_247_19 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0

				arg_244_1.dialog_:SetActive(true)

				arg_244_1.dialogCg_.alpha = 0

				local var_247_21 = LeanTween.value(arg_244_1.dialog_, 0, 1, 0.3)

				var_247_21:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_244_1.dialogCg_.alpha = arg_248_0
				end))
				var_247_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_244_1.dialog_)
					var_247_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_244_1.duration_ = arg_244_1.duration_ + 0.3

				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_22 = arg_244_1:GetWordFromCfg(417171057)
				local var_247_23 = arg_244_1:FormatText(var_247_22.content)

				arg_244_1.text_.text = var_247_23

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_25 = 3 <= 0 and var_247_20 or var_247_20 * (utf8.len(var_247_23) / 3)

				if (3 <= 0 and var_247_20 or var_247_20 * (utf8.len(var_247_23) / 3)) > 0 and var_247_20 < var_247_25 then
					arg_244_1.talkMaxDuration = var_247_25
					var_247_19 = var_247_19 + 0.3

					if var_247_25 + var_247_19 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_25 + var_247_19
					end
				end

				arg_244_1.text_.text = var_247_23
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171057", "story_v_out_417171.awb") ~= 0 then
					local var_247_26 = manager.audio:GetVoiceLength("story_v_out_417171", "417171057", "story_v_out_417171.awb") / 1000

					if var_247_26 + var_247_19 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_26 + var_247_19
					end

					if var_247_22.prefab_name ~= "" and arg_244_1.actors_[var_247_22.prefab_name] ~= nil then
						local var_247_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_22.prefab_name].transform, "story_v_out_417171", "417171057", "story_v_out_417171.awb")

						arg_244_1:RecordAudio("417171057", var_247_27)
						arg_244_1:RecordAudio("417171057", var_247_27)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_417171", "417171057", "story_v_out_417171.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_417171", "417171057", "story_v_out_417171.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_28 = var_247_19 + 0.3
			local var_247_29 = math.max(var_247_20, arg_244_1.talkMaxDuration)

			if var_247_19 + 0.3 <= arg_244_1.time_ and arg_244_1.time_ < var_247_28 + var_247_29 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_28) / var_247_29

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_28 + var_247_29 and arg_244_1.time_ < var_247_28 + var_247_29 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play417171058 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 417171058
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play417171059(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos10128 = arg_250_1.actors_["10128"].transform.localPosition
				arg_250_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("10128", 7)

				for iter_253_0 = 0, arg_250_1.actors_["10128"].transform.childCount - 1 do
					local var_253_0 = arg_250_1.actors_["10128"].transform:GetChild(iter_253_0)

					if var_253_0.name == "" or not string.find(var_253_0.name, "split") then
						var_253_0.gameObject:SetActive(true)
					else
						var_253_0.gameObject:SetActive(false)
					end
				end
			end

			local var_253_1 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_1 then
				arg_250_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_250_1.time_ - 0) / var_253_1)
			end

			if arg_250_1.time_ >= 0 + var_253_1 and arg_250_1.time_ < 0 + var_253_1 + arg_253_0 then
				arg_250_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_253_2 = 0
			local var_253_3 = 0.65

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_4 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(417171058).content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_6 = 26 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_4) / 26)

				if (26 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_4) / 26)) > 0 and var_253_3 < var_253_6 then
					arg_250_1.talkMaxDuration = var_253_6

					if var_253_6 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_6 + var_253_2
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_3, arg_250_1.talkMaxDuration)

			if var_253_2 <= arg_250_1.time_ and arg_250_1.time_ < var_253_2 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_2) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_2 + var_253_7 and arg_250_1.time_ < var_253_2 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
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

		arg_250_1:InitPlayNodeList()
	end,
	Play417171059 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 417171059
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play417171060(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.825

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_1 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(417171059).content)

				arg_254_1.text_.text = var_257_1

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_3 = 33 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 33)

				if (33 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 33)) > 0 and var_257_0 < var_257_3 then
					arg_254_1.talkMaxDuration = var_257_3

					if var_257_3 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_3 + 0
					end
				end

				arg_254_1.text_.text = var_257_1
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_4 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_4

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play417171060 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 417171060
		arg_258_1.duration_ = 9

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play417171061(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 4 < arg_258_1.time_ and arg_258_1.time_ <= 4 + arg_261_0 then
				arg_258_1.allBtn_.enabled = false
			end

			if arg_258_1.time_ >= 4 + 0.3 and arg_258_1.time_ < 4 + 0.3 + arg_261_0 then
				arg_258_1.allBtn_.enabled = true
			end

			if 2 < arg_258_1.time_ and arg_258_1.time_ <= 2 + arg_261_0 then
				local var_261_0 = arg_258_1.bgs_.SS1706

				arg_258_1.bgs_.SS1706.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_261_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_261_1 = var_261_0:GetComponent("SpriteRenderer")

				if var_261_1 and var_261_1.sprite then
					local var_261_2 = 2 * (var_261_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_261_0.transform.localScale = Vector3.New(var_261_2 / var_261_1.sprite.bounds.size.y < var_261_2 * manager.ui.mainCameraCom_.aspect / var_261_1.sprite.bounds.size.x and var_261_2 * manager.ui.mainCameraCom_.aspect / var_261_1.sprite.bounds.size.x or var_261_2 / var_261_1.sprite.bounds.size.y, var_261_2 / var_261_1.sprite.bounds.size.y < var_261_2 * manager.ui.mainCameraCom_.aspect / var_261_1.sprite.bounds.size.x and var_261_2 * manager.ui.mainCameraCom_.aspect / var_261_1.sprite.bounds.size.x or var_261_2 / var_261_1.sprite.bounds.size.y, 0)
				end

				for iter_261_0, iter_261_1 in pairs(arg_258_1.bgs_) do
					if iter_261_0 ~= "SS1706" then
						iter_261_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_261_3 = 0

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_3 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_4 = 2

			if var_261_3 <= arg_258_1.time_ and arg_258_1.time_ < var_261_3 + var_261_4 then
				local var_261_5 = Color.New(0, 0, 0)

				var_261_5.a = Mathf.Lerp(0, 1, (arg_258_1.time_ - var_261_3) / var_261_4)
				arg_258_1.mask_.color = var_261_5
			end

			if arg_258_1.time_ >= var_261_3 + var_261_4 and arg_258_1.time_ < var_261_3 + var_261_4 + arg_261_0 then
				local var_261_6 = Color.New(0, 0, 0)

				var_261_6.a = 1
				arg_258_1.mask_.color = var_261_6
			end

			local var_261_7 = 2

			if 2 < arg_258_1.time_ and arg_258_1.time_ <= var_261_7 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_8 = 2

			if var_261_7 <= arg_258_1.time_ and arg_258_1.time_ < var_261_7 + var_261_8 then
				local var_261_9 = Color.New(0, 0, 0)

				var_261_9.a = Mathf.Lerp(1, 0, (arg_258_1.time_ - var_261_7) / var_261_8)
				arg_258_1.mask_.color = var_261_9
			end

			if arg_258_1.time_ >= var_261_7 + var_261_8 and arg_258_1.time_ < var_261_7 + var_261_8 + arg_261_0 then
				local var_261_10 = Color.New(0, 0, 0)

				arg_258_1.mask_.enabled = false
				var_261_10.a = 0
				arg_258_1.mask_.color = var_261_10
			end

			if 4.13333333333333 < arg_258_1.time_ and arg_258_1.time_ <= 4.13333333333333 + arg_261_0 then
				arg_258_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_pictures", "")
			end

			if arg_258_1.frameCnt_ <= 1 then
				arg_258_1.dialog_:SetActive(false)
			end

			local var_261_12 = 4
			local var_261_13 = 0.9

			if 4 < arg_258_1.time_ and arg_258_1.time_ <= var_261_12 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0

				arg_258_1.dialog_:SetActive(true)

				arg_258_1.dialogCg_.alpha = 0

				local var_261_14 = LeanTween.value(arg_258_1.dialog_, 0, 1, 0.3)

				var_261_14:setOnUpdate(LuaHelper.FloatAction(function(arg_262_0)
					arg_258_1.dialogCg_.alpha = arg_262_0
				end))
				var_261_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_258_1.dialog_)
					var_261_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_258_1.duration_ = arg_258_1.duration_ + 0.3

				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_15 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(417171060).content)

				arg_258_1.text_.text = var_261_15

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_17 = 36 <= 0 and var_261_13 or var_261_13 * (utf8.len(var_261_15) / 36)

				if (36 <= 0 and var_261_13 or var_261_13 * (utf8.len(var_261_15) / 36)) > 0 and var_261_13 < var_261_17 then
					arg_258_1.talkMaxDuration = var_261_17
					var_261_12 = var_261_12 + 0.3

					if var_261_17 + var_261_12 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_17 + var_261_12
					end
				end

				arg_258_1.text_.text = var_261_15
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_18 = var_261_12 + 0.3
			local var_261_19 = math.max(var_261_13, arg_258_1.talkMaxDuration)

			if var_261_12 + 0.3 <= arg_258_1.time_ and arg_258_1.time_ < var_261_18 + var_261_19 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_18) / var_261_19

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_18 + var_261_19 and arg_258_1.time_ < var_261_18 + var_261_19 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play417171061 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 417171061
		arg_264_1.duration_ = 9

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play417171062(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 4 < arg_264_1.time_ and arg_264_1.time_ <= 4 + arg_267_0 then
				arg_264_1.allBtn_.enabled = false
			end

			if arg_264_1.time_ >= 4 + 0.766666666666667 and arg_264_1.time_ < 4 + 0.766666666666667 + arg_267_0 then
				arg_264_1.allBtn_.enabled = true
			end

			if 2 < arg_264_1.time_ and arg_264_1.time_ <= 2 + arg_267_0 then
				local var_267_0 = arg_264_1.bgs_.I16h

				arg_264_1.bgs_.I16h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_267_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_267_1 = var_267_0:GetComponent("SpriteRenderer")

				if var_267_1 and var_267_1.sprite then
					local var_267_2 = 2 * (var_267_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_267_0.transform.localScale = Vector3.New(var_267_2 / var_267_1.sprite.bounds.size.y < var_267_2 * manager.ui.mainCameraCom_.aspect / var_267_1.sprite.bounds.size.x and var_267_2 * manager.ui.mainCameraCom_.aspect / var_267_1.sprite.bounds.size.x or var_267_2 / var_267_1.sprite.bounds.size.y, var_267_2 / var_267_1.sprite.bounds.size.y < var_267_2 * manager.ui.mainCameraCom_.aspect / var_267_1.sprite.bounds.size.x and var_267_2 * manager.ui.mainCameraCom_.aspect / var_267_1.sprite.bounds.size.x or var_267_2 / var_267_1.sprite.bounds.size.y, 0)
				end

				for iter_267_0, iter_267_1 in pairs(arg_264_1.bgs_) do
					if iter_267_0 ~= "I16h" then
						iter_267_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_267_3 = 0

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_3 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_4 = 2

			if var_267_3 <= arg_264_1.time_ and arg_264_1.time_ < var_267_3 + var_267_4 then
				local var_267_5 = Color.New(0, 0, 0)

				var_267_5.a = Mathf.Lerp(0, 1, (arg_264_1.time_ - var_267_3) / var_267_4)
				arg_264_1.mask_.color = var_267_5
			end

			if arg_264_1.time_ >= var_267_3 + var_267_4 and arg_264_1.time_ < var_267_3 + var_267_4 + arg_267_0 then
				local var_267_6 = Color.New(0, 0, 0)

				var_267_6.a = 1
				arg_264_1.mask_.color = var_267_6
			end

			local var_267_7 = 2

			if 2 < arg_264_1.time_ and arg_264_1.time_ <= var_267_7 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_8 = 2

			if var_267_7 <= arg_264_1.time_ and arg_264_1.time_ < var_267_7 + var_267_8 then
				local var_267_9 = Color.New(0, 0, 0)

				var_267_9.a = Mathf.Lerp(1, 0, (arg_264_1.time_ - var_267_7) / var_267_8)
				arg_264_1.mask_.color = var_267_9
			end

			if arg_264_1.time_ >= var_267_7 + var_267_8 and arg_264_1.time_ < var_267_7 + var_267_8 + arg_267_0 then
				local var_267_10 = Color.New(0, 0, 0)

				arg_264_1.mask_.enabled = false
				var_267_10.a = 0
				arg_264_1.mask_.color = var_267_10
			end

			if arg_264_1.frameCnt_ <= 1 then
				arg_264_1.dialog_:SetActive(false)
			end

			local var_267_11 = 4
			local var_267_12 = 1.3

			if 4 < arg_264_1.time_ and arg_264_1.time_ <= var_267_11 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0

				arg_264_1.dialog_:SetActive(true)

				arg_264_1.dialogCg_.alpha = 0

				local var_267_13 = LeanTween.value(arg_264_1.dialog_, 0, 1, 0.3)

				var_267_13:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_264_1.dialogCg_.alpha = arg_268_0
				end))
				var_267_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_264_1.dialog_)
					var_267_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_264_1.duration_ = arg_264_1.duration_ + 0.3

				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_14 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(417171061).content)

				arg_264_1.text_.text = var_267_14

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_16 = 52 <= 0 and var_267_12 or var_267_12 * (utf8.len(var_267_14) / 52)

				if (52 <= 0 and var_267_12 or var_267_12 * (utf8.len(var_267_14) / 52)) > 0 and var_267_12 < var_267_16 then
					arg_264_1.talkMaxDuration = var_267_16
					var_267_11 = var_267_11 + 0.3

					if var_267_16 + var_267_11 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_16 + var_267_11
					end
				end

				arg_264_1.text_.text = var_267_14
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_17 = var_267_11 + 0.3
			local var_267_18 = math.max(var_267_12, arg_264_1.talkMaxDuration)

			if var_267_11 + 0.3 <= arg_264_1.time_ and arg_264_1.time_ < var_267_17 + var_267_18 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_17) / var_267_18

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_17 + var_267_18 and arg_264_1.time_ < var_267_17 + var_267_18 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play417171062 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 417171062
		arg_270_1.duration_ = 5.2

		local var_270_0 = {
			zh = 4.966,
			ja = 5.2
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play417171063(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 4 < arg_270_1.time_ and arg_270_1.time_ <= 4 + arg_273_0 then
				arg_270_1.allBtn_.enabled = false
			end

			if arg_270_1.time_ >= 4 + 0.0166666666666667 and arg_270_1.time_ < 4 + 0.0166666666666667 + arg_273_0 then
				arg_270_1.allBtn_.enabled = true
			end

			if 2 < arg_270_1.time_ and arg_270_1.time_ <= 2 + arg_273_0 then
				local var_273_0 = arg_270_1.bgs_.ST75

				arg_270_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_273_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_273_1 = var_273_0:GetComponent("SpriteRenderer")

				if var_273_1 and var_273_1.sprite then
					local var_273_2 = 2 * (var_273_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_273_0.transform.localScale = Vector3.New(var_273_2 / var_273_1.sprite.bounds.size.y < var_273_2 * manager.ui.mainCameraCom_.aspect / var_273_1.sprite.bounds.size.x and var_273_2 * manager.ui.mainCameraCom_.aspect / var_273_1.sprite.bounds.size.x or var_273_2 / var_273_1.sprite.bounds.size.y, var_273_2 / var_273_1.sprite.bounds.size.y < var_273_2 * manager.ui.mainCameraCom_.aspect / var_273_1.sprite.bounds.size.x and var_273_2 * manager.ui.mainCameraCom_.aspect / var_273_1.sprite.bounds.size.x or var_273_2 / var_273_1.sprite.bounds.size.y, 0)
				end

				for iter_273_0, iter_273_1 in pairs(arg_270_1.bgs_) do
					if iter_273_0 ~= "ST75" then
						iter_273_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_273_3 = 0

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_3 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_4 = 2

			if var_273_3 <= arg_270_1.time_ and arg_270_1.time_ < var_273_3 + var_273_4 then
				local var_273_5 = Color.New(0, 0, 0)

				var_273_5.a = Mathf.Lerp(0, 1, (arg_270_1.time_ - var_273_3) / var_273_4)
				arg_270_1.mask_.color = var_273_5
			end

			if arg_270_1.time_ >= var_273_3 + var_273_4 and arg_270_1.time_ < var_273_3 + var_273_4 + arg_273_0 then
				local var_273_6 = Color.New(0, 0, 0)

				var_273_6.a = 1
				arg_270_1.mask_.color = var_273_6
			end

			local var_273_7 = 2

			if 2 < arg_270_1.time_ and arg_270_1.time_ <= var_273_7 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_8 = 2

			if var_273_7 <= arg_270_1.time_ and arg_270_1.time_ < var_273_7 + var_273_8 then
				local var_273_9 = Color.New(0, 0, 0)

				var_273_9.a = Mathf.Lerp(1, 0, (arg_270_1.time_ - var_273_7) / var_273_8)
				arg_270_1.mask_.color = var_273_9
			end

			if arg_270_1.time_ >= var_273_7 + var_273_8 and arg_270_1.time_ < var_273_7 + var_273_8 + arg_273_0 then
				local var_273_10 = Color.New(0, 0, 0)

				arg_270_1.mask_.enabled = false
				var_273_10.a = 0
				arg_270_1.mask_.color = var_273_10
			end

			local var_273_11 = arg_270_1.actors_["10128"]

			if 3.8 < arg_270_1.time_ and arg_270_1.time_ <= 3.8 + arg_273_0 and not isNil(var_273_11) and arg_270_1.var_.actorSpriteComps10128 == nil then
				arg_270_1.var_.actorSpriteComps10128 = var_273_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_12 = 0.2

			if 3.8 <= arg_270_1.time_ and arg_270_1.time_ < 3.8 + var_273_12 and not isNil(var_273_11) then
				if arg_270_1.var_.actorSpriteComps10128 then
					for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_273_3 then
							if arg_270_1.isInRecall_ then
								iter_273_3.color = Color.New(Mathf.Lerp(iter_273_3.color.r, arg_270_1.hightColor1.r, (arg_270_1.time_ - 3.8) / var_273_12), Mathf.Lerp(iter_273_3.color.g, arg_270_1.hightColor1.g, (arg_270_1.time_ - 3.8) / var_273_12), (Mathf.Lerp(iter_273_3.color.b, arg_270_1.hightColor1.b, (arg_270_1.time_ - 3.8) / var_273_12)))
							else
								local var_273_13 = Mathf.Lerp(iter_273_3.color.r, 1, (arg_270_1.time_ - 3.8) / var_273_12)

								iter_273_3.color = Color.New(var_273_13, var_273_13, var_273_13)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 3.8 + var_273_12 and arg_270_1.time_ < 3.8 + var_273_12 + arg_273_0 and not isNil(var_273_11) and arg_270_1.var_.actorSpriteComps10128 then
				for iter_273_4, iter_273_5 in pairs(arg_270_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_273_5 then
						iter_273_5.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_270_1.var_.actorSpriteComps10128 = nil
			end

			local var_273_14 = arg_270_1.actors_["10128"].transform

			if 3.8 < arg_270_1.time_ and arg_270_1.time_ <= 3.8 + arg_273_0 then
				arg_270_1.var_.moveOldPos10128 = var_273_14.localPosition
				var_273_14.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("10128", 3)

				for iter_273_6 = 0, var_273_14.childCount - 1 do
					local var_273_15 = var_273_14:GetChild(iter_273_6)

					if var_273_15.name == "" or not string.find(var_273_15.name, "split") then
						var_273_15.gameObject:SetActive(true)
					else
						var_273_15.gameObject:SetActive(false)
					end
				end
			end

			local var_273_16 = 0.001

			if 3.8 <= arg_270_1.time_ and arg_270_1.time_ < 3.8 + var_273_16 then
				var_273_14.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_270_1.time_ - 3.8) / var_273_16)
			end

			if arg_270_1.time_ >= 3.8 + var_273_16 and arg_270_1.time_ < 3.8 + var_273_16 + arg_273_0 then
				var_273_14.localPosition = Vector3.New(0, -347, -300)
			end

			if 3.8 < arg_270_1.time_ and arg_270_1.time_ <= 3.8 + arg_273_0 then
				local var_273_17 = arg_270_1.actors_["10128"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_273_17 then
					arg_270_1.var_.alphaOldValue10128 = var_273_17.alpha
					arg_270_1.var_.characterEffect10128 = var_273_17
				end

				arg_270_1.var_.alphaOldValue10128 = 0
			end

			local var_273_18 = 0.2

			if 3.8 <= arg_270_1.time_ and arg_270_1.time_ < 3.8 + var_273_18 then
				if arg_270_1.var_.characterEffect10128 then
					arg_270_1.var_.characterEffect10128.alpha = Mathf.Lerp(arg_270_1.var_.alphaOldValue10128, 1, (arg_270_1.time_ - 3.8) / var_273_18)
				end
			end

			if arg_270_1.time_ >= 3.8 + var_273_18 and arg_270_1.time_ < 3.8 + var_273_18 + arg_273_0 and arg_270_1.var_.characterEffect10128 then
				arg_270_1.var_.characterEffect10128.alpha = 1
			end

			local var_273_19 = 1.93333333333333

			arg_270_1.isInRecall_ = false

			if var_273_19 < arg_270_1.time_ and arg_270_1.time_ <= var_273_19 + arg_273_0 then
				arg_270_1.screenFilterGo_:SetActive(false)

				for iter_273_7, iter_273_8 in pairs(arg_270_1.actors_) do
					for iter_273_9, iter_273_10 in ipairs((iter_273_8:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_273_10.color = iter_273_10.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_273_20 = 0.0666666666666667

			if var_273_19 <= arg_270_1.time_ and arg_270_1.time_ < var_273_19 + var_273_20 then
				arg_270_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_270_1.time_ - var_273_19) / var_273_20)
			end

			if arg_270_1.time_ >= var_273_19 + var_273_20 and arg_270_1.time_ < var_273_19 + var_273_20 + arg_273_0 then
				arg_270_1.screenFilterEffect_.weight = 0
			end

			if 1.66666666666667 < arg_270_1.time_ and arg_270_1.time_ <= 1.66666666666667 + arg_273_0 then
				arg_270_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_truck_loop", "")
			end

			if arg_270_1.frameCnt_ <= 1 then
				arg_270_1.dialog_:SetActive(false)
			end

			local var_273_22 = 4
			local var_273_23 = 0.05

			if 4 < arg_270_1.time_ and arg_270_1.time_ <= var_273_22 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				arg_270_1.dialog_:SetActive(true)

				arg_270_1.dialogCg_.alpha = 0

				local var_273_24 = LeanTween.value(arg_270_1.dialog_, 0, 1, 0.3)

				var_273_24:setOnUpdate(LuaHelper.FloatAction(function(arg_274_0)
					arg_270_1.dialogCg_.alpha = arg_274_0
				end))
				var_273_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_270_1.dialog_)
					var_273_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_270_1.duration_ = arg_270_1.duration_ + 0.3

				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_25 = arg_270_1:GetWordFromCfg(417171062)
				local var_273_26 = arg_270_1:FormatText(var_273_25.content)

				arg_270_1.text_.text = var_273_26

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_28 = 2 <= 0 and var_273_23 or var_273_23 * (utf8.len(var_273_26) / 2)

				if (2 <= 0 and var_273_23 or var_273_23 * (utf8.len(var_273_26) / 2)) > 0 and var_273_23 < var_273_28 then
					arg_270_1.talkMaxDuration = var_273_28
					var_273_22 = var_273_22 + 0.3

					if var_273_28 + var_273_22 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_28 + var_273_22
					end
				end

				arg_270_1.text_.text = var_273_26
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171062", "story_v_out_417171.awb") ~= 0 then
					local var_273_29 = manager.audio:GetVoiceLength("story_v_out_417171", "417171062", "story_v_out_417171.awb") / 1000

					if var_273_29 + var_273_22 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_29 + var_273_22
					end

					if var_273_25.prefab_name ~= "" and arg_270_1.actors_[var_273_25.prefab_name] ~= nil then
						local var_273_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_25.prefab_name].transform, "story_v_out_417171", "417171062", "story_v_out_417171.awb")

						arg_270_1:RecordAudio("417171062", var_273_30)
						arg_270_1:RecordAudio("417171062", var_273_30)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_417171", "417171062", "story_v_out_417171.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_417171", "417171062", "story_v_out_417171.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_31 = var_273_22 + 0.3
			local var_273_32 = math.max(var_273_23, arg_270_1.talkMaxDuration)

			if var_273_22 + 0.3 <= arg_270_1.time_ and arg_270_1.time_ < var_273_31 + var_273_32 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_31) / var_273_32

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_31 + var_273_32 and arg_270_1.time_ < var_273_31 + var_273_32 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play417171063 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 417171063
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play417171064(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos10128 = arg_276_1.actors_["10128"].transform.localPosition
				arg_276_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("10128", 7)

				for iter_279_0 = 0, arg_276_1.actors_["10128"].transform.childCount - 1 do
					local var_279_0 = arg_276_1.actors_["10128"].transform:GetChild(iter_279_0)

					if var_279_0.name == "" or not string.find(var_279_0.name, "split") then
						var_279_0.gameObject:SetActive(true)
					else
						var_279_0.gameObject:SetActive(false)
					end
				end
			end

			local var_279_1 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_1 then
				arg_276_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_276_1.time_ - 0) / var_279_1)
			end

			if arg_276_1.time_ >= 0 + var_279_1 and arg_276_1.time_ < 0 + var_279_1 + arg_279_0 then
				arg_276_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:AudioAction("play", "effect", "se_story_138", "se_story_138_carloop_stop", "")
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:AudioAction("stop", "effect", "se_story_1311_truck_loop", "se_story_1311_truck_loop", "")
			end

			local var_279_4 = 0
			local var_279_5 = 1.75

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_4 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_6 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(417171063).content)

				arg_276_1.text_.text = var_279_6

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_8 = 70 <= 0 and var_279_5 or var_279_5 * (utf8.len(var_279_6) / 70)

				if (70 <= 0 and var_279_5 or var_279_5 * (utf8.len(var_279_6) / 70)) > 0 and var_279_5 < var_279_8 then
					arg_276_1.talkMaxDuration = var_279_8

					if var_279_8 + var_279_4 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_4
					end
				end

				arg_276_1.text_.text = var_279_6
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_9 = math.max(var_279_5, arg_276_1.talkMaxDuration)

			if var_279_4 <= arg_276_1.time_ and arg_276_1.time_ < var_279_4 + var_279_9 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_4) / var_279_9

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_4 + var_279_9 and arg_276_1.time_ < var_279_4 + var_279_9 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
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

		arg_276_1:InitPlayNodeList()
	end,
	Play417171064 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 417171064
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play417171065(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0.05 < arg_280_1.time_ and arg_280_1.time_ <= 0.05 + arg_283_0 then
				arg_280_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_cardoor", "")
			end

			local var_283_1 = 0
			local var_283_2 = 0.725

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_3 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(417171064).content)

				arg_280_1.text_.text = var_283_3

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 29 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_3) / 29)

				if (29 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_3) / 29)) > 0 and var_283_2 < var_283_5 then
					arg_280_1.talkMaxDuration = var_283_5

					if var_283_5 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_5 + var_283_1
					end
				end

				arg_280_1.text_.text = var_283_3
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_6 = math.max(var_283_2, arg_280_1.talkMaxDuration)

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_6 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_1) / var_283_6

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_1 + var_283_6 and arg_280_1.time_ < var_283_1 + var_283_6 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play417171065 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 417171065
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
			arg_284_1.auto_ = false
		end

		function arg_284_1.playNext_(arg_286_0)
			arg_284_1.onStoryFinished_()
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.875

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_1 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(417171065).content)

				arg_284_1.text_.text = var_287_1

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_3 = 35 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_1) / 35)

				if (35 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_1) / 35)) > 0 and var_287_0 < var_287_3 then
					arg_284_1.talkMaxDuration = var_287_3

					if var_287_3 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_3 + 0
					end
				end

				arg_284_1.text_.text = var_287_1
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_4 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_4

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I16h",
		"TextureConfig/Background/I17f",
		"TextureConfig/Background/ST75",
		"TextureConfig/Background/SS1706"
	},
	voices = {
		"story_v_out_417171.awb"
	}
}
