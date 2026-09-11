return {
	Play417082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417082001
		arg_1_1.duration_ = 7.5

		local var_1_0 = {
			zh = 6.866,
			ja = 7.5
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
				arg_1_0:Play417082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D06a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D06a")
				var_4_0.name = "D06a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D06a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D06a

				arg_1_1.bgs_.D06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D06a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 5.600000000001

			if 5.600000000001 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = "1034"

			if arg_1_1.actors_["1034"] == nil then
				local var_4_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

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

			local var_4_8 = arg_1_1.actors_["1034"]

			if 5.4 < arg_1_1.time_ and arg_1_1.time_ <= 5.4 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.actorSpriteComps1034 == nil then
				arg_1_1.var_.actorSpriteComps1034 = var_4_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_9 = 0.2

			if 5.4 <= arg_1_1.time_ and arg_1_1.time_ < 5.4 + var_4_9 and not isNil(var_4_8) then
				if arg_1_1.var_.actorSpriteComps1034 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 5.4) / var_4_9), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 5.4) / var_4_9), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 5.4) / var_4_9)))
							else
								local var_4_10 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 5.4) / var_4_9)

								iter_4_5.color = Color.New(var_4_10, var_4_10, var_4_10)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 5.4 + var_4_9 and arg_1_1.time_ < 5.4 + var_4_9 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.actorSpriteComps1034 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1034 = nil
			end

			local var_4_11 = arg_1_1.actors_["1034"].transform

			if 5.4 < arg_1_1.time_ and arg_1_1.time_ <= 5.4 + arg_4_0 then
				arg_1_1.var_.moveOldPos1034 = var_4_11.localPosition
				var_4_11.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1034", 3)

				for iter_4_8 = 0, var_4_11.childCount - 1 do
					local var_4_12 = var_4_11:GetChild(iter_4_8)

					if var_4_12.name == "" or not string.find(var_4_12.name, "split") then
						var_4_12.gameObject:SetActive(true)
					else
						var_4_12.gameObject:SetActive(false)
					end
				end
			end

			local var_4_13 = 0.001

			if 5.4 <= arg_1_1.time_ and arg_1_1.time_ < 5.4 + var_4_13 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_1_1.time_ - 5.4) / var_4_13)
			end

			if arg_1_1.time_ >= 5.4 + var_4_13 and arg_1_1.time_ < 5.4 + var_4_13 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, -331.9, -324)
			end

			if 5.4 < arg_1_1.time_ and arg_1_1.time_ <= 5.4 + arg_4_0 then
				local var_4_14 = arg_1_1.actors_["1034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_14 then
					arg_1_1.var_.alphaOldValue1034 = var_4_14.alpha
					arg_1_1.var_.characterEffect1034 = var_4_14
				end

				arg_1_1.var_.alphaOldValue1034 = 0
			end

			local var_4_15 = 0.200000000001

			if 5.4 <= arg_1_1.time_ and arg_1_1.time_ < 5.4 + var_4_15 then
				if arg_1_1.var_.characterEffect1034 then
					arg_1_1.var_.characterEffect1034.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue1034, 1, (arg_1_1.time_ - 5.4) / var_4_15)
				end
			end

			if arg_1_1.time_ >= 5.4 + var_4_15 and arg_1_1.time_ < 5.4 + var_4_15 + arg_4_0 and arg_1_1.var_.characterEffect1034 then
				arg_1_1.var_.characterEffect1034.alpha = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			local var_4_22 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D06a")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501031).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501032).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_22 + 3 and arg_1_1.time_ < var_4_22 + 3 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_23 = 3

			if 3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_24 = 1.2

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				local var_4_25 = Color.New(0, 0, 0)

				var_4_25.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_23) / var_4_24)
				arg_1_1.mask_.color = var_4_25
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				local var_4_26 = Color.New(0, 0, 0)

				var_4_26.a = 1
				arg_1_1.mask_.color = var_4_26
			end

			local var_4_27 = 4.2

			if 4.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_28 = 1.2

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 then
				local var_4_29 = Color.New(0, 0, 0)

				var_4_29.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_27) / var_4_28)
				arg_1_1.mask_.color = var_4_29
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 then
				local var_4_30 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_30.a = 0
				arg_1_1.mask_.color = var_4_30
			end

			local var_4_31 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_32 = 1

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				local var_4_33 = Color.New(0, 0, 0)

				var_4_33.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_31) / var_4_32)
				arg_1_1.mask_.color = var_4_33
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				local var_4_34 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_34.a = 0
				arg_1_1.mask_.color = var_4_34
			end

			local var_4_35 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_35 + 3 and arg_1_1.time_ < var_4_35 + 3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 5.4
			local var_4_37 = 0.15

			if 5.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:GetWordFromCfg(417082001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 6 <= 0 and var_4_37 or var_4_37 * (utf8.len(var_4_40) / 6)

				if (6 <= 0 and var_4_37 or var_4_37 * (utf8.len(var_4_40) / 6)) > 0 and var_4_37 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_36 = var_4_36 + 0.3

					if var_4_42 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_40
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082001", "story_v_out_417082.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_417082", "417082001", "story_v_out_417082.awb") / 1000

					if var_4_43 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_36
					end

					if var_4_39.prefab_name ~= "" and arg_1_1.actors_[var_4_39.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_39.prefab_name].transform, "story_v_out_417082", "417082001", "story_v_out_417082.awb")

						arg_1_1:RecordAudio("417082001", var_4_44)
						arg_1_1:RecordAudio("417082001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417082", "417082001", "story_v_out_417082.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417082", "417082001", "story_v_out_417082.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_36 + 0.3
			local var_4_46 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_36 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play417082002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417082002
		arg_10_1.duration_ = 2.27

		local var_10_0 = {
			zh = 1.6,
			ja = 2.266
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
				arg_10_0:Play417082003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(arg_10_1.actors_["1034"]) and arg_10_1.var_.actorSpriteComps1034 == nil then
				arg_10_1.var_.actorSpriteComps1034 = arg_10_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_0 = 0.2

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_0 and not isNil(arg_10_1.actors_["1034"]) then
				if arg_10_1.var_.actorSpriteComps1034 then
					for iter_13_0, iter_13_1 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_10_1.time_ >= 0 + var_13_0 and arg_10_1.time_ < 0 + var_13_0 + arg_13_0 and not isNil(arg_10_1.actors_["1034"]) and arg_10_1.var_.actorSpriteComps1034 then
				for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_13_3 then
						iter_13_3.color = arg_10_1.isInRecall_ and (arg_10_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_10_1.var_.actorSpriteComps1034 = nil
			end

			local var_13_2 = 0
			local var_13_3 = 0.15

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_2 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, true)
				arg_10_1.iconController_:SetSelectedState("hero")

				arg_10_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_10_1.callingController_:SetSelectedState("normal")

				arg_10_1.keyicon_.color = Color.New(1, 1, 1)
				arg_10_1.icon_.color = Color.New(1, 1, 1)

				local var_13_4 = arg_10_1:GetWordFromCfg(417082002)
				local var_13_5 = arg_10_1:FormatText(var_13_4.content)

				arg_10_1.text_.text = var_13_5

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_7 = 6 <= 0 and var_13_3 or var_13_3 * (utf8.len(var_13_5) / 6)

				if (6 <= 0 and var_13_3 or var_13_3 * (utf8.len(var_13_5) / 6)) > 0 and var_13_3 < var_13_7 then
					arg_10_1.talkMaxDuration = var_13_7

					if var_13_7 + var_13_2 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_7 + var_13_2
					end
				end

				arg_10_1.text_.text = var_13_5
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082002", "story_v_out_417082.awb") ~= 0 then
					local var_13_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082002", "story_v_out_417082.awb") / 1000

					if var_13_8 + var_13_2 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_8 + var_13_2
					end

					if var_13_4.prefab_name ~= "" and arg_10_1.actors_[var_13_4.prefab_name] ~= nil then
						local var_13_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_4.prefab_name].transform, "story_v_out_417082", "417082002", "story_v_out_417082.awb")

						arg_10_1:RecordAudio("417082002", var_13_9)
						arg_10_1:RecordAudio("417082002", var_13_9)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_417082", "417082002", "story_v_out_417082.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_417082", "417082002", "story_v_out_417082.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_10 = math.max(var_13_3, arg_10_1.talkMaxDuration)

			if var_13_2 <= arg_10_1.time_ and arg_10_1.time_ < var_13_2 + var_13_10 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_2) / var_13_10

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_2 + var_13_10 and arg_10_1.time_ < var_13_2 + var_13_10 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417082003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417082003
		arg_14_1.duration_ = 7.87

		local var_14_0 = {
			zh = 4.5,
			ja = 7.866
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
				arg_14_0:Play417082004(arg_14_1)
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
								iter_17_1.color = Color.New(Mathf.Lerp(iter_17_1.color.r, arg_14_1.hightColor1.r, (arg_14_1.time_ - 0) / var_17_0), Mathf.Lerp(iter_17_1.color.g, arg_14_1.hightColor1.g, (arg_14_1.time_ - 0) / var_17_0), (Mathf.Lerp(iter_17_1.color.b, arg_14_1.hightColor1.b, (arg_14_1.time_ - 0) / var_17_0)))
							else
								local var_17_1 = Mathf.Lerp(iter_17_1.color.r, 1, (arg_14_1.time_ - 0) / var_17_0)

								iter_17_1.color = Color.New(var_17_1, var_17_1, var_17_1)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 and not isNil(arg_14_1.actors_["1034"]) and arg_14_1.var_.actorSpriteComps1034 then
				for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_17_3 then
						iter_17_3.color = arg_14_1.isInRecall_ and (arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_14_1.var_.actorSpriteComps1034 = nil
			end

			local var_17_2 = arg_14_1.actors_["1034"].transform

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos1034 = var_17_2.localPosition
				var_17_2.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("1034", 3)

				for iter_17_4 = 0, var_17_2.childCount - 1 do
					local var_17_3 = var_17_2:GetChild(iter_17_4)

					if var_17_3.name == "" or not string.find(var_17_3.name, "split") then
						var_17_3.gameObject:SetActive(true)
					else
						var_17_3.gameObject:SetActive(false)
					end
				end
			end

			local var_17_4 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_4 then
				var_17_2.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_14_1.time_ - 0) / var_17_4)
			end

			if arg_14_1.time_ >= 0 + var_17_4 and arg_14_1.time_ < 0 + var_17_4 + arg_17_0 then
				var_17_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_17_5 = 0
			local var_17_6 = 0.575

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_5 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_7 = arg_14_1:GetWordFromCfg(417082003)
				local var_17_8 = arg_14_1:FormatText(var_17_7.content)

				arg_14_1.text_.text = var_17_8

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_10 = 23 <= 0 and var_17_6 or var_17_6 * (utf8.len(var_17_8) / 23)

				if (23 <= 0 and var_17_6 or var_17_6 * (utf8.len(var_17_8) / 23)) > 0 and var_17_6 < var_17_10 then
					arg_14_1.talkMaxDuration = var_17_10

					if var_17_10 + var_17_5 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_10 + var_17_5
					end
				end

				arg_14_1.text_.text = var_17_8
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082003", "story_v_out_417082.awb") ~= 0 then
					local var_17_11 = manager.audio:GetVoiceLength("story_v_out_417082", "417082003", "story_v_out_417082.awb") / 1000

					if var_17_11 + var_17_5 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_11 + var_17_5
					end

					if var_17_7.prefab_name ~= "" and arg_14_1.actors_[var_17_7.prefab_name] ~= nil then
						local var_17_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_7.prefab_name].transform, "story_v_out_417082", "417082003", "story_v_out_417082.awb")

						arg_14_1:RecordAudio("417082003", var_17_12)
						arg_14_1:RecordAudio("417082003", var_17_12)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417082", "417082003", "story_v_out_417082.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417082", "417082003", "story_v_out_417082.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_13 = math.max(var_17_6, arg_14_1.talkMaxDuration)

			if var_17_5 <= arg_14_1.time_ and arg_14_1.time_ < var_17_5 + var_17_13 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_5) / var_17_13

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_5 + var_17_13 and arg_14_1.time_ < var_17_5 + var_17_13 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
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

		arg_14_1:InitPlayNodeList()
	end,
	Play417082004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417082004
		arg_18_1.duration_ = 3.9

		local var_18_0 = {
			zh = 1.6,
			ja = 3.9
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
				arg_18_0:Play417082005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.2

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
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

				local var_21_1 = arg_18_1:GetWordFromCfg(417082004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 8 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 8)

				if (8 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 8)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082004", "story_v_out_417082.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_417082", "417082004", "story_v_out_417082.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_417082", "417082004", "story_v_out_417082.awb")

						arg_18_1:RecordAudio("417082004", var_21_6)
						arg_18_1:RecordAudio("417082004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417082", "417082004", "story_v_out_417082.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417082", "417082004", "story_v_out_417082.awb")
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
	Play417082005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417082005
		arg_22_1.duration_ = 9.87

		local var_22_0 = {
			zh = 5.766,
			ja = 9.866
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
				arg_22_0:Play417082006(arg_22_1)
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
			local var_25_3 = 0.75

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_4 = arg_22_1:GetWordFromCfg(417082005)
				local var_25_5 = arg_22_1:FormatText(var_25_4.content)

				arg_22_1.text_.text = var_25_5

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_7 = 30 <= 0 and var_25_3 or var_25_3 * (utf8.len(var_25_5) / 30)

				if (30 <= 0 and var_25_3 or var_25_3 * (utf8.len(var_25_5) / 30)) > 0 and var_25_3 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_2 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_2
					end
				end

				arg_22_1.text_.text = var_25_5
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082005", "story_v_out_417082.awb") ~= 0 then
					local var_25_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082005", "story_v_out_417082.awb") / 1000

					if var_25_8 + var_25_2 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_8 + var_25_2
					end

					if var_25_4.prefab_name ~= "" and arg_22_1.actors_[var_25_4.prefab_name] ~= nil then
						local var_25_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_4.prefab_name].transform, "story_v_out_417082", "417082005", "story_v_out_417082.awb")

						arg_22_1:RecordAudio("417082005", var_25_9)
						arg_22_1:RecordAudio("417082005", var_25_9)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417082", "417082005", "story_v_out_417082.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417082", "417082005", "story_v_out_417082.awb")
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
	Play417082006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417082006
		arg_26_1.duration_ = 9.8

		local var_26_0 = {
			zh = 5.066,
			ja = 9.8
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
				arg_26_0:Play417082007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.675

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_1 = arg_26_1:GetWordFromCfg(417082006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 27 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 27)

				if (27 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 27)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082006", "story_v_out_417082.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_417082", "417082006", "story_v_out_417082.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_417082", "417082006", "story_v_out_417082.awb")

						arg_26_1:RecordAudio("417082006", var_29_6)
						arg_26_1:RecordAudio("417082006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417082", "417082006", "story_v_out_417082.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417082", "417082006", "story_v_out_417082.awb")
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
	Play417082007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417082007
		arg_30_1.duration_ = 1.9

		local var_30_0 = {
			zh = 1.9,
			ja = 1.666
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
				arg_30_0:Play417082008(arg_30_1)
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
								iter_33_1.color = Color.New(Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor1.r, (arg_30_1.time_ - 0) / var_33_0), Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor1.g, (arg_30_1.time_ - 0) / var_33_0), (Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor1.b, (arg_30_1.time_ - 0) / var_33_0)))
							else
								local var_33_1 = Mathf.Lerp(iter_33_1.color.r, 1, (arg_30_1.time_ - 0) / var_33_0)

								iter_33_1.color = Color.New(var_33_1, var_33_1, var_33_1)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["1034"]) and arg_30_1.var_.actorSpriteComps1034 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_30_1.var_.actorSpriteComps1034 = nil
			end

			local var_33_2 = arg_30_1.actors_["1034"].transform

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos1034 = var_33_2.localPosition
				var_33_2.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("1034", 3)

				for iter_33_4 = 0, var_33_2.childCount - 1 do
					local var_33_3 = var_33_2:GetChild(iter_33_4)

					if var_33_3.name == "split_7" or not string.find(var_33_3.name, "split") then
						var_33_3.gameObject:SetActive(true)
					else
						var_33_3.gameObject:SetActive(false)
					end
				end
			end

			local var_33_4 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				var_33_2.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_30_1.time_ - 0) / var_33_4)
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				var_33_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_33_5 = 0
			local var_33_6 = 0.125

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_7 = arg_30_1:GetWordFromCfg(417082007)
				local var_33_8 = arg_30_1:FormatText(var_33_7.content)

				arg_30_1.text_.text = var_33_8

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_10 = 5 <= 0 and var_33_6 or var_33_6 * (utf8.len(var_33_8) / 5)

				if (5 <= 0 and var_33_6 or var_33_6 * (utf8.len(var_33_8) / 5)) > 0 and var_33_6 < var_33_10 then
					arg_30_1.talkMaxDuration = var_33_10

					if var_33_10 + var_33_5 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_5
					end
				end

				arg_30_1.text_.text = var_33_8
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082007", "story_v_out_417082.awb") ~= 0 then
					local var_33_11 = manager.audio:GetVoiceLength("story_v_out_417082", "417082007", "story_v_out_417082.awb") / 1000

					if var_33_11 + var_33_5 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_11 + var_33_5
					end

					if var_33_7.prefab_name ~= "" and arg_30_1.actors_[var_33_7.prefab_name] ~= nil then
						local var_33_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_7.prefab_name].transform, "story_v_out_417082", "417082007", "story_v_out_417082.awb")

						arg_30_1:RecordAudio("417082007", var_33_12)
						arg_30_1:RecordAudio("417082007", var_33_12)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417082", "417082007", "story_v_out_417082.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417082", "417082007", "story_v_out_417082.awb")
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
				actorName = "1034",
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
	Play417082008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417082008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417082009(arg_34_1)
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
								iter_37_1.color = Color.New(Mathf.Lerp(iter_37_1.color.r, arg_34_1.hightColor2.r, (arg_34_1.time_ - 0) / var_37_0), Mathf.Lerp(iter_37_1.color.g, arg_34_1.hightColor2.g, (arg_34_1.time_ - 0) / var_37_0), (Mathf.Lerp(iter_37_1.color.b, arg_34_1.hightColor2.b, (arg_34_1.time_ - 0) / var_37_0)))
							else
								local var_37_1 = Mathf.Lerp(iter_37_1.color.r, 0.5, (arg_34_1.time_ - 0) / var_37_0)

								iter_37_1.color = Color.New(var_37_1, var_37_1, var_37_1)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["1034"]) and arg_34_1.var_.actorSpriteComps1034 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_37_3 then
						iter_37_3.color = arg_34_1.isInRecall_ and (arg_34_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_34_1.var_.actorSpriteComps1034 = nil
			end

			local var_37_2 = arg_34_1.actors_["1034"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1034 = var_37_2.localPosition
				var_37_2.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1034", 7)

				for iter_37_4 = 0, var_37_2.childCount - 1 do
					local var_37_3 = var_37_2:GetChild(iter_37_4)

					if var_37_3.name == "" or not string.find(var_37_3.name, "split") then
						var_37_3.gameObject:SetActive(true)
					else
						var_37_3.gameObject:SetActive(false)
					end
				end
			end

			local var_37_4 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				var_37_2.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_34_1.time_ - 0) / var_37_4)
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				var_37_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.633333333333333 < arg_34_1.time_ and arg_34_1.time_ <= 0.633333333333333 + arg_37_0 then
				arg_34_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_clap", "")
			end

			local var_37_6 = 0
			local var_37_7 = 1.15

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_8 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(417082008).content)

				arg_34_1.text_.text = var_37_8

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_10 = 46 <= 0 and var_37_7 or var_37_7 * (utf8.len(var_37_8) / 46)

				if (46 <= 0 and var_37_7 or var_37_7 * (utf8.len(var_37_8) / 46)) > 0 and var_37_7 < var_37_10 then
					arg_34_1.talkMaxDuration = var_37_10

					if var_37_10 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_10 + var_37_6
					end
				end

				arg_34_1.text_.text = var_37_8
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_11 = math.max(var_37_7, arg_34_1.talkMaxDuration)

			if var_37_6 <= arg_34_1.time_ and arg_34_1.time_ < var_37_6 + var_37_11 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_6) / var_37_11

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_6 + var_37_11 and arg_34_1.time_ < var_37_6 + var_37_11 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
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

		arg_34_1:InitPlayNodeList()
	end,
	Play417082009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417082009
		arg_38_1.duration_ = 5.43

		local var_38_0 = {
			zh = 3.666,
			ja = 5.433
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
				arg_38_0:Play417082010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1034"]) and arg_38_1.var_.actorSpriteComps1034 == nil then
				arg_38_1.var_.actorSpriteComps1034 = arg_38_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1034"]) then
				if arg_38_1.var_.actorSpriteComps1034 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1034"]) and arg_38_1.var_.actorSpriteComps1034 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_41_3 then
						iter_41_3.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_38_1.var_.actorSpriteComps1034 = nil
			end

			local var_41_2 = arg_38_1.actors_["1034"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos1034 = var_41_2.localPosition
				var_41_2.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("1034", 3)

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
				var_41_2.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_38_1.time_ - 0) / var_41_4)
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 then
				var_41_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_41_5 = 0
			local var_41_6 = 0.5

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 then
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

				local var_41_7 = arg_38_1:GetWordFromCfg(417082009)
				local var_41_8 = arg_38_1:FormatText(var_41_7.content)

				arg_38_1.text_.text = var_41_8

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_10 = 20 <= 0 and var_41_6 or var_41_6 * (utf8.len(var_41_8) / 20)

				if (20 <= 0 and var_41_6 or var_41_6 * (utf8.len(var_41_8) / 20)) > 0 and var_41_6 < var_41_10 then
					arg_38_1.talkMaxDuration = var_41_10

					if var_41_10 + var_41_5 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_5
					end
				end

				arg_38_1.text_.text = var_41_8
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082009", "story_v_out_417082.awb") ~= 0 then
					local var_41_11 = manager.audio:GetVoiceLength("story_v_out_417082", "417082009", "story_v_out_417082.awb") / 1000

					if var_41_11 + var_41_5 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_11 + var_41_5
					end

					if var_41_7.prefab_name ~= "" and arg_38_1.actors_[var_41_7.prefab_name] ~= nil then
						local var_41_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_7.prefab_name].transform, "story_v_out_417082", "417082009", "story_v_out_417082.awb")

						arg_38_1:RecordAudio("417082009", var_41_12)
						arg_38_1:RecordAudio("417082009", var_41_12)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417082", "417082009", "story_v_out_417082.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417082", "417082009", "story_v_out_417082.awb")
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
	Play417082010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417082010
		arg_42_1.duration_ = 3.7

		local var_42_0 = {
			zh = 2.466,
			ja = 3.7
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
				arg_42_0:Play417082011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1034 = arg_42_1.actors_["1034"].transform.localPosition
				arg_42_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("1034", 3)

				for iter_45_0 = 0, arg_42_1.actors_["1034"].transform.childCount - 1 do
					local var_45_0 = arg_42_1.actors_["1034"].transform:GetChild(iter_45_0)

					if var_45_0.name == "" or not string.find(var_45_0.name, "split") then
						var_45_0.gameObject:SetActive(true)
					else
						var_45_0.gameObject:SetActive(false)
					end
				end
			end

			local var_45_1 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_1 then
				arg_42_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_42_1.time_ - 0) / var_45_1)
			end

			if arg_42_1.time_ >= 0 + var_45_1 and arg_42_1.time_ < 0 + var_45_1 + arg_45_0 then
				arg_42_1.actors_["1034"].transform.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_45_2 = 0
			local var_45_3 = 0.325

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_4 = arg_42_1:GetWordFromCfg(417082010)
				local var_45_5 = arg_42_1:FormatText(var_45_4.content)

				arg_42_1.text_.text = var_45_5

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_7 = 13 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 13)

				if (13 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 13)) > 0 and var_45_3 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_2
					end
				end

				arg_42_1.text_.text = var_45_5
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082010", "story_v_out_417082.awb") ~= 0 then
					local var_45_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082010", "story_v_out_417082.awb") / 1000

					if var_45_8 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_2
					end

					if var_45_4.prefab_name ~= "" and arg_42_1.actors_[var_45_4.prefab_name] ~= nil then
						local var_45_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_4.prefab_name].transform, "story_v_out_417082", "417082010", "story_v_out_417082.awb")

						arg_42_1:RecordAudio("417082010", var_45_9)
						arg_42_1:RecordAudio("417082010", var_45_9)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417082", "417082010", "story_v_out_417082.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417082", "417082010", "story_v_out_417082.awb")
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

		arg_42_1.nodeConfigList_ = {
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

		arg_42_1:InitPlayNodeList()
	end,
	Play417082011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417082011
		arg_46_1.duration_ = 3.03

		local var_46_0 = {
			zh = 1.633,
			ja = 3.033
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
				arg_46_0:Play417082012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1034"]) and arg_46_1.var_.actorSpriteComps1034 == nil then
				arg_46_1.var_.actorSpriteComps1034 = arg_46_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1034"]) then
				if arg_46_1.var_.actorSpriteComps1034 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1034"]) and arg_46_1.var_.actorSpriteComps1034 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_49_3 then
						iter_49_3.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_46_1.var_.actorSpriteComps1034 = nil
			end

			local var_49_2 = 0
			local var_49_3 = 0.225

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

				local var_49_4 = arg_46_1:GetWordFromCfg(417082011)
				local var_49_5 = arg_46_1:FormatText(var_49_4.content)

				arg_46_1.text_.text = var_49_5

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_7 = 9 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 9)

				if (9 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 9)) > 0 and var_49_3 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_2
					end
				end

				arg_46_1.text_.text = var_49_5
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082011", "story_v_out_417082.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082011", "story_v_out_417082.awb") / 1000

					if var_49_8 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_2
					end

					if var_49_4.prefab_name ~= "" and arg_46_1.actors_[var_49_4.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_4.prefab_name].transform, "story_v_out_417082", "417082011", "story_v_out_417082.awb")

						arg_46_1:RecordAudio("417082011", var_49_9)
						arg_46_1:RecordAudio("417082011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417082", "417082011", "story_v_out_417082.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417082", "417082011", "story_v_out_417082.awb")
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
	Play417082012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417082012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play417082013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1034 = arg_50_1.actors_["1034"].transform.localPosition
				arg_50_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1034", 7)

				for iter_53_0 = 0, arg_50_1.actors_["1034"].transform.childCount - 1 do
					local var_53_0 = arg_50_1.actors_["1034"].transform:GetChild(iter_53_0)

					if var_53_0.name == "" or not string.find(var_53_0.name, "split") then
						var_53_0.gameObject:SetActive(true)
					else
						var_53_0.gameObject:SetActive(false)
					end
				end
			end

			local var_53_1 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_1 then
				arg_50_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_50_1.time_ - 0) / var_53_1)
			end

			if arg_50_1.time_ >= 0 + var_53_1 and arg_50_1.time_ < 0 + var_53_1 + arg_53_0 then
				arg_50_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.266666666666667 < arg_50_1.time_ and arg_50_1.time_ <= 0.266666666666667 + arg_53_0 then
				arg_50_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_rush", "")
			end

			local var_53_3 = 0
			local var_53_4 = 1.1

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_3 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_5 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(417082012).content)

				arg_50_1.text_.text = var_53_5

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_7 = 44 <= 0 and var_53_4 or var_53_4 * (utf8.len(var_53_5) / 44)

				if (44 <= 0 and var_53_4 or var_53_4 * (utf8.len(var_53_5) / 44)) > 0 and var_53_4 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_3 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_3
					end
				end

				arg_50_1.text_.text = var_53_5
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_8 = math.max(var_53_4, arg_50_1.talkMaxDuration)

			if var_53_3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_3 + var_53_8 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_3) / var_53_8

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_3 + var_53_8 and arg_50_1.time_ < var_53_3 + var_53_8 + arg_53_0 then
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
	Play417082013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417082013
		arg_54_1.duration_ = 5.53

		local var_54_0 = {
			zh = 3.633,
			ja = 5.533
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
				arg_54_0:Play417082014(arg_54_1)
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
								iter_57_1.color = Color.New(Mathf.Lerp(iter_57_1.color.r, arg_54_1.hightColor1.r, (arg_54_1.time_ - 0) / var_57_0), Mathf.Lerp(iter_57_1.color.g, arg_54_1.hightColor1.g, (arg_54_1.time_ - 0) / var_57_0), (Mathf.Lerp(iter_57_1.color.b, arg_54_1.hightColor1.b, (arg_54_1.time_ - 0) / var_57_0)))
							else
								local var_57_1 = Mathf.Lerp(iter_57_1.color.r, 1, (arg_54_1.time_ - 0) / var_57_0)

								iter_57_1.color = Color.New(var_57_1, var_57_1, var_57_1)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1034"]) and arg_54_1.var_.actorSpriteComps1034 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_57_3 then
						iter_57_3.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_54_1.var_.actorSpriteComps1034 = nil
			end

			local var_57_2 = 0
			local var_57_3 = 0.425

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_4 = arg_54_1:GetWordFromCfg(417082013)
				local var_57_5 = arg_54_1:FormatText(var_57_4.content)

				arg_54_1.text_.text = var_57_5

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_7 = 17 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 17)

				if (17 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 17)) > 0 and var_57_3 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_2
					end
				end

				arg_54_1.text_.text = var_57_5
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082013", "story_v_out_417082.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082013", "story_v_out_417082.awb") / 1000

					if var_57_8 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_2
					end

					if var_57_4.prefab_name ~= "" and arg_54_1.actors_[var_57_4.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_4.prefab_name].transform, "story_v_out_417082", "417082013", "story_v_out_417082.awb")

						arg_54_1:RecordAudio("417082013", var_57_9)
						arg_54_1:RecordAudio("417082013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417082", "417082013", "story_v_out_417082.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417082", "417082013", "story_v_out_417082.awb")
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
	Play417082014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417082014
		arg_58_1.duration_ = 4.3

		local var_58_0 = {
			zh = 4.3,
			ja = 4.1
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
				arg_58_0:Play417082015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if arg_58_1.bgs_.STblack == nil then
				local var_61_0 = Object.Instantiate(arg_58_1.paintGo_)

				var_61_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_61_0.name = "STblack"
				var_61_0.transform.parent = arg_58_1.stage_.transform
				var_61_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.bgs_.STblack = var_61_0
			end

			if 1.16666666666667 < arg_58_1.time_ and arg_58_1.time_ <= 1.16666666666667 + arg_61_0 then
				local var_61_1 = arg_58_1.bgs_.STblack

				arg_58_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_61_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_61_2 = var_61_1:GetComponent("SpriteRenderer")

				if var_61_2 and var_61_2.sprite then
					local var_61_3 = 2 * (var_61_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_61_1.transform.localScale = Vector3.New(var_61_3 / var_61_2.sprite.bounds.size.y < var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x and var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x or var_61_3 / var_61_2.sprite.bounds.size.y, var_61_3 / var_61_2.sprite.bounds.size.y < var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x and var_61_3 * manager.ui.mainCameraCom_.aspect / var_61_2.sprite.bounds.size.x or var_61_3 / var_61_2.sprite.bounds.size.y, 0)
				end

				for iter_61_0, iter_61_1 in pairs(arg_58_1.bgs_) do
					if iter_61_0 ~= "STblack" then
						iter_61_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_61_4 = 1.16666666666667

			if 1.16666666666667 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1.allBtn_.enabled = false
			end

			if arg_58_1.time_ >= var_61_4 + 0.3 and arg_58_1.time_ < var_61_4 + 0.3 + arg_61_0 then
				arg_58_1.allBtn_.enabled = true
			end

			local var_61_5 = 0

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_6 = 1.16666666666667

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_6 then
				local var_61_7 = Color.New(0, 0, 0)

				var_61_7.a = Mathf.Lerp(0, 1, (arg_58_1.time_ - var_61_5) / var_61_6)
				arg_58_1.mask_.color = var_61_7
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 then
				local var_61_8 = Color.New(0, 0, 0)

				var_61_8.a = 1
				arg_58_1.mask_.color = var_61_8
			end

			local var_61_9 = 1.16666666666667

			if 1.16666666666667 < arg_58_1.time_ and arg_58_1.time_ <= var_61_9 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_10 = 1.725

			if var_61_9 <= arg_58_1.time_ and arg_58_1.time_ < var_61_9 + var_61_10 then
				local var_61_11 = Color.New(0, 0, 0)

				var_61_11.a = Mathf.Lerp(1, 0, (arg_58_1.time_ - var_61_9) / var_61_10)
				arg_58_1.mask_.color = var_61_11
			end

			if arg_58_1.time_ >= var_61_9 + var_61_10 and arg_58_1.time_ < var_61_9 + var_61_10 + arg_61_0 then
				local var_61_12 = Color.New(0, 0, 0)

				arg_58_1.mask_.enabled = false
				var_61_12.a = 0
				arg_58_1.mask_.color = var_61_12
			end

			local var_61_13 = arg_58_1.actors_["1034"]

			if 1.16666666666667 < arg_58_1.time_ and arg_58_1.time_ <= 1.16666666666667 + arg_61_0 and not isNil(var_61_13) and arg_58_1.var_.actorSpriteComps1034 == nil then
				arg_58_1.var_.actorSpriteComps1034 = var_61_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_14 = 0.2

			if 1.16666666666667 <= arg_58_1.time_ and arg_58_1.time_ < 1.16666666666667 + var_61_14 and not isNil(var_61_13) then
				if arg_58_1.var_.actorSpriteComps1034 then
					for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_61_3 then
							if arg_58_1.isInRecall_ then
								iter_61_3.color = Color.New(Mathf.Lerp(iter_61_3.color.r, arg_58_1.hightColor2.r, (arg_58_1.time_ - 1.16666666666667) / var_61_14), Mathf.Lerp(iter_61_3.color.g, arg_58_1.hightColor2.g, (arg_58_1.time_ - 1.16666666666667) / var_61_14), (Mathf.Lerp(iter_61_3.color.b, arg_58_1.hightColor2.b, (arg_58_1.time_ - 1.16666666666667) / var_61_14)))
							else
								local var_61_15 = Mathf.Lerp(iter_61_3.color.r, 0.5, (arg_58_1.time_ - 1.16666666666667) / var_61_14)

								iter_61_3.color = Color.New(var_61_15, var_61_15, var_61_15)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 1.16666666666667 + var_61_14 and arg_58_1.time_ < 1.16666666666667 + var_61_14 + arg_61_0 and not isNil(var_61_13) and arg_58_1.var_.actorSpriteComps1034 then
				for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_61_5 then
						iter_61_5.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps1034 = nil
			end

			if arg_58_1.frameCnt_ <= 1 then
				arg_58_1.dialog_:SetActive(false)
			end

			local var_61_16 = 2.4
			local var_61_17 = 0.225

			if 2.4 < arg_58_1.time_ and arg_58_1.time_ <= var_61_16 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_18 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_18:setOnUpdate(LuaHelper.FloatAction(function(arg_62_0)
					arg_58_1.dialogCg_.alpha = arg_62_0
				end))
				var_61_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1133].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_19 = arg_58_1:GetWordFromCfg(417082014)
				local var_61_20 = arg_58_1:FormatText(var_61_19.content)

				arg_58_1.text_.text = var_61_20

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_22 = 9 <= 0 and var_61_17 or var_61_17 * (utf8.len(var_61_20) / 9)

				if (9 <= 0 and var_61_17 or var_61_17 * (utf8.len(var_61_20) / 9)) > 0 and var_61_17 < var_61_22 then
					arg_58_1.talkMaxDuration = var_61_22
					var_61_16 = var_61_16 + 0.3

					if var_61_22 + var_61_16 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_22 + var_61_16
					end
				end

				arg_58_1.text_.text = var_61_20
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082014", "story_v_out_417082.awb") ~= 0 then
					local var_61_23 = manager.audio:GetVoiceLength("story_v_out_417082", "417082014", "story_v_out_417082.awb") / 1000

					if var_61_23 + var_61_16 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_23 + var_61_16
					end

					if var_61_19.prefab_name ~= "" and arg_58_1.actors_[var_61_19.prefab_name] ~= nil then
						local var_61_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_19.prefab_name].transform, "story_v_out_417082", "417082014", "story_v_out_417082.awb")

						arg_58_1:RecordAudio("417082014", var_61_24)
						arg_58_1:RecordAudio("417082014", var_61_24)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417082", "417082014", "story_v_out_417082.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417082", "417082014", "story_v_out_417082.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_25 = var_61_16 + 0.3
			local var_61_26 = math.max(var_61_17, arg_58_1.talkMaxDuration)

			if var_61_16 + 0.3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_25 + var_61_26 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_25) / var_61_26

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_25 + var_61_26 and arg_58_1.time_ < var_61_25 + var_61_26 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417082015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 417082015
		arg_64_1.duration_ = 1.01

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play417082016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0.01 < arg_64_1.time_ and arg_64_1.time_ <= 0.01 + arg_67_0 then
				arg_64_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_gun03", "")
			end

			local var_67_1 = 0
			local var_67_2 = 0.05

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1133].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(417082015)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_6 = 2 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_4) / 2)

				if (2 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_4) / 2)) > 0 and var_67_2 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082015", "story_v_out_417082.awb") ~= 0 then
					local var_67_7 = manager.audio:GetVoiceLength("story_v_out_417082", "417082015", "story_v_out_417082.awb") / 1000

					if var_67_7 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_1
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_417082", "417082015", "story_v_out_417082.awb")

						arg_64_1:RecordAudio("417082015", var_67_8)
						arg_64_1:RecordAudio("417082015", var_67_8)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_417082", "417082015", "story_v_out_417082.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_417082", "417082015", "story_v_out_417082.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_9 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_9 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_9

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_9 and arg_64_1.time_ < var_67_1 + var_67_9 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play417082016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 417082016
		arg_68_1.duration_ = 9

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play417082017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 1.999999999999 < arg_68_1.time_ and arg_68_1.time_ <= 1.999999999999 + arg_71_0 then
				local var_71_0 = arg_68_1.bgs_.D06a

				arg_68_1.bgs_.D06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_71_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_71_1 = var_71_0:GetComponent("SpriteRenderer")

				if var_71_1 and var_71_1.sprite then
					local var_71_2 = 2 * (var_71_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_71_0.transform.localScale = Vector3.New(var_71_2 / var_71_1.sprite.bounds.size.y < var_71_2 * manager.ui.mainCameraCom_.aspect / var_71_1.sprite.bounds.size.x and var_71_2 * manager.ui.mainCameraCom_.aspect / var_71_1.sprite.bounds.size.x or var_71_2 / var_71_1.sprite.bounds.size.y, var_71_2 / var_71_1.sprite.bounds.size.y < var_71_2 * manager.ui.mainCameraCom_.aspect / var_71_1.sprite.bounds.size.x and var_71_2 * manager.ui.mainCameraCom_.aspect / var_71_1.sprite.bounds.size.x or var_71_2 / var_71_1.sprite.bounds.size.y, 0)
				end

				for iter_71_0, iter_71_1 in pairs(arg_68_1.bgs_) do
					if iter_71_0 ~= "D06a" then
						iter_71_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_71_3 = 1.999999999999

			if 1.999999999999 < arg_68_1.time_ and arg_68_1.time_ <= var_71_3 + arg_71_0 then
				arg_68_1.allBtn_.enabled = false
			end

			if arg_68_1.time_ >= var_71_3 + 0.3 and arg_68_1.time_ < var_71_3 + 0.3 + arg_71_0 then
				arg_68_1.allBtn_.enabled = true
			end

			local var_71_4 = 0

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_5 = 2

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_5 then
				local var_71_6 = Color.New(0, 0, 0)

				var_71_6.a = Mathf.Lerp(0, 1, (arg_68_1.time_ - var_71_4) / var_71_5)
				arg_68_1.mask_.color = var_71_6
			end

			if arg_68_1.time_ >= var_71_4 + var_71_5 and arg_68_1.time_ < var_71_4 + var_71_5 + arg_71_0 then
				local var_71_7 = Color.New(0, 0, 0)

				var_71_7.a = 1
				arg_68_1.mask_.color = var_71_7
			end

			local var_71_8 = 1.999999999999

			if 1.999999999999 < arg_68_1.time_ and arg_68_1.time_ <= var_71_8 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_9 = 2.36666666666767

			if var_71_8 <= arg_68_1.time_ and arg_68_1.time_ < var_71_8 + var_71_9 then
				local var_71_10 = Color.New(0, 0, 0)

				var_71_10.a = Mathf.Lerp(1, 0, (arg_68_1.time_ - var_71_8) / var_71_9)
				arg_68_1.mask_.color = var_71_10
			end

			if arg_68_1.time_ >= var_71_8 + var_71_9 and arg_68_1.time_ < var_71_8 + var_71_9 + arg_71_0 then
				local var_71_11 = Color.New(0, 0, 0)

				arg_68_1.mask_.enabled = false
				var_71_11.a = 0
				arg_68_1.mask_.color = var_71_11
			end

			if arg_68_1.frameCnt_ <= 1 then
				arg_68_1.dialog_:SetActive(false)
			end

			local var_71_12 = 3.999999999999
			local var_71_13 = 1.425

			if 3.999999999999 < arg_68_1.time_ and arg_68_1.time_ <= var_71_12 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0

				arg_68_1.dialog_:SetActive(true)

				arg_68_1.dialogCg_.alpha = 0

				local var_71_14 = LeanTween.value(arg_68_1.dialog_, 0, 1, 0.3)

				var_71_14:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_68_1.dialogCg_.alpha = arg_72_0
				end))
				var_71_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_68_1.dialog_)
					var_71_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_68_1.duration_ = arg_68_1.duration_ + 0.3

				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_15 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(417082016).content)

				arg_68_1.text_.text = var_71_15

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_17 = 57 <= 0 and var_71_13 or var_71_13 * (utf8.len(var_71_15) / 57)

				if (57 <= 0 and var_71_13 or var_71_13 * (utf8.len(var_71_15) / 57)) > 0 and var_71_13 < var_71_17 then
					arg_68_1.talkMaxDuration = var_71_17
					var_71_12 = var_71_12 + 0.3

					if var_71_17 + var_71_12 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_17 + var_71_12
					end
				end

				arg_68_1.text_.text = var_71_15
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_18 = var_71_12 + 0.3
			local var_71_19 = math.max(var_71_13, arg_68_1.talkMaxDuration)

			if var_71_12 + 0.3 <= arg_68_1.time_ and arg_68_1.time_ < var_71_18 + var_71_19 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_18) / var_71_19

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_18 + var_71_19 and arg_68_1.time_ < var_71_18 + var_71_19 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play417082017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417082017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play417082018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.725

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(417082017).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 29 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 29)

				if (29 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 29)) > 0 and var_77_0 < var_77_3 then
					arg_74_1.talkMaxDuration = var_77_3

					if var_77_3 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_3 + 0
					end
				end

				arg_74_1.text_.text = var_77_1
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_4 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_4

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play417082018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417082018
		arg_78_1.duration_ = 3.03

		local var_78_0 = {
			zh = 2.233,
			ja = 3.033
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
				arg_78_0:Play417082019(arg_78_1)
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
								iter_81_1.color = Color.New(Mathf.Lerp(iter_81_1.color.r, arg_78_1.hightColor1.r, (arg_78_1.time_ - 0) / var_81_0), Mathf.Lerp(iter_81_1.color.g, arg_78_1.hightColor1.g, (arg_78_1.time_ - 0) / var_81_0), (Mathf.Lerp(iter_81_1.color.b, arg_78_1.hightColor1.b, (arg_78_1.time_ - 0) / var_81_0)))
							else
								local var_81_1 = Mathf.Lerp(iter_81_1.color.r, 1, (arg_78_1.time_ - 0) / var_81_0)

								iter_81_1.color = Color.New(var_81_1, var_81_1, var_81_1)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1034"]) and arg_78_1.var_.actorSpriteComps1034 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_81_3 then
						iter_81_3.color = arg_78_1.isInRecall_ and (arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_78_1.var_.actorSpriteComps1034 = nil
			end

			local var_81_2 = arg_78_1.actors_["1034"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1034 = var_81_2.localPosition
				var_81_2.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1034", 3)

				for iter_81_4 = 0, var_81_2.childCount - 1 do
					local var_81_3 = var_81_2:GetChild(iter_81_4)

					if var_81_3.name == "split_7" or not string.find(var_81_3.name, "split") then
						var_81_3.gameObject:SetActive(true)
					else
						var_81_3.gameObject:SetActive(false)
					end
				end
			end

			local var_81_4 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				var_81_2.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_78_1.time_ - 0) / var_81_4)
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				var_81_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_81_5 = 0
			local var_81_6 = 0.275

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_7 = arg_78_1:GetWordFromCfg(417082018)
				local var_81_8 = arg_78_1:FormatText(var_81_7.content)

				arg_78_1.text_.text = var_81_8

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_10 = 11 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_8) / 11)

				if (11 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_8) / 11)) > 0 and var_81_6 < var_81_10 then
					arg_78_1.talkMaxDuration = var_81_10

					if var_81_10 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_5
					end
				end

				arg_78_1.text_.text = var_81_8
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082018", "story_v_out_417082.awb") ~= 0 then
					local var_81_11 = manager.audio:GetVoiceLength("story_v_out_417082", "417082018", "story_v_out_417082.awb") / 1000

					if var_81_11 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_11 + var_81_5
					end

					if var_81_7.prefab_name ~= "" and arg_78_1.actors_[var_81_7.prefab_name] ~= nil then
						local var_81_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_7.prefab_name].transform, "story_v_out_417082", "417082018", "story_v_out_417082.awb")

						arg_78_1:RecordAudio("417082018", var_81_12)
						arg_78_1:RecordAudio("417082018", var_81_12)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417082", "417082018", "story_v_out_417082.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417082", "417082018", "story_v_out_417082.awb")
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

		arg_78_1.nodeConfigList_ = {
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

		arg_78_1:InitPlayNodeList()
	end,
	Play417082019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417082019
		arg_82_1.duration_ = 3.23

		local var_82_0 = {
			zh = 2.3,
			ja = 3.233
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
				arg_82_0:Play417082020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["1034"]) and arg_82_1.var_.actorSpriteComps1034 == nil then
				arg_82_1.var_.actorSpriteComps1034 = arg_82_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_0 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["1034"]) then
				if arg_82_1.var_.actorSpriteComps1034 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["1034"]) and arg_82_1.var_.actorSpriteComps1034 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_85_3 then
						iter_85_3.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_82_1.var_.actorSpriteComps1034 = nil
			end

			local var_85_2 = 0
			local var_85_3 = 0.25

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_2 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1133].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_4 = arg_82_1:GetWordFromCfg(417082019)
				local var_85_5 = arg_82_1:FormatText(var_85_4.content)

				arg_82_1.text_.text = var_85_5

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_7 = 10 <= 0 and var_85_3 or var_85_3 * (utf8.len(var_85_5) / 10)

				if (10 <= 0 and var_85_3 or var_85_3 * (utf8.len(var_85_5) / 10)) > 0 and var_85_3 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_2
					end
				end

				arg_82_1.text_.text = var_85_5
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082019", "story_v_out_417082.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082019", "story_v_out_417082.awb") / 1000

					if var_85_8 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_2
					end

					if var_85_4.prefab_name ~= "" and arg_82_1.actors_[var_85_4.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_4.prefab_name].transform, "story_v_out_417082", "417082019", "story_v_out_417082.awb")

						arg_82_1:RecordAudio("417082019", var_85_9)
						arg_82_1:RecordAudio("417082019", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417082", "417082019", "story_v_out_417082.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417082", "417082019", "story_v_out_417082.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_3, arg_82_1.talkMaxDuration)

			if var_85_2 <= arg_82_1.time_ and arg_82_1.time_ < var_85_2 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_2) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_2 + var_85_10 and arg_82_1.time_ < var_85_2 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417082020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417082020
		arg_86_1.duration_ = 10.57

		local var_86_0 = {
			zh = 9.7,
			ja = 10.566
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
				arg_86_0:Play417082021(arg_86_1)
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
			local var_89_3 = 1.05

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

				local var_89_4 = arg_86_1:GetWordFromCfg(417082020)
				local var_89_5 = arg_86_1:FormatText(var_89_4.content)

				arg_86_1.text_.text = var_89_5

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_7 = 42 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_5) / 42)

				if (42 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_5) / 42)) > 0 and var_89_3 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_2
					end
				end

				arg_86_1.text_.text = var_89_5
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082020", "story_v_out_417082.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082020", "story_v_out_417082.awb") / 1000

					if var_89_8 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_2
					end

					if var_89_4.prefab_name ~= "" and arg_86_1.actors_[var_89_4.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_4.prefab_name].transform, "story_v_out_417082", "417082020", "story_v_out_417082.awb")

						arg_86_1:RecordAudio("417082020", var_89_9)
						arg_86_1:RecordAudio("417082020", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_417082", "417082020", "story_v_out_417082.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_417082", "417082020", "story_v_out_417082.awb")
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
	Play417082021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417082021
		arg_90_1.duration_ = 6.67

		local var_90_0 = {
			zh = 3.766,
			ja = 6.666
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
				arg_90_0:Play417082022(arg_90_1)
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
			local var_93_3 = 0.475

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1133].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_4 = arg_90_1:GetWordFromCfg(417082021)
				local var_93_5 = arg_90_1:FormatText(var_93_4.content)

				arg_90_1.text_.text = var_93_5

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_7 = 19 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 19)

				if (19 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 19)) > 0 and var_93_3 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_2
					end
				end

				arg_90_1.text_.text = var_93_5
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082021", "story_v_out_417082.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082021", "story_v_out_417082.awb") / 1000

					if var_93_8 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_2
					end

					if var_93_4.prefab_name ~= "" and arg_90_1.actors_[var_93_4.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_4.prefab_name].transform, "story_v_out_417082", "417082021", "story_v_out_417082.awb")

						arg_90_1:RecordAudio("417082021", var_93_9)
						arg_90_1:RecordAudio("417082021", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417082", "417082021", "story_v_out_417082.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417082", "417082021", "story_v_out_417082.awb")
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
	Play417082022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417082022
		arg_94_1.duration_ = 4.8

		local var_94_0 = {
			zh = 4.8,
			ja = 2.6
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
				arg_94_0:Play417082023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.525

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1133].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_1 = arg_94_1:GetWordFromCfg(417082022)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 21 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 21)

				if (21 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 21)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082022", "story_v_out_417082.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_417082", "417082022", "story_v_out_417082.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_417082", "417082022", "story_v_out_417082.awb")

						arg_94_1:RecordAudio("417082022", var_97_6)
						arg_94_1:RecordAudio("417082022", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417082", "417082022", "story_v_out_417082.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417082", "417082022", "story_v_out_417082.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play417082023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417082023
		arg_98_1.duration_ = 5.5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play417082024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1034 = arg_98_1.actors_["1034"].transform.localPosition
				arg_98_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("1034", 7)

				for iter_101_0 = 0, arg_98_1.actors_["1034"].transform.childCount - 1 do
					local var_101_0 = arg_98_1.actors_["1034"].transform:GetChild(iter_101_0)

					if var_101_0.name == "" or not string.find(var_101_0.name, "split") then
						var_101_0.gameObject:SetActive(true)
					else
						var_101_0.gameObject:SetActive(false)
					end
				end
			end

			local var_101_1 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_1 then
				arg_98_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_98_1.time_ - 0) / var_101_1)
			end

			if arg_98_1.time_ >= 0 + var_101_1 and arg_98_1.time_ < 0 + var_101_1 + arg_101_0 then
				arg_98_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_98_1.time_ and arg_98_1.time_ <= 1 + arg_101_0 then
				arg_98_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_gun03", "")
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_3 = 0.5
			local var_101_4 = 0.6

			if 0.5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_3 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_5 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_5:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(417082023).content)

				arg_98_1.text_.text = var_101_6

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_8 = 24 <= 0 and var_101_4 or var_101_4 * (utf8.len(var_101_6) / 24)

				if (24 <= 0 and var_101_4 or var_101_4 * (utf8.len(var_101_6) / 24)) > 0 and var_101_4 < var_101_8 then
					arg_98_1.talkMaxDuration = var_101_8
					var_101_3 = var_101_3 + 0.3

					if var_101_8 + var_101_3 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_3
					end
				end

				arg_98_1.text_.text = var_101_6
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_9 = var_101_3 + 0.3
			local var_101_10 = math.max(var_101_4, arg_98_1.talkMaxDuration)

			if var_101_3 + 0.3 <= arg_98_1.time_ and arg_98_1.time_ < var_101_9 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_9) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_9 + var_101_10 and arg_98_1.time_ < var_101_9 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play417082024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417082024
		arg_104_1.duration_ = 1.27

		local var_104_0 = {
			zh = 1.266,
			ja = 1.133
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play417082025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.1

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1133].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_1 = arg_104_1:GetWordFromCfg(417082024)
				local var_107_2 = arg_104_1:FormatText(var_107_1.content)

				arg_104_1.text_.text = var_107_2

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 4 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 4)

				if (4 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 4)) > 0 and var_107_0 < var_107_4 then
					arg_104_1.talkMaxDuration = var_107_4

					if var_107_4 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_4 + 0
					end
				end

				arg_104_1.text_.text = var_107_2
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082024", "story_v_out_417082.awb") ~= 0 then
					local var_107_5 = manager.audio:GetVoiceLength("story_v_out_417082", "417082024", "story_v_out_417082.awb") / 1000

					if var_107_5 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + 0
					end

					if var_107_1.prefab_name ~= "" and arg_104_1.actors_[var_107_1.prefab_name] ~= nil then
						local var_107_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_1.prefab_name].transform, "story_v_out_417082", "417082024", "story_v_out_417082.awb")

						arg_104_1:RecordAudio("417082024", var_107_6)
						arg_104_1:RecordAudio("417082024", var_107_6)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_417082", "417082024", "story_v_out_417082.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_417082", "417082024", "story_v_out_417082.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play417082025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417082025
		arg_108_1.duration_ = 3.8

		local var_108_0 = {
			zh = 1.866,
			ja = 3.8
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play417082026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1034"]) and arg_108_1.var_.actorSpriteComps1034 == nil then
				arg_108_1.var_.actorSpriteComps1034 = arg_108_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_0 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1034"]) then
				if arg_108_1.var_.actorSpriteComps1034 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								iter_111_1.color = Color.New(Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor1.r, (arg_108_1.time_ - 0) / var_111_0), Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor1.g, (arg_108_1.time_ - 0) / var_111_0), (Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor1.b, (arg_108_1.time_ - 0) / var_111_0)))
							else
								local var_111_1 = Mathf.Lerp(iter_111_1.color.r, 1, (arg_108_1.time_ - 0) / var_111_0)

								iter_111_1.color = Color.New(var_111_1, var_111_1, var_111_1)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1034"]) and arg_108_1.var_.actorSpriteComps1034 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_111_3 then
						iter_111_3.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_108_1.var_.actorSpriteComps1034 = nil
			end

			local var_111_2 = arg_108_1.actors_["1034"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1034 = var_111_2.localPosition
				var_111_2.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("1034", 3)

				for iter_111_4 = 0, var_111_2.childCount - 1 do
					local var_111_3 = var_111_2:GetChild(iter_111_4)

					if var_111_3.name == "split_6" or not string.find(var_111_3.name, "split") then
						var_111_3.gameObject:SetActive(true)
					else
						var_111_3.gameObject:SetActive(false)
					end
				end
			end

			local var_111_4 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				var_111_2.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_108_1.time_ - 0) / var_111_4)
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				var_111_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_111_5 = 0
			local var_111_6 = 0.15

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_7 = arg_108_1:GetWordFromCfg(417082025)
				local var_111_8 = arg_108_1:FormatText(var_111_7.content)

				arg_108_1.text_.text = var_111_8

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_10 = 6 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 6)

				if (6 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 6)) > 0 and var_111_6 < var_111_10 then
					arg_108_1.talkMaxDuration = var_111_10

					if var_111_10 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_5
					end
				end

				arg_108_1.text_.text = var_111_8
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082025", "story_v_out_417082.awb") ~= 0 then
					local var_111_11 = manager.audio:GetVoiceLength("story_v_out_417082", "417082025", "story_v_out_417082.awb") / 1000

					if var_111_11 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_11 + var_111_5
					end

					if var_111_7.prefab_name ~= "" and arg_108_1.actors_[var_111_7.prefab_name] ~= nil then
						local var_111_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_7.prefab_name].transform, "story_v_out_417082", "417082025", "story_v_out_417082.awb")

						arg_108_1:RecordAudio("417082025", var_111_12)
						arg_108_1:RecordAudio("417082025", var_111_12)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417082", "417082025", "story_v_out_417082.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417082", "417082025", "story_v_out_417082.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_13 = math.max(var_111_6, arg_108_1.talkMaxDuration)

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_13 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_5) / var_111_13

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_5 + var_111_13 and arg_108_1.time_ < var_111_5 + var_111_13 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play417082026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417082026
		arg_112_1.duration_ = 2.8

		local var_112_0 = {
			zh = 1.6,
			ja = 2.8
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play417082027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1034"]) and arg_112_1.var_.actorSpriteComps1034 == nil then
				arg_112_1.var_.actorSpriteComps1034 = arg_112_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1034"]) then
				if arg_112_1.var_.actorSpriteComps1034 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								iter_115_1.color = Color.New(Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor2.r, (arg_112_1.time_ - 0) / var_115_0), Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor2.g, (arg_112_1.time_ - 0) / var_115_0), (Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor2.b, (arg_112_1.time_ - 0) / var_115_0)))
							else
								local var_115_1 = Mathf.Lerp(iter_115_1.color.r, 0.5, (arg_112_1.time_ - 0) / var_115_0)

								iter_115_1.color = Color.New(var_115_1, var_115_1, var_115_1)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1034"]) and arg_112_1.var_.actorSpriteComps1034 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_115_3 then
						iter_115_3.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_112_1.var_.actorSpriteComps1034 = nil
			end

			local var_115_2 = 0
			local var_115_3 = 0.1

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1133].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_4 = arg_112_1:GetWordFromCfg(417082026)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 4 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 4)

				if (4 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 4)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082026", "story_v_out_417082.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082026", "story_v_out_417082.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_417082", "417082026", "story_v_out_417082.awb")

						arg_112_1:RecordAudio("417082026", var_115_9)
						arg_112_1:RecordAudio("417082026", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_417082", "417082026", "story_v_out_417082.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_417082", "417082026", "story_v_out_417082.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play417082027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417082027
		arg_116_1.duration_ = 10.87

		local var_116_0 = {
			zh = 10.2,
			ja = 10.866
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play417082028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1034"]) and arg_116_1.var_.actorSpriteComps1034 == nil then
				arg_116_1.var_.actorSpriteComps1034 = arg_116_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1034"]) then
				if arg_116_1.var_.actorSpriteComps1034 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								iter_119_1.color = Color.New(Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor1.r, (arg_116_1.time_ - 0) / var_119_0), Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor1.g, (arg_116_1.time_ - 0) / var_119_0), (Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor1.b, (arg_116_1.time_ - 0) / var_119_0)))
							else
								local var_119_1 = Mathf.Lerp(iter_119_1.color.r, 1, (arg_116_1.time_ - 0) / var_119_0)

								iter_119_1.color = Color.New(var_119_1, var_119_1, var_119_1)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1034"]) and arg_116_1.var_.actorSpriteComps1034 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_119_3 then
						iter_119_3.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_116_1.var_.actorSpriteComps1034 = nil
			end

			local var_119_2 = arg_116_1.actors_["1034"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1034 = var_119_2.localPosition
				var_119_2.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1034", 3)

				for iter_119_4 = 0, var_119_2.childCount - 1 do
					local var_119_3 = var_119_2:GetChild(iter_119_4)

					if var_119_3.name == "" or not string.find(var_119_3.name, "split") then
						var_119_3.gameObject:SetActive(true)
					else
						var_119_3.gameObject:SetActive(false)
					end
				end
			end

			local var_119_4 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				var_119_2.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_116_1.time_ - 0) / var_119_4)
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				var_119_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_119_5 = 0
			local var_119_6 = 1.05

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_7 = arg_116_1:GetWordFromCfg(417082027)
				local var_119_8 = arg_116_1:FormatText(var_119_7.content)

				arg_116_1.text_.text = var_119_8

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_10 = 42 <= 0 and var_119_6 or var_119_6 * (utf8.len(var_119_8) / 42)

				if (42 <= 0 and var_119_6 or var_119_6 * (utf8.len(var_119_8) / 42)) > 0 and var_119_6 < var_119_10 then
					arg_116_1.talkMaxDuration = var_119_10

					if var_119_10 + var_119_5 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_5
					end
				end

				arg_116_1.text_.text = var_119_8
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082027", "story_v_out_417082.awb") ~= 0 then
					local var_119_11 = manager.audio:GetVoiceLength("story_v_out_417082", "417082027", "story_v_out_417082.awb") / 1000

					if var_119_11 + var_119_5 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_11 + var_119_5
					end

					if var_119_7.prefab_name ~= "" and arg_116_1.actors_[var_119_7.prefab_name] ~= nil then
						local var_119_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_7.prefab_name].transform, "story_v_out_417082", "417082027", "story_v_out_417082.awb")

						arg_116_1:RecordAudio("417082027", var_119_12)
						arg_116_1:RecordAudio("417082027", var_119_12)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417082", "417082027", "story_v_out_417082.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417082", "417082027", "story_v_out_417082.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_13 = math.max(var_119_6, arg_116_1.talkMaxDuration)

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_13 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_5) / var_119_13

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_5 + var_119_13 and arg_116_1.time_ < var_119_5 + var_119_13 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play417082028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417082028
		arg_120_1.duration_ = 11.7

		local var_120_0 = {
			zh = 11.7,
			ja = 7.1
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play417082029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 1.225

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:GetWordFromCfg(417082028)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 49 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 49)

				if (49 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 49)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082028", "story_v_out_417082.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_417082", "417082028", "story_v_out_417082.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_417082", "417082028", "story_v_out_417082.awb")

						arg_120_1:RecordAudio("417082028", var_123_6)
						arg_120_1:RecordAudio("417082028", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_417082", "417082028", "story_v_out_417082.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_417082", "417082028", "story_v_out_417082.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play417082029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417082029
		arg_124_1.duration_ = 5.1

		local var_124_0 = {
			zh = 4.9,
			ja = 5.1
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play417082030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1034"]) and arg_124_1.var_.actorSpriteComps1034 == nil then
				arg_124_1.var_.actorSpriteComps1034 = arg_124_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1034"]) then
				if arg_124_1.var_.actorSpriteComps1034 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								iter_127_1.color = Color.New(Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor2.r, (arg_124_1.time_ - 0) / var_127_0), Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor2.g, (arg_124_1.time_ - 0) / var_127_0), (Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor2.b, (arg_124_1.time_ - 0) / var_127_0)))
							else
								local var_127_1 = Mathf.Lerp(iter_127_1.color.r, 0.5, (arg_124_1.time_ - 0) / var_127_0)

								iter_127_1.color = Color.New(var_127_1, var_127_1, var_127_1)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1034"]) and arg_124_1.var_.actorSpriteComps1034 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_127_3 then
						iter_127_3.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_124_1.var_.actorSpriteComps1034 = nil
			end

			local var_127_2 = 0
			local var_127_3 = 0.575

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1133].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_4 = arg_124_1:GetWordFromCfg(417082029)
				local var_127_5 = arg_124_1:FormatText(var_127_4.content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_7 = 23 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 23)

				if (23 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 23)) > 0 and var_127_3 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_2
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082029", "story_v_out_417082.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082029", "story_v_out_417082.awb") / 1000

					if var_127_8 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_2
					end

					if var_127_4.prefab_name ~= "" and arg_124_1.actors_[var_127_4.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_4.prefab_name].transform, "story_v_out_417082", "417082029", "story_v_out_417082.awb")

						arg_124_1:RecordAudio("417082029", var_127_9)
						arg_124_1:RecordAudio("417082029", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_417082", "417082029", "story_v_out_417082.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_417082", "417082029", "story_v_out_417082.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_3, arg_124_1.talkMaxDuration)

			if var_127_2 <= arg_124_1.time_ and arg_124_1.time_ < var_127_2 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_2) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_2 + var_127_10 and arg_124_1.time_ < var_127_2 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play417082030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417082030
		arg_128_1.duration_ = 7.6

		local var_128_0 = {
			zh = 6.533,
			ja = 7.6
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
				arg_128_0:Play417082031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1034"]) and arg_128_1.var_.actorSpriteComps1034 == nil then
				arg_128_1.var_.actorSpriteComps1034 = arg_128_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1034"]) then
				if arg_128_1.var_.actorSpriteComps1034 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								iter_131_1.color = Color.New(Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor1.r, (arg_128_1.time_ - 0) / var_131_0), Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor1.g, (arg_128_1.time_ - 0) / var_131_0), (Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor1.b, (arg_128_1.time_ - 0) / var_131_0)))
							else
								local var_131_1 = Mathf.Lerp(iter_131_1.color.r, 1, (arg_128_1.time_ - 0) / var_131_0)

								iter_131_1.color = Color.New(var_131_1, var_131_1, var_131_1)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1034"]) and arg_128_1.var_.actorSpriteComps1034 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_131_3 then
						iter_131_3.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_128_1.var_.actorSpriteComps1034 = nil
			end

			local var_131_2 = 0
			local var_131_3 = 0.775

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_4 = arg_128_1:GetWordFromCfg(417082030)
				local var_131_5 = arg_128_1:FormatText(var_131_4.content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_7 = 31 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 31)

				if (31 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 31)) > 0 and var_131_3 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_2
					end
				end

				arg_128_1.text_.text = var_131_5
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082030", "story_v_out_417082.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082030", "story_v_out_417082.awb") / 1000

					if var_131_8 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_2
					end

					if var_131_4.prefab_name ~= "" and arg_128_1.actors_[var_131_4.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_4.prefab_name].transform, "story_v_out_417082", "417082030", "story_v_out_417082.awb")

						arg_128_1:RecordAudio("417082030", var_131_9)
						arg_128_1:RecordAudio("417082030", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417082", "417082030", "story_v_out_417082.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417082", "417082030", "story_v_out_417082.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_3, arg_128_1.talkMaxDuration)

			if var_131_2 <= arg_128_1.time_ and arg_128_1.time_ < var_131_2 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_2) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_2 + var_131_10 and arg_128_1.time_ < var_131_2 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play417082031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417082031
		arg_132_1.duration_ = 2.23

		local var_132_0 = {
			zh = 0.999999999999,
			ja = 2.233
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
				arg_132_0:Play417082032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1034"]) and arg_132_1.var_.actorSpriteComps1034 == nil then
				arg_132_1.var_.actorSpriteComps1034 = arg_132_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1034"]) then
				if arg_132_1.var_.actorSpriteComps1034 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								iter_135_1.color = Color.New(Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor2.r, (arg_132_1.time_ - 0) / var_135_0), Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor2.g, (arg_132_1.time_ - 0) / var_135_0), (Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor2.b, (arg_132_1.time_ - 0) / var_135_0)))
							else
								local var_135_1 = Mathf.Lerp(iter_135_1.color.r, 0.5, (arg_132_1.time_ - 0) / var_135_0)

								iter_135_1.color = Color.New(var_135_1, var_135_1, var_135_1)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1034"]) and arg_132_1.var_.actorSpriteComps1034 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_132_1.var_.actorSpriteComps1034 = nil
			end

			local var_135_2 = 0
			local var_135_3 = 0.05

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_2 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1133].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_4 = arg_132_1:GetWordFromCfg(417082031)
				local var_135_5 = arg_132_1:FormatText(var_135_4.content)

				arg_132_1.text_.text = var_135_5

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_7 = 2 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_5) / 2)

				if (2 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_5) / 2)) > 0 and var_135_3 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_2
					end
				end

				arg_132_1.text_.text = var_135_5
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082031", "story_v_out_417082.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082031", "story_v_out_417082.awb") / 1000

					if var_135_8 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_2
					end

					if var_135_4.prefab_name ~= "" and arg_132_1.actors_[var_135_4.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_4.prefab_name].transform, "story_v_out_417082", "417082031", "story_v_out_417082.awb")

						arg_132_1:RecordAudio("417082031", var_135_9)
						arg_132_1:RecordAudio("417082031", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417082", "417082031", "story_v_out_417082.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417082", "417082031", "story_v_out_417082.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_3, arg_132_1.talkMaxDuration)

			if var_135_2 <= arg_132_1.time_ and arg_132_1.time_ < var_135_2 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_2) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_2 + var_135_10 and arg_132_1.time_ < var_135_2 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play417082032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417082032
		arg_136_1.duration_ = 5.57

		local var_136_0 = {
			zh = 4.266,
			ja = 5.566
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
				arg_136_0:Play417082033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1034"]) and arg_136_1.var_.actorSpriteComps1034 == nil then
				arg_136_1.var_.actorSpriteComps1034 = arg_136_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1034"]) then
				if arg_136_1.var_.actorSpriteComps1034 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								iter_139_1.color = Color.New(Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor1.r, (arg_136_1.time_ - 0) / var_139_0), Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor1.g, (arg_136_1.time_ - 0) / var_139_0), (Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor1.b, (arg_136_1.time_ - 0) / var_139_0)))
							else
								local var_139_1 = Mathf.Lerp(iter_139_1.color.r, 1, (arg_136_1.time_ - 0) / var_139_0)

								iter_139_1.color = Color.New(var_139_1, var_139_1, var_139_1)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1034"]) and arg_136_1.var_.actorSpriteComps1034 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_139_3 then
						iter_139_3.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_136_1.var_.actorSpriteComps1034 = nil
			end

			local var_139_2 = arg_136_1.actors_["1034"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1034 = var_139_2.localPosition
				var_139_2.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1034", 3)

				for iter_139_4 = 0, var_139_2.childCount - 1 do
					local var_139_3 = var_139_2:GetChild(iter_139_4)

					if var_139_3.name == "" or not string.find(var_139_3.name, "split") then
						var_139_3.gameObject:SetActive(true)
					else
						var_139_3.gameObject:SetActive(false)
					end
				end
			end

			local var_139_4 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				var_139_2.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_136_1.time_ - 0) / var_139_4)
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				var_139_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_139_5 = 0
			local var_139_6 = 0.45

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_7 = arg_136_1:GetWordFromCfg(417082032)
				local var_139_8 = arg_136_1:FormatText(var_139_7.content)

				arg_136_1.text_.text = var_139_8

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_10 = 18 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 18)

				if (18 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 18)) > 0 and var_139_6 < var_139_10 then
					arg_136_1.talkMaxDuration = var_139_10

					if var_139_10 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_5
					end
				end

				arg_136_1.text_.text = var_139_8
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082032", "story_v_out_417082.awb") ~= 0 then
					local var_139_11 = manager.audio:GetVoiceLength("story_v_out_417082", "417082032", "story_v_out_417082.awb") / 1000

					if var_139_11 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_5
					end

					if var_139_7.prefab_name ~= "" and arg_136_1.actors_[var_139_7.prefab_name] ~= nil then
						local var_139_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_7.prefab_name].transform, "story_v_out_417082", "417082032", "story_v_out_417082.awb")

						arg_136_1:RecordAudio("417082032", var_139_12)
						arg_136_1:RecordAudio("417082032", var_139_12)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_417082", "417082032", "story_v_out_417082.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_417082", "417082032", "story_v_out_417082.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_13 = math.max(var_139_6, arg_136_1.talkMaxDuration)

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_13 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_5) / var_139_13

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_5 + var_139_13 and arg_136_1.time_ < var_139_5 + var_139_13 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play417082033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417082033
		arg_140_1.duration_ = 3.17

		local var_140_0 = {
			zh = 2.5,
			ja = 3.166
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
				arg_140_0:Play417082034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1034"]) and arg_140_1.var_.actorSpriteComps1034 == nil then
				arg_140_1.var_.actorSpriteComps1034 = arg_140_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1034"]) then
				if arg_140_1.var_.actorSpriteComps1034 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								iter_143_1.color = Color.New(Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor2.r, (arg_140_1.time_ - 0) / var_143_0), Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor2.g, (arg_140_1.time_ - 0) / var_143_0), (Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor2.b, (arg_140_1.time_ - 0) / var_143_0)))
							else
								local var_143_1 = Mathf.Lerp(iter_143_1.color.r, 0.5, (arg_140_1.time_ - 0) / var_143_0)

								iter_143_1.color = Color.New(var_143_1, var_143_1, var_143_1)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1034"]) and arg_140_1.var_.actorSpriteComps1034 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_143_3 then
						iter_143_3.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_140_1.var_.actorSpriteComps1034 = nil
			end

			local var_143_2 = 0
			local var_143_3 = 0.2

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1133].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_4 = arg_140_1:GetWordFromCfg(417082033)
				local var_143_5 = arg_140_1:FormatText(var_143_4.content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 8 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 8)

				if (8 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 8)) > 0 and var_143_3 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082033", "story_v_out_417082.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082033", "story_v_out_417082.awb") / 1000

					if var_143_8 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_2
					end

					if var_143_4.prefab_name ~= "" and arg_140_1.actors_[var_143_4.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_4.prefab_name].transform, "story_v_out_417082", "417082033", "story_v_out_417082.awb")

						arg_140_1:RecordAudio("417082033", var_143_9)
						arg_140_1:RecordAudio("417082033", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_417082", "417082033", "story_v_out_417082.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_417082", "417082033", "story_v_out_417082.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_10 and arg_140_1.time_ < var_143_2 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play417082034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417082034
		arg_144_1.duration_ = 9.53

		local var_144_0 = {
			zh = 6.366,
			ja = 9.533
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play417082035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1034"]) and arg_144_1.var_.actorSpriteComps1034 == nil then
				arg_144_1.var_.actorSpriteComps1034 = arg_144_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_0 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1034"]) then
				if arg_144_1.var_.actorSpriteComps1034 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								iter_147_1.color = Color.New(Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor1.r, (arg_144_1.time_ - 0) / var_147_0), Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor1.g, (arg_144_1.time_ - 0) / var_147_0), (Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor1.b, (arg_144_1.time_ - 0) / var_147_0)))
							else
								local var_147_1 = Mathf.Lerp(iter_147_1.color.r, 1, (arg_144_1.time_ - 0) / var_147_0)

								iter_147_1.color = Color.New(var_147_1, var_147_1, var_147_1)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1034"]) and arg_144_1.var_.actorSpriteComps1034 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_147_3 then
						iter_147_3.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_144_1.var_.actorSpriteComps1034 = nil
			end

			local var_147_2 = 0
			local var_147_3 = 0.85

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_4 = arg_144_1:GetWordFromCfg(417082034)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 34 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 34)

				if (34 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 34)) > 0 and var_147_3 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082034", "story_v_out_417082.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082034", "story_v_out_417082.awb") / 1000

					if var_147_8 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_2
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_out_417082", "417082034", "story_v_out_417082.awb")

						arg_144_1:RecordAudio("417082034", var_147_9)
						arg_144_1:RecordAudio("417082034", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_417082", "417082034", "story_v_out_417082.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_417082", "417082034", "story_v_out_417082.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_3, arg_144_1.talkMaxDuration)

			if var_147_2 <= arg_144_1.time_ and arg_144_1.time_ < var_147_2 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_2) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_2 + var_147_10 and arg_144_1.time_ < var_147_2 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play417082035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417082035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play417082036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1034"]) and arg_148_1.var_.actorSpriteComps1034 == nil then
				arg_148_1.var_.actorSpriteComps1034 = arg_148_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1034"]) then
				if arg_148_1.var_.actorSpriteComps1034 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								iter_151_1.color = Color.New(Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor2.r, (arg_148_1.time_ - 0) / var_151_0), Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor2.g, (arg_148_1.time_ - 0) / var_151_0), (Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor2.b, (arg_148_1.time_ - 0) / var_151_0)))
							else
								local var_151_1 = Mathf.Lerp(iter_151_1.color.r, 0.5, (arg_148_1.time_ - 0) / var_151_0)

								iter_151_1.color = Color.New(var_151_1, var_151_1, var_151_1)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1034"]) and arg_148_1.var_.actorSpriteComps1034 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_151_3 then
						iter_151_3.color = arg_148_1.isInRecall_ and (arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_148_1.var_.actorSpriteComps1034 = nil
			end

			local var_151_2 = 0
			local var_151_3 = 1.275

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_2 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_4 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(417082035).content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_6 = 51 <= 0 and var_151_3 or var_151_3 * (utf8.len(var_151_4) / 51)

				if (51 <= 0 and var_151_3 or var_151_3 * (utf8.len(var_151_4) / 51)) > 0 and var_151_3 < var_151_6 then
					arg_148_1.talkMaxDuration = var_151_6

					if var_151_6 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_2
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_3, arg_148_1.talkMaxDuration)

			if var_151_2 <= arg_148_1.time_ and arg_148_1.time_ < var_151_2 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_2) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_2 + var_151_7 and arg_148_1.time_ < var_151_2 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play417082036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417082036
		arg_152_1.duration_ = 4.8

		local var_152_0 = {
			zh = 4.266,
			ja = 4.8
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play417082037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1034"]) and arg_152_1.var_.actorSpriteComps1034 == nil then
				arg_152_1.var_.actorSpriteComps1034 = arg_152_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_0 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1034"]) then
				if arg_152_1.var_.actorSpriteComps1034 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								iter_155_1.color = Color.New(Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor1.r, (arg_152_1.time_ - 0) / var_155_0), Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor1.g, (arg_152_1.time_ - 0) / var_155_0), (Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor1.b, (arg_152_1.time_ - 0) / var_155_0)))
							else
								local var_155_1 = Mathf.Lerp(iter_155_1.color.r, 1, (arg_152_1.time_ - 0) / var_155_0)

								iter_155_1.color = Color.New(var_155_1, var_155_1, var_155_1)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1034"]) and arg_152_1.var_.actorSpriteComps1034 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_155_3 then
						iter_155_3.color = arg_152_1.isInRecall_ and (arg_152_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_152_1.var_.actorSpriteComps1034 = nil
			end

			local var_155_2 = arg_152_1.actors_["1034"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1034 = var_155_2.localPosition
				var_155_2.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("1034", 3)

				for iter_155_4 = 0, var_155_2.childCount - 1 do
					local var_155_3 = var_155_2:GetChild(iter_155_4)

					if var_155_3.name == "split_6" or not string.find(var_155_3.name, "split") then
						var_155_3.gameObject:SetActive(true)
					else
						var_155_3.gameObject:SetActive(false)
					end
				end
			end

			local var_155_4 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 then
				var_155_2.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_152_1.time_ - 0) / var_155_4)
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 then
				var_155_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_155_5 = 0
			local var_155_6 = 0.475

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_7 = arg_152_1:GetWordFromCfg(417082036)
				local var_155_8 = arg_152_1:FormatText(var_155_7.content)

				arg_152_1.text_.text = var_155_8

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_10 = 19 <= 0 and var_155_6 or var_155_6 * (utf8.len(var_155_8) / 19)

				if (19 <= 0 and var_155_6 or var_155_6 * (utf8.len(var_155_8) / 19)) > 0 and var_155_6 < var_155_10 then
					arg_152_1.talkMaxDuration = var_155_10

					if var_155_10 + var_155_5 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_5
					end
				end

				arg_152_1.text_.text = var_155_8
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082036", "story_v_out_417082.awb") ~= 0 then
					local var_155_11 = manager.audio:GetVoiceLength("story_v_out_417082", "417082036", "story_v_out_417082.awb") / 1000

					if var_155_11 + var_155_5 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_11 + var_155_5
					end

					if var_155_7.prefab_name ~= "" and arg_152_1.actors_[var_155_7.prefab_name] ~= nil then
						local var_155_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_7.prefab_name].transform, "story_v_out_417082", "417082036", "story_v_out_417082.awb")

						arg_152_1:RecordAudio("417082036", var_155_12)
						arg_152_1:RecordAudio("417082036", var_155_12)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_417082", "417082036", "story_v_out_417082.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_417082", "417082036", "story_v_out_417082.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_13 = math.max(var_155_6, arg_152_1.talkMaxDuration)

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_13 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_5) / var_155_13

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_5 + var_155_13 and arg_152_1.time_ < var_155_5 + var_155_13 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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

		arg_152_1:InitPlayNodeList()
	end,
	Play417082037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417082037
		arg_156_1.duration_ = 1.03

		local var_156_0 = {
			zh = 1,
			ja = 1.033
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
				arg_156_0:Play417082038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if arg_156_1.actors_["1052"] == nil then
				local var_159_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1052")

				if not isNil(var_159_0) then
					local var_159_1 = Object.Instantiate(var_159_0, arg_156_1.canvasGo_.transform)

					var_159_1.transform:SetSiblingIndex(1)

					var_159_1.name = "1052"
					var_159_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_156_1.actors_["1052"] = var_159_1

					if arg_156_1.isInRecall_ then
						for iter_159_0, iter_159_1 in ipairs((var_159_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_159_1.color = arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_159_2 = arg_156_1.actors_["1052"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.actorSpriteComps1052 == nil then
				arg_156_1.var_.actorSpriteComps1052 = var_159_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_3 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_3 and not isNil(var_159_2) then
				if arg_156_1.var_.actorSpriteComps1052 then
					for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps1052:ToTable()) do
						if iter_159_3 then
							if arg_156_1.isInRecall_ then
								iter_159_3.color = Color.New(Mathf.Lerp(iter_159_3.color.r, arg_156_1.hightColor1.r, (arg_156_1.time_ - 0) / var_159_3), Mathf.Lerp(iter_159_3.color.g, arg_156_1.hightColor1.g, (arg_156_1.time_ - 0) / var_159_3), (Mathf.Lerp(iter_159_3.color.b, arg_156_1.hightColor1.b, (arg_156_1.time_ - 0) / var_159_3)))
							else
								local var_159_4 = Mathf.Lerp(iter_159_3.color.r, 1, (arg_156_1.time_ - 0) / var_159_3)

								iter_159_3.color = Color.New(var_159_4, var_159_4, var_159_4)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= 0 + var_159_3 and arg_156_1.time_ < 0 + var_159_3 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.actorSpriteComps1052 then
				for iter_159_4, iter_159_5 in pairs(arg_156_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_159_5 then
						iter_159_5.color = arg_156_1.isInRecall_ and (arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_156_1.var_.actorSpriteComps1052 = nil
			end

			local var_159_5 = arg_156_1.actors_["1034"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_5) and arg_156_1.var_.actorSpriteComps1034 == nil then
				arg_156_1.var_.actorSpriteComps1034 = var_159_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_6 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_6 and not isNil(var_159_5) then
				if arg_156_1.var_.actorSpriteComps1034 then
					for iter_159_6, iter_159_7 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_159_7 then
							if arg_156_1.isInRecall_ then
								iter_159_7.color = Color.New(Mathf.Lerp(iter_159_7.color.r, arg_156_1.hightColor2.r, (arg_156_1.time_ - 0) / var_159_6), Mathf.Lerp(iter_159_7.color.g, arg_156_1.hightColor2.g, (arg_156_1.time_ - 0) / var_159_6), (Mathf.Lerp(iter_159_7.color.b, arg_156_1.hightColor2.b, (arg_156_1.time_ - 0) / var_159_6)))
							else
								local var_159_7 = Mathf.Lerp(iter_159_7.color.r, 0.5, (arg_156_1.time_ - 0) / var_159_6)

								iter_159_7.color = Color.New(var_159_7, var_159_7, var_159_7)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= 0 + var_159_6 and arg_156_1.time_ < 0 + var_159_6 + arg_159_0 and not isNil(var_159_5) and arg_156_1.var_.actorSpriteComps1034 then
				for iter_159_8, iter_159_9 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_159_9 then
						iter_159_9.color = arg_156_1.isInRecall_ and (arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_156_1.var_.actorSpriteComps1034 = nil
			end

			local var_159_8 = 0
			local var_159_9 = 0.1

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_8 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_5")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_10 = arg_156_1:GetWordFromCfg(417082037)
				local var_159_11 = arg_156_1:FormatText(var_159_10.content)

				arg_156_1.text_.text = var_159_11

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_13 = 4 <= 0 and var_159_9 or var_159_9 * (utf8.len(var_159_11) / 4)

				if (4 <= 0 and var_159_9 or var_159_9 * (utf8.len(var_159_11) / 4)) > 0 and var_159_9 < var_159_13 then
					arg_156_1.talkMaxDuration = var_159_13

					if var_159_13 + var_159_8 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_8
					end
				end

				arg_156_1.text_.text = var_159_11
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082037", "story_v_out_417082.awb") ~= 0 then
					local var_159_14 = manager.audio:GetVoiceLength("story_v_out_417082", "417082037", "story_v_out_417082.awb") / 1000

					if var_159_14 + var_159_8 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_14 + var_159_8
					end

					if var_159_10.prefab_name ~= "" and arg_156_1.actors_[var_159_10.prefab_name] ~= nil then
						local var_159_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_10.prefab_name].transform, "story_v_out_417082", "417082037", "story_v_out_417082.awb")

						arg_156_1:RecordAudio("417082037", var_159_15)
						arg_156_1:RecordAudio("417082037", var_159_15)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_417082", "417082037", "story_v_out_417082.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_417082", "417082037", "story_v_out_417082.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_16 = math.max(var_159_9, arg_156_1.talkMaxDuration)

			if var_159_8 <= arg_156_1.time_ and arg_156_1.time_ < var_159_8 + var_159_16 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_8) / var_159_16

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_8 + var_159_16 and arg_156_1.time_ < var_159_8 + var_159_16 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play417082038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417082038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play417082039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1052"]) and arg_160_1.var_.actorSpriteComps1052 == nil then
				arg_160_1.var_.actorSpriteComps1052 = arg_160_1.actors_["1052"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_0 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1052"]) then
				if arg_160_1.var_.actorSpriteComps1052 then
					for iter_163_0, iter_163_1 in pairs(arg_160_1.var_.actorSpriteComps1052:ToTable()) do
						if iter_163_1 then
							if arg_160_1.isInRecall_ then
								iter_163_1.color = Color.New(Mathf.Lerp(iter_163_1.color.r, arg_160_1.hightColor2.r, (arg_160_1.time_ - 0) / var_163_0), Mathf.Lerp(iter_163_1.color.g, arg_160_1.hightColor2.g, (arg_160_1.time_ - 0) / var_163_0), (Mathf.Lerp(iter_163_1.color.b, arg_160_1.hightColor2.b, (arg_160_1.time_ - 0) / var_163_0)))
							else
								local var_163_1 = Mathf.Lerp(iter_163_1.color.r, 0.5, (arg_160_1.time_ - 0) / var_163_0)

								iter_163_1.color = Color.New(var_163_1, var_163_1, var_163_1)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1052"]) and arg_160_1.var_.actorSpriteComps1052 then
				for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_163_3 then
						iter_163_3.color = arg_160_1.isInRecall_ and (arg_160_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_160_1.var_.actorSpriteComps1052 = nil
			end

			local var_163_2 = arg_160_1.actors_["1034"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1034 = var_163_2.localPosition
				var_163_2.localScale = Vector3.New(1, 1, 1)

				arg_160_1:CheckSpriteTmpPos("1034", 7)

				for iter_163_4 = 0, var_163_2.childCount - 1 do
					local var_163_3 = var_163_2:GetChild(iter_163_4)

					if var_163_3.name == "" or not string.find(var_163_3.name, "split") then
						var_163_3.gameObject:SetActive(true)
					else
						var_163_3.gameObject:SetActive(false)
					end
				end
			end

			local var_163_4 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 then
				var_163_2.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_160_1.time_ - 0) / var_163_4)
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 then
				var_163_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.2 < arg_160_1.time_ and arg_160_1.time_ <= 0.2 + arg_163_0 then
				arg_160_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_surround", "")
			end

			local var_163_6 = 0
			local var_163_7 = 1.6

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_8 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(417082038).content)

				arg_160_1.text_.text = var_163_8

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_10 = 64 <= 0 and var_163_7 or var_163_7 * (utf8.len(var_163_8) / 64)

				if (64 <= 0 and var_163_7 or var_163_7 * (utf8.len(var_163_8) / 64)) > 0 and var_163_7 < var_163_10 then
					arg_160_1.talkMaxDuration = var_163_10

					if var_163_10 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_10 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_8
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_11 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_11 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_11

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_11 and arg_160_1.time_ < var_163_6 + var_163_11 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
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

		arg_160_1:InitPlayNodeList()
	end,
	Play417082039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 417082039
		arg_164_1.duration_ = 2.43

		local var_164_0 = {
			zh = 1.3,
			ja = 2.433
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play417082040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if arg_164_1.actors_["10113"] == nil then
				local var_167_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_167_0) then
					local var_167_1 = Object.Instantiate(var_167_0, arg_164_1.canvasGo_.transform)

					var_167_1.transform:SetSiblingIndex(1)

					var_167_1.name = "10113"
					var_167_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_164_1.actors_["10113"] = var_167_1

					if arg_164_1.isInRecall_ then
						for iter_167_0, iter_167_1 in ipairs((var_167_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_167_1.color = arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_167_2 = arg_164_1.actors_["10113"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.actorSpriteComps10113 == nil then
				arg_164_1.var_.actorSpriteComps10113 = var_167_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_3 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_3 and not isNil(var_167_2) then
				if arg_164_1.var_.actorSpriteComps10113 then
					for iter_167_2, iter_167_3 in pairs(arg_164_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_167_3 then
							if arg_164_1.isInRecall_ then
								iter_167_3.color = Color.New(Mathf.Lerp(iter_167_3.color.r, arg_164_1.hightColor1.r, (arg_164_1.time_ - 0) / var_167_3), Mathf.Lerp(iter_167_3.color.g, arg_164_1.hightColor1.g, (arg_164_1.time_ - 0) / var_167_3), (Mathf.Lerp(iter_167_3.color.b, arg_164_1.hightColor1.b, (arg_164_1.time_ - 0) / var_167_3)))
							else
								local var_167_4 = Mathf.Lerp(iter_167_3.color.r, 1, (arg_164_1.time_ - 0) / var_167_3)

								iter_167_3.color = Color.New(var_167_4, var_167_4, var_167_4)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= 0 + var_167_3 and arg_164_1.time_ < 0 + var_167_3 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.actorSpriteComps10113 then
				for iter_167_4, iter_167_5 in pairs(arg_164_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_167_5 then
						iter_167_5.color = arg_164_1.isInRecall_ and (arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_164_1.var_.actorSpriteComps10113 = nil
			end

			local var_167_5 = arg_164_1.actors_["10113"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos10113 = var_167_5.localPosition
				var_167_5.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("10113", 3)

				for iter_167_6 = 0, var_167_5.childCount - 1 do
					local var_167_6 = var_167_5:GetChild(iter_167_6)

					if var_167_6.name == "split_6" or not string.find(var_167_6.name, "split") then
						var_167_6.gameObject:SetActive(true)
					else
						var_167_6.gameObject:SetActive(false)
					end
				end
			end

			local var_167_7 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_7 then
				var_167_5.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_164_1.time_ - 0) / var_167_7)
			end

			if arg_164_1.time_ >= 0 + var_167_7 and arg_164_1.time_ < 0 + var_167_7 + arg_167_0 then
				var_167_5.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_167_8 = 0
			local var_167_9 = 0.15

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_8 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_10 = arg_164_1:GetWordFromCfg(417082039)
				local var_167_11 = arg_164_1:FormatText(var_167_10.content)

				arg_164_1.text_.text = var_167_11

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_13 = 6 <= 0 and var_167_9 or var_167_9 * (utf8.len(var_167_11) / 6)

				if (6 <= 0 and var_167_9 or var_167_9 * (utf8.len(var_167_11) / 6)) > 0 and var_167_9 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_8 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_8
					end
				end

				arg_164_1.text_.text = var_167_11
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082039", "story_v_out_417082.awb") ~= 0 then
					local var_167_14 = manager.audio:GetVoiceLength("story_v_out_417082", "417082039", "story_v_out_417082.awb") / 1000

					if var_167_14 + var_167_8 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_14 + var_167_8
					end

					if var_167_10.prefab_name ~= "" and arg_164_1.actors_[var_167_10.prefab_name] ~= nil then
						local var_167_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_10.prefab_name].transform, "story_v_out_417082", "417082039", "story_v_out_417082.awb")

						arg_164_1:RecordAudio("417082039", var_167_15)
						arg_164_1:RecordAudio("417082039", var_167_15)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_417082", "417082039", "story_v_out_417082.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_417082", "417082039", "story_v_out_417082.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_16 = math.max(var_167_9, arg_164_1.talkMaxDuration)

			if var_167_8 <= arg_164_1.time_ and arg_164_1.time_ < var_167_8 + var_167_16 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_8) / var_167_16

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_8 + var_167_16 and arg_164_1.time_ < var_167_8 + var_167_16 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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

		arg_164_1:InitPlayNodeList()
	end,
	Play417082040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 417082040
		arg_168_1.duration_ = 4.1

		local var_168_0 = {
			zh = 2.433,
			ja = 4.1
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play417082041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["1034"]) and arg_168_1.var_.actorSpriteComps1034 == nil then
				arg_168_1.var_.actorSpriteComps1034 = arg_168_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_0 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["1034"]) then
				if arg_168_1.var_.actorSpriteComps1034 then
					for iter_171_0, iter_171_1 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_171_1 then
							if arg_168_1.isInRecall_ then
								iter_171_1.color = Color.New(Mathf.Lerp(iter_171_1.color.r, arg_168_1.hightColor1.r, (arg_168_1.time_ - 0) / var_171_0), Mathf.Lerp(iter_171_1.color.g, arg_168_1.hightColor1.g, (arg_168_1.time_ - 0) / var_171_0), (Mathf.Lerp(iter_171_1.color.b, arg_168_1.hightColor1.b, (arg_168_1.time_ - 0) / var_171_0)))
							else
								local var_171_1 = Mathf.Lerp(iter_171_1.color.r, 1, (arg_168_1.time_ - 0) / var_171_0)

								iter_171_1.color = Color.New(var_171_1, var_171_1, var_171_1)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1034"]) and arg_168_1.var_.actorSpriteComps1034 then
				for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_171_3 then
						iter_171_3.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_168_1.var_.actorSpriteComps1034 = nil
			end

			local var_171_2 = arg_168_1.actors_["10113"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.actorSpriteComps10113 == nil then
				arg_168_1.var_.actorSpriteComps10113 = var_171_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_3 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_3 and not isNil(var_171_2) then
				if arg_168_1.var_.actorSpriteComps10113 then
					for iter_171_4, iter_171_5 in pairs(arg_168_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_171_5 then
							if arg_168_1.isInRecall_ then
								iter_171_5.color = Color.New(Mathf.Lerp(iter_171_5.color.r, arg_168_1.hightColor2.r, (arg_168_1.time_ - 0) / var_171_3), Mathf.Lerp(iter_171_5.color.g, arg_168_1.hightColor2.g, (arg_168_1.time_ - 0) / var_171_3), (Mathf.Lerp(iter_171_5.color.b, arg_168_1.hightColor2.b, (arg_168_1.time_ - 0) / var_171_3)))
							else
								local var_171_4 = Mathf.Lerp(iter_171_5.color.r, 0.5, (arg_168_1.time_ - 0) / var_171_3)

								iter_171_5.color = Color.New(var_171_4, var_171_4, var_171_4)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_3 and arg_168_1.time_ < 0 + var_171_3 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.actorSpriteComps10113 then
				for iter_171_6, iter_171_7 in pairs(arg_168_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_171_7 then
						iter_171_7.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_168_1.var_.actorSpriteComps10113 = nil
			end

			local var_171_5 = arg_168_1.actors_["1034"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1034 = var_171_5.localPosition
				var_171_5.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("1034", 4)

				for iter_171_8 = 0, var_171_5.childCount - 1 do
					local var_171_6 = var_171_5:GetChild(iter_171_8)

					if var_171_6.name == "" or not string.find(var_171_6.name, "split") then
						var_171_6.gameObject:SetActive(true)
					else
						var_171_6.gameObject:SetActive(false)
					end
				end
			end

			local var_171_7 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				var_171_5.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_168_1.time_ - 0) / var_171_7)
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				var_171_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_171_8 = arg_168_1.actors_["10113"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos10113 = var_171_8.localPosition
				var_171_8.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10113", 2)

				for iter_171_9 = 0, var_171_8.childCount - 1 do
					local var_171_9 = var_171_8:GetChild(iter_171_9)

					if var_171_9.name == "split_6" or not string.find(var_171_9.name, "split") then
						var_171_9.gameObject:SetActive(true)
					else
						var_171_9.gameObject:SetActive(false)
					end
				end
			end

			local var_171_10 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_10 then
				var_171_8.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10113, Vector3.New(-403.26, -328.4, -517.4), (arg_168_1.time_ - 0) / var_171_10)
			end

			if arg_168_1.time_ >= 0 + var_171_10 and arg_168_1.time_ < 0 + var_171_10 + arg_171_0 then
				var_171_8.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_171_11 = 0
			local var_171_12 = 0.275

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_11 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_13 = arg_168_1:GetWordFromCfg(417082040)
				local var_171_14 = arg_168_1:FormatText(var_171_13.content)

				arg_168_1.text_.text = var_171_14

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_16 = 11 <= 0 and var_171_12 or var_171_12 * (utf8.len(var_171_14) / 11)

				if (11 <= 0 and var_171_12 or var_171_12 * (utf8.len(var_171_14) / 11)) > 0 and var_171_12 < var_171_16 then
					arg_168_1.talkMaxDuration = var_171_16

					if var_171_16 + var_171_11 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_16 + var_171_11
					end
				end

				arg_168_1.text_.text = var_171_14
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082040", "story_v_out_417082.awb") ~= 0 then
					local var_171_17 = manager.audio:GetVoiceLength("story_v_out_417082", "417082040", "story_v_out_417082.awb") / 1000

					if var_171_17 + var_171_11 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_17 + var_171_11
					end

					if var_171_13.prefab_name ~= "" and arg_168_1.actors_[var_171_13.prefab_name] ~= nil then
						local var_171_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_13.prefab_name].transform, "story_v_out_417082", "417082040", "story_v_out_417082.awb")

						arg_168_1:RecordAudio("417082040", var_171_18)
						arg_168_1:RecordAudio("417082040", var_171_18)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_417082", "417082040", "story_v_out_417082.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_417082", "417082040", "story_v_out_417082.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_19 = math.max(var_171_12, arg_168_1.talkMaxDuration)

			if var_171_11 <= arg_168_1.time_ and arg_168_1.time_ < var_171_11 + var_171_19 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_11) / var_171_19

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_11 + var_171_19 and arg_168_1.time_ < var_171_11 + var_171_19 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
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

		arg_168_1:InitPlayNodeList()
	end,
	Play417082041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 417082041
		arg_172_1.duration_ = 9.6

		local var_172_0 = {
			zh = 3.766,
			ja = 9.6
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play417082042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["10113"]) and arg_172_1.var_.actorSpriteComps10113 == nil then
				arg_172_1.var_.actorSpriteComps10113 = arg_172_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_0 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["10113"]) then
				if arg_172_1.var_.actorSpriteComps10113 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_175_1 then
							if arg_172_1.isInRecall_ then
								iter_175_1.color = Color.New(Mathf.Lerp(iter_175_1.color.r, arg_172_1.hightColor1.r, (arg_172_1.time_ - 0) / var_175_0), Mathf.Lerp(iter_175_1.color.g, arg_172_1.hightColor1.g, (arg_172_1.time_ - 0) / var_175_0), (Mathf.Lerp(iter_175_1.color.b, arg_172_1.hightColor1.b, (arg_172_1.time_ - 0) / var_175_0)))
							else
								local var_175_1 = Mathf.Lerp(iter_175_1.color.r, 1, (arg_172_1.time_ - 0) / var_175_0)

								iter_175_1.color = Color.New(var_175_1, var_175_1, var_175_1)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["10113"]) and arg_172_1.var_.actorSpriteComps10113 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_175_3 then
						iter_175_3.color = arg_172_1.isInRecall_ and (arg_172_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_172_1.var_.actorSpriteComps10113 = nil
			end

			local var_175_2 = arg_172_1.actors_["1034"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.actorSpriteComps1034 == nil then
				arg_172_1.var_.actorSpriteComps1034 = var_175_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_3 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_3 and not isNil(var_175_2) then
				if arg_172_1.var_.actorSpriteComps1034 then
					for iter_175_4, iter_175_5 in pairs(arg_172_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_175_5 then
							if arg_172_1.isInRecall_ then
								iter_175_5.color = Color.New(Mathf.Lerp(iter_175_5.color.r, arg_172_1.hightColor2.r, (arg_172_1.time_ - 0) / var_175_3), Mathf.Lerp(iter_175_5.color.g, arg_172_1.hightColor2.g, (arg_172_1.time_ - 0) / var_175_3), (Mathf.Lerp(iter_175_5.color.b, arg_172_1.hightColor2.b, (arg_172_1.time_ - 0) / var_175_3)))
							else
								local var_175_4 = Mathf.Lerp(iter_175_5.color.r, 0.5, (arg_172_1.time_ - 0) / var_175_3)

								iter_175_5.color = Color.New(var_175_4, var_175_4, var_175_4)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= 0 + var_175_3 and arg_172_1.time_ < 0 + var_175_3 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.actorSpriteComps1034 then
				for iter_175_6, iter_175_7 in pairs(arg_172_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_175_7 then
						iter_175_7.color = arg_172_1.isInRecall_ and (arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_172_1.var_.actorSpriteComps1034 = nil
			end

			local var_175_5 = 0
			local var_175_6 = 0.45

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_7 = arg_172_1:GetWordFromCfg(417082041)
				local var_175_8 = arg_172_1:FormatText(var_175_7.content)

				arg_172_1.text_.text = var_175_8

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_10 = 18 <= 0 and var_175_6 or var_175_6 * (utf8.len(var_175_8) / 18)

				if (18 <= 0 and var_175_6 or var_175_6 * (utf8.len(var_175_8) / 18)) > 0 and var_175_6 < var_175_10 then
					arg_172_1.talkMaxDuration = var_175_10

					if var_175_10 + var_175_5 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_10 + var_175_5
					end
				end

				arg_172_1.text_.text = var_175_8
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082041", "story_v_out_417082.awb") ~= 0 then
					local var_175_11 = manager.audio:GetVoiceLength("story_v_out_417082", "417082041", "story_v_out_417082.awb") / 1000

					if var_175_11 + var_175_5 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_11 + var_175_5
					end

					if var_175_7.prefab_name ~= "" and arg_172_1.actors_[var_175_7.prefab_name] ~= nil then
						local var_175_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_7.prefab_name].transform, "story_v_out_417082", "417082041", "story_v_out_417082.awb")

						arg_172_1:RecordAudio("417082041", var_175_12)
						arg_172_1:RecordAudio("417082041", var_175_12)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_417082", "417082041", "story_v_out_417082.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_417082", "417082041", "story_v_out_417082.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_13 = math.max(var_175_6, arg_172_1.talkMaxDuration)

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_13 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_5) / var_175_13

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_5 + var_175_13 and arg_172_1.time_ < var_175_5 + var_175_13 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play417082042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 417082042
		arg_176_1.duration_ = 7.6

		local var_176_0 = {
			zh = 4.466,
			ja = 7.6
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
				arg_176_0:Play417082043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1034"]) and arg_176_1.var_.actorSpriteComps1034 == nil then
				arg_176_1.var_.actorSpriteComps1034 = arg_176_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_0 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1034"]) then
				if arg_176_1.var_.actorSpriteComps1034 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_179_1 then
							if arg_176_1.isInRecall_ then
								iter_179_1.color = Color.New(Mathf.Lerp(iter_179_1.color.r, arg_176_1.hightColor1.r, (arg_176_1.time_ - 0) / var_179_0), Mathf.Lerp(iter_179_1.color.g, arg_176_1.hightColor1.g, (arg_176_1.time_ - 0) / var_179_0), (Mathf.Lerp(iter_179_1.color.b, arg_176_1.hightColor1.b, (arg_176_1.time_ - 0) / var_179_0)))
							else
								local var_179_1 = Mathf.Lerp(iter_179_1.color.r, 1, (arg_176_1.time_ - 0) / var_179_0)

								iter_179_1.color = Color.New(var_179_1, var_179_1, var_179_1)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1034"]) and arg_176_1.var_.actorSpriteComps1034 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_179_3 then
						iter_179_3.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_176_1.var_.actorSpriteComps1034 = nil
			end

			local var_179_2 = arg_176_1.actors_["10113"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.actorSpriteComps10113 == nil then
				arg_176_1.var_.actorSpriteComps10113 = var_179_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_3 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_3 and not isNil(var_179_2) then
				if arg_176_1.var_.actorSpriteComps10113 then
					for iter_179_4, iter_179_5 in pairs(arg_176_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_179_5 then
							if arg_176_1.isInRecall_ then
								iter_179_5.color = Color.New(Mathf.Lerp(iter_179_5.color.r, arg_176_1.hightColor2.r, (arg_176_1.time_ - 0) / var_179_3), Mathf.Lerp(iter_179_5.color.g, arg_176_1.hightColor2.g, (arg_176_1.time_ - 0) / var_179_3), (Mathf.Lerp(iter_179_5.color.b, arg_176_1.hightColor2.b, (arg_176_1.time_ - 0) / var_179_3)))
							else
								local var_179_4 = Mathf.Lerp(iter_179_5.color.r, 0.5, (arg_176_1.time_ - 0) / var_179_3)

								iter_179_5.color = Color.New(var_179_4, var_179_4, var_179_4)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= 0 + var_179_3 and arg_176_1.time_ < 0 + var_179_3 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.actorSpriteComps10113 then
				for iter_179_6, iter_179_7 in pairs(arg_176_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_179_7 then
						iter_179_7.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_176_1.var_.actorSpriteComps10113 = nil
			end

			local var_179_5 = 0
			local var_179_6 = 0.6

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_7 = arg_176_1:GetWordFromCfg(417082042)
				local var_179_8 = arg_176_1:FormatText(var_179_7.content)

				arg_176_1.text_.text = var_179_8

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_10 = 24 <= 0 and var_179_6 or var_179_6 * (utf8.len(var_179_8) / 24)

				if (24 <= 0 and var_179_6 or var_179_6 * (utf8.len(var_179_8) / 24)) > 0 and var_179_6 < var_179_10 then
					arg_176_1.talkMaxDuration = var_179_10

					if var_179_10 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_10 + var_179_5
					end
				end

				arg_176_1.text_.text = var_179_8
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082042", "story_v_out_417082.awb") ~= 0 then
					local var_179_11 = manager.audio:GetVoiceLength("story_v_out_417082", "417082042", "story_v_out_417082.awb") / 1000

					if var_179_11 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_11 + var_179_5
					end

					if var_179_7.prefab_name ~= "" and arg_176_1.actors_[var_179_7.prefab_name] ~= nil then
						local var_179_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_7.prefab_name].transform, "story_v_out_417082", "417082042", "story_v_out_417082.awb")

						arg_176_1:RecordAudio("417082042", var_179_12)
						arg_176_1:RecordAudio("417082042", var_179_12)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_417082", "417082042", "story_v_out_417082.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_417082", "417082042", "story_v_out_417082.awb")
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

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play417082043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 417082043
		arg_180_1.duration_ = 1.43

		local var_180_0 = {
			zh = 0.999999999999,
			ja = 1.433
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
				arg_180_0:Play417082044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if arg_180_1.actors_["1028"] == nil then
				local var_183_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_183_0) then
					local var_183_1 = Object.Instantiate(var_183_0, arg_180_1.canvasGo_.transform)

					var_183_1.transform:SetSiblingIndex(1)

					var_183_1.name = "1028"
					var_183_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_180_1.actors_["1028"] = var_183_1

					if arg_180_1.isInRecall_ then
						for iter_183_0, iter_183_1 in ipairs((var_183_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_183_1.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_183_2 = arg_180_1.actors_["1028"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.actorSpriteComps1028 == nil then
				arg_180_1.var_.actorSpriteComps1028 = var_183_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_3 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_3 and not isNil(var_183_2) then
				if arg_180_1.var_.actorSpriteComps1028 then
					for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_180_1.time_ >= 0 + var_183_3 and arg_180_1.time_ < 0 + var_183_3 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.actorSpriteComps1028 then
				for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_183_5 then
						iter_183_5.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_180_1.var_.actorSpriteComps1028 = nil
			end

			local var_183_5 = arg_180_1.actors_["1034"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_5) and arg_180_1.var_.actorSpriteComps1034 == nil then
				arg_180_1.var_.actorSpriteComps1034 = var_183_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_6 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_6 and not isNil(var_183_5) then
				if arg_180_1.var_.actorSpriteComps1034 then
					for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_183_7 then
							if arg_180_1.isInRecall_ then
								iter_183_7.color = Color.New(Mathf.Lerp(iter_183_7.color.r, arg_180_1.hightColor2.r, (arg_180_1.time_ - 0) / var_183_6), Mathf.Lerp(iter_183_7.color.g, arg_180_1.hightColor2.g, (arg_180_1.time_ - 0) / var_183_6), (Mathf.Lerp(iter_183_7.color.b, arg_180_1.hightColor2.b, (arg_180_1.time_ - 0) / var_183_6)))
							else
								local var_183_7 = Mathf.Lerp(iter_183_7.color.r, 0.5, (arg_180_1.time_ - 0) / var_183_6)

								iter_183_7.color = Color.New(var_183_7, var_183_7, var_183_7)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_6 and arg_180_1.time_ < 0 + var_183_6 + arg_183_0 and not isNil(var_183_5) and arg_180_1.var_.actorSpriteComps1034 then
				for iter_183_8, iter_183_9 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_183_9 then
						iter_183_9.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_180_1.var_.actorSpriteComps1034 = nil
			end

			local var_183_8 = 0
			local var_183_9 = 0.075

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_8 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_10 = arg_180_1:GetWordFromCfg(417082043)
				local var_183_11 = arg_180_1:FormatText(var_183_10.content)

				arg_180_1.text_.text = var_183_11

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_13 = 3 <= 0 and var_183_9 or var_183_9 * (utf8.len(var_183_11) / 3)

				if (3 <= 0 and var_183_9 or var_183_9 * (utf8.len(var_183_11) / 3)) > 0 and var_183_9 < var_183_13 then
					arg_180_1.talkMaxDuration = var_183_13

					if var_183_13 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_8
					end
				end

				arg_180_1.text_.text = var_183_11
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082043", "story_v_out_417082.awb") ~= 0 then
					local var_183_14 = manager.audio:GetVoiceLength("story_v_out_417082", "417082043", "story_v_out_417082.awb") / 1000

					if var_183_14 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_14 + var_183_8
					end

					if var_183_10.prefab_name ~= "" and arg_180_1.actors_[var_183_10.prefab_name] ~= nil then
						local var_183_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_10.prefab_name].transform, "story_v_out_417082", "417082043", "story_v_out_417082.awb")

						arg_180_1:RecordAudio("417082043", var_183_15)
						arg_180_1:RecordAudio("417082043", var_183_15)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_417082", "417082043", "story_v_out_417082.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_417082", "417082043", "story_v_out_417082.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_16 = math.max(var_183_9, arg_180_1.talkMaxDuration)

			if var_183_8 <= arg_180_1.time_ and arg_180_1.time_ < var_183_8 + var_183_16 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_8) / var_183_16

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_8 + var_183_16 and arg_180_1.time_ < var_183_8 + var_183_16 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play417082044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417082044
		arg_184_1.duration_ = 5.43

		local var_184_0 = {
			zh = 3.6,
			ja = 5.433
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
				arg_184_0:Play417082045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["10113"]) and arg_184_1.var_.actorSpriteComps10113 == nil then
				arg_184_1.var_.actorSpriteComps10113 = arg_184_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_0 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["10113"]) then
				if arg_184_1.var_.actorSpriteComps10113 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["10113"]) and arg_184_1.var_.actorSpriteComps10113 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_187_3 then
						iter_187_3.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_184_1.var_.actorSpriteComps10113 = nil
			end

			local var_187_2 = arg_184_1.actors_["1028"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.actorSpriteComps1028 == nil then
				arg_184_1.var_.actorSpriteComps1028 = var_187_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_3 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_3 and not isNil(var_187_2) then
				if arg_184_1.var_.actorSpriteComps1028 then
					for iter_187_4, iter_187_5 in pairs(arg_184_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_184_1.time_ >= 0 + var_187_3 and arg_184_1.time_ < 0 + var_187_3 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.actorSpriteComps1028 then
				for iter_187_6, iter_187_7 in pairs(arg_184_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_187_7 then
						iter_187_7.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_184_1.var_.actorSpriteComps1028 = nil
			end

			local var_187_5 = arg_184_1.actors_["10113"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos10113 = var_187_5.localPosition
				var_187_5.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10113", 2)

				for iter_187_8 = 0, var_187_5.childCount - 1 do
					local var_187_6 = var_187_5:GetChild(iter_187_8)

					if var_187_6.name == "split_4" or not string.find(var_187_6.name, "split") then
						var_187_6.gameObject:SetActive(true)
					else
						var_187_6.gameObject:SetActive(false)
					end
				end
			end

			local var_187_7 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_7 then
				var_187_5.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10113, Vector3.New(-403.26, -328.4, -517.4), (arg_184_1.time_ - 0) / var_187_7)
			end

			if arg_184_1.time_ >= 0 + var_187_7 and arg_184_1.time_ < 0 + var_187_7 + arg_187_0 then
				var_187_5.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_187_8 = 0
			local var_187_9 = 0.425

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_8 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_10 = arg_184_1:GetWordFromCfg(417082044)
				local var_187_11 = arg_184_1:FormatText(var_187_10.content)

				arg_184_1.text_.text = var_187_11

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_13 = 17 <= 0 and var_187_9 or var_187_9 * (utf8.len(var_187_11) / 17)

				if (17 <= 0 and var_187_9 or var_187_9 * (utf8.len(var_187_11) / 17)) > 0 and var_187_9 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_8
					end
				end

				arg_184_1.text_.text = var_187_11
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082044", "story_v_out_417082.awb") ~= 0 then
					local var_187_14 = manager.audio:GetVoiceLength("story_v_out_417082", "417082044", "story_v_out_417082.awb") / 1000

					if var_187_14 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_8
					end

					if var_187_10.prefab_name ~= "" and arg_184_1.actors_[var_187_10.prefab_name] ~= nil then
						local var_187_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_10.prefab_name].transform, "story_v_out_417082", "417082044", "story_v_out_417082.awb")

						arg_184_1:RecordAudio("417082044", var_187_15)
						arg_184_1:RecordAudio("417082044", var_187_15)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_417082", "417082044", "story_v_out_417082.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_417082", "417082044", "story_v_out_417082.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_16 = math.max(var_187_9, arg_184_1.talkMaxDuration)

			if var_187_8 <= arg_184_1.time_ and arg_184_1.time_ < var_187_8 + var_187_16 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_8) / var_187_16

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_8 + var_187_16 and arg_184_1.time_ < var_187_8 + var_187_16 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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

		arg_184_1:InitPlayNodeList()
	end,
	Play417082045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417082045
		arg_188_1.duration_ = 5.5

		local var_188_0 = {
			zh = 3.233,
			ja = 5.5
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
				arg_188_0:Play417082046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1034"]) and arg_188_1.var_.actorSpriteComps1034 == nil then
				arg_188_1.var_.actorSpriteComps1034 = arg_188_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_0 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1034"]) then
				if arg_188_1.var_.actorSpriteComps1034 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1034"]) and arg_188_1.var_.actorSpriteComps1034 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_191_3 then
						iter_191_3.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_188_1.var_.actorSpriteComps1034 = nil
			end

			local var_191_2 = arg_188_1.actors_["10113"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.actorSpriteComps10113 == nil then
				arg_188_1.var_.actorSpriteComps10113 = var_191_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_3 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_3 and not isNil(var_191_2) then
				if arg_188_1.var_.actorSpriteComps10113 then
					for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_191_5 then
							if arg_188_1.isInRecall_ then
								iter_191_5.color = Color.New(Mathf.Lerp(iter_191_5.color.r, arg_188_1.hightColor2.r, (arg_188_1.time_ - 0) / var_191_3), Mathf.Lerp(iter_191_5.color.g, arg_188_1.hightColor2.g, (arg_188_1.time_ - 0) / var_191_3), (Mathf.Lerp(iter_191_5.color.b, arg_188_1.hightColor2.b, (arg_188_1.time_ - 0) / var_191_3)))
							else
								local var_191_4 = Mathf.Lerp(iter_191_5.color.r, 0.5, (arg_188_1.time_ - 0) / var_191_3)

								iter_191_5.color = Color.New(var_191_4, var_191_4, var_191_4)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_3 and arg_188_1.time_ < 0 + var_191_3 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.actorSpriteComps10113 then
				for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_191_7 then
						iter_191_7.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_188_1.var_.actorSpriteComps10113 = nil
			end

			local var_191_5 = arg_188_1.actors_["1034"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1034 = var_191_5.localPosition
				var_191_5.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("1034", 4)

				for iter_191_8 = 0, var_191_5.childCount - 1 do
					local var_191_6 = var_191_5:GetChild(iter_191_8)

					if var_191_6.name == "split_6" or not string.find(var_191_6.name, "split") then
						var_191_6.gameObject:SetActive(true)
					else
						var_191_6.gameObject:SetActive(false)
					end
				end
			end

			local var_191_7 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 then
				var_191_5.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_188_1.time_ - 0) / var_191_7)
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 then
				var_191_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_191_8 = arg_188_1.actors_["10113"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10113 = var_191_8.localPosition
				var_191_8.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10113", 2)

				for iter_191_9 = 0, var_191_8.childCount - 1 do
					local var_191_9 = var_191_8:GetChild(iter_191_9)

					if var_191_9.name == "split_6" or not string.find(var_191_9.name, "split") then
						var_191_9.gameObject:SetActive(true)
					else
						var_191_9.gameObject:SetActive(false)
					end
				end
			end

			local var_191_10 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_10 then
				var_191_8.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10113, Vector3.New(-403.26, -328.4, -517.4), (arg_188_1.time_ - 0) / var_191_10)
			end

			if arg_188_1.time_ >= 0 + var_191_10 and arg_188_1.time_ < 0 + var_191_10 + arg_191_0 then
				var_191_8.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_191_11 = 0
			local var_191_12 = 0.375

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_11 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_13 = arg_188_1:GetWordFromCfg(417082045)
				local var_191_14 = arg_188_1:FormatText(var_191_13.content)

				arg_188_1.text_.text = var_191_14

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_16 = 15 <= 0 and var_191_12 or var_191_12 * (utf8.len(var_191_14) / 15)

				if (15 <= 0 and var_191_12 or var_191_12 * (utf8.len(var_191_14) / 15)) > 0 and var_191_12 < var_191_16 then
					arg_188_1.talkMaxDuration = var_191_16

					if var_191_16 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_16 + var_191_11
					end
				end

				arg_188_1.text_.text = var_191_14
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082045", "story_v_out_417082.awb") ~= 0 then
					local var_191_17 = manager.audio:GetVoiceLength("story_v_out_417082", "417082045", "story_v_out_417082.awb") / 1000

					if var_191_17 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_17 + var_191_11
					end

					if var_191_13.prefab_name ~= "" and arg_188_1.actors_[var_191_13.prefab_name] ~= nil then
						local var_191_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_13.prefab_name].transform, "story_v_out_417082", "417082045", "story_v_out_417082.awb")

						arg_188_1:RecordAudio("417082045", var_191_18)
						arg_188_1:RecordAudio("417082045", var_191_18)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417082", "417082045", "story_v_out_417082.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417082", "417082045", "story_v_out_417082.awb")
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

		arg_188_1:InitPlayNodeList()
	end,
	Play417082046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 417082046
		arg_192_1.duration_ = 8.07

		local var_192_0 = {
			zh = 8.066,
			ja = 7.233
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
				arg_192_0:Play417082047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 1

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_1 = arg_192_1:GetWordFromCfg(417082046)
				local var_195_2 = arg_192_1:FormatText(var_195_1.content)

				arg_192_1.text_.text = var_195_2

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_4 = 40 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 40)

				if (40 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 40)) > 0 and var_195_0 < var_195_4 then
					arg_192_1.talkMaxDuration = var_195_4

					if var_195_4 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_4 + 0
					end
				end

				arg_192_1.text_.text = var_195_2
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082046", "story_v_out_417082.awb") ~= 0 then
					local var_195_5 = manager.audio:GetVoiceLength("story_v_out_417082", "417082046", "story_v_out_417082.awb") / 1000

					if var_195_5 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + 0
					end

					if var_195_1.prefab_name ~= "" and arg_192_1.actors_[var_195_1.prefab_name] ~= nil then
						local var_195_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_1.prefab_name].transform, "story_v_out_417082", "417082046", "story_v_out_417082.awb")

						arg_192_1:RecordAudio("417082046", var_195_6)
						arg_192_1:RecordAudio("417082046", var_195_6)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_417082", "417082046", "story_v_out_417082.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_417082", "417082046", "story_v_out_417082.awb")
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
	Play417082047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 417082047
		arg_196_1.duration_ = 7.6

		local var_196_0 = {
			zh = 4.733,
			ja = 7.6
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
				arg_196_0:Play417082048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1034 = arg_196_1.actors_["1034"].transform.localPosition
				arg_196_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("1034", 4)

				for iter_199_0 = 0, arg_196_1.actors_["1034"].transform.childCount - 1 do
					local var_199_0 = arg_196_1.actors_["1034"].transform:GetChild(iter_199_0)

					if var_199_0.name == "" or not string.find(var_199_0.name, "split") then
						var_199_0.gameObject:SetActive(true)
					else
						var_199_0.gameObject:SetActive(false)
					end
				end
			end

			local var_199_1 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				arg_196_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_196_1.time_ - 0) / var_199_1)
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 then
				arg_196_1.actors_["1034"].transform.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_199_2 = 0
			local var_199_3 = 0.625

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_2 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_4 = arg_196_1:GetWordFromCfg(417082047)
				local var_199_5 = arg_196_1:FormatText(var_199_4.content)

				arg_196_1.text_.text = var_199_5

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_7 = 25 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_5) / 25)

				if (25 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_5) / 25)) > 0 and var_199_3 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_2
					end
				end

				arg_196_1.text_.text = var_199_5
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082047", "story_v_out_417082.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082047", "story_v_out_417082.awb") / 1000

					if var_199_8 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_2
					end

					if var_199_4.prefab_name ~= "" and arg_196_1.actors_[var_199_4.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_4.prefab_name].transform, "story_v_out_417082", "417082047", "story_v_out_417082.awb")

						arg_196_1:RecordAudio("417082047", var_199_9)
						arg_196_1:RecordAudio("417082047", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_417082", "417082047", "story_v_out_417082.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_417082", "417082047", "story_v_out_417082.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_3, arg_196_1.talkMaxDuration)

			if var_199_2 <= arg_196_1.time_ and arg_196_1.time_ < var_199_2 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_2) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_2 + var_199_10 and arg_196_1.time_ < var_199_2 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
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

		arg_196_1:InitPlayNodeList()
	end,
	Play417082048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 417082048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play417082049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1034"]) and arg_200_1.var_.actorSpriteComps1034 == nil then
				arg_200_1.var_.actorSpriteComps1034 = arg_200_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_0 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1034"]) then
				if arg_200_1.var_.actorSpriteComps1034 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								iter_203_1.color = Color.New(Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 0) / var_203_0), Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 0) / var_203_0), (Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 0) / var_203_0)))
							else
								local var_203_1 = Mathf.Lerp(iter_203_1.color.r, 0.5, (arg_200_1.time_ - 0) / var_203_0)

								iter_203_1.color = Color.New(var_203_1, var_203_1, var_203_1)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1034"]) and arg_200_1.var_.actorSpriteComps1034 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_203_3 then
						iter_203_3.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps1034 = nil
			end

			local var_203_2 = arg_200_1.actors_["10113"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos10113 = var_203_2.localPosition
				var_203_2.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10113", 7)

				for iter_203_4 = 0, var_203_2.childCount - 1 do
					local var_203_3 = var_203_2:GetChild(iter_203_4)

					if var_203_3.name == "split_4" or not string.find(var_203_3.name, "split") then
						var_203_3.gameObject:SetActive(true)
					else
						var_203_3.gameObject:SetActive(false)
					end
				end
			end

			local var_203_4 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				var_203_2.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_200_1.time_ - 0) / var_203_4)
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				var_203_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_203_5 = arg_200_1.actors_["1034"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1034 = var_203_5.localPosition
				var_203_5.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("1034", 7)

				for iter_203_5 = 0, var_203_5.childCount - 1 do
					local var_203_6 = var_203_5:GetChild(iter_203_5)

					if var_203_6.name == "" or not string.find(var_203_6.name, "split") then
						var_203_6.gameObject:SetActive(true)
					else
						var_203_6.gameObject:SetActive(false)
					end
				end
			end

			local var_203_7 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				var_203_5.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_200_1.time_ - 0) / var_203_7)
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				var_203_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_203_8 = 0
			local var_203_9 = 1.275

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_10 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(417082048).content)

				arg_200_1.text_.text = var_203_10

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_12 = 51 <= 0 and var_203_9 or var_203_9 * (utf8.len(var_203_10) / 51)

				if (51 <= 0 and var_203_9 or var_203_9 * (utf8.len(var_203_10) / 51)) > 0 and var_203_9 < var_203_12 then
					arg_200_1.talkMaxDuration = var_203_12

					if var_203_12 + var_203_8 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_12 + var_203_8
					end
				end

				arg_200_1.text_.text = var_203_10
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_13 = math.max(var_203_9, arg_200_1.talkMaxDuration)

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_13 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_8) / var_203_13

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_8 + var_203_13 and arg_200_1.time_ < var_203_8 + var_203_13 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
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

		arg_200_1:InitPlayNodeList()
	end,
	Play417082049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 417082049
		arg_204_1.duration_ = 10.13

		local var_204_0 = {
			zh = 9,
			ja = 10.133
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
				arg_204_0:Play417082050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["10113"]) and arg_204_1.var_.actorSpriteComps10113 == nil then
				arg_204_1.var_.actorSpriteComps10113 = arg_204_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_0 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["10113"]) then
				if arg_204_1.var_.actorSpriteComps10113 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["10113"]) and arg_204_1.var_.actorSpriteComps10113 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_207_3 then
						iter_207_3.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_204_1.var_.actorSpriteComps10113 = nil
			end

			local var_207_2 = arg_204_1.actors_["10113"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10113 = var_207_2.localPosition
				var_207_2.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10113", 2)

				for iter_207_4 = 0, var_207_2.childCount - 1 do
					local var_207_3 = var_207_2:GetChild(iter_207_4)

					if var_207_3.name == "split_6" or not string.find(var_207_3.name, "split") then
						var_207_3.gameObject:SetActive(true)
					else
						var_207_3.gameObject:SetActive(false)
					end
				end
			end

			local var_207_4 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				var_207_2.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10113, Vector3.New(-403.26, -328.4, -517.4), (arg_204_1.time_ - 0) / var_207_4)
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				var_207_2.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_207_5 = 0
			local var_207_6 = 1

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_7 = arg_204_1:GetWordFromCfg(417082049)
				local var_207_8 = arg_204_1:FormatText(var_207_7.content)

				arg_204_1.text_.text = var_207_8

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_10 = 40 <= 0 and var_207_6 or var_207_6 * (utf8.len(var_207_8) / 40)

				if (40 <= 0 and var_207_6 or var_207_6 * (utf8.len(var_207_8) / 40)) > 0 and var_207_6 < var_207_10 then
					arg_204_1.talkMaxDuration = var_207_10

					if var_207_10 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_5
					end
				end

				arg_204_1.text_.text = var_207_8
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082049", "story_v_out_417082.awb") ~= 0 then
					local var_207_11 = manager.audio:GetVoiceLength("story_v_out_417082", "417082049", "story_v_out_417082.awb") / 1000

					if var_207_11 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_11 + var_207_5
					end

					if var_207_7.prefab_name ~= "" and arg_204_1.actors_[var_207_7.prefab_name] ~= nil then
						local var_207_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_7.prefab_name].transform, "story_v_out_417082", "417082049", "story_v_out_417082.awb")

						arg_204_1:RecordAudio("417082049", var_207_12)
						arg_204_1:RecordAudio("417082049", var_207_12)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_417082", "417082049", "story_v_out_417082.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_417082", "417082049", "story_v_out_417082.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_13 = math.max(var_207_6, arg_204_1.talkMaxDuration)

			if var_207_5 <= arg_204_1.time_ and arg_204_1.time_ < var_207_5 + var_207_13 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_5) / var_207_13

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_5 + var_207_13 and arg_204_1.time_ < var_207_5 + var_207_13 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
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

		arg_204_1:InitPlayNodeList()
	end,
	Play417082050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 417082050
		arg_208_1.duration_ = 3.27

		local var_208_0 = {
			zh = 1.666,
			ja = 3.266
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
				arg_208_0:Play417082051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos10113 = arg_208_1.actors_["10113"].transform.localPosition
				arg_208_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10113", 2)

				for iter_211_0 = 0, arg_208_1.actors_["10113"].transform.childCount - 1 do
					local var_211_0 = arg_208_1.actors_["10113"].transform:GetChild(iter_211_0)

					if var_211_0.name == "split_6" or not string.find(var_211_0.name, "split") then
						var_211_0.gameObject:SetActive(true)
					else
						var_211_0.gameObject:SetActive(false)
					end
				end
			end

			local var_211_1 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_1 then
				arg_208_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10113, Vector3.New(-403.26, -328.4, -517.4), (arg_208_1.time_ - 0) / var_211_1)
			end

			if arg_208_1.time_ >= 0 + var_211_1 and arg_208_1.time_ < 0 + var_211_1 + arg_211_0 then
				arg_208_1.actors_["10113"].transform.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_211_2 = 0
			local var_211_3 = 0.25

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_2 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_4 = arg_208_1:GetWordFromCfg(417082050)
				local var_211_5 = arg_208_1:FormatText(var_211_4.content)

				arg_208_1.text_.text = var_211_5

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_7 = 10 <= 0 and var_211_3 or var_211_3 * (utf8.len(var_211_5) / 10)

				if (10 <= 0 and var_211_3 or var_211_3 * (utf8.len(var_211_5) / 10)) > 0 and var_211_3 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_2 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_2
					end
				end

				arg_208_1.text_.text = var_211_5
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082050", "story_v_out_417082.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082050", "story_v_out_417082.awb") / 1000

					if var_211_8 + var_211_2 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_2
					end

					if var_211_4.prefab_name ~= "" and arg_208_1.actors_[var_211_4.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_4.prefab_name].transform, "story_v_out_417082", "417082050", "story_v_out_417082.awb")

						arg_208_1:RecordAudio("417082050", var_211_9)
						arg_208_1:RecordAudio("417082050", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_417082", "417082050", "story_v_out_417082.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_417082", "417082050", "story_v_out_417082.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_10 = math.max(var_211_3, arg_208_1.talkMaxDuration)

			if var_211_2 <= arg_208_1.time_ and arg_208_1.time_ < var_211_2 + var_211_10 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_2) / var_211_10

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_2 + var_211_10 and arg_208_1.time_ < var_211_2 + var_211_10 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
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

		arg_208_1:InitPlayNodeList()
	end,
	Play417082051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 417082051
		arg_212_1.duration_ = 6.13

		local var_212_0 = {
			zh = 3.1,
			ja = 6.133
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
				arg_212_0:Play417082052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1034"]) and arg_212_1.var_.actorSpriteComps1034 == nil then
				arg_212_1.var_.actorSpriteComps1034 = arg_212_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_0 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1034"]) then
				if arg_212_1.var_.actorSpriteComps1034 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1034"]) and arg_212_1.var_.actorSpriteComps1034 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_215_3 then
						iter_215_3.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_212_1.var_.actorSpriteComps1034 = nil
			end

			local var_215_2 = arg_212_1.actors_["10113"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps10113 == nil then
				arg_212_1.var_.actorSpriteComps10113 = var_215_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_3 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 and not isNil(var_215_2) then
				if arg_212_1.var_.actorSpriteComps10113 then
					for iter_215_4, iter_215_5 in pairs(arg_212_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps10113 then
				for iter_215_6, iter_215_7 in pairs(arg_212_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_215_7 then
						iter_215_7.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_212_1.var_.actorSpriteComps10113 = nil
			end

			local var_215_5 = arg_212_1.actors_["1034"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1034 = var_215_5.localPosition
				var_215_5.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("1034", 4)

				for iter_215_8 = 0, var_215_5.childCount - 1 do
					local var_215_6 = var_215_5:GetChild(iter_215_8)

					if var_215_6.name == "split_7" or not string.find(var_215_6.name, "split") then
						var_215_6.gameObject:SetActive(true)
					else
						var_215_6.gameObject:SetActive(false)
					end
				end
			end

			local var_215_7 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				var_215_5.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_212_1.time_ - 0) / var_215_7)
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				var_215_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_215_8 = 0
			local var_215_9 = 0.375

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_8 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_10 = arg_212_1:GetWordFromCfg(417082051)
				local var_215_11 = arg_212_1:FormatText(var_215_10.content)

				arg_212_1.text_.text = var_215_11

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_13 = 15 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 15)

				if (15 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 15)) > 0 and var_215_9 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_8
					end
				end

				arg_212_1.text_.text = var_215_11
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082051", "story_v_out_417082.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_417082", "417082051", "story_v_out_417082.awb") / 1000

					if var_215_14 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_8
					end

					if var_215_10.prefab_name ~= "" and arg_212_1.actors_[var_215_10.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_10.prefab_name].transform, "story_v_out_417082", "417082051", "story_v_out_417082.awb")

						arg_212_1:RecordAudio("417082051", var_215_15)
						arg_212_1:RecordAudio("417082051", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_417082", "417082051", "story_v_out_417082.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_417082", "417082051", "story_v_out_417082.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_9, arg_212_1.talkMaxDuration)

			if var_215_8 <= arg_212_1.time_ and arg_212_1.time_ < var_215_8 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_8) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_8 + var_215_16 and arg_212_1.time_ < var_215_8 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
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

		arg_212_1:InitPlayNodeList()
	end,
	Play417082052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 417082052
		arg_216_1.duration_ = 6.9

		local var_216_0 = {
			zh = 3.366,
			ja = 6.9
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
				arg_216_0:Play417082053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1034 = arg_216_1.actors_["1034"].transform.localPosition
				arg_216_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("1034", 4)

				for iter_219_0 = 0, arg_216_1.actors_["1034"].transform.childCount - 1 do
					local var_219_0 = arg_216_1.actors_["1034"].transform:GetChild(iter_219_0)

					if var_219_0.name == "" or not string.find(var_219_0.name, "split") then
						var_219_0.gameObject:SetActive(true)
					else
						var_219_0.gameObject:SetActive(false)
					end
				end
			end

			local var_219_1 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_1 then
				arg_216_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_216_1.time_ - 0) / var_219_1)
			end

			if arg_216_1.time_ >= 0 + var_219_1 and arg_216_1.time_ < 0 + var_219_1 + arg_219_0 then
				arg_216_1.actors_["1034"].transform.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_219_2 = 0
			local var_219_3 = 0.4

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_2 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_4 = arg_216_1:GetWordFromCfg(417082052)
				local var_219_5 = arg_216_1:FormatText(var_219_4.content)

				arg_216_1.text_.text = var_219_5

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_7 = 16 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_5) / 16)

				if (16 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_5) / 16)) > 0 and var_219_3 < var_219_7 then
					arg_216_1.talkMaxDuration = var_219_7

					if var_219_7 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_2
					end
				end

				arg_216_1.text_.text = var_219_5
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082052", "story_v_out_417082.awb") ~= 0 then
					local var_219_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082052", "story_v_out_417082.awb") / 1000

					if var_219_8 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_2
					end

					if var_219_4.prefab_name ~= "" and arg_216_1.actors_[var_219_4.prefab_name] ~= nil then
						local var_219_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_4.prefab_name].transform, "story_v_out_417082", "417082052", "story_v_out_417082.awb")

						arg_216_1:RecordAudio("417082052", var_219_9)
						arg_216_1:RecordAudio("417082052", var_219_9)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_417082", "417082052", "story_v_out_417082.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_417082", "417082052", "story_v_out_417082.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_3, arg_216_1.talkMaxDuration)

			if var_219_2 <= arg_216_1.time_ and arg_216_1.time_ < var_219_2 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_2) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_2 + var_219_10 and arg_216_1.time_ < var_219_2 + var_219_10 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
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

		arg_216_1:InitPlayNodeList()
	end,
	Play417082053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 417082053
		arg_220_1.duration_ = 7.43

		local var_220_0 = {
			zh = 6.833,
			ja = 7.433
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
				arg_220_0:Play417082054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["1028"]) and arg_220_1.var_.actorSpriteComps1028 == nil then
				arg_220_1.var_.actorSpriteComps1028 = arg_220_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_0 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["1028"]) then
				if arg_220_1.var_.actorSpriteComps1028 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["1028"]) and arg_220_1.var_.actorSpriteComps1028 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_223_3 then
						iter_223_3.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_220_1.var_.actorSpriteComps1028 = nil
			end

			local var_223_2 = arg_220_1.actors_["1034"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.actorSpriteComps1034 == nil then
				arg_220_1.var_.actorSpriteComps1034 = var_223_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_3 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_3 and not isNil(var_223_2) then
				if arg_220_1.var_.actorSpriteComps1034 then
					for iter_223_4, iter_223_5 in pairs(arg_220_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_220_1.time_ >= 0 + var_223_3 and arg_220_1.time_ < 0 + var_223_3 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.actorSpriteComps1034 then
				for iter_223_6, iter_223_7 in pairs(arg_220_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_223_7 then
						iter_223_7.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_220_1.var_.actorSpriteComps1034 = nil
			end

			local var_223_5 = 0
			local var_223_6 = 0.875

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_7 = arg_220_1:GetWordFromCfg(417082053)
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

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082053", "story_v_out_417082.awb") ~= 0 then
					local var_223_11 = manager.audio:GetVoiceLength("story_v_out_417082", "417082053", "story_v_out_417082.awb") / 1000

					if var_223_11 + var_223_5 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_11 + var_223_5
					end

					if var_223_7.prefab_name ~= "" and arg_220_1.actors_[var_223_7.prefab_name] ~= nil then
						local var_223_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_7.prefab_name].transform, "story_v_out_417082", "417082053", "story_v_out_417082.awb")

						arg_220_1:RecordAudio("417082053", var_223_12)
						arg_220_1:RecordAudio("417082053", var_223_12)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_417082", "417082053", "story_v_out_417082.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_417082", "417082053", "story_v_out_417082.awb")
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
	Play417082054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 417082054
		arg_224_1.duration_ = 9.13

		local var_224_0 = {
			zh = 6.1,
			ja = 9.133
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
				arg_224_0:Play417082055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["10113"]) and arg_224_1.var_.actorSpriteComps10113 == nil then
				arg_224_1.var_.actorSpriteComps10113 = arg_224_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_0 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["10113"]) then
				if arg_224_1.var_.actorSpriteComps10113 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								iter_227_1.color = Color.New(Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor1.r, (arg_224_1.time_ - 0) / var_227_0), Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor1.g, (arg_224_1.time_ - 0) / var_227_0), (Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor1.b, (arg_224_1.time_ - 0) / var_227_0)))
							else
								local var_227_1 = Mathf.Lerp(iter_227_1.color.r, 1, (arg_224_1.time_ - 0) / var_227_0)

								iter_227_1.color = Color.New(var_227_1, var_227_1, var_227_1)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["10113"]) and arg_224_1.var_.actorSpriteComps10113 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_227_3 then
						iter_227_3.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_224_1.var_.actorSpriteComps10113 = nil
			end

			local var_227_2 = arg_224_1.actors_["1028"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.actorSpriteComps1028 == nil then
				arg_224_1.var_.actorSpriteComps1028 = var_227_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_3 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_3 and not isNil(var_227_2) then
				if arg_224_1.var_.actorSpriteComps1028 then
					for iter_227_4, iter_227_5 in pairs(arg_224_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_227_5 then
							if arg_224_1.isInRecall_ then
								iter_227_5.color = Color.New(Mathf.Lerp(iter_227_5.color.r, arg_224_1.hightColor2.r, (arg_224_1.time_ - 0) / var_227_3), Mathf.Lerp(iter_227_5.color.g, arg_224_1.hightColor2.g, (arg_224_1.time_ - 0) / var_227_3), (Mathf.Lerp(iter_227_5.color.b, arg_224_1.hightColor2.b, (arg_224_1.time_ - 0) / var_227_3)))
							else
								local var_227_4 = Mathf.Lerp(iter_227_5.color.r, 0.5, (arg_224_1.time_ - 0) / var_227_3)

								iter_227_5.color = Color.New(var_227_4, var_227_4, var_227_4)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_3 and arg_224_1.time_ < 0 + var_227_3 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.actorSpriteComps1028 then
				for iter_227_6, iter_227_7 in pairs(arg_224_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_227_7 then
						iter_227_7.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_224_1.var_.actorSpriteComps1028 = nil
			end

			local var_227_5 = 0
			local var_227_6 = 0.8

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_7 = arg_224_1:GetWordFromCfg(417082054)
				local var_227_8 = arg_224_1:FormatText(var_227_7.content)

				arg_224_1.text_.text = var_227_8

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_10 = 32 <= 0 and var_227_6 or var_227_6 * (utf8.len(var_227_8) / 32)

				if (32 <= 0 and var_227_6 or var_227_6 * (utf8.len(var_227_8) / 32)) > 0 and var_227_6 < var_227_10 then
					arg_224_1.talkMaxDuration = var_227_10

					if var_227_10 + var_227_5 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_10 + var_227_5
					end
				end

				arg_224_1.text_.text = var_227_8
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082054", "story_v_out_417082.awb") ~= 0 then
					local var_227_11 = manager.audio:GetVoiceLength("story_v_out_417082", "417082054", "story_v_out_417082.awb") / 1000

					if var_227_11 + var_227_5 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_11 + var_227_5
					end

					if var_227_7.prefab_name ~= "" and arg_224_1.actors_[var_227_7.prefab_name] ~= nil then
						local var_227_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_7.prefab_name].transform, "story_v_out_417082", "417082054", "story_v_out_417082.awb")

						arg_224_1:RecordAudio("417082054", var_227_12)
						arg_224_1:RecordAudio("417082054", var_227_12)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_417082", "417082054", "story_v_out_417082.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_417082", "417082054", "story_v_out_417082.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_13 = math.max(var_227_6, arg_224_1.talkMaxDuration)

			if var_227_5 <= arg_224_1.time_ and arg_224_1.time_ < var_227_5 + var_227_13 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_5) / var_227_13

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_5 + var_227_13 and arg_224_1.time_ < var_227_5 + var_227_13 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play417082055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 417082055
		arg_228_1.duration_ = 9.67

		local var_228_0 = {
			zh = 5.6,
			ja = 9.666
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
			arg_228_1.auto_ = false
		end

		function arg_228_1.playNext_(arg_230_0)
			arg_228_1.onStoryFinished_()
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0.725

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_1 = arg_228_1:GetWordFromCfg(417082055)
				local var_231_2 = arg_228_1:FormatText(var_231_1.content)

				arg_228_1.text_.text = var_231_2

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_4 = 29 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 29)

				if (29 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 29)) > 0 and var_231_0 < var_231_4 then
					arg_228_1.talkMaxDuration = var_231_4

					if var_231_4 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_4 + 0
					end
				end

				arg_228_1.text_.text = var_231_2
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082055", "story_v_out_417082.awb") ~= 0 then
					local var_231_5 = manager.audio:GetVoiceLength("story_v_out_417082", "417082055", "story_v_out_417082.awb") / 1000

					if var_231_5 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + 0
					end

					if var_231_1.prefab_name ~= "" and arg_228_1.actors_[var_231_1.prefab_name] ~= nil then
						local var_231_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_1.prefab_name].transform, "story_v_out_417082", "417082055", "story_v_out_417082.awb")

						arg_228_1:RecordAudio("417082055", var_231_6)
						arg_228_1:RecordAudio("417082055", var_231_6)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_417082", "417082055", "story_v_out_417082.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_417082", "417082055", "story_v_out_417082.awb")
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
	assets = {
		"TextureConfig/Background/D06a",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_417082.awb"
	}
}
