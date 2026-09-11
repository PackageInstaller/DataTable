return {
	Play425061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425061001
		arg_1_1.duration_ = 7.84

		local var_1_0 = {
			zh = 5.77500033333333,
			ja = 7.84100033333333
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
				arg_1_0:Play425061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 4.20000033333333 < arg_1_1.time_ and arg_1_1.time_ <= 4.20000033333333 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 4.20000033333333 + 0.3 and arg_1_1.time_ < 4.20000033333333 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "1037"

			if arg_1_1.actors_["1037"] == nil then
				local var_4_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1037")

				if not isNil(var_4_1) then
					local var_4_2 = Object.Instantiate(var_4_1, arg_1_1.canvasGo_.transform)

					var_4_2.transform:SetSiblingIndex(1)

					var_4_2.name = var_4_0
					var_4_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_0] = var_4_2

					if arg_1_1.isInRecall_ then
						for iter_4_0, iter_4_1 in ipairs((var_4_2:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_1.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_3 = arg_1_1.actors_["1037"]

			if 4.20000033333333 < arg_1_1.time_ and arg_1_1.time_ <= 4.20000033333333 + arg_4_0 and not isNil(var_4_3) and arg_1_1.var_.actorSpriteComps1037 == nil then
				arg_1_1.var_.actorSpriteComps1037 = var_4_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_4 = 0.2

			if 4.20000033333333 <= arg_1_1.time_ and arg_1_1.time_ < 4.20000033333333 + var_4_4 and not isNil(var_4_3) then
				if arg_1_1.var_.actorSpriteComps1037 then
					for iter_4_2, iter_4_3 in pairs(arg_1_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_4_3 then
							if arg_1_1.isInRecall_ then
								iter_4_3.color = Color.New(Mathf.Lerp(iter_4_3.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 4.20000033333333) / var_4_4), Mathf.Lerp(iter_4_3.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 4.20000033333333) / var_4_4), (Mathf.Lerp(iter_4_3.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 4.20000033333333) / var_4_4)))
							else
								local var_4_5 = Mathf.Lerp(iter_4_3.color.r, 1, (arg_1_1.time_ - 4.20000033333333) / var_4_4)

								iter_4_3.color = Color.New(var_4_5, var_4_5, var_4_5)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 4.20000033333333 + var_4_4 and arg_1_1.time_ < 4.20000033333333 + var_4_4 + arg_4_0 and not isNil(var_4_3) and arg_1_1.var_.actorSpriteComps1037 then
				for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_4_5 then
						iter_4_5.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1037 = nil
			end

			local var_4_6 = arg_1_1.actors_["1037"].transform

			if 4.20000033333333 < arg_1_1.time_ and arg_1_1.time_ <= 4.20000033333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos1037 = var_4_6.localPosition
				var_4_6.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1037", 3)

				for iter_4_6 = 0, var_4_6.childCount - 1 do
					local var_4_7 = var_4_6:GetChild(iter_4_6)

					if var_4_7.name == "" or not string.find(var_4_7.name, "split") then
						var_4_7.gameObject:SetActive(true)
					else
						var_4_7.gameObject:SetActive(false)
					end
				end
			end

			local var_4_8 = 0.001

			if 4.20000033333333 <= arg_1_1.time_ and arg_1_1.time_ < 4.20000033333333 + var_4_8 then
				var_4_6.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_1_1.time_ - 4.20000033333333) / var_4_8)
			end

			if arg_1_1.time_ >= 4.20000033333333 + var_4_8 and arg_1_1.time_ < 4.20000033333333 + var_4_8 + arg_4_0 then
				var_4_6.localPosition = Vector3.New(0, -430, -55)
			end

			local var_4_9 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST60")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501113).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_9 + 1.999999999999 and arg_1_1.time_ < var_4_9 + 1.999999999999 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_10 = 2.00000033333333

			if 2.00000033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_11 = 1.2

			if var_4_10 <= arg_1_1.time_ and arg_1_1.time_ < var_4_10 + var_4_11 then
				local var_4_12 = Color.New(0, 0, 0)

				var_4_12.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_10) / var_4_11)
				arg_1_1.mask_.color = var_4_12
			end

			if arg_1_1.time_ >= var_4_10 + var_4_11 and arg_1_1.time_ < var_4_10 + var_4_11 + arg_4_0 then
				local var_4_13 = Color.New(0, 0, 0)

				var_4_13.a = 1
				arg_1_1.mask_.color = var_4_13
			end

			local var_4_14 = 3.20000033333333

			if 3.20000033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_15 = 1.2

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				local var_4_16 = Color.New(0, 0, 0)

				var_4_16.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_14) / var_4_15)
				arg_1_1.mask_.color = var_4_16
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				local var_4_17 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_17.a = 0
				arg_1_1.mask_.color = var_4_17
			end

			local var_4_18 = "ST60"

			if arg_1_1.bgs_.ST60 == nil then
				local var_4_19 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_18)
				var_4_19.name = var_4_18
				var_4_19.transform.parent = arg_1_1.stage_.transform
				var_4_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_18] = var_4_19
			end

			if 3.33333332935837e-07 < arg_1_1.time_ and arg_1_1.time_ <= 3.33333332935837e-07 + arg_4_0 then
				local var_4_20 = arg_1_1.bgs_.ST60

				arg_1_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_21 = var_4_20:GetComponent("SpriteRenderer")

				if var_4_21 and var_4_21.sprite then
					local var_4_22 = 2 * (var_4_20.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_20.transform.localScale = Vector3.New(var_4_22 / var_4_21.sprite.bounds.size.y < var_4_22 * manager.ui.mainCameraCom_.aspect / var_4_21.sprite.bounds.size.x and var_4_22 * manager.ui.mainCameraCom_.aspect / var_4_21.sprite.bounds.size.x or var_4_22 / var_4_21.sprite.bounds.size.y, var_4_22 / var_4_21.sprite.bounds.size.y < var_4_22 * manager.ui.mainCameraCom_.aspect / var_4_21.sprite.bounds.size.x and var_4_22 * manager.ui.mainCameraCom_.aspect / var_4_21.sprite.bounds.size.x or var_4_22 / var_4_21.sprite.bounds.size.y, 0)
				end

				for iter_4_7, iter_4_8 in pairs(arg_1_1.bgs_) do
					if iter_4_7 ~= "ST60" then
						iter_4_8.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_25 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_25

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_25
						arg_1_1.bgmTxt2_.text = var_4_25
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

			if 2.9 < arg_1_1.time_ and arg_1_1.time_ <= 2.9 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic.awb")

				local var_4_28 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_28 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_28

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_28
						arg_1_1.bgmTxt2_.text = var_4_28
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

			if 2.9 < arg_1_1.time_ and arg_1_1.time_ <= 2.9 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_147", "se_story_147_amb_rooftop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_30 = 4.37500033333333
			local var_4_31 = 0.125

			if 4.37500033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_32 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_32:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_33 = arg_1_1:GetWordFromCfg(425061001)
				local var_4_34 = arg_1_1:FormatText(var_4_33.content)

				arg_1_1.text_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_36 = 5 <= 0 and var_4_31 or var_4_31 * (utf8.len(var_4_34) / 5)

				if (5 <= 0 and var_4_31 or var_4_31 * (utf8.len(var_4_34) / 5)) > 0 and var_4_31 < var_4_36 then
					arg_1_1.talkMaxDuration = var_4_36
					var_4_30 = var_4_30 + 0.3

					if var_4_36 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_36 + var_4_30
					end
				end

				arg_1_1.text_.text = var_4_34
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061001", "story_v_out_425061.awb") ~= 0 then
					local var_4_37 = manager.audio:GetVoiceLength("story_v_out_425061", "425061001", "story_v_out_425061.awb") / 1000

					if var_4_37 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_30
					end

					if var_4_33.prefab_name ~= "" and arg_1_1.actors_[var_4_33.prefab_name] ~= nil then
						local var_4_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_33.prefab_name].transform, "story_v_out_425061", "425061001", "story_v_out_425061.awb")

						arg_1_1:RecordAudio("425061001", var_4_38)
						arg_1_1:RecordAudio("425061001", var_4_38)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_425061", "425061001", "story_v_out_425061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_425061", "425061001", "story_v_out_425061.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_39 = var_4_30 + 0.3
			local var_4_40 = math.max(var_4_31, arg_1_1.talkMaxDuration)

			if var_4_30 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_39) / var_4_40

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4.20000033333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play425061002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 425061002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play425061003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos1037 = arg_10_1.actors_["1037"].transform.localPosition
				arg_10_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("1037", 7)

				for iter_13_0 = 0, arg_10_1.actors_["1037"].transform.childCount - 1 do
					local var_13_0 = arg_10_1.actors_["1037"].transform:GetChild(iter_13_0)

					if var_13_0.name == "" or not string.find(var_13_0.name, "split") then
						var_13_0.gameObject:SetActive(true)
					else
						var_13_0.gameObject:SetActive(false)
					end
				end
			end

			local var_13_1 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_1 then
				arg_10_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_10_1.time_ - 0) / var_13_1)
			end

			if arg_10_1.time_ >= 0 + var_13_1 and arg_10_1.time_ < 0 + var_13_1 + arg_13_0 then
				arg_10_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_13_2 = 0
			local var_13_3 = 0.75

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

				local var_13_4 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(425061002).content)

				arg_10_1.text_.text = var_13_4

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_6 = 30 <= 0 and var_13_3 or var_13_3 * (utf8.len(var_13_4) / 30)

				if (30 <= 0 and var_13_3 or var_13_3 * (utf8.len(var_13_4) / 30)) > 0 and var_13_3 < var_13_6 then
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
				actorName = "1037",
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
	Play425061003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 425061003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play425061004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0.975

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_1 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(425061003).content)

				arg_14_1.text_.text = var_17_1

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_3 = 39 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 39)

				if (39 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 39)) > 0 and var_17_0 < var_17_3 then
					arg_14_1.talkMaxDuration = var_17_3

					if var_17_3 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_3 + 0
					end
				end

				arg_14_1.text_.text = var_17_1
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_4 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_4 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_4

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_4 and arg_14_1.time_ < 0 + var_17_4 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play425061004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 425061004
		arg_18_1.duration_ = 3.73

		local var_18_0 = {
			zh = 2.266,
			ja = 3.733
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
				arg_18_0:Play425061005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(arg_18_1.actors_["1037"]) and arg_18_1.var_.actorSpriteComps1037 == nil then
				arg_18_1.var_.actorSpriteComps1037 = arg_18_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_0 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 and not isNil(arg_18_1.actors_["1037"]) then
				if arg_18_1.var_.actorSpriteComps1037 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 and not isNil(arg_18_1.actors_["1037"]) and arg_18_1.var_.actorSpriteComps1037 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_21_3 then
						iter_21_3.color = arg_18_1.isInRecall_ and (arg_18_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_18_1.var_.actorSpriteComps1037 = nil
			end

			local var_21_2 = arg_18_1.actors_["1037"].transform

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos1037 = var_21_2.localPosition
				var_21_2.localScale = Vector3.New(1, 1, 1)

				arg_18_1:CheckSpriteTmpPos("1037", 3)

				for iter_21_4 = 0, var_21_2.childCount - 1 do
					local var_21_3 = var_21_2:GetChild(iter_21_4)

					if var_21_3.name == "split_5" or not string.find(var_21_3.name, "split") then
						var_21_3.gameObject:SetActive(true)
					else
						var_21_3.gameObject:SetActive(false)
					end
				end
			end

			local var_21_4 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_4 then
				var_21_2.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_18_1.time_ - 0) / var_21_4)
			end

			if arg_18_1.time_ >= 0 + var_21_4 and arg_18_1.time_ < 0 + var_21_4 + arg_21_0 then
				var_21_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_21_5 = 0
			local var_21_6 = 0.225

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_5 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_7 = arg_18_1:GetWordFromCfg(425061004)
				local var_21_8 = arg_18_1:FormatText(var_21_7.content)

				arg_18_1.text_.text = var_21_8

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_10 = 9 <= 0 and var_21_6 or var_21_6 * (utf8.len(var_21_8) / 9)

				if (9 <= 0 and var_21_6 or var_21_6 * (utf8.len(var_21_8) / 9)) > 0 and var_21_6 < var_21_10 then
					arg_18_1.talkMaxDuration = var_21_10

					if var_21_10 + var_21_5 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_10 + var_21_5
					end
				end

				arg_18_1.text_.text = var_21_8
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061004", "story_v_out_425061.awb") ~= 0 then
					local var_21_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061004", "story_v_out_425061.awb") / 1000

					if var_21_11 + var_21_5 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_11 + var_21_5
					end

					if var_21_7.prefab_name ~= "" and arg_18_1.actors_[var_21_7.prefab_name] ~= nil then
						local var_21_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_7.prefab_name].transform, "story_v_out_425061", "425061004", "story_v_out_425061.awb")

						arg_18_1:RecordAudio("425061004", var_21_12)
						arg_18_1:RecordAudio("425061004", var_21_12)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_425061", "425061004", "story_v_out_425061.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_425061", "425061004", "story_v_out_425061.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_13 = math.max(var_21_6, arg_18_1.talkMaxDuration)

			if var_21_5 <= arg_18_1.time_ and arg_18_1.time_ < var_21_5 + var_21_13 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_5) / var_21_13

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_5 + var_21_13 and arg_18_1.time_ < var_21_5 + var_21_13 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 425061005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play425061006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(arg_22_1.actors_["1037"]) and arg_22_1.var_.actorSpriteComps1037 == nil then
				arg_22_1.var_.actorSpriteComps1037 = arg_22_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_0 = 0.2

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 and not isNil(arg_22_1.actors_["1037"]) then
				if arg_22_1.var_.actorSpriteComps1037 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 and not isNil(arg_22_1.actors_["1037"]) and arg_22_1.var_.actorSpriteComps1037 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_25_3 then
						iter_25_3.color = arg_22_1.isInRecall_ and (arg_22_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_22_1.var_.actorSpriteComps1037 = nil
			end

			local var_25_2 = 0
			local var_25_3 = 0.95

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_4 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(425061005).content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_6 = 38 <= 0 and var_25_3 or var_25_3 * (utf8.len(var_25_4) / 38)

				if (38 <= 0 and var_25_3 or var_25_3 * (utf8.len(var_25_4) / 38)) > 0 and var_25_3 < var_25_6 then
					arg_22_1.talkMaxDuration = var_25_6

					if var_25_6 + var_25_2 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_6 + var_25_2
					end
				end

				arg_22_1.text_.text = var_25_4
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_7 = math.max(var_25_3, arg_22_1.talkMaxDuration)

			if var_25_2 <= arg_22_1.time_ and arg_22_1.time_ < var_25_2 + var_25_7 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_2) / var_25_7

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_2 + var_25_7 and arg_22_1.time_ < var_25_2 + var_25_7 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play425061006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 425061006
		arg_26_1.duration_ = 8.8

		local var_26_0 = {
			zh = 4.9,
			ja = 8.8
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
				arg_26_0:Play425061007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["1037"]) and arg_26_1.var_.actorSpriteComps1037 == nil then
				arg_26_1.var_.actorSpriteComps1037 = arg_26_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_0 = 0.2

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["1037"]) then
				if arg_26_1.var_.actorSpriteComps1037 then
					for iter_29_0, iter_29_1 in pairs(arg_26_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["1037"]) and arg_26_1.var_.actorSpriteComps1037 then
				for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_29_3 then
						iter_29_3.color = arg_26_1.isInRecall_ and (arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_26_1.var_.actorSpriteComps1037 = nil
			end

			local var_29_2 = arg_26_1.actors_["1037"].transform

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos1037 = var_29_2.localPosition
				var_29_2.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("1037", 3)

				for iter_29_4 = 0, var_29_2.childCount - 1 do
					local var_29_3 = var_29_2:GetChild(iter_29_4)

					if var_29_3.name == "split_4" then
						var_29_3:SetAsLastSibling()
						var_29_3.gameObject:SetActive(true)

						arg_26_1.var_.actorSpriteSplit1037 = var_29_3.gameObject:GetComponent(typeof(Image))

						arg_26_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_29_4 = 0.5

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_4 then
				var_29_2.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_26_1.time_ - 0) / var_29_4)

				if arg_26_1.var_.actorSpriteSplit1037 ~= nil then
					arg_26_1.var_.actorSpriteSplit1037:SetAlpha((arg_26_1.time_ - 0) / var_29_4)
				end
			end

			if arg_26_1.time_ >= 0 + var_29_4 and arg_26_1.time_ < 0 + var_29_4 + arg_29_0 then
				var_29_2.localPosition = Vector3.New(0, -430, -55)

				if arg_26_1.var_.actorSpriteSplit1037 ~= nil then
					arg_26_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_29_5 = 0
			local var_29_6 = 0.5

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_5 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_7 = arg_26_1:GetWordFromCfg(425061006)
				local var_29_8 = arg_26_1:FormatText(var_29_7.content)

				arg_26_1.text_.text = var_29_8

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_10 = 20 <= 0 and var_29_6 or var_29_6 * (utf8.len(var_29_8) / 20)

				if (20 <= 0 and var_29_6 or var_29_6 * (utf8.len(var_29_8) / 20)) > 0 and var_29_6 < var_29_10 then
					arg_26_1.talkMaxDuration = var_29_10

					if var_29_10 + var_29_5 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_10 + var_29_5
					end
				end

				arg_26_1.text_.text = var_29_8
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061006", "story_v_out_425061.awb") ~= 0 then
					local var_29_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061006", "story_v_out_425061.awb") / 1000

					if var_29_11 + var_29_5 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_11 + var_29_5
					end

					if var_29_7.prefab_name ~= "" and arg_26_1.actors_[var_29_7.prefab_name] ~= nil then
						local var_29_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_7.prefab_name].transform, "story_v_out_425061", "425061006", "story_v_out_425061.awb")

						arg_26_1:RecordAudio("425061006", var_29_12)
						arg_26_1:RecordAudio("425061006", var_29_12)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_425061", "425061006", "story_v_out_425061.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_425061", "425061006", "story_v_out_425061.awb")
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
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play425061007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 425061007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play425061008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["1037"]) and arg_30_1.var_.actorSpriteComps1037 == nil then
				arg_30_1.var_.actorSpriteComps1037 = arg_30_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["1037"]) then
				if arg_30_1.var_.actorSpriteComps1037 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["1037"]) and arg_30_1.var_.actorSpriteComps1037 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_30_1.var_.actorSpriteComps1037 = nil
			end

			local var_33_2 = 0
			local var_33_3 = 0.25

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_4 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(425061007).content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_6 = 10 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_4) / 10)

				if (10 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_4) / 10)) > 0 and var_33_3 < var_33_6 then
					arg_30_1.talkMaxDuration = var_33_6

					if var_33_6 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_6 + var_33_2
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_7 = math.max(var_33_3, arg_30_1.talkMaxDuration)

			if var_33_2 <= arg_30_1.time_ and arg_30_1.time_ < var_33_2 + var_33_7 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_2) / var_33_7

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_2 + var_33_7 and arg_30_1.time_ < var_33_2 + var_33_7 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play425061008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 425061008
		arg_34_1.duration_ = 8.3

		local var_34_0 = {
			zh = 7.1,
			ja = 8.3
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
				arg_34_0:Play425061009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["1037"]) and arg_34_1.var_.actorSpriteComps1037 == nil then
				arg_34_1.var_.actorSpriteComps1037 = arg_34_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_0 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["1037"]) then
				if arg_34_1.var_.actorSpriteComps1037 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["1037"]) and arg_34_1.var_.actorSpriteComps1037 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_37_3 then
						iter_37_3.color = arg_34_1.isInRecall_ and (arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_34_1.var_.actorSpriteComps1037 = nil
			end

			local var_37_2 = arg_34_1.actors_["1037"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1037 = var_37_2.localPosition
				var_37_2.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1037", 3)

				for iter_37_4 = 0, var_37_2.childCount - 1 do
					local var_37_3 = var_37_2:GetChild(iter_37_4)

					if var_37_3.name == "split_1" then
						var_37_3:SetAsLastSibling()
						var_37_3.gameObject:SetActive(true)

						arg_34_1.var_.actorSpriteSplit1037 = var_37_3.gameObject:GetComponent(typeof(Image))

						arg_34_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_37_4 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				var_37_2.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_34_1.time_ - 0) / var_37_4)

				if arg_34_1.var_.actorSpriteSplit1037 ~= nil then
					arg_34_1.var_.actorSpriteSplit1037:SetAlpha((arg_34_1.time_ - 0) / var_37_4)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				var_37_2.localPosition = Vector3.New(0, -430, -55)

				if arg_34_1.var_.actorSpriteSplit1037 ~= nil then
					arg_34_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_37_5 = 0
			local var_37_6 = 0.85

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_7 = arg_34_1:GetWordFromCfg(425061008)
				local var_37_8 = arg_34_1:FormatText(var_37_7.content)

				arg_34_1.text_.text = var_37_8

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_10 = 34 <= 0 and var_37_6 or var_37_6 * (utf8.len(var_37_8) / 34)

				if (34 <= 0 and var_37_6 or var_37_6 * (utf8.len(var_37_8) / 34)) > 0 and var_37_6 < var_37_10 then
					arg_34_1.talkMaxDuration = var_37_10

					if var_37_10 + var_37_5 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_10 + var_37_5
					end
				end

				arg_34_1.text_.text = var_37_8
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061008", "story_v_out_425061.awb") ~= 0 then
					local var_37_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061008", "story_v_out_425061.awb") / 1000

					if var_37_11 + var_37_5 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_11 + var_37_5
					end

					if var_37_7.prefab_name ~= "" and arg_34_1.actors_[var_37_7.prefab_name] ~= nil then
						local var_37_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_7.prefab_name].transform, "story_v_out_425061", "425061008", "story_v_out_425061.awb")

						arg_34_1:RecordAudio("425061008", var_37_12)
						arg_34_1:RecordAudio("425061008", var_37_12)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_425061", "425061008", "story_v_out_425061.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_425061", "425061008", "story_v_out_425061.awb")
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
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play425061009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 425061009
		arg_38_1.duration_ = 13.4

		local var_38_0 = {
			zh = 10.433,
			ja = 13.4
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
				arg_38_0:Play425061010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 1.125

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:GetWordFromCfg(425061009)
				local var_41_2 = arg_38_1:FormatText(var_41_1.content)

				arg_38_1.text_.text = var_41_2

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 45 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 45)

				if (45 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 45)) > 0 and var_41_0 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end

				arg_38_1.text_.text = var_41_2
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061009", "story_v_out_425061.awb") ~= 0 then
					local var_41_5 = manager.audio:GetVoiceLength("story_v_out_425061", "425061009", "story_v_out_425061.awb") / 1000

					if var_41_5 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + 0
					end

					if var_41_1.prefab_name ~= "" and arg_38_1.actors_[var_41_1.prefab_name] ~= nil then
						local var_41_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_1.prefab_name].transform, "story_v_out_425061", "425061009", "story_v_out_425061.awb")

						arg_38_1:RecordAudio("425061009", var_41_6)
						arg_38_1:RecordAudio("425061009", var_41_6)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_425061", "425061009", "story_v_out_425061.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_425061", "425061009", "story_v_out_425061.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_7 and arg_38_1.time_ < 0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play425061010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 425061010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play425061011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1037"]) and arg_42_1.var_.actorSpriteComps1037 == nil then
				arg_42_1.var_.actorSpriteComps1037 = arg_42_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_0 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1037"]) then
				if arg_42_1.var_.actorSpriteComps1037 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1037"]) and arg_42_1.var_.actorSpriteComps1037 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_45_3 then
						iter_45_3.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_42_1.var_.actorSpriteComps1037 = nil
			end

			local var_45_2 = 0
			local var_45_3 = 0.35

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_4 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(425061010).content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_6 = 14 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_4) / 14)

				if (14 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_4) / 14)) > 0 and var_45_3 < var_45_6 then
					arg_42_1.talkMaxDuration = var_45_6

					if var_45_6 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_6 + var_45_2
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_7 = math.max(var_45_3, arg_42_1.talkMaxDuration)

			if var_45_2 <= arg_42_1.time_ and arg_42_1.time_ < var_45_2 + var_45_7 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_2) / var_45_7

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_2 + var_45_7 and arg_42_1.time_ < var_45_2 + var_45_7 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play425061011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 425061011
		arg_46_1.duration_ = 9.23

		local var_46_0 = {
			zh = 5.866,
			ja = 9.233
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
				arg_46_0:Play425061012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1037"]) and arg_46_1.var_.actorSpriteComps1037 == nil then
				arg_46_1.var_.actorSpriteComps1037 = arg_46_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1037"]) then
				if arg_46_1.var_.actorSpriteComps1037 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1037"]) and arg_46_1.var_.actorSpriteComps1037 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_49_3 then
						iter_49_3.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_46_1.var_.actorSpriteComps1037 = nil
			end

			local var_49_2 = arg_46_1.actors_["1037"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1037 = var_49_2.localPosition
				var_49_2.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1037", 3)

				for iter_49_4 = 0, var_49_2.childCount - 1 do
					local var_49_3 = var_49_2:GetChild(iter_49_4)

					if var_49_3.name == "split_4" then
						var_49_3:SetAsLastSibling()
						var_49_3.gameObject:SetActive(true)

						arg_46_1.var_.actorSpriteSplit1037 = var_49_3.gameObject:GetComponent(typeof(Image))

						arg_46_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_49_4 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				var_49_2.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_46_1.time_ - 0) / var_49_4)

				if arg_46_1.var_.actorSpriteSplit1037 ~= nil then
					arg_46_1.var_.actorSpriteSplit1037:SetAlpha((arg_46_1.time_ - 0) / var_49_4)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				var_49_2.localPosition = Vector3.New(0, -430, -55)

				if arg_46_1.var_.actorSpriteSplit1037 ~= nil then
					arg_46_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_49_5 = 0
			local var_49_6 = 0.55

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_7 = arg_46_1:GetWordFromCfg(425061011)
				local var_49_8 = arg_46_1:FormatText(var_49_7.content)

				arg_46_1.text_.text = var_49_8

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_10 = 22 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_8) / 22)

				if (22 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_8) / 22)) > 0 and var_49_6 < var_49_10 then
					arg_46_1.talkMaxDuration = var_49_10

					if var_49_10 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_10 + var_49_5
					end
				end

				arg_46_1.text_.text = var_49_8
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061011", "story_v_out_425061.awb") ~= 0 then
					local var_49_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061011", "story_v_out_425061.awb") / 1000

					if var_49_11 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_11 + var_49_5
					end

					if var_49_7.prefab_name ~= "" and arg_46_1.actors_[var_49_7.prefab_name] ~= nil then
						local var_49_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_7.prefab_name].transform, "story_v_out_425061", "425061011", "story_v_out_425061.awb")

						arg_46_1:RecordAudio("425061011", var_49_12)
						arg_46_1:RecordAudio("425061011", var_49_12)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_425061", "425061011", "story_v_out_425061.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_425061", "425061011", "story_v_out_425061.awb")
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
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play425061012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 425061012
		arg_50_1.duration_ = 15.2

		local var_50_0 = {
			zh = 10.666,
			ja = 15.2
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
				arg_50_0:Play425061013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 1.075

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_1 = arg_50_1:GetWordFromCfg(425061012)
				local var_53_2 = arg_50_1:FormatText(var_53_1.content)

				arg_50_1.text_.text = var_53_2

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 43 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 43)

				if (43 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 43)) > 0 and var_53_0 < var_53_4 then
					arg_50_1.talkMaxDuration = var_53_4

					if var_53_4 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_4 + 0
					end
				end

				arg_50_1.text_.text = var_53_2
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061012", "story_v_out_425061.awb") ~= 0 then
					local var_53_5 = manager.audio:GetVoiceLength("story_v_out_425061", "425061012", "story_v_out_425061.awb") / 1000

					if var_53_5 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + 0
					end

					if var_53_1.prefab_name ~= "" and arg_50_1.actors_[var_53_1.prefab_name] ~= nil then
						local var_53_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_1.prefab_name].transform, "story_v_out_425061", "425061012", "story_v_out_425061.awb")

						arg_50_1:RecordAudio("425061012", var_53_6)
						arg_50_1:RecordAudio("425061012", var_53_6)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_425061", "425061012", "story_v_out_425061.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_425061", "425061012", "story_v_out_425061.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play425061013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 425061013
		arg_54_1.duration_ = 10.03

		local var_54_0 = {
			zh = 8.3,
			ja = 10.033
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
				arg_54_0:Play425061014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.625

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_1 = arg_54_1:GetWordFromCfg(425061013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 25 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 25)

				if (25 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 25)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061013", "story_v_out_425061.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_425061", "425061013", "story_v_out_425061.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_425061", "425061013", "story_v_out_425061.awb")

						arg_54_1:RecordAudio("425061013", var_57_6)
						arg_54_1:RecordAudio("425061013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_425061", "425061013", "story_v_out_425061.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_425061", "425061013", "story_v_out_425061.awb")
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
	Play425061014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 425061014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play425061015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1037"]) and arg_58_1.var_.actorSpriteComps1037 == nil then
				arg_58_1.var_.actorSpriteComps1037 = arg_58_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1037"]) then
				if arg_58_1.var_.actorSpriteComps1037 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1037"]) and arg_58_1.var_.actorSpriteComps1037 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps1037 = nil
			end

			local var_61_2 = 0
			local var_61_3 = 0.925

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_4 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(425061014).content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_6 = 37 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_4) / 37)

				if (37 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_4) / 37)) > 0 and var_61_3 < var_61_6 then
					arg_58_1.talkMaxDuration = var_61_6

					if var_61_6 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_7 and arg_58_1.time_ < var_61_2 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play425061015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 425061015
		arg_62_1.duration_ = 11.5

		local var_62_0 = {
			zh = 6.5,
			ja = 11.5
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
				arg_62_0:Play425061016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1037"]) and arg_62_1.var_.actorSpriteComps1037 == nil then
				arg_62_1.var_.actorSpriteComps1037 = arg_62_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_0 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1037"]) then
				if arg_62_1.var_.actorSpriteComps1037 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1037"]) and arg_62_1.var_.actorSpriteComps1037 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_65_3 then
						iter_65_3.color = arg_62_1.isInRecall_ and (arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_62_1.var_.actorSpriteComps1037 = nil
			end

			local var_65_2 = 0
			local var_65_3 = 0.75

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_4 = arg_62_1:GetWordFromCfg(425061015)
				local var_65_5 = arg_62_1:FormatText(var_65_4.content)

				arg_62_1.text_.text = var_65_5

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_7 = 30 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 30)

				if (30 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 30)) > 0 and var_65_3 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_5
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061015", "story_v_out_425061.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_425061", "425061015", "story_v_out_425061.awb") / 1000

					if var_65_8 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_2
					end

					if var_65_4.prefab_name ~= "" and arg_62_1.actors_[var_65_4.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_4.prefab_name].transform, "story_v_out_425061", "425061015", "story_v_out_425061.awb")

						arg_62_1:RecordAudio("425061015", var_65_9)
						arg_62_1:RecordAudio("425061015", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_425061", "425061015", "story_v_out_425061.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_425061", "425061015", "story_v_out_425061.awb")
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
	Play425061016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 425061016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play425061017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1037"]) and arg_66_1.var_.actorSpriteComps1037 == nil then
				arg_66_1.var_.actorSpriteComps1037 = arg_66_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1037"]) then
				if arg_66_1.var_.actorSpriteComps1037 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1037"]) and arg_66_1.var_.actorSpriteComps1037 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_69_3 then
						iter_69_3.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_66_1.var_.actorSpriteComps1037 = nil
			end

			local var_69_2 = 0
			local var_69_3 = 0.825

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_4 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(425061016).content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_6 = 33 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_4) / 33)

				if (33 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_4) / 33)) > 0 and var_69_3 < var_69_6 then
					arg_66_1.talkMaxDuration = var_69_6

					if var_69_6 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_2
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_3, arg_66_1.talkMaxDuration)

			if var_69_2 <= arg_66_1.time_ and arg_66_1.time_ < var_69_2 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_2) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_2 + var_69_7 and arg_66_1.time_ < var_69_2 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play425061017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 425061017
		arg_70_1.duration_ = 4.9

		local var_70_0 = {
			zh = 3.1,
			ja = 4.9
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
				arg_70_0:Play425061018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1037"]) and arg_70_1.var_.actorSpriteComps1037 == nil then
				arg_70_1.var_.actorSpriteComps1037 = arg_70_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_0 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1037"]) then
				if arg_70_1.var_.actorSpriteComps1037 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1037"]) and arg_70_1.var_.actorSpriteComps1037 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_73_3 then
						iter_73_3.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_70_1.var_.actorSpriteComps1037 = nil
			end

			local var_73_2 = arg_70_1.actors_["1037"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1037 = var_73_2.localPosition
				var_73_2.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1037", 3)

				for iter_73_4 = 0, var_73_2.childCount - 1 do
					local var_73_3 = var_73_2:GetChild(iter_73_4)

					if var_73_3.name == "split_3" then
						var_73_3:SetAsLastSibling()
						var_73_3.gameObject:SetActive(true)

						arg_70_1.var_.actorSpriteSplit1037 = var_73_3.gameObject:GetComponent(typeof(Image))

						arg_70_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_73_4 = 0.5

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				var_73_2.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_70_1.time_ - 0) / var_73_4)

				if arg_70_1.var_.actorSpriteSplit1037 ~= nil then
					arg_70_1.var_.actorSpriteSplit1037:SetAlpha((arg_70_1.time_ - 0) / var_73_4)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				var_73_2.localPosition = Vector3.New(0, -430, -55)

				if arg_70_1.var_.actorSpriteSplit1037 ~= nil then
					arg_70_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_73_5 = 0
			local var_73_6 = 0.25

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_7 = arg_70_1:GetWordFromCfg(425061017)
				local var_73_8 = arg_70_1:FormatText(var_73_7.content)

				arg_70_1.text_.text = var_73_8

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_10 = 10 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_8) / 10)

				if (10 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_8) / 10)) > 0 and var_73_6 < var_73_10 then
					arg_70_1.talkMaxDuration = var_73_10

					if var_73_10 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_5
					end
				end

				arg_70_1.text_.text = var_73_8
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061017", "story_v_out_425061.awb") ~= 0 then
					local var_73_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061017", "story_v_out_425061.awb") / 1000

					if var_73_11 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_5
					end

					if var_73_7.prefab_name ~= "" and arg_70_1.actors_[var_73_7.prefab_name] ~= nil then
						local var_73_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_7.prefab_name].transform, "story_v_out_425061", "425061017", "story_v_out_425061.awb")

						arg_70_1:RecordAudio("425061017", var_73_12)
						arg_70_1:RecordAudio("425061017", var_73_12)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_425061", "425061017", "story_v_out_425061.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_425061", "425061017", "story_v_out_425061.awb")
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

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play425061018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 425061018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play425061019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1037"]) and arg_74_1.var_.actorSpriteComps1037 == nil then
				arg_74_1.var_.actorSpriteComps1037 = arg_74_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_0 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1037"]) then
				if arg_74_1.var_.actorSpriteComps1037 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								iter_77_1.color = Color.New(Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor2.r, (arg_74_1.time_ - 0) / var_77_0), Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor2.g, (arg_74_1.time_ - 0) / var_77_0), (Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor2.b, (arg_74_1.time_ - 0) / var_77_0)))
							else
								local var_77_1 = Mathf.Lerp(iter_77_1.color.r, 0.5, (arg_74_1.time_ - 0) / var_77_0)

								iter_77_1.color = Color.New(var_77_1, var_77_1, var_77_1)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1037"]) and arg_74_1.var_.actorSpriteComps1037 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_77_3 then
						iter_77_3.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_74_1.var_.actorSpriteComps1037 = nil
			end

			local var_77_2 = 0
			local var_77_3 = 0.1

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_4 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(425061018).content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_6 = 4 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 4)

				if (4 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 4)) > 0 and var_77_3 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_3, arg_74_1.talkMaxDuration)

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_2) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_2 + var_77_7 and arg_74_1.time_ < var_77_2 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play425061019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 425061019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play425061020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1037 = arg_78_1.actors_["1037"].transform.localPosition
				arg_78_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1037", 7)

				for iter_81_0 = 0, arg_78_1.actors_["1037"].transform.childCount - 1 do
					local var_81_0 = arg_78_1.actors_["1037"].transform:GetChild(iter_81_0)

					if var_81_0.name == "" or not string.find(var_81_0.name, "split") then
						var_81_0.gameObject:SetActive(true)
					else
						var_81_0.gameObject:SetActive(false)
					end
				end
			end

			local var_81_1 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_1 then
				arg_78_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_78_1.time_ - 0) / var_81_1)
			end

			if arg_78_1.time_ >= 0 + var_81_1 and arg_78_1.time_ < 0 + var_81_1 + arg_81_0 then
				arg_78_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			if 0.533333333333333 < arg_78_1.time_ and arg_78_1.time_ <= 0.533333333333333 + arg_81_0 then
				arg_78_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_81_3 = 0
			local var_81_4 = 1.65

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_3 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_5 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(425061019).content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 66 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 66)

				if (66 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 66)) > 0 and var_81_4 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_3 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_3
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_8 = math.max(var_81_4, arg_78_1.talkMaxDuration)

			if var_81_3 <= arg_78_1.time_ and arg_78_1.time_ < var_81_3 + var_81_8 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_3) / var_81_8

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_3 + var_81_8 and arg_78_1.time_ < var_81_3 + var_81_8 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 425061020
		arg_82_1.duration_ = 3.73

		local var_82_0 = {
			zh = 1.7,
			ja = 3.733
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
				arg_82_0:Play425061021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["1037"]) and arg_82_1.var_.actorSpriteComps1037 == nil then
				arg_82_1.var_.actorSpriteComps1037 = arg_82_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_0 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["1037"]) then
				if arg_82_1.var_.actorSpriteComps1037 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["1037"]) and arg_82_1.var_.actorSpriteComps1037 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_85_3 then
						iter_85_3.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_82_1.var_.actorSpriteComps1037 = nil
			end

			local var_85_2 = arg_82_1.actors_["1037"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1037 = var_85_2.localPosition
				var_85_2.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("1037", 3)

				for iter_85_4 = 0, var_85_2.childCount - 1 do
					local var_85_3 = var_85_2:GetChild(iter_85_4)

					if var_85_3.name == "" or not string.find(var_85_3.name, "split") then
						var_85_3.gameObject:SetActive(true)
					else
						var_85_3.gameObject:SetActive(false)
					end
				end
			end

			local var_85_4 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 then
				var_85_2.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_82_1.time_ - 0) / var_85_4)
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 then
				var_85_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_85_5 = 0
			local var_85_6 = 0.125

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_7 = arg_82_1:GetWordFromCfg(425061020)
				local var_85_8 = arg_82_1:FormatText(var_85_7.content)

				arg_82_1.text_.text = var_85_8

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_10 = 5 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_8) / 5)

				if (5 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_8) / 5)) > 0 and var_85_6 < var_85_10 then
					arg_82_1.talkMaxDuration = var_85_10

					if var_85_10 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_5
					end
				end

				arg_82_1.text_.text = var_85_8
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061020", "story_v_out_425061.awb") ~= 0 then
					local var_85_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061020", "story_v_out_425061.awb") / 1000

					if var_85_11 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_5
					end

					if var_85_7.prefab_name ~= "" and arg_82_1.actors_[var_85_7.prefab_name] ~= nil then
						local var_85_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_7.prefab_name].transform, "story_v_out_425061", "425061020", "story_v_out_425061.awb")

						arg_82_1:RecordAudio("425061020", var_85_12)
						arg_82_1:RecordAudio("425061020", var_85_12)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_425061", "425061020", "story_v_out_425061.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_425061", "425061020", "story_v_out_425061.awb")
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

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 425061021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play425061022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1037"]) and arg_86_1.var_.actorSpriteComps1037 == nil then
				arg_86_1.var_.actorSpriteComps1037 = arg_86_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1037"]) then
				if arg_86_1.var_.actorSpriteComps1037 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1037"]) and arg_86_1.var_.actorSpriteComps1037 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_89_3 then
						iter_89_3.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_86_1.var_.actorSpriteComps1037 = nil
			end

			local var_89_2 = 0
			local var_89_3 = 0.275

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_2 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_4 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(425061021).content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_6 = 11 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_4) / 11)

				if (11 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_4) / 11)) > 0 and var_89_3 < var_89_6 then
					arg_86_1.talkMaxDuration = var_89_6

					if var_89_6 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_6 + var_89_2
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_3, arg_86_1.talkMaxDuration)

			if var_89_2 <= arg_86_1.time_ and arg_86_1.time_ < var_89_2 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_2) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_2 + var_89_7 and arg_86_1.time_ < var_89_2 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play425061022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 425061022
		arg_90_1.duration_ = 8.17

		local var_90_0 = {
			zh = 6.2,
			ja = 8.166
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
				arg_90_0:Play425061023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1037"]) and arg_90_1.var_.actorSpriteComps1037 == nil then
				arg_90_1.var_.actorSpriteComps1037 = arg_90_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1037"]) then
				if arg_90_1.var_.actorSpriteComps1037 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1037"]) and arg_90_1.var_.actorSpriteComps1037 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_90_1.var_.actorSpriteComps1037 = nil
			end

			local var_93_2 = arg_90_1.actors_["1037"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1037 = var_93_2.localPosition
				var_93_2.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("1037", 3)

				for iter_93_4 = 0, var_93_2.childCount - 1 do
					local var_93_3 = var_93_2:GetChild(iter_93_4)

					if var_93_3.name == "split_4" then
						var_93_3:SetAsLastSibling()
						var_93_3.gameObject:SetActive(true)

						arg_90_1.var_.actorSpriteSplit1037 = var_93_3.gameObject:GetComponent(typeof(Image))

						arg_90_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_93_4 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				var_93_2.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_90_1.time_ - 0) / var_93_4)

				if arg_90_1.var_.actorSpriteSplit1037 ~= nil then
					arg_90_1.var_.actorSpriteSplit1037:SetAlpha((arg_90_1.time_ - 0) / var_93_4)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				var_93_2.localPosition = Vector3.New(0, -430, -55)

				if arg_90_1.var_.actorSpriteSplit1037 ~= nil then
					arg_90_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_93_5 = 0
			local var_93_6 = 0.6

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_7 = arg_90_1:GetWordFromCfg(425061022)
				local var_93_8 = arg_90_1:FormatText(var_93_7.content)

				arg_90_1.text_.text = var_93_8

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_10 = 24 <= 0 and var_93_6 or var_93_6 * (utf8.len(var_93_8) / 24)

				if (24 <= 0 and var_93_6 or var_93_6 * (utf8.len(var_93_8) / 24)) > 0 and var_93_6 < var_93_10 then
					arg_90_1.talkMaxDuration = var_93_10

					if var_93_10 + var_93_5 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_5
					end
				end

				arg_90_1.text_.text = var_93_8
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061022", "story_v_out_425061.awb") ~= 0 then
					local var_93_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061022", "story_v_out_425061.awb") / 1000

					if var_93_11 + var_93_5 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_11 + var_93_5
					end

					if var_93_7.prefab_name ~= "" and arg_90_1.actors_[var_93_7.prefab_name] ~= nil then
						local var_93_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_7.prefab_name].transform, "story_v_out_425061", "425061022", "story_v_out_425061.awb")

						arg_90_1:RecordAudio("425061022", var_93_12)
						arg_90_1:RecordAudio("425061022", var_93_12)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_425061", "425061022", "story_v_out_425061.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_425061", "425061022", "story_v_out_425061.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_13 = math.max(var_93_6, arg_90_1.talkMaxDuration)

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_13 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_5) / var_93_13

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_5 + var_93_13 and arg_90_1.time_ < var_93_5 + var_93_13 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play425061023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 425061023
		arg_94_1.duration_ = 8.97

		local var_94_0 = {
			zh = 4.833,
			ja = 8.966
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
				arg_94_0:Play425061024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.575

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:GetWordFromCfg(425061023)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 23 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 23)

				if (23 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 23)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061023", "story_v_out_425061.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_425061", "425061023", "story_v_out_425061.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_425061", "425061023", "story_v_out_425061.awb")

						arg_94_1:RecordAudio("425061023", var_97_6)
						arg_94_1:RecordAudio("425061023", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_425061", "425061023", "story_v_out_425061.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_425061", "425061023", "story_v_out_425061.awb")
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
	Play425061024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 425061024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play425061025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1037"]) and arg_98_1.var_.actorSpriteComps1037 == nil then
				arg_98_1.var_.actorSpriteComps1037 = arg_98_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_0 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1037"]) then
				if arg_98_1.var_.actorSpriteComps1037 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1037"]) and arg_98_1.var_.actorSpriteComps1037 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_101_3 then
						iter_101_3.color = arg_98_1.isInRecall_ and (arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_98_1.var_.actorSpriteComps1037 = nil
			end

			local var_101_2 = 0
			local var_101_3 = 1.175

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_4 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(425061024).content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_6 = 47 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_4) / 47)

				if (47 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_4) / 47)) > 0 and var_101_3 < var_101_6 then
					arg_98_1.talkMaxDuration = var_101_6

					if var_101_6 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_2
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_3, arg_98_1.talkMaxDuration)

			if var_101_2 <= arg_98_1.time_ and arg_98_1.time_ < var_101_2 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_2) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_2 + var_101_7 and arg_98_1.time_ < var_101_2 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play425061025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 425061025
		arg_102_1.duration_ = 10.13

		local var_102_0 = {
			zh = 8.466,
			ja = 10.133
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
				arg_102_0:Play425061026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1037"]) and arg_102_1.var_.actorSpriteComps1037 == nil then
				arg_102_1.var_.actorSpriteComps1037 = arg_102_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1037"]) then
				if arg_102_1.var_.actorSpriteComps1037 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1037"]) and arg_102_1.var_.actorSpriteComps1037 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_105_3 then
						iter_105_3.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_102_1.var_.actorSpriteComps1037 = nil
			end

			local var_105_2 = 0
			local var_105_3 = 0.9

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_4 = arg_102_1:GetWordFromCfg(425061025)
				local var_105_5 = arg_102_1:FormatText(var_105_4.content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 36 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 36)

				if (36 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 36)) > 0 and var_105_3 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_2
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061025", "story_v_out_425061.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_425061", "425061025", "story_v_out_425061.awb") / 1000

					if var_105_8 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_2
					end

					if var_105_4.prefab_name ~= "" and arg_102_1.actors_[var_105_4.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_4.prefab_name].transform, "story_v_out_425061", "425061025", "story_v_out_425061.awb")

						arg_102_1:RecordAudio("425061025", var_105_9)
						arg_102_1:RecordAudio("425061025", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_425061", "425061025", "story_v_out_425061.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_425061", "425061025", "story_v_out_425061.awb")
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
	Play425061026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 425061026
		arg_106_1.duration_ = 10.9

		local var_106_0 = {
			zh = 9,
			ja = 10.9
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
				arg_106_0:Play425061027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 1.05

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_1 = arg_106_1:GetWordFromCfg(425061026)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 42 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 42)

				if (42 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 42)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061026", "story_v_out_425061.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_425061", "425061026", "story_v_out_425061.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_425061", "425061026", "story_v_out_425061.awb")

						arg_106_1:RecordAudio("425061026", var_109_6)
						arg_106_1:RecordAudio("425061026", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_425061", "425061026", "story_v_out_425061.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_425061", "425061026", "story_v_out_425061.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play425061027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 425061027
		arg_110_1.duration_ = 5.7

		local var_110_0 = {
			zh = 3.8,
			ja = 5.7
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
				arg_110_0:Play425061028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1037 = arg_110_1.actors_["1037"].transform.localPosition
				arg_110_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("1037", 3)

				for iter_113_0 = 0, arg_110_1.actors_["1037"].transform.childCount - 1 do
					local var_113_0 = arg_110_1.actors_["1037"].transform:GetChild(iter_113_0)

					if var_113_0.name == "split_4" or not string.find(var_113_0.name, "split") then
						var_113_0.gameObject:SetActive(true)
					else
						var_113_0.gameObject:SetActive(false)
					end
				end
			end

			local var_113_1 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_1 then
				arg_110_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_110_1.time_ - 0) / var_113_1)
			end

			if arg_110_1.time_ >= 0 + var_113_1 and arg_110_1.time_ < 0 + var_113_1 + arg_113_0 then
				arg_110_1.actors_["1037"].transform.localPosition = Vector3.New(0, -430, -55)
			end

			local var_113_2 = 0
			local var_113_3 = 0.3

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_4 = arg_110_1:GetWordFromCfg(425061027)
				local var_113_5 = arg_110_1:FormatText(var_113_4.content)

				arg_110_1.text_.text = var_113_5

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_7 = 12 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_5) / 12)

				if (12 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_5) / 12)) > 0 and var_113_3 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_2 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_2
					end
				end

				arg_110_1.text_.text = var_113_5
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061027", "story_v_out_425061.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_425061", "425061027", "story_v_out_425061.awb") / 1000

					if var_113_8 + var_113_2 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_2
					end

					if var_113_4.prefab_name ~= "" and arg_110_1.actors_[var_113_4.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_4.prefab_name].transform, "story_v_out_425061", "425061027", "story_v_out_425061.awb")

						arg_110_1:RecordAudio("425061027", var_113_9)
						arg_110_1:RecordAudio("425061027", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_425061", "425061027", "story_v_out_425061.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_425061", "425061027", "story_v_out_425061.awb")
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

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 425061028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play425061029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1037"]) and arg_114_1.var_.actorSpriteComps1037 == nil then
				arg_114_1.var_.actorSpriteComps1037 = arg_114_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_0 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1037"]) then
				if arg_114_1.var_.actorSpriteComps1037 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1037"]) and arg_114_1.var_.actorSpriteComps1037 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_117_3 then
						iter_117_3.color = arg_114_1.isInRecall_ and (arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_114_1.var_.actorSpriteComps1037 = nil
			end

			local var_117_2 = 0
			local var_117_3 = 0.2

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_4 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(425061028).content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_6 = 8 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_4) / 8)

				if (8 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_4) / 8)) > 0 and var_117_3 < var_117_6 then
					arg_114_1.talkMaxDuration = var_117_6

					if var_117_6 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_6 + var_117_2
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_3, arg_114_1.talkMaxDuration)

			if var_117_2 <= arg_114_1.time_ and arg_114_1.time_ < var_117_2 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_2) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_2 + var_117_7 and arg_114_1.time_ < var_117_2 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play425061029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 425061029
		arg_118_1.duration_ = 9.73

		local var_118_0 = {
			zh = 9.733,
			ja = 8.5
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
				arg_118_0:Play425061030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1037"]) and arg_118_1.var_.actorSpriteComps1037 == nil then
				arg_118_1.var_.actorSpriteComps1037 = arg_118_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_0 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1037"]) then
				if arg_118_1.var_.actorSpriteComps1037 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								iter_121_1.color = Color.New(Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor1.r, (arg_118_1.time_ - 0) / var_121_0), Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor1.g, (arg_118_1.time_ - 0) / var_121_0), (Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor1.b, (arg_118_1.time_ - 0) / var_121_0)))
							else
								local var_121_1 = Mathf.Lerp(iter_121_1.color.r, 1, (arg_118_1.time_ - 0) / var_121_0)

								iter_121_1.color = Color.New(var_121_1, var_121_1, var_121_1)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1037"]) and arg_118_1.var_.actorSpriteComps1037 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_121_3 then
						iter_121_3.color = arg_118_1.isInRecall_ and (arg_118_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_118_1.var_.actorSpriteComps1037 = nil
			end

			local var_121_2 = 0
			local var_121_3 = 1.025

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_2 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_4 = arg_118_1:GetWordFromCfg(425061029)
				local var_121_5 = arg_118_1:FormatText(var_121_4.content)

				arg_118_1.text_.text = var_121_5

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_7 = 64 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_5) / 64)

				if (64 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_5) / 64)) > 0 and var_121_3 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_2
					end
				end

				arg_118_1.text_.text = var_121_5
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061029", "story_v_out_425061.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_425061", "425061029", "story_v_out_425061.awb") / 1000

					if var_121_8 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_2
					end

					if var_121_4.prefab_name ~= "" and arg_118_1.actors_[var_121_4.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_4.prefab_name].transform, "story_v_out_425061", "425061029", "story_v_out_425061.awb")

						arg_118_1:RecordAudio("425061029", var_121_9)
						arg_118_1:RecordAudio("425061029", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_425061", "425061029", "story_v_out_425061.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_425061", "425061029", "story_v_out_425061.awb")
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
	Play425061030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 425061030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play425061031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1037"]) and arg_122_1.var_.actorSpriteComps1037 == nil then
				arg_122_1.var_.actorSpriteComps1037 = arg_122_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1037"]) then
				if arg_122_1.var_.actorSpriteComps1037 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								iter_125_1.color = Color.New(Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor2.r, (arg_122_1.time_ - 0) / var_125_0), Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor2.g, (arg_122_1.time_ - 0) / var_125_0), (Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor2.b, (arg_122_1.time_ - 0) / var_125_0)))
							else
								local var_125_1 = Mathf.Lerp(iter_125_1.color.r, 0.5, (arg_122_1.time_ - 0) / var_125_0)

								iter_125_1.color = Color.New(var_125_1, var_125_1, var_125_1)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1037"]) and arg_122_1.var_.actorSpriteComps1037 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_125_3 then
						iter_125_3.color = arg_122_1.isInRecall_ and (arg_122_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_122_1.var_.actorSpriteComps1037 = nil
			end

			local var_125_2 = 0
			local var_125_3 = 1.05

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_4 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(425061030).content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_6 = 42 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_4) / 42)

				if (42 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_4) / 42)) > 0 and var_125_3 < var_125_6 then
					arg_122_1.talkMaxDuration = var_125_6

					if var_125_6 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_2
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_7 = math.max(var_125_3, arg_122_1.talkMaxDuration)

			if var_125_2 <= arg_122_1.time_ and arg_122_1.time_ < var_125_2 + var_125_7 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_2) / var_125_7

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_2 + var_125_7 and arg_122_1.time_ < var_125_2 + var_125_7 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play425061031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 425061031
		arg_126_1.duration_ = 2.77

		local var_126_0 = {
			zh = 1.733,
			ja = 2.766
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
				arg_126_0:Play425061032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1037"]) and arg_126_1.var_.actorSpriteComps1037 == nil then
				arg_126_1.var_.actorSpriteComps1037 = arg_126_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_0 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1037"]) then
				if arg_126_1.var_.actorSpriteComps1037 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_129_1 then
							if arg_126_1.isInRecall_ then
								iter_129_1.color = Color.New(Mathf.Lerp(iter_129_1.color.r, arg_126_1.hightColor1.r, (arg_126_1.time_ - 0) / var_129_0), Mathf.Lerp(iter_129_1.color.g, arg_126_1.hightColor1.g, (arg_126_1.time_ - 0) / var_129_0), (Mathf.Lerp(iter_129_1.color.b, arg_126_1.hightColor1.b, (arg_126_1.time_ - 0) / var_129_0)))
							else
								local var_129_1 = Mathf.Lerp(iter_129_1.color.r, 1, (arg_126_1.time_ - 0) / var_129_0)

								iter_129_1.color = Color.New(var_129_1, var_129_1, var_129_1)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1037"]) and arg_126_1.var_.actorSpriteComps1037 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_129_3 then
						iter_129_3.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_126_1.var_.actorSpriteComps1037 = nil
			end

			local var_129_2 = arg_126_1.actors_["1037"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1037 = var_129_2.localPosition
				var_129_2.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("1037", 3)

				for iter_129_4 = 0, var_129_2.childCount - 1 do
					local var_129_3 = var_129_2:GetChild(iter_129_4)

					if var_129_3.name == "split_1" then
						var_129_3:SetAsLastSibling()
						var_129_3.gameObject:SetActive(true)

						arg_126_1.var_.actorSpriteSplit1037 = var_129_3.gameObject:GetComponent(typeof(Image))

						arg_126_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_129_4 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				var_129_2.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_126_1.time_ - 0) / var_129_4)

				if arg_126_1.var_.actorSpriteSplit1037 ~= nil then
					arg_126_1.var_.actorSpriteSplit1037:SetAlpha((arg_126_1.time_ - 0) / var_129_4)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				var_129_2.localPosition = Vector3.New(0, -430, -55)

				if arg_126_1.var_.actorSpriteSplit1037 ~= nil then
					arg_126_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_129_5 = 0
			local var_129_6 = 0.125

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_7 = arg_126_1:GetWordFromCfg(425061031)
				local var_129_8 = arg_126_1:FormatText(var_129_7.content)

				arg_126_1.text_.text = var_129_8

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_10 = 5 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_8) / 5)

				if (5 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_8) / 5)) > 0 and var_129_6 < var_129_10 then
					arg_126_1.talkMaxDuration = var_129_10

					if var_129_10 + var_129_5 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_5
					end
				end

				arg_126_1.text_.text = var_129_8
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061031", "story_v_out_425061.awb") ~= 0 then
					local var_129_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061031", "story_v_out_425061.awb") / 1000

					if var_129_11 + var_129_5 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_11 + var_129_5
					end

					if var_129_7.prefab_name ~= "" and arg_126_1.actors_[var_129_7.prefab_name] ~= nil then
						local var_129_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_7.prefab_name].transform, "story_v_out_425061", "425061031", "story_v_out_425061.awb")

						arg_126_1:RecordAudio("425061031", var_129_12)
						arg_126_1:RecordAudio("425061031", var_129_12)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_425061", "425061031", "story_v_out_425061.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_425061", "425061031", "story_v_out_425061.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_13 = math.max(var_129_6, arg_126_1.talkMaxDuration)

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_13 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_5) / var_129_13

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_5 + var_129_13 and arg_126_1.time_ < var_129_5 + var_129_13 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play425061032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 425061032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play425061033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1037"]) and arg_130_1.var_.actorSpriteComps1037 == nil then
				arg_130_1.var_.actorSpriteComps1037 = arg_130_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_0 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1037"]) then
				if arg_130_1.var_.actorSpriteComps1037 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								iter_133_1.color = Color.New(Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor2.r, (arg_130_1.time_ - 0) / var_133_0), Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor2.g, (arg_130_1.time_ - 0) / var_133_0), (Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor2.b, (arg_130_1.time_ - 0) / var_133_0)))
							else
								local var_133_1 = Mathf.Lerp(iter_133_1.color.r, 0.5, (arg_130_1.time_ - 0) / var_133_0)

								iter_133_1.color = Color.New(var_133_1, var_133_1, var_133_1)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1037"]) and arg_130_1.var_.actorSpriteComps1037 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_133_3 then
						iter_133_3.color = arg_130_1.isInRecall_ and (arg_130_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_130_1.var_.actorSpriteComps1037 = nil
			end

			local var_133_2 = 0
			local var_133_3 = 1.2

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_2 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_4 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(425061032).content)

				arg_130_1.text_.text = var_133_4

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_6 = 48 <= 0 and var_133_3 or var_133_3 * (utf8.len(var_133_4) / 48)

				if (48 <= 0 and var_133_3 or var_133_3 * (utf8.len(var_133_4) / 48)) > 0 and var_133_3 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_2 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_2
					end
				end

				arg_130_1.text_.text = var_133_4
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_3, arg_130_1.talkMaxDuration)

			if var_133_2 <= arg_130_1.time_ and arg_130_1.time_ < var_133_2 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_2) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_2 + var_133_7 and arg_130_1.time_ < var_133_2 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play425061033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 425061033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play425061034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 1

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_1 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(425061033).content)

				arg_134_1.text_.text = var_137_1

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_3 = 40 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 40)

				if (40 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 40)) > 0 and var_137_0 < var_137_3 then
					arg_134_1.talkMaxDuration = var_137_3

					if var_137_3 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_3 + 0
					end
				end

				arg_134_1.text_.text = var_137_1
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_4 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_4

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play425061034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 425061034
		arg_138_1.duration_ = 2.07

		local var_138_0 = {
			zh = 2.066,
			ja = 2
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
				arg_138_0:Play425061035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1037"]) and arg_138_1.var_.actorSpriteComps1037 == nil then
				arg_138_1.var_.actorSpriteComps1037 = arg_138_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_0 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1037"]) then
				if arg_138_1.var_.actorSpriteComps1037 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1037"]) and arg_138_1.var_.actorSpriteComps1037 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_141_3 then
						iter_141_3.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_138_1.var_.actorSpriteComps1037 = nil
			end

			local var_141_2 = arg_138_1.actors_["1037"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1037 = var_141_2.localPosition
				var_141_2.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("1037", 3)

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
				var_141_2.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_138_1.time_ - 0) / var_141_4)
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 then
				var_141_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_141_5 = 0
			local var_141_6 = 0.05

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_7 = arg_138_1:GetWordFromCfg(425061034)
				local var_141_8 = arg_138_1:FormatText(var_141_7.content)

				arg_138_1.text_.text = var_141_8

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_10 = 2 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 2)

				if (2 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 2)) > 0 and var_141_6 < var_141_10 then
					arg_138_1.talkMaxDuration = var_141_10

					if var_141_10 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_10 + var_141_5
					end
				end

				arg_138_1.text_.text = var_141_8
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061034", "story_v_out_425061.awb") ~= 0 then
					local var_141_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061034", "story_v_out_425061.awb") / 1000

					if var_141_11 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_5
					end

					if var_141_7.prefab_name ~= "" and arg_138_1.actors_[var_141_7.prefab_name] ~= nil then
						local var_141_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_7.prefab_name].transform, "story_v_out_425061", "425061034", "story_v_out_425061.awb")

						arg_138_1:RecordAudio("425061034", var_141_12)
						arg_138_1:RecordAudio("425061034", var_141_12)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_425061", "425061034", "story_v_out_425061.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_425061", "425061034", "story_v_out_425061.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_13 = math.max(var_141_6, arg_138_1.talkMaxDuration)

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_13 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_5) / var_141_13

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_5 + var_141_13 and arg_138_1.time_ < var_141_5 + var_141_13 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 425061035
		arg_142_1.duration_ = 8.6

		local var_142_0 = {
			zh = 8.6,
			ja = 7.833
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
				arg_142_0:Play425061036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1037 = arg_142_1.actors_["1037"].transform.localPosition
				arg_142_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("1037", 3)

				for iter_145_0 = 0, arg_142_1.actors_["1037"].transform.childCount - 1 do
					local var_145_0 = arg_142_1.actors_["1037"].transform:GetChild(iter_145_0)

					if var_145_0.name == "" or not string.find(var_145_0.name, "split") then
						var_145_0.gameObject:SetActive(true)
					else
						var_145_0.gameObject:SetActive(false)
					end
				end
			end

			local var_145_1 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_1 then
				arg_142_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_142_1.time_ - 0) / var_145_1)
			end

			if arg_142_1.time_ >= 0 + var_145_1 and arg_142_1.time_ < 0 + var_145_1 + arg_145_0 then
				arg_142_1.actors_["1037"].transform.localPosition = Vector3.New(0, -430, -55)
			end

			local var_145_2 = 0
			local var_145_3 = 0.95

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_2 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_4 = arg_142_1:GetWordFromCfg(425061035)
				local var_145_5 = arg_142_1:FormatText(var_145_4.content)

				arg_142_1.text_.text = var_145_5

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_7 = 38 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 38)

				if (38 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 38)) > 0 and var_145_3 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_2
					end
				end

				arg_142_1.text_.text = var_145_5
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061035", "story_v_out_425061.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_425061", "425061035", "story_v_out_425061.awb") / 1000

					if var_145_8 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_2
					end

					if var_145_4.prefab_name ~= "" and arg_142_1.actors_[var_145_4.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_4.prefab_name].transform, "story_v_out_425061", "425061035", "story_v_out_425061.awb")

						arg_142_1:RecordAudio("425061035", var_145_9)
						arg_142_1:RecordAudio("425061035", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_425061", "425061035", "story_v_out_425061.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_425061", "425061035", "story_v_out_425061.awb")
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

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play425061036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 425061036
		arg_146_1.duration_ = 1

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"

			SetActive(arg_146_1.choicesGo_, true)

			for iter_147_0, iter_147_1 in ipairs(arg_146_1.choices_) do
				SetActive(iter_147_1.go, iter_147_0 <= 1)
			end

			arg_146_1.choices_[1].txt.text = arg_146_1:FormatText(StoryChoiceCfg[1535].name)
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play425061037(arg_146_1)
			end

			arg_146_1:RecordChoiceLog(425061036, 1535)
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1037"]) and arg_146_1.var_.actorSpriteComps1037 == nil then
				arg_146_1.var_.actorSpriteComps1037 = arg_146_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_0 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1037"]) then
				if arg_146_1.var_.actorSpriteComps1037 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1037"]) and arg_146_1.var_.actorSpriteComps1037 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_149_3 then
						iter_149_3.color = arg_146_1.isInRecall_ and (arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_146_1.var_.actorSpriteComps1037 = nil
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play425061037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 425061037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play425061038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.425

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_1 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(425061037).content)

				arg_150_1.text_.text = var_153_1

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_3 = 17 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 17)

				if (17 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 17)) > 0 and var_153_0 < var_153_3 then
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
	Play425061038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 425061038
		arg_154_1.duration_ = 1.23

		local var_154_0 = {
			zh = 1.233,
			ja = 1
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
				arg_154_0:Play425061039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["1037"]) and arg_154_1.var_.actorSpriteComps1037 == nil then
				arg_154_1.var_.actorSpriteComps1037 = arg_154_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_0 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["1037"]) then
				if arg_154_1.var_.actorSpriteComps1037 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								iter_157_1.color = Color.New(Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor1.r, (arg_154_1.time_ - 0) / var_157_0), Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor1.g, (arg_154_1.time_ - 0) / var_157_0), (Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor1.b, (arg_154_1.time_ - 0) / var_157_0)))
							else
								local var_157_1 = Mathf.Lerp(iter_157_1.color.r, 1, (arg_154_1.time_ - 0) / var_157_0)

								iter_157_1.color = Color.New(var_157_1, var_157_1, var_157_1)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["1037"]) and arg_154_1.var_.actorSpriteComps1037 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_157_3 then
						iter_157_3.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_154_1.var_.actorSpriteComps1037 = nil
			end

			local var_157_2 = arg_154_1.actors_["1037"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1037 = var_157_2.localPosition
				var_157_2.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("1037", 3)

				for iter_157_4 = 0, var_157_2.childCount - 1 do
					local var_157_3 = var_157_2:GetChild(iter_157_4)

					if var_157_3.name == "" or not string.find(var_157_3.name, "split") then
						var_157_3.gameObject:SetActive(true)
					else
						var_157_3.gameObject:SetActive(false)
					end
				end
			end

			local var_157_4 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				var_157_2.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_154_1.time_ - 0) / var_157_4)
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				var_157_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_157_5 = 0
			local var_157_6 = 0.125

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_7 = arg_154_1:GetWordFromCfg(425061038)
				local var_157_8 = arg_154_1:FormatText(var_157_7.content)

				arg_154_1.text_.text = var_157_8

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_10 = 5 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_8) / 5)

				if (5 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_8) / 5)) > 0 and var_157_6 < var_157_10 then
					arg_154_1.talkMaxDuration = var_157_10

					if var_157_10 + var_157_5 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_5
					end
				end

				arg_154_1.text_.text = var_157_8
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061038", "story_v_out_425061.awb") ~= 0 then
					local var_157_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061038", "story_v_out_425061.awb") / 1000

					if var_157_11 + var_157_5 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_11 + var_157_5
					end

					if var_157_7.prefab_name ~= "" and arg_154_1.actors_[var_157_7.prefab_name] ~= nil then
						local var_157_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_7.prefab_name].transform, "story_v_out_425061", "425061038", "story_v_out_425061.awb")

						arg_154_1:RecordAudio("425061038", var_157_12)
						arg_154_1:RecordAudio("425061038", var_157_12)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_425061", "425061038", "story_v_out_425061.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_425061", "425061038", "story_v_out_425061.awb")
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

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play425061039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 425061039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play425061040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1037"]) and arg_158_1.var_.actorSpriteComps1037 == nil then
				arg_158_1.var_.actorSpriteComps1037 = arg_158_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_0 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1037"]) then
				if arg_158_1.var_.actorSpriteComps1037 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1037"]) and arg_158_1.var_.actorSpriteComps1037 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_161_3 then
						iter_161_3.color = arg_158_1.isInRecall_ and (arg_158_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_158_1.var_.actorSpriteComps1037 = nil
			end

			local var_161_2 = 0
			local var_161_3 = 0.525

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_4 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(425061039).content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_6 = 21 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_4) / 21)

				if (21 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_4) / 21)) > 0 and var_161_3 < var_161_6 then
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
	Play425061040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 425061040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play425061041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1037 = arg_162_1.actors_["1037"].transform.localPosition
				arg_162_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("1037", 7)

				for iter_165_0 = 0, arg_162_1.actors_["1037"].transform.childCount - 1 do
					local var_165_0 = arg_162_1.actors_["1037"].transform:GetChild(iter_165_0)

					if var_165_0.name == "" or not string.find(var_165_0.name, "split") then
						var_165_0.gameObject:SetActive(true)
					else
						var_165_0.gameObject:SetActive(false)
					end
				end
			end

			local var_165_1 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_1 then
				arg_162_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_162_1.time_ - 0) / var_165_1)
			end

			if arg_162_1.time_ >= 0 + var_165_1 and arg_162_1.time_ < 0 + var_165_1 + arg_165_0 then
				arg_162_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			if 0.7 < arg_162_1.time_ and arg_162_1.time_ <= 0.7 + arg_165_0 then
				arg_162_1:AudioAction("play", "effect", "se_story_130", "se_story_130_paper", "")
			end

			local var_165_3 = 0
			local var_165_4 = 1.25

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_3 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_5 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(425061040).content)

				arg_162_1.text_.text = var_165_5

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_7 = 50 <= 0 and var_165_4 or var_165_4 * (utf8.len(var_165_5) / 50)

				if (50 <= 0 and var_165_4 or var_165_4 * (utf8.len(var_165_5) / 50)) > 0 and var_165_4 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_3 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_3
					end
				end

				arg_162_1.text_.text = var_165_5
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_8 = math.max(var_165_4, arg_162_1.talkMaxDuration)

			if var_165_3 <= arg_162_1.time_ and arg_162_1.time_ < var_165_3 + var_165_8 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_3) / var_165_8

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_3 + var_165_8 and arg_162_1.time_ < var_165_3 + var_165_8 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play425061041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 425061041
		arg_166_1.duration_ = 14.7

		local var_166_0 = {
			zh = 10.8,
			ja = 14.7
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
				arg_166_0:Play425061042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1037"]) and arg_166_1.var_.actorSpriteComps1037 == nil then
				arg_166_1.var_.actorSpriteComps1037 = arg_166_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1037"]) then
				if arg_166_1.var_.actorSpriteComps1037 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								iter_169_1.color = Color.New(Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor1.r, (arg_166_1.time_ - 0) / var_169_0), Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor1.g, (arg_166_1.time_ - 0) / var_169_0), (Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor1.b, (arg_166_1.time_ - 0) / var_169_0)))
							else
								local var_169_1 = Mathf.Lerp(iter_169_1.color.r, 1, (arg_166_1.time_ - 0) / var_169_0)

								iter_169_1.color = Color.New(var_169_1, var_169_1, var_169_1)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1037"]) and arg_166_1.var_.actorSpriteComps1037 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_169_3 then
						iter_169_3.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_166_1.var_.actorSpriteComps1037 = nil
			end

			local var_169_2 = arg_166_1.actors_["1037"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1037 = var_169_2.localPosition
				var_169_2.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("1037", 3)

				for iter_169_4 = 0, var_169_2.childCount - 1 do
					local var_169_3 = var_169_2:GetChild(iter_169_4)

					if var_169_3.name == "" or not string.find(var_169_3.name, "split") then
						var_169_3.gameObject:SetActive(true)
					else
						var_169_3.gameObject:SetActive(false)
					end
				end
			end

			local var_169_4 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				var_169_2.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_166_1.time_ - 0) / var_169_4)
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				var_169_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_169_5 = 0
			local var_169_6 = 1.45

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_7 = arg_166_1:GetWordFromCfg(425061041)
				local var_169_8 = arg_166_1:FormatText(var_169_7.content)

				arg_166_1.text_.text = var_169_8

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_10 = 58 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_8) / 58)

				if (58 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_8) / 58)) > 0 and var_169_6 < var_169_10 then
					arg_166_1.talkMaxDuration = var_169_10

					if var_169_10 + var_169_5 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_5
					end
				end

				arg_166_1.text_.text = var_169_8
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061041", "story_v_out_425061.awb") ~= 0 then
					local var_169_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061041", "story_v_out_425061.awb") / 1000

					if var_169_11 + var_169_5 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_11 + var_169_5
					end

					if var_169_7.prefab_name ~= "" and arg_166_1.actors_[var_169_7.prefab_name] ~= nil then
						local var_169_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_7.prefab_name].transform, "story_v_out_425061", "425061041", "story_v_out_425061.awb")

						arg_166_1:RecordAudio("425061041", var_169_12)
						arg_166_1:RecordAudio("425061041", var_169_12)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_425061", "425061041", "story_v_out_425061.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_425061", "425061041", "story_v_out_425061.awb")
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

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 425061042
		arg_170_1.duration_ = 7.27

		local var_170_0 = {
			zh = 6.733,
			ja = 7.266
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
				arg_170_0:Play425061043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.7

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_1 = arg_170_1:GetWordFromCfg(425061042)
				local var_173_2 = arg_170_1:FormatText(var_173_1.content)

				arg_170_1.text_.text = var_173_2

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 28 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 28)

				if (28 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_2) / 28)) > 0 and var_173_0 < var_173_4 then
					arg_170_1.talkMaxDuration = var_173_4

					if var_173_4 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_4 + 0
					end
				end

				arg_170_1.text_.text = var_173_2
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061042", "story_v_out_425061.awb") ~= 0 then
					local var_173_5 = manager.audio:GetVoiceLength("story_v_out_425061", "425061042", "story_v_out_425061.awb") / 1000

					if var_173_5 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + 0
					end

					if var_173_1.prefab_name ~= "" and arg_170_1.actors_[var_173_1.prefab_name] ~= nil then
						local var_173_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_1.prefab_name].transform, "story_v_out_425061", "425061042", "story_v_out_425061.awb")

						arg_170_1:RecordAudio("425061042", var_173_6)
						arg_170_1:RecordAudio("425061042", var_173_6)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_425061", "425061042", "story_v_out_425061.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_425061", "425061042", "story_v_out_425061.awb")
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
	Play425061043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 425061043
		arg_174_1.duration_ = 1

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"

			SetActive(arg_174_1.choicesGo_, true)

			for iter_175_0, iter_175_1 in ipairs(arg_174_1.choices_) do
				SetActive(iter_175_1.go, iter_175_0 <= 1)
			end

			arg_174_1.choices_[1].txt.text = arg_174_1:FormatText(StoryChoiceCfg[1536].name)
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play425061044(arg_174_1)
			end

			arg_174_1:RecordChoiceLog(425061043, 1536)
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1037"]) and arg_174_1.var_.actorSpriteComps1037 == nil then
				arg_174_1.var_.actorSpriteComps1037 = arg_174_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_0 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1037"]) then
				if arg_174_1.var_.actorSpriteComps1037 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1037"]) and arg_174_1.var_.actorSpriteComps1037 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_177_3 then
						iter_177_3.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_174_1.var_.actorSpriteComps1037 = nil
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play425061044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 425061044
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play425061045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0.675

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_1 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(425061044).content)

				arg_178_1.text_.text = var_181_1

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_3 = 27 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 27)

				if (27 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 27)) > 0 and var_181_0 < var_181_3 then
					arg_178_1.talkMaxDuration = var_181_3

					if var_181_3 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_3 + 0
					end
				end

				arg_178_1.text_.text = var_181_1
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_4 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_4

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play425061045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 425061045
		arg_182_1.duration_ = 5.5

		local var_182_0 = {
			zh = 4.8,
			ja = 5.5
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
				arg_182_0:Play425061046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1037"]) and arg_182_1.var_.actorSpriteComps1037 == nil then
				arg_182_1.var_.actorSpriteComps1037 = arg_182_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_0 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1037"]) then
				if arg_182_1.var_.actorSpriteComps1037 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								iter_185_1.color = Color.New(Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor1.r, (arg_182_1.time_ - 0) / var_185_0), Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor1.g, (arg_182_1.time_ - 0) / var_185_0), (Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor1.b, (arg_182_1.time_ - 0) / var_185_0)))
							else
								local var_185_1 = Mathf.Lerp(iter_185_1.color.r, 1, (arg_182_1.time_ - 0) / var_185_0)

								iter_185_1.color = Color.New(var_185_1, var_185_1, var_185_1)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1037"]) and arg_182_1.var_.actorSpriteComps1037 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_185_3 then
						iter_185_3.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_182_1.var_.actorSpriteComps1037 = nil
			end

			local var_185_2 = arg_182_1.actors_["1037"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1037 = var_185_2.localPosition
				var_185_2.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("1037", 3)

				for iter_185_4 = 0, var_185_2.childCount - 1 do
					local var_185_3 = var_185_2:GetChild(iter_185_4)

					if var_185_3.name == "split_5" then
						var_185_3:SetAsLastSibling()
						var_185_3.gameObject:SetActive(true)

						arg_182_1.var_.actorSpriteSplit1037 = var_185_3.gameObject:GetComponent(typeof(Image))

						arg_182_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_185_4 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				var_185_2.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_182_1.time_ - 0) / var_185_4)

				if arg_182_1.var_.actorSpriteSplit1037 ~= nil then
					arg_182_1.var_.actorSpriteSplit1037:SetAlpha((arg_182_1.time_ - 0) / var_185_4)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				var_185_2.localPosition = Vector3.New(0, -430, -55)

				if arg_182_1.var_.actorSpriteSplit1037 ~= nil then
					arg_182_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_185_5 = 0
			local var_185_6 = 0.375

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_7 = arg_182_1:GetWordFromCfg(425061045)
				local var_185_8 = arg_182_1:FormatText(var_185_7.content)

				arg_182_1.text_.text = var_185_8

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_10 = 15 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_8) / 15)

				if (15 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_8) / 15)) > 0 and var_185_6 < var_185_10 then
					arg_182_1.talkMaxDuration = var_185_10

					if var_185_10 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_5
					end
				end

				arg_182_1.text_.text = var_185_8
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061045", "story_v_out_425061.awb") ~= 0 then
					local var_185_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061045", "story_v_out_425061.awb") / 1000

					if var_185_11 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_11 + var_185_5
					end

					if var_185_7.prefab_name ~= "" and arg_182_1.actors_[var_185_7.prefab_name] ~= nil then
						local var_185_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_7.prefab_name].transform, "story_v_out_425061", "425061045", "story_v_out_425061.awb")

						arg_182_1:RecordAudio("425061045", var_185_12)
						arg_182_1:RecordAudio("425061045", var_185_12)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_425061", "425061045", "story_v_out_425061.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_425061", "425061045", "story_v_out_425061.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_13 = math.max(var_185_6, arg_182_1.talkMaxDuration)

			if var_185_5 <= arg_182_1.time_ and arg_182_1.time_ < var_185_5 + var_185_13 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_5) / var_185_13

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_5 + var_185_13 and arg_182_1.time_ < var_185_5 + var_185_13 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play425061046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 425061046
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play425061047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1037"]) and arg_186_1.var_.actorSpriteComps1037 == nil then
				arg_186_1.var_.actorSpriteComps1037 = arg_186_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_0 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1037"]) then
				if arg_186_1.var_.actorSpriteComps1037 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1037"]) and arg_186_1.var_.actorSpriteComps1037 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_189_3 then
						iter_189_3.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_186_1.var_.actorSpriteComps1037 = nil
			end

			local var_189_2 = 0
			local var_189_3 = 0.45

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_4 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(425061046).content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_6 = 18 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_4) / 18)

				if (18 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_4) / 18)) > 0 and var_189_3 < var_189_6 then
					arg_186_1.talkMaxDuration = var_189_6

					if var_189_6 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_2
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_7 = math.max(var_189_3, arg_186_1.talkMaxDuration)

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_7 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_2) / var_189_7

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_2 + var_189_7 and arg_186_1.time_ < var_189_2 + var_189_7 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play425061047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 425061047
		arg_190_1.duration_ = 11.83

		local var_190_0 = {
			zh = 9.8,
			ja = 11.833
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
				arg_190_0:Play425061048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1037"]) and arg_190_1.var_.actorSpriteComps1037 == nil then
				arg_190_1.var_.actorSpriteComps1037 = arg_190_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_0 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1037"]) then
				if arg_190_1.var_.actorSpriteComps1037 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1037"]) and arg_190_1.var_.actorSpriteComps1037 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_193_3 then
						iter_193_3.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_190_1.var_.actorSpriteComps1037 = nil
			end

			local var_193_2 = arg_190_1.actors_["1037"].transform

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1037 = var_193_2.localPosition
				var_193_2.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("1037", 3)

				for iter_193_4 = 0, var_193_2.childCount - 1 do
					local var_193_3 = var_193_2:GetChild(iter_193_4)

					if var_193_3.name == "split_1" then
						var_193_3:SetAsLastSibling()
						var_193_3.gameObject:SetActive(true)

						arg_190_1.var_.actorSpriteSplit1037 = var_193_3.gameObject:GetComponent(typeof(Image))

						arg_190_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_193_4 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				var_193_2.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_190_1.time_ - 0) / var_193_4)

				if arg_190_1.var_.actorSpriteSplit1037 ~= nil then
					arg_190_1.var_.actorSpriteSplit1037:SetAlpha((arg_190_1.time_ - 0) / var_193_4)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
				var_193_2.localPosition = Vector3.New(0, -430, -55)

				if arg_190_1.var_.actorSpriteSplit1037 ~= nil then
					arg_190_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_193_5 = 0
			local var_193_6 = 0.975

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_7 = arg_190_1:GetWordFromCfg(425061047)
				local var_193_8 = arg_190_1:FormatText(var_193_7.content)

				arg_190_1.text_.text = var_193_8

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_10 = 39 <= 0 and var_193_6 or var_193_6 * (utf8.len(var_193_8) / 39)

				if (39 <= 0 and var_193_6 or var_193_6 * (utf8.len(var_193_8) / 39)) > 0 and var_193_6 < var_193_10 then
					arg_190_1.talkMaxDuration = var_193_10

					if var_193_10 + var_193_5 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_5
					end
				end

				arg_190_1.text_.text = var_193_8
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061047", "story_v_out_425061.awb") ~= 0 then
					local var_193_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061047", "story_v_out_425061.awb") / 1000

					if var_193_11 + var_193_5 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_11 + var_193_5
					end

					if var_193_7.prefab_name ~= "" and arg_190_1.actors_[var_193_7.prefab_name] ~= nil then
						local var_193_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_7.prefab_name].transform, "story_v_out_425061", "425061047", "story_v_out_425061.awb")

						arg_190_1:RecordAudio("425061047", var_193_12)
						arg_190_1:RecordAudio("425061047", var_193_12)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_425061", "425061047", "story_v_out_425061.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_425061", "425061047", "story_v_out_425061.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_13 = math.max(var_193_6, arg_190_1.talkMaxDuration)

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_13 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_5) / var_193_13

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_5 + var_193_13 and arg_190_1.time_ < var_193_5 + var_193_13 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play425061048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 425061048
		arg_194_1.duration_ = 10.6

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play425061049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_0 = 1.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 then
				local var_197_1 = Color.New(0, 0, 0)

				var_197_1.a = Mathf.Lerp(0, 1, (arg_194_1.time_ - 0) / var_197_0)
				arg_194_1.mask_.color = var_197_1
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 then
				local var_197_2 = Color.New(0, 0, 0)

				var_197_2.a = 1
				arg_194_1.mask_.color = var_197_2
			end

			local var_197_3 = 1.2

			if 1.2 < arg_194_1.time_ and arg_194_1.time_ <= var_197_3 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_4 = 1.2

			if var_197_3 <= arg_194_1.time_ and arg_194_1.time_ < var_197_3 + var_197_4 then
				local var_197_5 = Color.New(0, 0, 0)

				var_197_5.a = Mathf.Lerp(1, 0, (arg_194_1.time_ - var_197_3) / var_197_4)
				arg_194_1.mask_.color = var_197_5
			end

			if arg_194_1.time_ >= var_197_3 + var_197_4 and arg_194_1.time_ < var_197_3 + var_197_4 + arg_197_0 then
				local var_197_6 = Color.New(0, 0, 0)

				arg_194_1.mask_.enabled = false
				var_197_6.a = 0
				arg_194_1.mask_.color = var_197_6
			end

			local var_197_7 = 5.60000033333333

			if 5.60000033333333 < arg_194_1.time_ and arg_194_1.time_ <= var_197_7 + arg_197_0 then
				arg_194_1.allBtn_.enabled = false
			end

			if arg_194_1.time_ >= var_197_7 + 0.95 and arg_194_1.time_ < var_197_7 + 0.95 + arg_197_0 then
				arg_194_1.allBtn_.enabled = true
			end

			local var_197_8 = arg_194_1.actors_["1037"].transform

			if 1.2 < arg_194_1.time_ and arg_194_1.time_ <= 1.2 + arg_197_0 then
				arg_194_1.var_.moveOldPos1037 = var_197_8.localPosition
				var_197_8.localScale = Vector3.New(1, 1, 1)

				arg_194_1:CheckSpriteTmpPos("1037", 7)

				for iter_197_0 = 0, var_197_8.childCount - 1 do
					local var_197_9 = var_197_8:GetChild(iter_197_0)

					if var_197_9.name == "" or not string.find(var_197_9.name, "split") then
						var_197_9.gameObject:SetActive(true)
					else
						var_197_9.gameObject:SetActive(false)
					end
				end
			end

			local var_197_10 = 0.001

			if 1.2 <= arg_194_1.time_ and arg_194_1.time_ < 1.2 + var_197_10 then
				var_197_8.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_194_1.time_ - 1.2) / var_197_10)
			end

			if arg_194_1.time_ >= 1.2 + var_197_10 and arg_194_1.time_ < 1.2 + var_197_10 + arg_197_0 then
				var_197_8.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_197_11 = 1.2

			if 1.2 < arg_194_1.time_ and arg_194_1.time_ <= var_197_11 + arg_197_0 then
				arg_194_1.timestampController_:SetSelectedState("show")
				arg_194_1.timestampAni_:Play("in")

				arg_194_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")

				arg_194_1.timestampColorController_:SetSelectedState("cold")
				arg_194_1.timeColdImg_:SetAlpha(0.031)

				arg_194_1.text_timeText_.text = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(501119).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_timeText_)

				arg_194_1.text_siteText_.text = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(501113).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_siteText_)
			end

			if arg_194_1.time_ >= var_197_11 + 1.999999999999 and arg_194_1.time_ < var_197_11 + 1.999999999999 + arg_197_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_194_1.timestampAni_, "out", function()
					arg_194_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_197_12 = 3.20000033333333

			if 3.20000033333333 < arg_194_1.time_ and arg_194_1.time_ <= var_197_12 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_13 = 1.2

			if var_197_12 <= arg_194_1.time_ and arg_194_1.time_ < var_197_12 + var_197_13 then
				local var_197_14 = Color.New(0, 0, 0)

				var_197_14.a = Mathf.Lerp(0, 1, (arg_194_1.time_ - var_197_12) / var_197_13)
				arg_194_1.mask_.color = var_197_14
			end

			if arg_194_1.time_ >= var_197_12 + var_197_13 and arg_194_1.time_ < var_197_12 + var_197_13 + arg_197_0 then
				local var_197_15 = Color.New(0, 0, 0)

				var_197_15.a = 1
				arg_194_1.mask_.color = var_197_15
			end

			local var_197_16 = 4.40000033333333

			if 4.40000033333333 < arg_194_1.time_ and arg_194_1.time_ <= var_197_16 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_17 = 1.2

			if var_197_16 <= arg_194_1.time_ and arg_194_1.time_ < var_197_16 + var_197_17 then
				local var_197_18 = Color.New(0, 0, 0)

				var_197_18.a = Mathf.Lerp(1, 0, (arg_194_1.time_ - var_197_16) / var_197_17)
				arg_194_1.mask_.color = var_197_18
			end

			if arg_194_1.time_ >= var_197_16 + var_197_17 and arg_194_1.time_ < var_197_16 + var_197_17 + arg_197_0 then
				local var_197_19 = Color.New(0, 0, 0)

				arg_194_1.mask_.enabled = false
				var_197_19.a = 0
				arg_194_1.mask_.color = var_197_19
			end

			local var_197_20 = "ST10"

			if arg_194_1.bgs_.ST10 == nil then
				local var_197_21 = Object.Instantiate(arg_194_1.paintGo_)

				var_197_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_197_20)
				var_197_21.name = var_197_20
				var_197_21.transform.parent = arg_194_1.stage_.transform
				var_197_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_194_1.bgs_[var_197_20] = var_197_21
			end

			if 1.2 < arg_194_1.time_ and arg_194_1.time_ <= 1.2 + arg_197_0 then
				local var_197_22 = arg_194_1.bgs_.ST10

				arg_194_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_197_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_197_23 = var_197_22:GetComponent("SpriteRenderer")

				if var_197_23 and var_197_23.sprite then
					local var_197_24 = 2 * (var_197_22.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_197_22.transform.localScale = Vector3.New(var_197_24 / var_197_23.sprite.bounds.size.y < var_197_24 * manager.ui.mainCameraCom_.aspect / var_197_23.sprite.bounds.size.x and var_197_24 * manager.ui.mainCameraCom_.aspect / var_197_23.sprite.bounds.size.x or var_197_24 / var_197_23.sprite.bounds.size.y, var_197_24 / var_197_23.sprite.bounds.size.y < var_197_24 * manager.ui.mainCameraCom_.aspect / var_197_23.sprite.bounds.size.x and var_197_24 * manager.ui.mainCameraCom_.aspect / var_197_23.sprite.bounds.size.x or var_197_24 / var_197_23.sprite.bounds.size.y, 0)
				end

				for iter_197_1, iter_197_2 in pairs(arg_194_1.bgs_) do
					if iter_197_1 ~= "ST10" then
						iter_197_2.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.1 < arg_194_1.time_ and arg_194_1.time_ <= 0.1 + arg_197_0 then
				arg_194_1:AudioAction("stop", "effect", "se_story_147", "se_story_147_amb_rooftop", "")
			end

			if 4 < arg_194_1.time_ and arg_194_1.time_ <= 4 + arg_197_0 then
				arg_194_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_194_1.frameCnt_ <= 1 then
				arg_194_1.dialog_:SetActive(false)
			end

			local var_197_27 = 5.60000033333333
			local var_197_28 = 0.95

			if 5.60000033333333 < arg_194_1.time_ and arg_194_1.time_ <= var_197_27 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0

				arg_194_1.dialog_:SetActive(true)

				arg_194_1.dialogCg_.alpha = 0

				local var_197_29 = LeanTween.value(arg_194_1.dialog_, 0, 1, 0.3)

				var_197_29:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_194_1.dialogCg_.alpha = arg_199_0
				end))
				var_197_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_194_1.dialog_)
					var_197_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_194_1.duration_ = arg_194_1.duration_ + 0.3

				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_30 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(425061048).content)

				arg_194_1.text_.text = var_197_30

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_32 = 38 <= 0 and var_197_28 or var_197_28 * (utf8.len(var_197_30) / 38)

				if (38 <= 0 and var_197_28 or var_197_28 * (utf8.len(var_197_30) / 38)) > 0 and var_197_28 < var_197_32 then
					arg_194_1.talkMaxDuration = var_197_32
					var_197_27 = var_197_27 + 0.3

					if var_197_32 + var_197_27 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_32 + var_197_27
					end
				end

				arg_194_1.text_.text = var_197_30
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_33 = var_197_27 + 0.3
			local var_197_34 = math.max(var_197_28, arg_194_1.talkMaxDuration)

			if var_197_27 + 0.3 <= arg_194_1.time_ and arg_194_1.time_ < var_197_33 + var_197_34 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_33) / var_197_34

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_33 + var_197_34 and arg_194_1.time_ < var_197_33 + var_197_34 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play425061049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 425061049
		arg_201_1.duration_ = 13.8

		local var_201_0 = {
			zh = 10.1,
			ja = 13.8
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
				arg_201_0:Play425061050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if arg_201_1.actors_["1033"] == nil then
				local var_204_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_204_0) then
					local var_204_1 = Object.Instantiate(var_204_0, arg_201_1.canvasGo_.transform)

					var_204_1.transform:SetSiblingIndex(1)

					var_204_1.name = "1033"
					var_204_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_201_1.actors_["1033"] = var_204_1

					if arg_201_1.isInRecall_ then
						for iter_204_0, iter_204_1 in ipairs((var_204_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_204_1.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_204_2 = arg_201_1.actors_["1033"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps1033 == nil then
				arg_201_1.var_.actorSpriteComps1033 = var_204_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_3 = 0.2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.actorSpriteComps1033 then
					for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_204_3 then
							if arg_201_1.isInRecall_ then
								iter_204_3.color = Color.New(Mathf.Lerp(iter_204_3.color.r, arg_201_1.hightColor1.r, (arg_201_1.time_ - 0) / var_204_3), Mathf.Lerp(iter_204_3.color.g, arg_201_1.hightColor1.g, (arg_201_1.time_ - 0) / var_204_3), (Mathf.Lerp(iter_204_3.color.b, arg_201_1.hightColor1.b, (arg_201_1.time_ - 0) / var_204_3)))
							else
								local var_204_4 = Mathf.Lerp(iter_204_3.color.r, 1, (arg_201_1.time_ - 0) / var_204_3)

								iter_204_3.color = Color.New(var_204_4, var_204_4, var_204_4)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps1033 then
				for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_204_5 then
						iter_204_5.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps1033 = nil
			end

			local var_204_5 = arg_201_1.actors_["1033"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1033 = var_204_5.localPosition
				var_204_5.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1033", 3)

				for iter_204_6 = 0, var_204_5.childCount - 1 do
					local var_204_6 = var_204_5:GetChild(iter_204_6)

					if var_204_6.name == "" or not string.find(var_204_6.name, "split") then
						var_204_6.gameObject:SetActive(true)
					else
						var_204_6.gameObject:SetActive(false)
					end
				end
			end

			local var_204_7 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				var_204_5.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_201_1.time_ - 0) / var_204_7)
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				var_204_5.localPosition = Vector3.New(0, -420, 0)
			end

			local var_204_8 = 0
			local var_204_9 = 1.25

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_10 = arg_201_1:GetWordFromCfg(425061049)
				local var_204_11 = arg_201_1:FormatText(var_204_10.content)

				arg_201_1.text_.text = var_204_11

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_13 = 50 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 50)

				if (50 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 50)) > 0 and var_204_9 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_8
					end
				end

				arg_201_1.text_.text = var_204_11
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061049", "story_v_out_425061.awb") ~= 0 then
					local var_204_14 = manager.audio:GetVoiceLength("story_v_out_425061", "425061049", "story_v_out_425061.awb") / 1000

					if var_204_14 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_8
					end

					if var_204_10.prefab_name ~= "" and arg_201_1.actors_[var_204_10.prefab_name] ~= nil then
						local var_204_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_10.prefab_name].transform, "story_v_out_425061", "425061049", "story_v_out_425061.awb")

						arg_201_1:RecordAudio("425061049", var_204_15)
						arg_201_1:RecordAudio("425061049", var_204_15)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_425061", "425061049", "story_v_out_425061.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_425061", "425061049", "story_v_out_425061.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_16 = math.max(var_204_9, arg_201_1.talkMaxDuration)

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_16 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_8) / var_204_16

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_8 + var_204_16 and arg_201_1.time_ < var_204_8 + var_204_16 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play425061050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 425061050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play425061051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1033"]) and arg_205_1.var_.actorSpriteComps1033 == nil then
				arg_205_1.var_.actorSpriteComps1033 = arg_205_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_0 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1033"]) then
				if arg_205_1.var_.actorSpriteComps1033 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_208_1 then
							if arg_205_1.isInRecall_ then
								iter_208_1.color = Color.New(Mathf.Lerp(iter_208_1.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 0) / var_208_0), Mathf.Lerp(iter_208_1.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 0) / var_208_0), (Mathf.Lerp(iter_208_1.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 0) / var_208_0)))
							else
								local var_208_1 = Mathf.Lerp(iter_208_1.color.r, 0.5, (arg_205_1.time_ - 0) / var_208_0)

								iter_208_1.color = Color.New(var_208_1, var_208_1, var_208_1)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1033"]) and arg_205_1.var_.actorSpriteComps1033 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_208_3 then
						iter_208_3.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps1033 = nil
			end

			local var_208_2 = 0
			local var_208_3 = 0.5

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_4 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(425061050).content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_6 = 20 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_4) / 20)

				if (20 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_4) / 20)) > 0 and var_208_3 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_2
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_3, arg_205_1.talkMaxDuration)

			if var_208_2 <= arg_205_1.time_ and arg_205_1.time_ < var_208_2 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_2) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_2 + var_208_7 and arg_205_1.time_ < var_208_2 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play425061051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 425061051
		arg_209_1.duration_ = 10.7

		local var_209_0 = {
			zh = 6.666,
			ja = 10.7
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play425061052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1033"]) and arg_209_1.var_.actorSpriteComps1033 == nil then
				arg_209_1.var_.actorSpriteComps1033 = arg_209_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1033"]) then
				if arg_209_1.var_.actorSpriteComps1033 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								iter_212_1.color = Color.New(Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_0), Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_0), (Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_0)))
							else
								local var_212_1 = Mathf.Lerp(iter_212_1.color.r, 1, (arg_209_1.time_ - 0) / var_212_0)

								iter_212_1.color = Color.New(var_212_1, var_212_1, var_212_1)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1033"]) and arg_209_1.var_.actorSpriteComps1033 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps1033 = nil
			end

			local var_212_2 = arg_209_1.actors_["1033"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1033 = var_212_2.localPosition
				var_212_2.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1033", 3)

				for iter_212_4 = 0, var_212_2.childCount - 1 do
					local var_212_3 = var_212_2:GetChild(iter_212_4)

					if var_212_3.name == "" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_2.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_209_1.time_ - 0) / var_212_4)
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_2.localPosition = Vector3.New(0, -420, 0)
			end

			local var_212_5 = 0
			local var_212_6 = 0.85

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_7 = arg_209_1:GetWordFromCfg(425061051)
				local var_212_8 = arg_209_1:FormatText(var_212_7.content)

				arg_209_1.text_.text = var_212_8

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_10 = 34 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 34)

				if (34 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 34)) > 0 and var_212_6 < var_212_10 then
					arg_209_1.talkMaxDuration = var_212_10

					if var_212_10 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_5
					end
				end

				arg_209_1.text_.text = var_212_8
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061051", "story_v_out_425061.awb") ~= 0 then
					local var_212_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061051", "story_v_out_425061.awb") / 1000

					if var_212_11 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_5
					end

					if var_212_7.prefab_name ~= "" and arg_209_1.actors_[var_212_7.prefab_name] ~= nil then
						local var_212_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_7.prefab_name].transform, "story_v_out_425061", "425061051", "story_v_out_425061.awb")

						arg_209_1:RecordAudio("425061051", var_212_12)
						arg_209_1:RecordAudio("425061051", var_212_12)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_425061", "425061051", "story_v_out_425061.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_425061", "425061051", "story_v_out_425061.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_13 = math.max(var_212_6, arg_209_1.talkMaxDuration)

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_13 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_5) / var_212_13

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_5 + var_212_13 and arg_209_1.time_ < var_212_5 + var_212_13 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play425061052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 425061052
		arg_213_1.duration_ = 9.43

		local var_213_0 = {
			zh = 9.433,
			ja = 8.833
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play425061053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if arg_213_1.actors_["1066"] == nil then
				local var_216_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1066")

				if not isNil(var_216_0) then
					local var_216_1 = Object.Instantiate(var_216_0, arg_213_1.canvasGo_.transform)

					var_216_1.transform:SetSiblingIndex(1)

					var_216_1.name = "1066"
					var_216_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_213_1.actors_["1066"] = var_216_1

					if arg_213_1.isInRecall_ then
						for iter_216_0, iter_216_1 in ipairs((var_216_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_216_1.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_216_2 = arg_213_1.actors_["1066"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps1066 == nil then
				arg_213_1.var_.actorSpriteComps1066 = var_216_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_3 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.actorSpriteComps1066 then
					for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_216_3 then
							if arg_213_1.isInRecall_ then
								iter_216_3.color = Color.New(Mathf.Lerp(iter_216_3.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_3), Mathf.Lerp(iter_216_3.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_3), (Mathf.Lerp(iter_216_3.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_3)))
							else
								local var_216_4 = Mathf.Lerp(iter_216_3.color.r, 1, (arg_213_1.time_ - 0) / var_216_3)

								iter_216_3.color = Color.New(var_216_4, var_216_4, var_216_4)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps1066 then
				for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_216_5 then
						iter_216_5.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps1066 = nil
			end

			local var_216_5 = arg_213_1.actors_["1033"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_5) and arg_213_1.var_.actorSpriteComps1033 == nil then
				arg_213_1.var_.actorSpriteComps1033 = var_216_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_6 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_6 and not isNil(var_216_5) then
				if arg_213_1.var_.actorSpriteComps1033 then
					for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_216_7 then
							if arg_213_1.isInRecall_ then
								iter_216_7.color = Color.New(Mathf.Lerp(iter_216_7.color.r, arg_213_1.hightColor2.r, (arg_213_1.time_ - 0) / var_216_6), Mathf.Lerp(iter_216_7.color.g, arg_213_1.hightColor2.g, (arg_213_1.time_ - 0) / var_216_6), (Mathf.Lerp(iter_216_7.color.b, arg_213_1.hightColor2.b, (arg_213_1.time_ - 0) / var_216_6)))
							else
								local var_216_7 = Mathf.Lerp(iter_216_7.color.r, 0.5, (arg_213_1.time_ - 0) / var_216_6)

								iter_216_7.color = Color.New(var_216_7, var_216_7, var_216_7)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_6 and arg_213_1.time_ < 0 + var_216_6 + arg_216_0 and not isNil(var_216_5) and arg_213_1.var_.actorSpriteComps1033 then
				for iter_216_8, iter_216_9 in pairs(arg_213_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_216_9 then
						iter_216_9.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps1033 = nil
			end

			local var_216_8 = arg_213_1.actors_["1066"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1066 = var_216_8.localPosition
				var_216_8.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1066", 4)

				for iter_216_10 = 0, var_216_8.childCount - 1 do
					local var_216_9 = var_216_8:GetChild(iter_216_10)

					if var_216_9.name == "" or not string.find(var_216_9.name, "split") then
						var_216_9.gameObject:SetActive(true)
					else
						var_216_9.gameObject:SetActive(false)
					end
				end
			end

			local var_216_10 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_10 then
				var_216_8.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1066, Vector3.New(453.9, -399.1, -303.3), (arg_213_1.time_ - 0) / var_216_10)
			end

			if arg_213_1.time_ >= 0 + var_216_10 and arg_213_1.time_ < 0 + var_216_10 + arg_216_0 then
				var_216_8.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_216_11 = arg_213_1.actors_["1033"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1033 = var_216_11.localPosition
				var_216_11.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1033", 2)

				for iter_216_11 = 0, var_216_11.childCount - 1 do
					local var_216_12 = var_216_11:GetChild(iter_216_11)

					if var_216_12.name == "" or not string.find(var_216_12.name, "split") then
						var_216_12.gameObject:SetActive(true)
					else
						var_216_12.gameObject:SetActive(false)
					end
				end
			end

			local var_216_13 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_13 then
				var_216_11.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_213_1.time_ - 0) / var_216_13)
			end

			if arg_213_1.time_ >= 0 + var_216_13 and arg_213_1.time_ < 0 + var_216_13 + arg_216_0 then
				var_216_11.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_216_14 = 0
			local var_216_15 = 1.125

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_14 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_16 = arg_213_1:GetWordFromCfg(425061052)
				local var_216_17 = arg_213_1:FormatText(var_216_16.content)

				arg_213_1.text_.text = var_216_17

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_19 = 45 <= 0 and var_216_15 or var_216_15 * (utf8.len(var_216_17) / 45)

				if (45 <= 0 and var_216_15 or var_216_15 * (utf8.len(var_216_17) / 45)) > 0 and var_216_15 < var_216_19 then
					arg_213_1.talkMaxDuration = var_216_19

					if var_216_19 + var_216_14 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_19 + var_216_14
					end
				end

				arg_213_1.text_.text = var_216_17
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061052", "story_v_out_425061.awb") ~= 0 then
					local var_216_20 = manager.audio:GetVoiceLength("story_v_out_425061", "425061052", "story_v_out_425061.awb") / 1000

					if var_216_20 + var_216_14 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_20 + var_216_14
					end

					if var_216_16.prefab_name ~= "" and arg_213_1.actors_[var_216_16.prefab_name] ~= nil then
						local var_216_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_16.prefab_name].transform, "story_v_out_425061", "425061052", "story_v_out_425061.awb")

						arg_213_1:RecordAudio("425061052", var_216_21)
						arg_213_1:RecordAudio("425061052", var_216_21)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_425061", "425061052", "story_v_out_425061.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_425061", "425061052", "story_v_out_425061.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_22 = math.max(var_216_15, arg_213_1.talkMaxDuration)

			if var_216_14 <= arg_213_1.time_ and arg_213_1.time_ < var_216_14 + var_216_22 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_14) / var_216_22

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_14 + var_216_22 and arg_213_1.time_ < var_216_14 + var_216_22 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play425061053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 425061053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play425061054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1066"]) and arg_217_1.var_.actorSpriteComps1066 == nil then
				arg_217_1.var_.actorSpriteComps1066 = arg_217_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_0 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1066"]) then
				if arg_217_1.var_.actorSpriteComps1066 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								iter_220_1.color = Color.New(Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor2.r, (arg_217_1.time_ - 0) / var_220_0), Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor2.g, (arg_217_1.time_ - 0) / var_220_0), (Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor2.b, (arg_217_1.time_ - 0) / var_220_0)))
							else
								local var_220_1 = Mathf.Lerp(iter_220_1.color.r, 0.5, (arg_217_1.time_ - 0) / var_220_0)

								iter_220_1.color = Color.New(var_220_1, var_220_1, var_220_1)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1066"]) and arg_217_1.var_.actorSpriteComps1066 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_220_3 then
						iter_220_3.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_217_1.var_.actorSpriteComps1066 = nil
			end

			local var_220_2 = 0
			local var_220_3 = 0.675

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_4 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(425061053).content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_6 = 27 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_4) / 27)

				if (27 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_4) / 27)) > 0 and var_220_3 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_2
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_3, arg_217_1.talkMaxDuration)

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_2) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_2 + var_220_7 and arg_217_1.time_ < var_220_2 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play425061054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 425061054
		arg_221_1.duration_ = 2.37

		local var_221_0 = {
			zh = 2.366,
			ja = 1.7
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
				arg_221_0:Play425061055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1066"]) and arg_221_1.var_.actorSpriteComps1066 == nil then
				arg_221_1.var_.actorSpriteComps1066 = arg_221_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_0 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1066"]) then
				if arg_221_1.var_.actorSpriteComps1066 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								iter_224_1.color = Color.New(Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor1.r, (arg_221_1.time_ - 0) / var_224_0), Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor1.g, (arg_221_1.time_ - 0) / var_224_0), (Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor1.b, (arg_221_1.time_ - 0) / var_224_0)))
							else
								local var_224_1 = Mathf.Lerp(iter_224_1.color.r, 1, (arg_221_1.time_ - 0) / var_224_0)

								iter_224_1.color = Color.New(var_224_1, var_224_1, var_224_1)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1066"]) and arg_221_1.var_.actorSpriteComps1066 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_224_3 then
						iter_224_3.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps1066 = nil
			end

			local var_224_2 = arg_221_1.actors_["1066"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1066 = var_224_2.localPosition
				var_224_2.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1066", 4)

				for iter_224_4 = 0, var_224_2.childCount - 1 do
					local var_224_3 = var_224_2:GetChild(iter_224_4)

					if var_224_3.name == "" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				var_224_2.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1066, Vector3.New(453.9, -399.1, -303.3), (arg_221_1.time_ - 0) / var_224_4)
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				var_224_2.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_224_5 = 0
			local var_224_6 = 0.275

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_7 = arg_221_1:GetWordFromCfg(425061054)
				local var_224_8 = arg_221_1:FormatText(var_224_7.content)

				arg_221_1.text_.text = var_224_8

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_10 = 11 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 11)

				if (11 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 11)) > 0 and var_224_6 < var_224_10 then
					arg_221_1.talkMaxDuration = var_224_10

					if var_224_10 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_5
					end
				end

				arg_221_1.text_.text = var_224_8
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061054", "story_v_out_425061.awb") ~= 0 then
					local var_224_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061054", "story_v_out_425061.awb") / 1000

					if var_224_11 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_11 + var_224_5
					end

					if var_224_7.prefab_name ~= "" and arg_221_1.actors_[var_224_7.prefab_name] ~= nil then
						local var_224_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_7.prefab_name].transform, "story_v_out_425061", "425061054", "story_v_out_425061.awb")

						arg_221_1:RecordAudio("425061054", var_224_12)
						arg_221_1:RecordAudio("425061054", var_224_12)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_425061", "425061054", "story_v_out_425061.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_425061", "425061054", "story_v_out_425061.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_13 = math.max(var_224_6, arg_221_1.talkMaxDuration)

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_13 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_5) / var_224_13

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_5 + var_224_13 and arg_221_1.time_ < var_224_5 + var_224_13 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
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
	Play425061055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 425061055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play425061056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1066"]) and arg_225_1.var_.actorSpriteComps1066 == nil then
				arg_225_1.var_.actorSpriteComps1066 = arg_225_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_0 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1066"]) then
				if arg_225_1.var_.actorSpriteComps1066 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_228_1 then
							if arg_225_1.isInRecall_ then
								iter_228_1.color = Color.New(Mathf.Lerp(iter_228_1.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 0) / var_228_0), Mathf.Lerp(iter_228_1.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 0) / var_228_0), (Mathf.Lerp(iter_228_1.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 0) / var_228_0)))
							else
								local var_228_1 = Mathf.Lerp(iter_228_1.color.r, 0.5, (arg_225_1.time_ - 0) / var_228_0)

								iter_228_1.color = Color.New(var_228_1, var_228_1, var_228_1)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1066"]) and arg_225_1.var_.actorSpriteComps1066 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_228_3 then
						iter_228_3.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps1066 = nil
			end

			local var_228_2 = 0
			local var_228_3 = 0.4

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_2 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_4 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(425061055).content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_6 = 16 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_4) / 16)

				if (16 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_4) / 16)) > 0 and var_228_3 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_2
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_3, arg_225_1.talkMaxDuration)

			if var_228_2 <= arg_225_1.time_ and arg_225_1.time_ < var_228_2 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_2) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_2 + var_228_7 and arg_225_1.time_ < var_228_2 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play425061056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 425061056
		arg_229_1.duration_ = 11.93

		local var_229_0 = {
			zh = 7.566,
			ja = 11.933
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play425061057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1033"]) and arg_229_1.var_.actorSpriteComps1033 == nil then
				arg_229_1.var_.actorSpriteComps1033 = arg_229_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1033"]) then
				if arg_229_1.var_.actorSpriteComps1033 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								iter_232_1.color = Color.New(Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor1.r, (arg_229_1.time_ - 0) / var_232_0), Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor1.g, (arg_229_1.time_ - 0) / var_232_0), (Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor1.b, (arg_229_1.time_ - 0) / var_232_0)))
							else
								local var_232_1 = Mathf.Lerp(iter_232_1.color.r, 1, (arg_229_1.time_ - 0) / var_232_0)

								iter_232_1.color = Color.New(var_232_1, var_232_1, var_232_1)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1033"]) and arg_229_1.var_.actorSpriteComps1033 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_232_3 then
						iter_232_3.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_229_1.var_.actorSpriteComps1033 = nil
			end

			local var_232_2 = arg_229_1.actors_["1033"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1033 = var_232_2.localPosition
				var_232_2.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1033", 2)

				for iter_232_4 = 0, var_232_2.childCount - 1 do
					local var_232_3 = var_232_2:GetChild(iter_232_4)

					if var_232_3.name == "" or not string.find(var_232_3.name, "split") then
						var_232_3.gameObject:SetActive(true)
					else
						var_232_3.gameObject:SetActive(false)
					end
				end
			end

			local var_232_4 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				var_232_2.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_229_1.time_ - 0) / var_232_4)
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				var_232_2.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_232_5 = 0
			local var_232_6 = 1

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_7 = arg_229_1:GetWordFromCfg(425061056)
				local var_232_8 = arg_229_1:FormatText(var_232_7.content)

				arg_229_1.text_.text = var_232_8

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_10 = 40 <= 0 and var_232_6 or var_232_6 * (utf8.len(var_232_8) / 40)

				if (40 <= 0 and var_232_6 or var_232_6 * (utf8.len(var_232_8) / 40)) > 0 and var_232_6 < var_232_10 then
					arg_229_1.talkMaxDuration = var_232_10

					if var_232_10 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_5
					end
				end

				arg_229_1.text_.text = var_232_8
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061056", "story_v_out_425061.awb") ~= 0 then
					local var_232_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061056", "story_v_out_425061.awb") / 1000

					if var_232_11 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_11 + var_232_5
					end

					if var_232_7.prefab_name ~= "" and arg_229_1.actors_[var_232_7.prefab_name] ~= nil then
						local var_232_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_7.prefab_name].transform, "story_v_out_425061", "425061056", "story_v_out_425061.awb")

						arg_229_1:RecordAudio("425061056", var_232_12)
						arg_229_1:RecordAudio("425061056", var_232_12)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_425061", "425061056", "story_v_out_425061.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_425061", "425061056", "story_v_out_425061.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_13 = math.max(var_232_6, arg_229_1.talkMaxDuration)

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_13 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_5) / var_232_13

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_5 + var_232_13 and arg_229_1.time_ < var_232_5 + var_232_13 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play425061057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 425061057
		arg_233_1.duration_ = 9.6

		local var_233_0 = {
			zh = 8.366,
			ja = 9.6
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play425061058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1033 = arg_233_1.actors_["1033"].transform.localPosition
				arg_233_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1033", 2)

				for iter_236_0 = 0, arg_233_1.actors_["1033"].transform.childCount - 1 do
					local var_236_0 = arg_233_1.actors_["1033"].transform:GetChild(iter_236_0)

					if var_236_0.name == "" or not string.find(var_236_0.name, "split") then
						var_236_0.gameObject:SetActive(true)
					else
						var_236_0.gameObject:SetActive(false)
					end
				end
			end

			local var_236_1 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_1 then
				arg_233_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_233_1.time_ - 0) / var_236_1)
			end

			if arg_233_1.time_ >= 0 + var_236_1 and arg_233_1.time_ < 0 + var_236_1 + arg_236_0 then
				arg_233_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_236_2 = 0
			local var_236_3 = 1.125

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_4 = arg_233_1:GetWordFromCfg(425061057)
				local var_236_5 = arg_233_1:FormatText(var_236_4.content)

				arg_233_1.text_.text = var_236_5

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_7 = 45 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 45)

				if (45 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 45)) > 0 and var_236_3 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_2
					end
				end

				arg_233_1.text_.text = var_236_5
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061057", "story_v_out_425061.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_425061", "425061057", "story_v_out_425061.awb") / 1000

					if var_236_8 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_2
					end

					if var_236_4.prefab_name ~= "" and arg_233_1.actors_[var_236_4.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_4.prefab_name].transform, "story_v_out_425061", "425061057", "story_v_out_425061.awb")

						arg_233_1:RecordAudio("425061057", var_236_9)
						arg_233_1:RecordAudio("425061057", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_425061", "425061057", "story_v_out_425061.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_425061", "425061057", "story_v_out_425061.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_3, arg_233_1.talkMaxDuration)

			if var_236_2 <= arg_233_1.time_ and arg_233_1.time_ < var_236_2 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_2) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_2 + var_236_10 and arg_233_1.time_ < var_236_2 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play425061058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 425061058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play425061059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1033 = arg_237_1.actors_["1033"].transform.localPosition
				arg_237_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1033", 7)

				for iter_240_0 = 0, arg_237_1.actors_["1033"].transform.childCount - 1 do
					local var_240_0 = arg_237_1.actors_["1033"].transform:GetChild(iter_240_0)

					if var_240_0.name == "" or not string.find(var_240_0.name, "split") then
						var_240_0.gameObject:SetActive(true)
					else
						var_240_0.gameObject:SetActive(false)
					end
				end
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				arg_237_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_237_1.time_ - 0) / var_240_1)
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				arg_237_1.actors_["1033"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_240_2 = arg_237_1.actors_["1066"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1066 = var_240_2.localPosition
				var_240_2.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1066", 7)

				for iter_240_1 = 0, var_240_2.childCount - 1 do
					local var_240_3 = var_240_2:GetChild(iter_240_1)

					if var_240_3.name == "" or not string.find(var_240_3.name, "split") then
						var_240_3.gameObject:SetActive(true)
					else
						var_240_3.gameObject:SetActive(false)
					end
				end
			end

			local var_240_4 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				var_240_2.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1066, Vector3.New(0, -2000, 0), (arg_237_1.time_ - 0) / var_240_4)
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				var_240_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_240_5 = 0
			local var_240_6 = 1.175

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_7 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(425061058).content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 47 <= 0 and var_240_6 or var_240_6 * (utf8.len(var_240_7) / 47)

				if (47 <= 0 and var_240_6 or var_240_6 * (utf8.len(var_240_7) / 47)) > 0 and var_240_6 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_5 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_5
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_6, arg_237_1.talkMaxDuration)

			if var_240_5 <= arg_237_1.time_ and arg_237_1.time_ < var_240_5 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_5) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_5 + var_240_10 and arg_237_1.time_ < var_240_5 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1066",
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
	Play425061059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 425061059
		arg_241_1.duration_ = 6.87

		local var_241_0 = {
			zh = 3.033,
			ja = 6.866
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
				arg_241_0:Play425061060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1037"]) and arg_241_1.var_.actorSpriteComps1037 == nil then
				arg_241_1.var_.actorSpriteComps1037 = arg_241_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_0 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1037"]) then
				if arg_241_1.var_.actorSpriteComps1037 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1037"]) and arg_241_1.var_.actorSpriteComps1037 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_244_3 then
						iter_244_3.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_241_1.var_.actorSpriteComps1037 = nil
			end

			local var_244_2 = arg_241_1.actors_["1037"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1037 = var_244_2.localPosition
				var_244_2.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("1037", 3)

				for iter_244_4 = 0, var_244_2.childCount - 1 do
					local var_244_3 = var_244_2:GetChild(iter_244_4)

					if var_244_3.name == "" or not string.find(var_244_3.name, "split") then
						var_244_3.gameObject:SetActive(true)
					else
						var_244_3.gameObject:SetActive(false)
					end
				end
			end

			local var_244_4 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				var_244_2.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_241_1.time_ - 0) / var_244_4)
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				var_244_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_244_5 = 0
			local var_244_6 = 0.3

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_7 = arg_241_1:GetWordFromCfg(425061059)
				local var_244_8 = arg_241_1:FormatText(var_244_7.content)

				arg_241_1.text_.text = var_244_8

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_10 = 12 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 12)

				if (12 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 12)) > 0 and var_244_6 < var_244_10 then
					arg_241_1.talkMaxDuration = var_244_10

					if var_244_10 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_5
					end
				end

				arg_241_1.text_.text = var_244_8
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061059", "story_v_out_425061.awb") ~= 0 then
					local var_244_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061059", "story_v_out_425061.awb") / 1000

					if var_244_11 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_11 + var_244_5
					end

					if var_244_7.prefab_name ~= "" and arg_241_1.actors_[var_244_7.prefab_name] ~= nil then
						local var_244_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_7.prefab_name].transform, "story_v_out_425061", "425061059", "story_v_out_425061.awb")

						arg_241_1:RecordAudio("425061059", var_244_12)
						arg_241_1:RecordAudio("425061059", var_244_12)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_425061", "425061059", "story_v_out_425061.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_425061", "425061059", "story_v_out_425061.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_13 = math.max(var_244_6, arg_241_1.talkMaxDuration)

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_13 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_5) / var_244_13

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_5 + var_244_13 and arg_241_1.time_ < var_244_5 + var_244_13 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 425061060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play425061061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1037"]) and arg_245_1.var_.actorSpriteComps1037 == nil then
				arg_245_1.var_.actorSpriteComps1037 = arg_245_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_0 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1037"]) then
				if arg_245_1.var_.actorSpriteComps1037 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_248_1 then
							if arg_245_1.isInRecall_ then
								iter_248_1.color = Color.New(Mathf.Lerp(iter_248_1.color.r, arg_245_1.hightColor2.r, (arg_245_1.time_ - 0) / var_248_0), Mathf.Lerp(iter_248_1.color.g, arg_245_1.hightColor2.g, (arg_245_1.time_ - 0) / var_248_0), (Mathf.Lerp(iter_248_1.color.b, arg_245_1.hightColor2.b, (arg_245_1.time_ - 0) / var_248_0)))
							else
								local var_248_1 = Mathf.Lerp(iter_248_1.color.r, 0.5, (arg_245_1.time_ - 0) / var_248_0)

								iter_248_1.color = Color.New(var_248_1, var_248_1, var_248_1)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1037"]) and arg_245_1.var_.actorSpriteComps1037 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_248_3 then
						iter_248_3.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_245_1.var_.actorSpriteComps1037 = nil
			end

			local var_248_2 = 0
			local var_248_3 = 0.15

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_4 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(425061060).content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 6 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 6)

				if (6 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 6)) > 0 and var_248_3 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_7 and arg_245_1.time_ < var_248_2 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play425061061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 425061061
		arg_249_1.duration_ = 8.9

		local var_249_0 = {
			zh = 8.166,
			ja = 8.9
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
				arg_249_0:Play425061062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1037"]) and arg_249_1.var_.actorSpriteComps1037 == nil then
				arg_249_1.var_.actorSpriteComps1037 = arg_249_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1037"]) then
				if arg_249_1.var_.actorSpriteComps1037 then
					for iter_252_0, iter_252_1 in pairs(arg_249_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1037"]) and arg_249_1.var_.actorSpriteComps1037 then
				for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_252_3 then
						iter_252_3.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps1037 = nil
			end

			local var_252_2 = arg_249_1.actors_["1037"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1037 = var_252_2.localPosition
				var_252_2.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1037", 3)

				for iter_252_4 = 0, var_252_2.childCount - 1 do
					local var_252_3 = var_252_2:GetChild(iter_252_4)

					if var_252_3.name == "split_1" or not string.find(var_252_3.name, "split") then
						var_252_3.gameObject:SetActive(true)
					else
						var_252_3.gameObject:SetActive(false)
					end
				end
			end

			local var_252_4 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				var_252_2.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_249_1.time_ - 0) / var_252_4)
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				var_252_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_252_5 = 0
			local var_252_6 = 0.975

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_7 = arg_249_1:GetWordFromCfg(425061061)
				local var_252_8 = arg_249_1:FormatText(var_252_7.content)

				arg_249_1.text_.text = var_252_8

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_10 = 39 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 39)

				if (39 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 39)) > 0 and var_252_6 < var_252_10 then
					arg_249_1.talkMaxDuration = var_252_10

					if var_252_10 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_5
					end
				end

				arg_249_1.text_.text = var_252_8
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061061", "story_v_out_425061.awb") ~= 0 then
					local var_252_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061061", "story_v_out_425061.awb") / 1000

					if var_252_11 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_5
					end

					if var_252_7.prefab_name ~= "" and arg_249_1.actors_[var_252_7.prefab_name] ~= nil then
						local var_252_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_7.prefab_name].transform, "story_v_out_425061", "425061061", "story_v_out_425061.awb")

						arg_249_1:RecordAudio("425061061", var_252_12)
						arg_249_1:RecordAudio("425061061", var_252_12)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_425061", "425061061", "story_v_out_425061.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_425061", "425061061", "story_v_out_425061.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_13 = math.max(var_252_6, arg_249_1.talkMaxDuration)

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_13 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_5) / var_252_13

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_5 + var_252_13 and arg_249_1.time_ < var_252_5 + var_252_13 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 425061062
		arg_253_1.duration_ = 11.83

		local var_253_0 = {
			zh = 8.833,
			ja = 11.833
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
				arg_253_0:Play425061063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 1.125

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:GetWordFromCfg(425061062)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 45 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 45)

				if (45 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 45)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061062", "story_v_out_425061.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_425061", "425061062", "story_v_out_425061.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_425061", "425061062", "story_v_out_425061.awb")

						arg_253_1:RecordAudio("425061062", var_256_6)
						arg_253_1:RecordAudio("425061062", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_425061", "425061062", "story_v_out_425061.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_425061", "425061062", "story_v_out_425061.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play425061063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 425061063
		arg_257_1.duration_ = 2.9

		local var_257_0 = {
			zh = 2.9,
			ja = 2.3
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
				arg_257_0:Play425061064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1066"]) and arg_257_1.var_.actorSpriteComps1066 == nil then
				arg_257_1.var_.actorSpriteComps1066 = arg_257_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_0 = 0.034

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1066"]) then
				if arg_257_1.var_.actorSpriteComps1066 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								iter_260_1.color = Color.New(Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor1.r, (arg_257_1.time_ - 0) / var_260_0), Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor1.g, (arg_257_1.time_ - 0) / var_260_0), (Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor1.b, (arg_257_1.time_ - 0) / var_260_0)))
							else
								local var_260_1 = Mathf.Lerp(iter_260_1.color.r, 1, (arg_257_1.time_ - 0) / var_260_0)

								iter_260_1.color = Color.New(var_260_1, var_260_1, var_260_1)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1066"]) and arg_257_1.var_.actorSpriteComps1066 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_260_3 then
						iter_260_3.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_257_1.var_.actorSpriteComps1066 = nil
			end

			local var_260_2 = arg_257_1.actors_["1037"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps1037 == nil then
				arg_257_1.var_.actorSpriteComps1037 = var_260_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_3 = 0.034

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.actorSpriteComps1037 then
					for iter_260_4, iter_260_5 in pairs(arg_257_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_260_5 then
							if arg_257_1.isInRecall_ then
								iter_260_5.color = Color.New(Mathf.Lerp(iter_260_5.color.r, arg_257_1.hightColor2.r, (arg_257_1.time_ - 0) / var_260_3), Mathf.Lerp(iter_260_5.color.g, arg_257_1.hightColor2.g, (arg_257_1.time_ - 0) / var_260_3), (Mathf.Lerp(iter_260_5.color.b, arg_257_1.hightColor2.b, (arg_257_1.time_ - 0) / var_260_3)))
							else
								local var_260_4 = Mathf.Lerp(iter_260_5.color.r, 0.5, (arg_257_1.time_ - 0) / var_260_3)

								iter_260_5.color = Color.New(var_260_4, var_260_4, var_260_4)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps1037 then
				for iter_260_6, iter_260_7 in pairs(arg_257_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_260_7 then
						iter_260_7.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_257_1.var_.actorSpriteComps1037 = nil
			end

			local var_260_5 = arg_257_1.actors_["1037"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1037 = var_260_5.localPosition
				var_260_5.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1037", 2)

				for iter_260_8 = 0, var_260_5.childCount - 1 do
					local var_260_6 = var_260_5:GetChild(iter_260_8)

					if var_260_6.name == "split_1" or not string.find(var_260_6.name, "split") then
						var_260_6.gameObject:SetActive(true)
					else
						var_260_6.gameObject:SetActive(false)
					end
				end
			end

			local var_260_7 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				var_260_5.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1037, Vector3.New(-390, -430, -55), (arg_257_1.time_ - 0) / var_260_7)
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				var_260_5.localPosition = Vector3.New(-390, -430, -55)
			end

			local var_260_8 = arg_257_1.actors_["1066"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1066 = var_260_8.localPosition
				var_260_8.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1066", 4)

				for iter_260_9 = 0, var_260_8.childCount - 1 do
					local var_260_9 = var_260_8:GetChild(iter_260_9)

					if var_260_9.name == "split_3" or not string.find(var_260_9.name, "split") then
						var_260_9.gameObject:SetActive(true)
					else
						var_260_9.gameObject:SetActive(false)
					end
				end
			end

			local var_260_10 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_10 then
				var_260_8.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1066, Vector3.New(453.9, -399.1, -303.3), (arg_257_1.time_ - 0) / var_260_10)
			end

			if arg_257_1.time_ >= 0 + var_260_10 and arg_257_1.time_ < 0 + var_260_10 + arg_260_0 then
				var_260_8.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_260_11 = 0
			local var_260_12 = 0.275

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_11 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_13 = arg_257_1:GetWordFromCfg(425061063)
				local var_260_14 = arg_257_1:FormatText(var_260_13.content)

				arg_257_1.text_.text = var_260_14

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_16 = 11 <= 0 and var_260_12 or var_260_12 * (utf8.len(var_260_14) / 11)

				if (11 <= 0 and var_260_12 or var_260_12 * (utf8.len(var_260_14) / 11)) > 0 and var_260_12 < var_260_16 then
					arg_257_1.talkMaxDuration = var_260_16

					if var_260_16 + var_260_11 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_16 + var_260_11
					end
				end

				arg_257_1.text_.text = var_260_14
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061063", "story_v_out_425061.awb") ~= 0 then
					local var_260_17 = manager.audio:GetVoiceLength("story_v_out_425061", "425061063", "story_v_out_425061.awb") / 1000

					if var_260_17 + var_260_11 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_17 + var_260_11
					end

					if var_260_13.prefab_name ~= "" and arg_257_1.actors_[var_260_13.prefab_name] ~= nil then
						local var_260_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_13.prefab_name].transform, "story_v_out_425061", "425061063", "story_v_out_425061.awb")

						arg_257_1:RecordAudio("425061063", var_260_18)
						arg_257_1:RecordAudio("425061063", var_260_18)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_425061", "425061063", "story_v_out_425061.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_425061", "425061063", "story_v_out_425061.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_19 = math.max(var_260_12, arg_257_1.talkMaxDuration)

			if var_260_11 <= arg_257_1.time_ and arg_257_1.time_ < var_260_11 + var_260_19 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_11) / var_260_19

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_11 + var_260_19 and arg_257_1.time_ < var_260_11 + var_260_19 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1066",
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
	Play425061064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 425061064
		arg_261_1.duration_ = 1.3

		local var_261_0 = {
			zh = 1.266,
			ja = 1.3
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
				arg_261_0:Play425061065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1033"]) and arg_261_1.var_.actorSpriteComps1033 == nil then
				arg_261_1.var_.actorSpriteComps1033 = arg_261_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_0 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1033"]) then
				if arg_261_1.var_.actorSpriteComps1033 then
					for iter_264_0, iter_264_1 in pairs(arg_261_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_264_1 then
							if arg_261_1.isInRecall_ then
								iter_264_1.color = Color.New(Mathf.Lerp(iter_264_1.color.r, arg_261_1.hightColor1.r, (arg_261_1.time_ - 0) / var_264_0), Mathf.Lerp(iter_264_1.color.g, arg_261_1.hightColor1.g, (arg_261_1.time_ - 0) / var_264_0), (Mathf.Lerp(iter_264_1.color.b, arg_261_1.hightColor1.b, (arg_261_1.time_ - 0) / var_264_0)))
							else
								local var_264_1 = Mathf.Lerp(iter_264_1.color.r, 1, (arg_261_1.time_ - 0) / var_264_0)

								iter_264_1.color = Color.New(var_264_1, var_264_1, var_264_1)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1033"]) and arg_261_1.var_.actorSpriteComps1033 then
				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_264_3 then
						iter_264_3.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps1033 = nil
			end

			local var_264_2 = arg_261_1.actors_["1066"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps1066 == nil then
				arg_261_1.var_.actorSpriteComps1066 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps1066 then
					for iter_264_4, iter_264_5 in pairs(arg_261_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_264_5 then
							if arg_261_1.isInRecall_ then
								iter_264_5.color = Color.New(Mathf.Lerp(iter_264_5.color.r, arg_261_1.hightColor2.r, (arg_261_1.time_ - 0) / var_264_3), Mathf.Lerp(iter_264_5.color.g, arg_261_1.hightColor2.g, (arg_261_1.time_ - 0) / var_264_3), (Mathf.Lerp(iter_264_5.color.b, arg_261_1.hightColor2.b, (arg_261_1.time_ - 0) / var_264_3)))
							else
								local var_264_4 = Mathf.Lerp(iter_264_5.color.r, 0.5, (arg_261_1.time_ - 0) / var_264_3)

								iter_264_5.color = Color.New(var_264_4, var_264_4, var_264_4)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps1066 then
				for iter_264_6, iter_264_7 in pairs(arg_261_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_264_7 then
						iter_264_7.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_261_1.var_.actorSpriteComps1066 = nil
			end

			local var_264_5 = arg_261_1.actors_["1033"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1033 = var_264_5.localPosition
				var_264_5.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1033", 2)

				for iter_264_8 = 0, var_264_5.childCount - 1 do
					local var_264_6 = var_264_5:GetChild(iter_264_8)

					if var_264_6.name == "split_6" or not string.find(var_264_6.name, "split") then
						var_264_6.gameObject:SetActive(true)
					else
						var_264_6.gameObject:SetActive(false)
					end
				end
			end

			local var_264_7 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				var_264_5.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_261_1.time_ - 0) / var_264_7)
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				var_264_5.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_264_8 = arg_261_1.actors_["1037"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1037 = var_264_8.localPosition
				var_264_8.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1037", 7)

				for iter_264_9 = 0, var_264_8.childCount - 1 do
					local var_264_9 = var_264_8:GetChild(iter_264_9)

					if var_264_9.name == "" or not string.find(var_264_9.name, "split") then
						var_264_9.gameObject:SetActive(true)
					else
						var_264_9.gameObject:SetActive(false)
					end
				end
			end

			local var_264_10 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_10 then
				var_264_8.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_261_1.time_ - 0) / var_264_10)
			end

			if arg_261_1.time_ >= 0 + var_264_10 and arg_261_1.time_ < 0 + var_264_10 + arg_264_0 then
				var_264_8.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_264_11 = 0
			local var_264_12 = 0.125

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_11 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_13 = arg_261_1:GetWordFromCfg(425061064)
				local var_264_14 = arg_261_1:FormatText(var_264_13.content)

				arg_261_1.text_.text = var_264_14

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_16 = 5 <= 0 and var_264_12 or var_264_12 * (utf8.len(var_264_14) / 5)

				if (5 <= 0 and var_264_12 or var_264_12 * (utf8.len(var_264_14) / 5)) > 0 and var_264_12 < var_264_16 then
					arg_261_1.talkMaxDuration = var_264_16

					if var_264_16 + var_264_11 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_16 + var_264_11
					end
				end

				arg_261_1.text_.text = var_264_14
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061064", "story_v_out_425061.awb") ~= 0 then
					local var_264_17 = manager.audio:GetVoiceLength("story_v_out_425061", "425061064", "story_v_out_425061.awb") / 1000

					if var_264_17 + var_264_11 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_17 + var_264_11
					end

					if var_264_13.prefab_name ~= "" and arg_261_1.actors_[var_264_13.prefab_name] ~= nil then
						local var_264_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_13.prefab_name].transform, "story_v_out_425061", "425061064", "story_v_out_425061.awb")

						arg_261_1:RecordAudio("425061064", var_264_18)
						arg_261_1:RecordAudio("425061064", var_264_18)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_425061", "425061064", "story_v_out_425061.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_425061", "425061064", "story_v_out_425061.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_19 = math.max(var_264_12, arg_261_1.talkMaxDuration)

			if var_264_11 <= arg_261_1.time_ and arg_261_1.time_ < var_264_11 + var_264_19 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_11) / var_264_19

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_11 + var_264_19 and arg_261_1.time_ < var_264_11 + var_264_19 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 425061065
		arg_265_1.duration_ = 12.9

		local var_265_0 = {
			zh = 8.466,
			ja = 12.9
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
				arg_265_0:Play425061066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 2 < arg_265_1.time_ and arg_265_1.time_ <= 2 + arg_268_0 then
				local var_268_0 = arg_265_1.bgs_.ST10

				arg_265_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_268_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_1 = var_268_0:GetComponent("SpriteRenderer")

				if var_268_1 and var_268_1.sprite then
					local var_268_2 = 2 * (var_268_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_268_0.transform.localScale = Vector3.New(var_268_2 / var_268_1.sprite.bounds.size.y < var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x and var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x or var_268_2 / var_268_1.sprite.bounds.size.y, var_268_2 / var_268_1.sprite.bounds.size.y < var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x and var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x or var_268_2 / var_268_1.sprite.bounds.size.y, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "ST10" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_3 = 4

			if 4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_3 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			if arg_265_1.time_ >= var_268_3 + 0.3 and arg_265_1.time_ < var_268_3 + 0.3 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			local var_268_4 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_5 = 2

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_5 then
				local var_268_6 = Color.New(0, 0, 0)

				var_268_6.a = Mathf.Lerp(0, 1, (arg_265_1.time_ - var_268_4) / var_268_5)
				arg_265_1.mask_.color = var_268_6
			end

			if arg_265_1.time_ >= var_268_4 + var_268_5 and arg_265_1.time_ < var_268_4 + var_268_5 + arg_268_0 then
				local var_268_7 = Color.New(0, 0, 0)

				var_268_7.a = 1
				arg_265_1.mask_.color = var_268_7
			end

			local var_268_8 = 2

			if 2 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_9 = 2

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_9 then
				local var_268_10 = Color.New(0, 0, 0)

				var_268_10.a = Mathf.Lerp(1, 0, (arg_265_1.time_ - var_268_8) / var_268_9)
				arg_265_1.mask_.color = var_268_10
			end

			if arg_265_1.time_ >= var_268_8 + var_268_9 and arg_265_1.time_ < var_268_8 + var_268_9 + arg_268_0 then
				local var_268_11 = Color.New(0, 0, 0)

				arg_265_1.mask_.enabled = false
				var_268_11.a = 0
				arg_265_1.mask_.color = var_268_11
			end

			local var_268_12 = arg_265_1.actors_["1033"].transform

			if 1.96666666666667 < arg_265_1.time_ and arg_265_1.time_ <= 1.96666666666667 + arg_268_0 then
				arg_265_1.var_.moveOldPos1033 = var_268_12.localPosition
				var_268_12.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1033", 7)

				for iter_268_2 = 0, var_268_12.childCount - 1 do
					local var_268_13 = var_268_12:GetChild(iter_268_2)

					if var_268_13.name == "" or not string.find(var_268_13.name, "split") then
						var_268_13.gameObject:SetActive(true)
					else
						var_268_13.gameObject:SetActive(false)
					end
				end
			end

			local var_268_14 = 0.001

			if 1.96666666666667 <= arg_265_1.time_ and arg_265_1.time_ < 1.96666666666667 + var_268_14 then
				var_268_12.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_265_1.time_ - 1.96666666666667) / var_268_14)
			end

			if arg_265_1.time_ >= 1.96666666666667 + var_268_14 and arg_265_1.time_ < 1.96666666666667 + var_268_14 + arg_268_0 then
				var_268_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_268_15 = arg_265_1.actors_["1033"].transform

			if 3.966 < arg_265_1.time_ and arg_265_1.time_ <= 3.966 + arg_268_0 then
				arg_265_1.var_.moveOldPos1033 = var_268_15.localPosition
				var_268_15.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1033", 3)

				for iter_268_3 = 0, var_268_15.childCount - 1 do
					local var_268_16 = var_268_15:GetChild(iter_268_3)

					if var_268_16.name == "" or not string.find(var_268_16.name, "split") then
						var_268_16.gameObject:SetActive(true)
					else
						var_268_16.gameObject:SetActive(false)
					end
				end
			end

			local var_268_17 = 0.001

			if 3.966 <= arg_265_1.time_ and arg_265_1.time_ < 3.966 + var_268_17 then
				var_268_15.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_265_1.time_ - 3.966) / var_268_17)
			end

			if arg_265_1.time_ >= 3.966 + var_268_17 and arg_265_1.time_ < 3.966 + var_268_17 + arg_268_0 then
				var_268_15.localPosition = Vector3.New(0, -420, 0)
			end

			local var_268_18 = arg_265_1.actors_["1066"].transform

			if 1.96666666666667 < arg_265_1.time_ and arg_265_1.time_ <= 1.96666666666667 + arg_268_0 then
				arg_265_1.var_.moveOldPos1066 = var_268_18.localPosition
				var_268_18.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1066", 7)

				for iter_268_4 = 0, var_268_18.childCount - 1 do
					local var_268_19 = var_268_18:GetChild(iter_268_4)

					if var_268_19.name == "" or not string.find(var_268_19.name, "split") then
						var_268_19.gameObject:SetActive(true)
					else
						var_268_19.gameObject:SetActive(false)
					end
				end
			end

			local var_268_20 = 0.001

			if 1.96666666666667 <= arg_265_1.time_ and arg_265_1.time_ < 1.96666666666667 + var_268_20 then
				var_268_18.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1066, Vector3.New(0, -2000, 0), (arg_265_1.time_ - 1.96666666666667) / var_268_20)
			end

			if arg_265_1.time_ >= 1.96666666666667 + var_268_20 and arg_265_1.time_ < 1.96666666666667 + var_268_20 + arg_268_0 then
				var_268_18.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_268_21 = arg_265_1.actors_["1033"]

			if 3.8 < arg_265_1.time_ and arg_265_1.time_ <= 3.8 + arg_268_0 and not isNil(var_268_21) and arg_265_1.var_.actorSpriteComps1033 == nil then
				arg_265_1.var_.actorSpriteComps1033 = var_268_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_22 = 0.2

			if 3.8 <= arg_265_1.time_ and arg_265_1.time_ < 3.8 + var_268_22 and not isNil(var_268_21) then
				if arg_265_1.var_.actorSpriteComps1033 then
					for iter_268_5, iter_268_6 in pairs(arg_265_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_268_6 then
							if arg_265_1.isInRecall_ then
								iter_268_6.color = Color.New(Mathf.Lerp(iter_268_6.color.r, arg_265_1.hightColor1.r, (arg_265_1.time_ - 3.8) / var_268_22), Mathf.Lerp(iter_268_6.color.g, arg_265_1.hightColor1.g, (arg_265_1.time_ - 3.8) / var_268_22), (Mathf.Lerp(iter_268_6.color.b, arg_265_1.hightColor1.b, (arg_265_1.time_ - 3.8) / var_268_22)))
							else
								local var_268_23 = Mathf.Lerp(iter_268_6.color.r, 1, (arg_265_1.time_ - 3.8) / var_268_22)

								iter_268_6.color = Color.New(var_268_23, var_268_23, var_268_23)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 3.8 + var_268_22 and arg_265_1.time_ < 3.8 + var_268_22 + arg_268_0 and not isNil(var_268_21) and arg_265_1.var_.actorSpriteComps1033 then
				for iter_268_7, iter_268_8 in pairs(arg_265_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_268_8 then
						iter_268_8.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_265_1.var_.actorSpriteComps1033 = nil
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_24 = 4
			local var_268_25 = 0.55

			if 4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_24 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_26 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_26:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_27 = arg_265_1:GetWordFromCfg(425061065)
				local var_268_28 = arg_265_1:FormatText(var_268_27.content)

				arg_265_1.text_.text = var_268_28

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_30 = 22 <= 0 and var_268_25 or var_268_25 * (utf8.len(var_268_28) / 22)

				if (22 <= 0 and var_268_25 or var_268_25 * (utf8.len(var_268_28) / 22)) > 0 and var_268_25 < var_268_30 then
					arg_265_1.talkMaxDuration = var_268_30
					var_268_24 = var_268_24 + 0.3

					if var_268_30 + var_268_24 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_30 + var_268_24
					end
				end

				arg_265_1.text_.text = var_268_28
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061065", "story_v_out_425061.awb") ~= 0 then
					local var_268_31 = manager.audio:GetVoiceLength("story_v_out_425061", "425061065", "story_v_out_425061.awb") / 1000

					if var_268_31 + var_268_24 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_31 + var_268_24
					end

					if var_268_27.prefab_name ~= "" and arg_265_1.actors_[var_268_27.prefab_name] ~= nil then
						local var_268_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_27.prefab_name].transform, "story_v_out_425061", "425061065", "story_v_out_425061.awb")

						arg_265_1:RecordAudio("425061065", var_268_32)
						arg_265_1:RecordAudio("425061065", var_268_32)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_425061", "425061065", "story_v_out_425061.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_425061", "425061065", "story_v_out_425061.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_33 = var_268_24 + 0.3
			local var_268_34 = math.max(var_268_25, arg_265_1.talkMaxDuration)

			if var_268_24 + 0.3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_33 + var_268_34 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_33) / var_268_34

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_33 + var_268_34 and arg_265_1.time_ < var_268_33 + var_268_34 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play425061066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 425061066
		arg_271_1.duration_ = 4.8

		local var_271_0 = {
			zh = 4.8,
			ja = 4.266
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
				arg_271_0:Play425061067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1066"]) and arg_271_1.var_.actorSpriteComps1066 == nil then
				arg_271_1.var_.actorSpriteComps1066 = arg_271_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_0 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1066"]) then
				if arg_271_1.var_.actorSpriteComps1066 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1066"]) and arg_271_1.var_.actorSpriteComps1066 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_274_3 then
						iter_274_3.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_271_1.var_.actorSpriteComps1066 = nil
			end

			local var_274_2 = arg_271_1.actors_["1033"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps1033 == nil then
				arg_271_1.var_.actorSpriteComps1033 = var_274_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_3 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 and not isNil(var_274_2) then
				if arg_271_1.var_.actorSpriteComps1033 then
					for iter_274_4, iter_274_5 in pairs(arg_271_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.actorSpriteComps1033 then
				for iter_274_6, iter_274_7 in pairs(arg_271_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_274_7 then
						iter_274_7.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_271_1.var_.actorSpriteComps1033 = nil
			end

			local var_274_5 = arg_271_1.actors_["1066"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1066 = var_274_5.localPosition
				var_274_5.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1066", 4)

				for iter_274_8 = 0, var_274_5.childCount - 1 do
					local var_274_6 = var_274_5:GetChild(iter_274_8)

					if var_274_6.name == "" or not string.find(var_274_6.name, "split") then
						var_274_6.gameObject:SetActive(true)
					else
						var_274_6.gameObject:SetActive(false)
					end
				end
			end

			local var_274_7 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 then
				var_274_5.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1066, Vector3.New(453.9, -399.1, -303.3), (arg_271_1.time_ - 0) / var_274_7)
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 then
				var_274_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_274_8 = arg_271_1.actors_["1033"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1033 = var_274_8.localPosition
				var_274_8.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1033", 2)

				for iter_274_9 = 0, var_274_8.childCount - 1 do
					local var_274_9 = var_274_8:GetChild(iter_274_9)

					if var_274_9.name == "" or not string.find(var_274_9.name, "split") then
						var_274_9.gameObject:SetActive(true)
					else
						var_274_9.gameObject:SetActive(false)
					end
				end
			end

			local var_274_10 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_10 then
				var_274_8.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_271_1.time_ - 0) / var_274_10)
			end

			if arg_271_1.time_ >= 0 + var_274_10 and arg_271_1.time_ < 0 + var_274_10 + arg_274_0 then
				var_274_8.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_274_11 = 0
			local var_274_12 = 0.575

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_11 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_13 = arg_271_1:GetWordFromCfg(425061066)
				local var_274_14 = arg_271_1:FormatText(var_274_13.content)

				arg_271_1.text_.text = var_274_14

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_16 = 23 <= 0 and var_274_12 or var_274_12 * (utf8.len(var_274_14) / 23)

				if (23 <= 0 and var_274_12 or var_274_12 * (utf8.len(var_274_14) / 23)) > 0 and var_274_12 < var_274_16 then
					arg_271_1.talkMaxDuration = var_274_16

					if var_274_16 + var_274_11 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_16 + var_274_11
					end
				end

				arg_271_1.text_.text = var_274_14
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061066", "story_v_out_425061.awb") ~= 0 then
					local var_274_17 = manager.audio:GetVoiceLength("story_v_out_425061", "425061066", "story_v_out_425061.awb") / 1000

					if var_274_17 + var_274_11 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_17 + var_274_11
					end

					if var_274_13.prefab_name ~= "" and arg_271_1.actors_[var_274_13.prefab_name] ~= nil then
						local var_274_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_13.prefab_name].transform, "story_v_out_425061", "425061066", "story_v_out_425061.awb")

						arg_271_1:RecordAudio("425061066", var_274_18)
						arg_271_1:RecordAudio("425061066", var_274_18)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_425061", "425061066", "story_v_out_425061.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_425061", "425061066", "story_v_out_425061.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_19 = math.max(var_274_12, arg_271_1.talkMaxDuration)

			if var_274_11 <= arg_271_1.time_ and arg_271_1.time_ < var_274_11 + var_274_19 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_11) / var_274_19

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_11 + var_274_19 and arg_271_1.time_ < var_274_11 + var_274_19 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play425061067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 425061067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play425061068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1066"]) and arg_275_1.var_.actorSpriteComps1066 == nil then
				arg_275_1.var_.actorSpriteComps1066 = arg_275_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_0 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1066"]) then
				if arg_275_1.var_.actorSpriteComps1066 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								iter_278_1.color = Color.New(Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor2.r, (arg_275_1.time_ - 0) / var_278_0), Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor2.g, (arg_275_1.time_ - 0) / var_278_0), (Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor2.b, (arg_275_1.time_ - 0) / var_278_0)))
							else
								local var_278_1 = Mathf.Lerp(iter_278_1.color.r, 0.5, (arg_275_1.time_ - 0) / var_278_0)

								iter_278_1.color = Color.New(var_278_1, var_278_1, var_278_1)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1066"]) and arg_275_1.var_.actorSpriteComps1066 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_278_3 then
						iter_278_3.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_275_1.var_.actorSpriteComps1066 = nil
			end

			local var_278_2 = 0
			local var_278_3 = 1.225

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_4 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(425061067).content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_6 = 49 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_4) / 49)

				if (49 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_4) / 49)) > 0 and var_278_3 < var_278_6 then
					arg_275_1.talkMaxDuration = var_278_6

					if var_278_6 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_6 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_3, arg_275_1.talkMaxDuration)

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_2) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_2 + var_278_7 and arg_275_1.time_ < var_278_2 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play425061068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 425061068
		arg_279_1.duration_ = 4.5

		local var_279_0 = {
			zh = 3.4,
			ja = 4.5
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
				arg_279_0:Play425061069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1033"]) and arg_279_1.var_.actorSpriteComps1033 == nil then
				arg_279_1.var_.actorSpriteComps1033 = arg_279_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_0 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1033"]) then
				if arg_279_1.var_.actorSpriteComps1033 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1033"]) and arg_279_1.var_.actorSpriteComps1033 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_282_3 then
						iter_282_3.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_279_1.var_.actorSpriteComps1033 = nil
			end

			local var_282_2 = arg_279_1.actors_["1033"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1033 = var_282_2.localPosition
				var_282_2.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("1033", 2)

				for iter_282_4 = 0, var_282_2.childCount - 1 do
					local var_282_3 = var_282_2:GetChild(iter_282_4)

					if var_282_3.name == "" or not string.find(var_282_3.name, "split") then
						var_282_3.gameObject:SetActive(true)
					else
						var_282_3.gameObject:SetActive(false)
					end
				end
			end

			local var_282_4 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				var_282_2.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_279_1.time_ - 0) / var_282_4)
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				var_282_2.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_282_5 = 0
			local var_282_6 = 0.425

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_7 = arg_279_1:GetWordFromCfg(425061068)
				local var_282_8 = arg_279_1:FormatText(var_282_7.content)

				arg_279_1.text_.text = var_282_8

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_10 = 17 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 17)

				if (17 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 17)) > 0 and var_282_6 < var_282_10 then
					arg_279_1.talkMaxDuration = var_282_10

					if var_282_10 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_5
					end
				end

				arg_279_1.text_.text = var_282_8
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061068", "story_v_out_425061.awb") ~= 0 then
					local var_282_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061068", "story_v_out_425061.awb") / 1000

					if var_282_11 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_11 + var_282_5
					end

					if var_282_7.prefab_name ~= "" and arg_279_1.actors_[var_282_7.prefab_name] ~= nil then
						local var_282_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_7.prefab_name].transform, "story_v_out_425061", "425061068", "story_v_out_425061.awb")

						arg_279_1:RecordAudio("425061068", var_282_12)
						arg_279_1:RecordAudio("425061068", var_282_12)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_425061", "425061068", "story_v_out_425061.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_425061", "425061068", "story_v_out_425061.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_13 = math.max(var_282_6, arg_279_1.talkMaxDuration)

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_13 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_5) / var_282_13

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_5 + var_282_13 and arg_279_1.time_ < var_282_5 + var_282_13 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play425061069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 425061069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play425061070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1033"]) and arg_283_1.var_.actorSpriteComps1033 == nil then
				arg_283_1.var_.actorSpriteComps1033 = arg_283_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1033"]) then
				if arg_283_1.var_.actorSpriteComps1033 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								iter_286_1.color = Color.New(Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor2.r, (arg_283_1.time_ - 0) / var_286_0), Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor2.g, (arg_283_1.time_ - 0) / var_286_0), (Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor2.b, (arg_283_1.time_ - 0) / var_286_0)))
							else
								local var_286_1 = Mathf.Lerp(iter_286_1.color.r, 0.5, (arg_283_1.time_ - 0) / var_286_0)

								iter_286_1.color = Color.New(var_286_1, var_286_1, var_286_1)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1033"]) and arg_283_1.var_.actorSpriteComps1033 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_286_3 then
						iter_286_3.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_283_1.var_.actorSpriteComps1033 = nil
			end

			local var_286_2 = 0
			local var_286_3 = 0.475

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_4 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(425061069).content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_6 = 19 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 19)

				if (19 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 19)) > 0 and var_286_3 < var_286_6 then
					arg_283_1.talkMaxDuration = var_286_6

					if var_286_6 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_6 + var_286_2
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_3, arg_283_1.talkMaxDuration)

			if var_286_2 <= arg_283_1.time_ and arg_283_1.time_ < var_286_2 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_2) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_2 + var_286_7 and arg_283_1.time_ < var_286_2 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play425061070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 425061070
		arg_287_1.duration_ = 2.27

		local var_287_0 = {
			zh = 2.266,
			ja = 1.7
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play425061071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1033"]) and arg_287_1.var_.actorSpriteComps1033 == nil then
				arg_287_1.var_.actorSpriteComps1033 = arg_287_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_0 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1033"]) then
				if arg_287_1.var_.actorSpriteComps1033 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								iter_290_1.color = Color.New(Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor1.r, (arg_287_1.time_ - 0) / var_290_0), Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor1.g, (arg_287_1.time_ - 0) / var_290_0), (Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor1.b, (arg_287_1.time_ - 0) / var_290_0)))
							else
								local var_290_1 = Mathf.Lerp(iter_290_1.color.r, 1, (arg_287_1.time_ - 0) / var_290_0)

								iter_290_1.color = Color.New(var_290_1, var_290_1, var_290_1)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1033"]) and arg_287_1.var_.actorSpriteComps1033 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_290_3 then
						iter_290_3.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_287_1.var_.actorSpriteComps1033 = nil
			end

			local var_290_2 = arg_287_1.actors_["1033"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1033 = var_290_2.localPosition
				var_290_2.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("1033", 2)

				for iter_290_4 = 0, var_290_2.childCount - 1 do
					local var_290_3 = var_290_2:GetChild(iter_290_4)

					if var_290_3.name == "split_4" or not string.find(var_290_3.name, "split") then
						var_290_3.gameObject:SetActive(true)
					else
						var_290_3.gameObject:SetActive(false)
					end
				end
			end

			local var_290_4 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				var_290_2.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_287_1.time_ - 0) / var_290_4)
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				var_290_2.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_290_5 = 0
			local var_290_6 = 0.175

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_7 = arg_287_1:GetWordFromCfg(425061070)
				local var_290_8 = arg_287_1:FormatText(var_290_7.content)

				arg_287_1.text_.text = var_290_8

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_10 = 7 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 7)

				if (7 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_8) / 7)) > 0 and var_290_6 < var_290_10 then
					arg_287_1.talkMaxDuration = var_290_10

					if var_290_10 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_5
					end
				end

				arg_287_1.text_.text = var_290_8
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061070", "story_v_out_425061.awb") ~= 0 then
					local var_290_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061070", "story_v_out_425061.awb") / 1000

					if var_290_11 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_11 + var_290_5
					end

					if var_290_7.prefab_name ~= "" and arg_287_1.actors_[var_290_7.prefab_name] ~= nil then
						local var_290_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_7.prefab_name].transform, "story_v_out_425061", "425061070", "story_v_out_425061.awb")

						arg_287_1:RecordAudio("425061070", var_290_12)
						arg_287_1:RecordAudio("425061070", var_290_12)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_425061", "425061070", "story_v_out_425061.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_425061", "425061070", "story_v_out_425061.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_13 = math.max(var_290_6, arg_287_1.talkMaxDuration)

			if var_290_5 <= arg_287_1.time_ and arg_287_1.time_ < var_290_5 + var_290_13 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_5) / var_290_13

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_5 + var_290_13 and arg_287_1.time_ < var_290_5 + var_290_13 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play425061071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 425061071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play425061072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1033"]) and arg_291_1.var_.actorSpriteComps1033 == nil then
				arg_291_1.var_.actorSpriteComps1033 = arg_291_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1033"]) then
				if arg_291_1.var_.actorSpriteComps1033 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								iter_294_1.color = Color.New(Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor2.r, (arg_291_1.time_ - 0) / var_294_0), Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor2.g, (arg_291_1.time_ - 0) / var_294_0), (Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor2.b, (arg_291_1.time_ - 0) / var_294_0)))
							else
								local var_294_1 = Mathf.Lerp(iter_294_1.color.r, 0.5, (arg_291_1.time_ - 0) / var_294_0)

								iter_294_1.color = Color.New(var_294_1, var_294_1, var_294_1)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1033"]) and arg_291_1.var_.actorSpriteComps1033 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_291_1.var_.actorSpriteComps1033 = nil
			end

			local var_294_2 = 0
			local var_294_3 = 0.75

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_4 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(425061071).content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_6 = 30 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_4) / 30)

				if (30 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_4) / 30)) > 0 and var_294_3 < var_294_6 then
					arg_291_1.talkMaxDuration = var_294_6

					if var_294_6 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_6 + var_294_2
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_3, arg_291_1.talkMaxDuration)

			if var_294_2 <= arg_291_1.time_ and arg_291_1.time_ < var_294_2 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_2) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_2 + var_294_7 and arg_291_1.time_ < var_294_2 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play425061072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 425061072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play425061073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.625

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(425061072).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 25 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 25)

				if (25 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 25)) > 0 and var_298_0 < var_298_3 then
					arg_295_1.talkMaxDuration = var_298_3

					if var_298_3 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_3 + 0
					end
				end

				arg_295_1.text_.text = var_298_1
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_4 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_4

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play425061073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 425061073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play425061074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.9

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(425061073).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 36 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 36)

				if (36 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 36)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play425061074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 425061074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play425061075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1033 = arg_303_1.actors_["1033"].transform.localPosition
				arg_303_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1033", 7)

				for iter_306_0 = 0, arg_303_1.actors_["1033"].transform.childCount - 1 do
					local var_306_0 = arg_303_1.actors_["1033"].transform:GetChild(iter_306_0)

					if var_306_0.name == "" or not string.find(var_306_0.name, "split") then
						var_306_0.gameObject:SetActive(true)
					else
						var_306_0.gameObject:SetActive(false)
					end
				end
			end

			local var_306_1 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_1 then
				arg_303_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_303_1.time_ - 0) / var_306_1)
			end

			if arg_303_1.time_ >= 0 + var_306_1 and arg_303_1.time_ < 0 + var_306_1 + arg_306_0 then
				arg_303_1.actors_["1033"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_306_2 = arg_303_1.actors_["1066"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1066 = var_306_2.localPosition
				var_306_2.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1066", 7)

				for iter_306_1 = 0, var_306_2.childCount - 1 do
					local var_306_3 = var_306_2:GetChild(iter_306_1)

					if var_306_3.name == "" or not string.find(var_306_3.name, "split") then
						var_306_3.gameObject:SetActive(true)
					else
						var_306_3.gameObject:SetActive(false)
					end
				end
			end

			local var_306_4 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				var_306_2.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1066, Vector3.New(0, -2000, 0), (arg_303_1.time_ - 0) / var_306_4)
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				var_306_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_306_5 = 0
			local var_306_6 = 1.1

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_5 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_7 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(425061074).content)

				arg_303_1.text_.text = var_306_7

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_9 = 44 <= 0 and var_306_6 or var_306_6 * (utf8.len(var_306_7) / 44)

				if (44 <= 0 and var_306_6 or var_306_6 * (utf8.len(var_306_7) / 44)) > 0 and var_306_6 < var_306_9 then
					arg_303_1.talkMaxDuration = var_306_9

					if var_306_9 + var_306_5 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_9 + var_306_5
					end
				end

				arg_303_1.text_.text = var_306_7
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_6, arg_303_1.talkMaxDuration)

			if var_306_5 <= arg_303_1.time_ and arg_303_1.time_ < var_306_5 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_5) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_5 + var_306_10 and arg_303_1.time_ < var_306_5 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play425061075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 425061075
		arg_307_1.duration_ = 18.3

		local var_307_0 = {
			zh = 11.666,
			ja = 18.3
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play425061076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if arg_307_1.bgs_.ST13 == nil then
				local var_310_0 = Object.Instantiate(arg_307_1.paintGo_)

				var_310_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST13")
				var_310_0.name = "ST13"
				var_310_0.transform.parent = arg_307_1.stage_.transform
				var_310_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_307_1.bgs_.ST13 = var_310_0
			end

			if 1 < arg_307_1.time_ and arg_307_1.time_ <= 1 + arg_310_0 then
				local var_310_1 = arg_307_1.bgs_.ST13

				arg_307_1.bgs_.ST13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_310_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_310_2 = var_310_1:GetComponent("SpriteRenderer")

				if var_310_2 and var_310_2.sprite then
					local var_310_3 = 2 * (var_310_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_310_1.transform.localScale = Vector3.New(var_310_3 / var_310_2.sprite.bounds.size.y < var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x and var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x or var_310_3 / var_310_2.sprite.bounds.size.y, var_310_3 / var_310_2.sprite.bounds.size.y < var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x and var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x or var_310_3 / var_310_2.sprite.bounds.size.y, 0)
				end

				for iter_310_0, iter_310_1 in pairs(arg_307_1.bgs_) do
					if iter_310_0 ~= "ST13" then
						iter_310_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_310_4 = 2.7

			if 2.7 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.allBtn_.enabled = false
			end

			if arg_307_1.time_ >= var_310_4 + 0.3 and arg_307_1.time_ < var_310_4 + 0.3 + arg_310_0 then
				arg_307_1.allBtn_.enabled = true
			end

			local var_310_5 = 0

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 then
				arg_307_1.mask_.enabled = true
				arg_307_1.mask_.raycastTarget = true

				arg_307_1:SetGaussion(false)
			end

			local var_310_6 = 1

			if var_310_5 <= arg_307_1.time_ and arg_307_1.time_ < var_310_5 + var_310_6 then
				local var_310_7 = Color.New(0, 0, 0)

				var_310_7.a = Mathf.Lerp(0, 1, (arg_307_1.time_ - var_310_5) / var_310_6)
				arg_307_1.mask_.color = var_310_7
			end

			if arg_307_1.time_ >= var_310_5 + var_310_6 and arg_307_1.time_ < var_310_5 + var_310_6 + arg_310_0 then
				local var_310_8 = Color.New(0, 0, 0)

				var_310_8.a = 1
				arg_307_1.mask_.color = var_310_8
			end

			local var_310_9 = 1

			if 1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_9 + arg_310_0 then
				arg_307_1.mask_.enabled = true
				arg_307_1.mask_.raycastTarget = true

				arg_307_1:SetGaussion(false)
			end

			local var_310_10 = 2

			if var_310_9 <= arg_307_1.time_ and arg_307_1.time_ < var_310_9 + var_310_10 then
				local var_310_11 = Color.New(0, 0, 0)

				var_310_11.a = Mathf.Lerp(1, 0, (arg_307_1.time_ - var_310_9) / var_310_10)
				arg_307_1.mask_.color = var_310_11
			end

			if arg_307_1.time_ >= var_310_9 + var_310_10 and arg_307_1.time_ < var_310_9 + var_310_10 + arg_310_0 then
				local var_310_12 = Color.New(0, 0, 0)

				arg_307_1.mask_.enabled = false
				var_310_12.a = 0
				arg_307_1.mask_.color = var_310_12
			end

			local var_310_13 = arg_307_1.actors_["1033"]

			if 2.7 < arg_307_1.time_ and arg_307_1.time_ <= 2.7 + arg_310_0 and not isNil(var_310_13) and arg_307_1.var_.actorSpriteComps1033 == nil then
				arg_307_1.var_.actorSpriteComps1033 = var_310_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_14 = 0.2

			if 2.7 <= arg_307_1.time_ and arg_307_1.time_ < 2.7 + var_310_14 and not isNil(var_310_13) then
				if arg_307_1.var_.actorSpriteComps1033 then
					for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_310_3 then
							if arg_307_1.isInRecall_ then
								iter_310_3.color = Color.New(Mathf.Lerp(iter_310_3.color.r, arg_307_1.hightColor1.r, (arg_307_1.time_ - 2.7) / var_310_14), Mathf.Lerp(iter_310_3.color.g, arg_307_1.hightColor1.g, (arg_307_1.time_ - 2.7) / var_310_14), (Mathf.Lerp(iter_310_3.color.b, arg_307_1.hightColor1.b, (arg_307_1.time_ - 2.7) / var_310_14)))
							else
								local var_310_15 = Mathf.Lerp(iter_310_3.color.r, 1, (arg_307_1.time_ - 2.7) / var_310_14)

								iter_310_3.color = Color.New(var_310_15, var_310_15, var_310_15)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 2.7 + var_310_14 and arg_307_1.time_ < 2.7 + var_310_14 + arg_310_0 and not isNil(var_310_13) and arg_307_1.var_.actorSpriteComps1033 then
				for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_310_5 then
						iter_310_5.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_307_1.var_.actorSpriteComps1033 = nil
			end

			local var_310_16 = arg_307_1.actors_["1033"].transform

			if 2.7 < arg_307_1.time_ and arg_307_1.time_ <= 2.7 + arg_310_0 then
				arg_307_1.var_.moveOldPos1033 = var_310_16.localPosition
				var_310_16.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1033", 3)

				for iter_310_6 = 0, var_310_16.childCount - 1 do
					local var_310_17 = var_310_16:GetChild(iter_310_6)

					if var_310_17.name == "" or not string.find(var_310_17.name, "split") then
						var_310_17.gameObject:SetActive(true)
					else
						var_310_17.gameObject:SetActive(false)
					end
				end
			end

			local var_310_18 = 0.001

			if 2.7 <= arg_307_1.time_ and arg_307_1.time_ < 2.7 + var_310_18 then
				var_310_16.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_307_1.time_ - 2.7) / var_310_18)
			end

			if arg_307_1.time_ >= 2.7 + var_310_18 and arg_307_1.time_ < 2.7 + var_310_18 + arg_310_0 then
				var_310_16.localPosition = Vector3.New(0, -420, 0)
			end

			if arg_307_1.frameCnt_ <= 1 then
				arg_307_1.dialog_:SetActive(false)
			end

			local var_310_19 = 3
			local var_310_20 = 0.925

			if 3 < arg_307_1.time_ and arg_307_1.time_ <= var_310_19 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0

				arg_307_1.dialog_:SetActive(true)

				arg_307_1.dialogCg_.alpha = 0

				local var_310_21 = LeanTween.value(arg_307_1.dialog_, 0, 1, 0.3)

				var_310_21:setOnUpdate(LuaHelper.FloatAction(function(arg_311_0)
					arg_307_1.dialogCg_.alpha = arg_311_0
				end))
				var_310_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_307_1.dialog_)
					var_310_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_307_1.duration_ = arg_307_1.duration_ + 0.3

				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_22 = arg_307_1:GetWordFromCfg(425061075)
				local var_310_23 = arg_307_1:FormatText(var_310_22.content)

				arg_307_1.text_.text = var_310_23

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_25 = 37 <= 0 and var_310_20 or var_310_20 * (utf8.len(var_310_23) / 37)

				if (37 <= 0 and var_310_20 or var_310_20 * (utf8.len(var_310_23) / 37)) > 0 and var_310_20 < var_310_25 then
					arg_307_1.talkMaxDuration = var_310_25
					var_310_19 = var_310_19 + 0.3

					if var_310_25 + var_310_19 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_25 + var_310_19
					end
				end

				arg_307_1.text_.text = var_310_23
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061075", "story_v_out_425061.awb") ~= 0 then
					local var_310_26 = manager.audio:GetVoiceLength("story_v_out_425061", "425061075", "story_v_out_425061.awb") / 1000

					if var_310_26 + var_310_19 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_26 + var_310_19
					end

					if var_310_22.prefab_name ~= "" and arg_307_1.actors_[var_310_22.prefab_name] ~= nil then
						local var_310_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_22.prefab_name].transform, "story_v_out_425061", "425061075", "story_v_out_425061.awb")

						arg_307_1:RecordAudio("425061075", var_310_27)
						arg_307_1:RecordAudio("425061075", var_310_27)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_425061", "425061075", "story_v_out_425061.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_425061", "425061075", "story_v_out_425061.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_28 = var_310_19 + 0.3
			local var_310_29 = math.max(var_310_20, arg_307_1.talkMaxDuration)

			if var_310_19 + 0.3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_28 + var_310_29 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_28) / var_310_29

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_28 + var_310_29 and arg_307_1.time_ < var_310_28 + var_310_29 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play425061076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 425061076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play425061077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1033"]) and arg_313_1.var_.actorSpriteComps1033 == nil then
				arg_313_1.var_.actorSpriteComps1033 = arg_313_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_0 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1033"]) then
				if arg_313_1.var_.actorSpriteComps1033 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_316_1 then
							if arg_313_1.isInRecall_ then
								iter_316_1.color = Color.New(Mathf.Lerp(iter_316_1.color.r, arg_313_1.hightColor2.r, (arg_313_1.time_ - 0) / var_316_0), Mathf.Lerp(iter_316_1.color.g, arg_313_1.hightColor2.g, (arg_313_1.time_ - 0) / var_316_0), (Mathf.Lerp(iter_316_1.color.b, arg_313_1.hightColor2.b, (arg_313_1.time_ - 0) / var_316_0)))
							else
								local var_316_1 = Mathf.Lerp(iter_316_1.color.r, 0.5, (arg_313_1.time_ - 0) / var_316_0)

								iter_316_1.color = Color.New(var_316_1, var_316_1, var_316_1)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1033"]) and arg_313_1.var_.actorSpriteComps1033 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_316_3 then
						iter_316_3.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_313_1.var_.actorSpriteComps1033 = nil
			end

			local var_316_2 = 0
			local var_316_3 = 0.25

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_4 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(425061076).content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_6 = 10 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_4) / 10)

				if (10 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_4) / 10)) > 0 and var_316_3 < var_316_6 then
					arg_313_1.talkMaxDuration = var_316_6

					if var_316_6 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_2
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_3, arg_313_1.talkMaxDuration)

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_2) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_2 + var_316_7 and arg_313_1.time_ < var_316_2 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play425061077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 425061077
		arg_317_1.duration_ = 7.6

		local var_317_0 = {
			zh = 5.233,
			ja = 7.6
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
			arg_317_1.auto_ = false
		end

		function arg_317_1.playNext_(arg_319_0)
			arg_317_1.onStoryFinished_()
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1033"]) and arg_317_1.var_.actorSpriteComps1033 == nil then
				arg_317_1.var_.actorSpriteComps1033 = arg_317_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_0 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1033"]) then
				if arg_317_1.var_.actorSpriteComps1033 then
					for iter_320_0, iter_320_1 in pairs(arg_317_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1033"]) and arg_317_1.var_.actorSpriteComps1033 then
				for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_320_3 then
						iter_320_3.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_317_1.var_.actorSpriteComps1033 = nil
			end

			local var_320_2 = arg_317_1.actors_["1033"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1033 = var_320_2.localPosition
				var_320_2.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1033", 3)

				for iter_320_4 = 0, var_320_2.childCount - 1 do
					local var_320_3 = var_320_2:GetChild(iter_320_4)

					if var_320_3.name == "split_6" then
						var_320_3:SetAsLastSibling()
						var_320_3.gameObject:SetActive(true)

						arg_317_1.var_.actorSpriteSplit1033 = var_320_3.gameObject:GetComponent(typeof(Image))

						arg_317_1.var_.actorSpriteSplit1033:SetAlpha(0)
					end
				end
			end

			local var_320_4 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				var_320_2.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_317_1.time_ - 0) / var_320_4)

				if arg_317_1.var_.actorSpriteSplit1033 ~= nil then
					arg_317_1.var_.actorSpriteSplit1033:SetAlpha((arg_317_1.time_ - 0) / var_320_4)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				var_320_2.localPosition = Vector3.New(0, -420, 0)

				if arg_317_1.var_.actorSpriteSplit1033 ~= nil then
					arg_317_1.var_.actorSpriteSplit1033:SetAlpha(1)
				end
			end

			local var_320_5 = 0
			local var_320_6 = 0.575

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_5 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_7 = arg_317_1:GetWordFromCfg(425061077)
				local var_320_8 = arg_317_1:FormatText(var_320_7.content)

				arg_317_1.text_.text = var_320_8

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_10 = 23 <= 0 and var_320_6 or var_320_6 * (utf8.len(var_320_8) / 23)

				if (23 <= 0 and var_320_6 or var_320_6 * (utf8.len(var_320_8) / 23)) > 0 and var_320_6 < var_320_10 then
					arg_317_1.talkMaxDuration = var_320_10

					if var_320_10 + var_320_5 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_5
					end
				end

				arg_317_1.text_.text = var_320_8
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061077", "story_v_out_425061.awb") ~= 0 then
					local var_320_11 = manager.audio:GetVoiceLength("story_v_out_425061", "425061077", "story_v_out_425061.awb") / 1000

					if var_320_11 + var_320_5 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_11 + var_320_5
					end

					if var_320_7.prefab_name ~= "" and arg_317_1.actors_[var_320_7.prefab_name] ~= nil then
						local var_320_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_7.prefab_name].transform, "story_v_out_425061", "425061077", "story_v_out_425061.awb")

						arg_317_1:RecordAudio("425061077", var_320_12)
						arg_317_1:RecordAudio("425061077", var_320_12)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_425061", "425061077", "story_v_out_425061.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_425061", "425061077", "story_v_out_425061.awb")
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

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST60",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/ST13"
	},
	voices = {
		"story_v_out_425061.awb"
	}
}
