return {
	Play417241001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417241001
		arg_1_1.duration_ = 12.4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417241002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST73")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501071).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501072).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= 0 + 5 and arg_1_1.time_ < 0 + 5 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_0 = 5

			if 5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_1 = 1.2

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_1 then
				local var_4_2 = Color.New(0, 0, 0)

				var_4_2.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_0) / var_4_1)
				arg_1_1.mask_.color = var_4_2
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = 1
				arg_1_1.mask_.color = var_4_3
			end

			local var_4_4 = 6.2

			if 6.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 1.2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = "ST73"

			if arg_1_1.bgs_.ST73 == nil then
				local var_4_9 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_8)
				var_4_9.name = var_4_8
				var_4_9.transform.parent = arg_1_1.stage_.transform
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_8] = var_4_9
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_10 = arg_1_1.bgs_.ST73

				arg_1_1.bgs_.ST73.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_11 = var_4_10:GetComponent("SpriteRenderer")

				if var_4_11 and var_4_11.sprite then
					local var_4_12 = 2 * (var_4_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_10.transform.localScale = Vector3.New(var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST73" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_13 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_13 + 6.2 and arg_1_1.time_ < var_4_13 + 6.2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_14 = "10115"

			if arg_1_1.actors_["10115"] == nil then
				local var_4_15 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

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

			local var_4_17 = arg_1_1.actors_["10115"].transform

			if 7.08333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 7.08333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos10115 = var_4_17.localPosition
				var_4_17.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10115", 3)

				for iter_4_4 = 0, var_4_17.childCount - 1 do
					local var_4_18 = var_4_17:GetChild(iter_4_4)

					if var_4_18.name == "split_6" or not string.find(var_4_18.name, "split") then
						var_4_18.gameObject:SetActive(true)
					else
						var_4_18.gameObject:SetActive(false)
					end
				end
			end

			local var_4_19 = 0.001

			if 7.08333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 7.08333333333333 + var_4_19 then
				var_4_17.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_1_1.time_ - 7.08333333333333) / var_4_19)
			end

			if arg_1_1.time_ >= 7.08333333333333 + var_4_19 and arg_1_1.time_ < 7.08333333333333 + var_4_19 + arg_4_0 then
				var_4_17.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_4_20 = arg_1_1.actors_["10115"]

			if 7.08333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 7.08333333333333 + arg_4_0 and not isNil(var_4_20) and arg_1_1.var_.actorSpriteComps10115 == nil then
				arg_1_1.var_.actorSpriteComps10115 = var_4_20:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_21 = 0.2

			if 7.08333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 7.08333333333333 + var_4_21 and not isNil(var_4_20) then
				if arg_1_1.var_.actorSpriteComps10115 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 7.08333333333333) / var_4_21), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 7.08333333333333) / var_4_21), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 7.08333333333333) / var_4_21)))
							else
								local var_4_22 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 7.08333333333333) / var_4_21)

								iter_4_6.color = Color.New(var_4_22, var_4_22, var_4_22)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 7.08333333333333 + var_4_21 and arg_1_1.time_ < 7.08333333333333 + var_4_21 + arg_4_0 and not isNil(var_4_20) and arg_1_1.var_.actorSpriteComps10115 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10115 = nil
			end

			if 7.08333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 7.08333333333333 + arg_4_0 then
				local var_4_23 = arg_1_1.actors_["10115"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_23 then
					arg_1_1.var_.alphaOldValue10115 = var_4_23.alpha
					arg_1_1.var_.characterEffect10115 = var_4_23
				end

				arg_1_1.var_.alphaOldValue10115 = 0
			end

			local var_4_24 = 0.316666666666666

			if 7.08333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 7.08333333333333 + var_4_24 then
				if arg_1_1.var_.characterEffect10115 then
					arg_1_1.var_.characterEffect10115.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10115, 1, (arg_1_1.time_ - 7.08333333333333) / var_4_24)
				end
			end

			if arg_1_1.time_ >= 7.08333333333333 + var_4_24 and arg_1_1.time_ < 7.08333333333333 + var_4_24 + arg_4_0 and arg_1_1.var_.characterEffect10115 then
				arg_1_1.var_.characterEffect10115.alpha = 1
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

			if 5.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 5.73333333333333 + arg_4_0 then
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

			if 6.2 < arg_1_1.time_ and arg_1_1.time_ <= 6.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_vibrate", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 7.4
			local var_4_37 = 0.05

			if 7.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(417241001).content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 2 <= 0 and var_4_37 or var_4_37 * (utf8.len(var_4_39) / 2)

				if (2 <= 0 and var_4_37 or var_4_37 * (utf8.len(var_4_39) / 2)) > 0 and var_4_37 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_36 = var_4_36 + 0.3

					if var_4_41 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_36 + 0.3
			local var_4_43 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_36 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 7.08333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play417241002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417241002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417241003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(arg_10_1.actors_["10115"]) and arg_10_1.var_.actorSpriteComps10115 == nil then
				arg_10_1.var_.actorSpriteComps10115 = arg_10_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_0 = 0.2

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_0 and not isNil(arg_10_1.actors_["10115"]) then
				if arg_10_1.var_.actorSpriteComps10115 then
					for iter_13_0, iter_13_1 in pairs(arg_10_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_10_1.time_ >= 0 + var_13_0 and arg_10_1.time_ < 0 + var_13_0 + arg_13_0 and not isNil(arg_10_1.actors_["10115"]) and arg_10_1.var_.actorSpriteComps10115 then
				for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_13_3 then
						iter_13_3.color = arg_10_1.isInRecall_ and (arg_10_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_10_1.var_.actorSpriteComps10115 = nil
			end

			if 0.02 < arg_10_1.time_ and arg_10_1.time_ <= 0.02 + arg_13_0 then
				arg_10_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_13_3 = 0
			local var_13_4 = 1.125

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

				local var_13_5 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(417241002).content)

				arg_10_1.text_.text = var_13_5

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_7 = 45 <= 0 and var_13_4 or var_13_4 * (utf8.len(var_13_5) / 45)

				if (45 <= 0 and var_13_4 or var_13_4 * (utf8.len(var_13_5) / 45)) > 0 and var_13_4 < var_13_7 then
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
	Play417241003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417241003
		arg_14_1.duration_ = 1.3

		local var_14_0 = {
			zh = 0.999999999999,
			ja = 1.3
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
				arg_14_0:Play417241004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(arg_14_1.actors_["10115"]) and arg_14_1.var_.actorSpriteComps10115 == nil then
				arg_14_1.var_.actorSpriteComps10115 = arg_14_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_0 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 and not isNil(arg_14_1.actors_["10115"]) then
				if arg_14_1.var_.actorSpriteComps10115 then
					for iter_17_0, iter_17_1 in pairs(arg_14_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 and not isNil(arg_14_1.actors_["10115"]) and arg_14_1.var_.actorSpriteComps10115 then
				for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_17_3 then
						iter_17_3.color = arg_14_1.isInRecall_ and (arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_14_1.var_.actorSpriteComps10115 = nil
			end

			local var_17_2 = arg_14_1.actors_["10115"].transform

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos10115 = var_17_2.localPosition
				var_17_2.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("10115", 3)

				for iter_17_4 = 0, var_17_2.childCount - 1 do
					local var_17_3 = var_17_2:GetChild(iter_17_4)

					if var_17_3.name == "split_6" or not string.find(var_17_3.name, "split") then
						var_17_3.gameObject:SetActive(true)
					else
						var_17_3.gameObject:SetActive(false)
					end
				end
			end

			local var_17_4 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_4 then
				var_17_2.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_14_1.time_ - 0) / var_17_4)
			end

			if arg_14_1.time_ >= 0 + var_17_4 and arg_14_1.time_ < 0 + var_17_4 + arg_17_0 then
				var_17_2.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_17_5 = 0
			local var_17_6 = 0.05

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_5 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_7 = arg_14_1:GetWordFromCfg(417241003)
				local var_17_8 = arg_14_1:FormatText(var_17_7.content)

				arg_14_1.text_.text = var_17_8

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_10 = 2 <= 0 and var_17_6 or var_17_6 * (utf8.len(var_17_8) / 2)

				if (2 <= 0 and var_17_6 or var_17_6 * (utf8.len(var_17_8) / 2)) > 0 and var_17_6 < var_17_10 then
					arg_14_1.talkMaxDuration = var_17_10

					if var_17_10 + var_17_5 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_10 + var_17_5
					end
				end

				arg_14_1.text_.text = var_17_8
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241003", "story_v_out_417241.awb") ~= 0 then
					local var_17_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241003", "story_v_out_417241.awb") / 1000

					if var_17_11 + var_17_5 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_11 + var_17_5
					end

					if var_17_7.prefab_name ~= "" and arg_14_1.actors_[var_17_7.prefab_name] ~= nil then
						local var_17_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_7.prefab_name].transform, "story_v_out_417241", "417241003", "story_v_out_417241.awb")

						arg_14_1:RecordAudio("417241003", var_17_12)
						arg_14_1:RecordAudio("417241003", var_17_12)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417241", "417241003", "story_v_out_417241.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417241", "417241003", "story_v_out_417241.awb")
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
				actorName = "10115",
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
	Play417241004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417241004
		arg_18_1.duration_ = 3.87

		local var_18_0 = {
			zh = 2.833,
			ja = 3.866
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
				arg_18_0:Play417241005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(arg_18_1.actors_["10115"]) and arg_18_1.var_.actorSpriteComps10115 == nil then
				arg_18_1.var_.actorSpriteComps10115 = arg_18_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_0 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 and not isNil(arg_18_1.actors_["10115"]) then
				if arg_18_1.var_.actorSpriteComps10115 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_21_1 then
							if arg_18_1.isInRecall_ then
								iter_21_1.color = Color.New(Mathf.Lerp(iter_21_1.color.r, arg_18_1.hightColor2.r, (arg_18_1.time_ - 0) / var_21_0), Mathf.Lerp(iter_21_1.color.g, arg_18_1.hightColor2.g, (arg_18_1.time_ - 0) / var_21_0), (Mathf.Lerp(iter_21_1.color.b, arg_18_1.hightColor2.b, (arg_18_1.time_ - 0) / var_21_0)))
							else
								local var_21_1 = Mathf.Lerp(iter_21_1.color.r, 0.5, (arg_18_1.time_ - 0) / var_21_0)

								iter_21_1.color = Color.New(var_21_1, var_21_1, var_21_1)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 and not isNil(arg_18_1.actors_["10115"]) and arg_18_1.var_.actorSpriteComps10115 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_21_3 then
						iter_21_3.color = arg_18_1.isInRecall_ and (arg_18_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_18_1.var_.actorSpriteComps10115 = nil
			end

			local var_21_2 = 0
			local var_21_3 = 0.4

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_2 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1153].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_18_1.callingController_:SetSelectedState("calling")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_4 = arg_18_1:GetWordFromCfg(417241004)
				local var_21_5 = arg_18_1:FormatText(var_21_4.content)

				arg_18_1.text_.text = var_21_5

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_7 = 16 <= 0 and var_21_3 or var_21_3 * (utf8.len(var_21_5) / 16)

				if (16 <= 0 and var_21_3 or var_21_3 * (utf8.len(var_21_5) / 16)) > 0 and var_21_3 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_2 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_2
					end
				end

				arg_18_1.text_.text = var_21_5
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241004", "story_v_out_417241.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241004", "story_v_out_417241.awb") / 1000

					if var_21_8 + var_21_2 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_2
					end

					if var_21_4.prefab_name ~= "" and arg_18_1.actors_[var_21_4.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_4.prefab_name].transform, "story_v_out_417241", "417241004", "story_v_out_417241.awb")

						arg_18_1:RecordAudio("417241004", var_21_9)
						arg_18_1:RecordAudio("417241004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417241", "417241004", "story_v_out_417241.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417241", "417241004", "story_v_out_417241.awb")
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
	Play417241005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417241005
		arg_22_1.duration_ = 5.7

		local var_22_0 = {
			zh = 5.033,
			ja = 5.7
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
				arg_22_0:Play417241006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(arg_22_1.actors_["10115"]) and arg_22_1.var_.actorSpriteComps10115 == nil then
				arg_22_1.var_.actorSpriteComps10115 = arg_22_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_0 = 0.2

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 and not isNil(arg_22_1.actors_["10115"]) then
				if arg_22_1.var_.actorSpriteComps10115 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_25_1 then
							if arg_22_1.isInRecall_ then
								iter_25_1.color = Color.New(Mathf.Lerp(iter_25_1.color.r, arg_22_1.hightColor1.r, (arg_22_1.time_ - 0) / var_25_0), Mathf.Lerp(iter_25_1.color.g, arg_22_1.hightColor1.g, (arg_22_1.time_ - 0) / var_25_0), (Mathf.Lerp(iter_25_1.color.b, arg_22_1.hightColor1.b, (arg_22_1.time_ - 0) / var_25_0)))
							else
								local var_25_1 = Mathf.Lerp(iter_25_1.color.r, 1, (arg_22_1.time_ - 0) / var_25_0)

								iter_25_1.color = Color.New(var_25_1, var_25_1, var_25_1)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 and not isNil(arg_22_1.actors_["10115"]) and arg_22_1.var_.actorSpriteComps10115 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_25_3 then
						iter_25_3.color = arg_22_1.isInRecall_ and (arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_22_1.var_.actorSpriteComps10115 = nil
			end

			local var_25_2 = arg_22_1.actors_["10115"].transform

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos10115 = var_25_2.localPosition
				var_25_2.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("10115", 3)

				for iter_25_4 = 0, var_25_2.childCount - 1 do
					local var_25_3 = var_25_2:GetChild(iter_25_4)

					if var_25_3.name == "split_4" or not string.find(var_25_3.name, "split") then
						var_25_3.gameObject:SetActive(true)
					else
						var_25_3.gameObject:SetActive(false)
					end
				end
			end

			local var_25_4 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_4 then
				var_25_2.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_22_1.time_ - 0) / var_25_4)
			end

			if arg_22_1.time_ >= 0 + var_25_4 and arg_22_1.time_ < 0 + var_25_4 + arg_25_0 then
				var_25_2.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_25_5 = 0
			local var_25_6 = 0.425

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_7 = arg_22_1:GetWordFromCfg(417241005)
				local var_25_8 = arg_22_1:FormatText(var_25_7.content)

				arg_22_1.text_.text = var_25_8

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_10 = 17 <= 0 and var_25_6 or var_25_6 * (utf8.len(var_25_8) / 17)

				if (17 <= 0 and var_25_6 or var_25_6 * (utf8.len(var_25_8) / 17)) > 0 and var_25_6 < var_25_10 then
					arg_22_1.talkMaxDuration = var_25_10

					if var_25_10 + var_25_5 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_10 + var_25_5
					end
				end

				arg_22_1.text_.text = var_25_8
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241005", "story_v_out_417241.awb") ~= 0 then
					local var_25_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241005", "story_v_out_417241.awb") / 1000

					if var_25_11 + var_25_5 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_11 + var_25_5
					end

					if var_25_7.prefab_name ~= "" and arg_22_1.actors_[var_25_7.prefab_name] ~= nil then
						local var_25_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_7.prefab_name].transform, "story_v_out_417241", "417241005", "story_v_out_417241.awb")

						arg_22_1:RecordAudio("417241005", var_25_12)
						arg_22_1:RecordAudio("417241005", var_25_12)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417241", "417241005", "story_v_out_417241.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417241", "417241005", "story_v_out_417241.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_13 = math.max(var_25_6, arg_22_1.talkMaxDuration)

			if var_25_5 <= arg_22_1.time_ and arg_22_1.time_ < var_25_5 + var_25_13 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_5) / var_25_13

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_5 + var_25_13 and arg_22_1.time_ < var_25_5 + var_25_13 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play417241006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417241006
		arg_26_1.duration_ = 7.2

		local var_26_0 = {
			zh = 4.066,
			ja = 7.2
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
				arg_26_0:Play417241007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["10115"]) and arg_26_1.var_.actorSpriteComps10115 == nil then
				arg_26_1.var_.actorSpriteComps10115 = arg_26_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_0 = 0.2

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["10115"]) then
				if arg_26_1.var_.actorSpriteComps10115 then
					for iter_29_0, iter_29_1 in pairs(arg_26_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["10115"]) and arg_26_1.var_.actorSpriteComps10115 then
				for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_29_3 then
						iter_29_3.color = arg_26_1.isInRecall_ and (arg_26_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_26_1.var_.actorSpriteComps10115 = nil
			end

			local var_29_2 = 0
			local var_29_3 = 0.575

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_2 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1153].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_26_1.callingController_:SetSelectedState("calling")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_4 = arg_26_1:GetWordFromCfg(417241006)
				local var_29_5 = arg_26_1:FormatText(var_29_4.content)

				arg_26_1.text_.text = var_29_5

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_7 = 23 <= 0 and var_29_3 or var_29_3 * (utf8.len(var_29_5) / 23)

				if (23 <= 0 and var_29_3 or var_29_3 * (utf8.len(var_29_5) / 23)) > 0 and var_29_3 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_2 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_2
					end
				end

				arg_26_1.text_.text = var_29_5
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241006", "story_v_out_417241.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241006", "story_v_out_417241.awb") / 1000

					if var_29_8 + var_29_2 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_2
					end

					if var_29_4.prefab_name ~= "" and arg_26_1.actors_[var_29_4.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_4.prefab_name].transform, "story_v_out_417241", "417241006", "story_v_out_417241.awb")

						arg_26_1:RecordAudio("417241006", var_29_9)
						arg_26_1:RecordAudio("417241006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417241", "417241006", "story_v_out_417241.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417241", "417241006", "story_v_out_417241.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_3, arg_26_1.talkMaxDuration)

			if var_29_2 <= arg_26_1.time_ and arg_26_1.time_ < var_29_2 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_2) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_2 + var_29_10 and arg_26_1.time_ < var_29_2 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417241007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417241007
		arg_30_1.duration_ = 5.47

		local var_30_0 = {
			zh = 4.6,
			ja = 5.466
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
				arg_30_0:Play417241008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["10115"]) and arg_30_1.var_.actorSpriteComps10115 == nil then
				arg_30_1.var_.actorSpriteComps10115 = arg_30_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["10115"]) then
				if arg_30_1.var_.actorSpriteComps10115 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["10115"]) and arg_30_1.var_.actorSpriteComps10115 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_30_1.var_.actorSpriteComps10115 = nil
			end

			local var_33_2 = arg_30_1.actors_["10115"].transform

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos10115 = var_33_2.localPosition
				var_33_2.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("10115", 3)

				for iter_33_4 = 0, var_33_2.childCount - 1 do
					local var_33_3 = var_33_2:GetChild(iter_33_4)

					if var_33_3.name == "split_6" or not string.find(var_33_3.name, "split") then
						var_33_3.gameObject:SetActive(true)
					else
						var_33_3.gameObject:SetActive(false)
					end
				end
			end

			local var_33_4 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				var_33_2.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_30_1.time_ - 0) / var_33_4)
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				var_33_2.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_33_5 = 0
			local var_33_6 = 0.6

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_7 = arg_30_1:GetWordFromCfg(417241007)
				local var_33_8 = arg_30_1:FormatText(var_33_7.content)

				arg_30_1.text_.text = var_33_8

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_10 = 24 <= 0 and var_33_6 or var_33_6 * (utf8.len(var_33_8) / 24)

				if (24 <= 0 and var_33_6 or var_33_6 * (utf8.len(var_33_8) / 24)) > 0 and var_33_6 < var_33_10 then
					arg_30_1.talkMaxDuration = var_33_10

					if var_33_10 + var_33_5 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_5
					end
				end

				arg_30_1.text_.text = var_33_8
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241007", "story_v_out_417241.awb") ~= 0 then
					local var_33_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241007", "story_v_out_417241.awb") / 1000

					if var_33_11 + var_33_5 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_11 + var_33_5
					end

					if var_33_7.prefab_name ~= "" and arg_30_1.actors_[var_33_7.prefab_name] ~= nil then
						local var_33_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_7.prefab_name].transform, "story_v_out_417241", "417241007", "story_v_out_417241.awb")

						arg_30_1:RecordAudio("417241007", var_33_12)
						arg_30_1:RecordAudio("417241007", var_33_12)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417241", "417241007", "story_v_out_417241.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417241", "417241007", "story_v_out_417241.awb")
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
				actorName = "10115",
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
	Play417241008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417241008
		arg_34_1.duration_ = 6.37

		local var_34_0 = {
			zh = 4.933,
			ja = 6.366
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
				arg_34_0:Play417241009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if arg_34_1.bgs_.SS1710 == nil then
				local var_37_0 = Object.Instantiate(arg_34_1.paintGo_)

				var_37_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1710")
				var_37_0.name = "SS1710"
				var_37_0.transform.parent = arg_34_1.stage_.transform
				var_37_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.bgs_.SS1710 = var_37_0
			end

			if 2 < arg_34_1.time_ and arg_34_1.time_ <= 2 + arg_37_0 then
				local var_37_1 = arg_34_1.bgs_.SS1710

				arg_34_1.bgs_.SS1710.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_37_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_37_2 = var_37_1:GetComponent("SpriteRenderer")

				if var_37_2 and var_37_2.sprite then
					local var_37_3 = 2 * (var_37_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_37_1.transform.localScale = Vector3.New(var_37_3 / var_37_2.sprite.bounds.size.y < var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x and var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x or var_37_3 / var_37_2.sprite.bounds.size.y, var_37_3 / var_37_2.sprite.bounds.size.y < var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x and var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x or var_37_3 / var_37_2.sprite.bounds.size.y, 0)
				end

				for iter_37_0, iter_37_1 in pairs(arg_34_1.bgs_) do
					if iter_37_0 ~= "SS1710" then
						iter_37_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_37_4 = 4

			if 4 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.allBtn_.enabled = false
			end

			if arg_34_1.time_ >= var_37_4 + 0.0999999999999996 and arg_34_1.time_ < var_37_4 + 0.0999999999999996 + arg_37_0 then
				arg_34_1.allBtn_.enabled = true
			end

			local var_37_5 = 0

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_6 = 2

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_6 then
				local var_37_7 = Color.New(0, 0, 0)

				var_37_7.a = Mathf.Lerp(0, 1, (arg_34_1.time_ - var_37_5) / var_37_6)
				arg_34_1.mask_.color = var_37_7
			end

			if arg_34_1.time_ >= var_37_5 + var_37_6 and arg_34_1.time_ < var_37_5 + var_37_6 + arg_37_0 then
				local var_37_8 = Color.New(0, 0, 0)

				var_37_8.a = 1
				arg_34_1.mask_.color = var_37_8
			end

			local var_37_9 = 2

			if 2 < arg_34_1.time_ and arg_34_1.time_ <= var_37_9 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_10 = 2

			if var_37_9 <= arg_34_1.time_ and arg_34_1.time_ < var_37_9 + var_37_10 then
				local var_37_11 = Color.New(0, 0, 0)

				var_37_11.a = Mathf.Lerp(1, 0, (arg_34_1.time_ - var_37_9) / var_37_10)
				arg_34_1.mask_.color = var_37_11
			end

			if arg_34_1.time_ >= var_37_9 + var_37_10 and arg_34_1.time_ < var_37_9 + var_37_10 + arg_37_0 then
				local var_37_12 = Color.New(0, 0, 0)

				arg_34_1.mask_.enabled = false
				var_37_12.a = 0
				arg_34_1.mask_.color = var_37_12
			end

			local var_37_13 = arg_34_1.actors_["10115"].transform

			if 1.966 < arg_34_1.time_ and arg_34_1.time_ <= 1.966 + arg_37_0 then
				arg_34_1.var_.moveOldPos10115 = var_37_13.localPosition
				var_37_13.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("10115", 7)

				for iter_37_2 = 0, var_37_13.childCount - 1 do
					local var_37_14 = var_37_13:GetChild(iter_37_2)

					if var_37_14.name == "" or not string.find(var_37_14.name, "split") then
						var_37_14.gameObject:SetActive(true)
					else
						var_37_14.gameObject:SetActive(false)
					end
				end
			end

			local var_37_15 = 0.001

			if 1.966 <= arg_34_1.time_ and arg_34_1.time_ < 1.966 + var_37_15 then
				var_37_13.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_34_1.time_ - 1.966) / var_37_15)
			end

			if arg_34_1.time_ >= 1.966 + var_37_15 and arg_34_1.time_ < 1.966 + var_37_15 + arg_37_0 then
				var_37_13.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_34_1.frameCnt_ <= 1 then
				arg_34_1.dialog_:SetActive(false)
			end

			local var_37_16 = 4
			local var_37_17 = 0.1

			if 4 < arg_34_1.time_ and arg_34_1.time_ <= var_37_16 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				arg_34_1.dialog_:SetActive(true)

				arg_34_1.dialogCg_.alpha = 0

				local var_37_18 = LeanTween.value(arg_34_1.dialog_, 0, 1, 0.3)

				var_37_18:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
					arg_34_1.dialogCg_.alpha = arg_38_0
				end))
				var_37_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_34_1.dialog_)
					var_37_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_34_1.duration_ = arg_34_1.duration_ + 0.3

				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_34_1.callingController_:SetSelectedState("calling")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_19 = arg_34_1:GetWordFromCfg(417241008)
				local var_37_20 = arg_34_1:FormatText(var_37_19.content)

				arg_34_1.text_.text = var_37_20

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_22 = 4 <= 0 and var_37_17 or var_37_17 * (utf8.len(var_37_20) / 4)

				if (4 <= 0 and var_37_17 or var_37_17 * (utf8.len(var_37_20) / 4)) > 0 and var_37_17 < var_37_22 then
					arg_34_1.talkMaxDuration = var_37_22
					var_37_16 = var_37_16 + 0.3

					if var_37_22 + var_37_16 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_22 + var_37_16
					end
				end

				arg_34_1.text_.text = var_37_20
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241008", "story_v_out_417241.awb") ~= 0 then
					local var_37_23 = manager.audio:GetVoiceLength("story_v_out_417241", "417241008", "story_v_out_417241.awb") / 1000

					if var_37_23 + var_37_16 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_23 + var_37_16
					end

					if var_37_19.prefab_name ~= "" and arg_34_1.actors_[var_37_19.prefab_name] ~= nil then
						local var_37_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_19.prefab_name].transform, "story_v_out_417241", "417241008", "story_v_out_417241.awb")

						arg_34_1:RecordAudio("417241008", var_37_24)
						arg_34_1:RecordAudio("417241008", var_37_24)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417241", "417241008", "story_v_out_417241.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417241", "417241008", "story_v_out_417241.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_25 = var_37_16 + 0.3
			local var_37_26 = math.max(var_37_17, arg_34_1.talkMaxDuration)

			if var_37_16 + 0.3 <= arg_34_1.time_ and arg_34_1.time_ < var_37_25 + var_37_26 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_25) / var_37_26

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_25 + var_37_26 and arg_34_1.time_ < var_37_25 + var_37_26 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play417241009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 417241009
		arg_40_1.duration_ = 5.2

		local var_40_0 = {
			zh = 2.6,
			ja = 5.2
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play417241010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.325

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:GetWordFromCfg(417241009)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 13 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 13)

				if (13 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 13)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241009", "story_v_out_417241.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241009", "story_v_out_417241.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_417241", "417241009", "story_v_out_417241.awb")

						arg_40_1:RecordAudio("417241009", var_43_6)
						arg_40_1:RecordAudio("417241009", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_417241", "417241009", "story_v_out_417241.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_417241", "417241009", "story_v_out_417241.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play417241010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 417241010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play417241011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 1.425

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(417241010).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 57 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 57)

				if (57 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 57)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play417241011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 417241011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play417241012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 1.05

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(417241011).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 42 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 42)

				if (42 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 42)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play417241012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 417241012
		arg_52_1.duration_ = 6.43

		local var_52_0 = {
			zh = 4.1,
			ja = 6.433
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play417241013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.bgs_["SS1710$naive"] == nil then
				local var_55_0 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1710$naive")
				var_55_0.name = "SS1710$naive"
				var_55_0.transform.parent = arg_52_1.stage_.transform
				var_55_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_["SS1710$naive"] = var_55_0
			end

			local var_55_1 = arg_52_1.bgs_["SS1710$naive"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPosSS1710_naive = var_55_1.localPosition
			end

			local var_55_2 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 then
				var_55_1.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosSS1710_naive, Vector3.New(0, 1, 10), (arg_52_1.time_ - 0) / var_55_2)
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 then
				var_55_1.localPosition = Vector3.New(0, 1, 10)
			end

			local var_55_3 = arg_52_1.bgs_["SS1710$naive"].transform

			if 0.0339999999999999 < arg_52_1.time_ and arg_52_1.time_ <= 0.0339999999999999 + arg_55_0 then
				arg_52_1.var_.moveOldPosSS1710_naive = var_55_3.localPosition
			end

			local var_55_4 = 1.966

			if 0.0339999999999999 <= arg_52_1.time_ and arg_52_1.time_ < 0.0339999999999999 + var_55_4 then
				var_55_3.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosSS1710_naive, Vector3.New(-0.2, 1, 10), (arg_52_1.time_ - 0.0339999999999999) / var_55_4)
			end

			if arg_52_1.time_ >= 0.0339999999999999 + var_55_4 and arg_52_1.time_ < 0.0339999999999999 + var_55_4 + arg_55_0 then
				var_55_3.localPosition = Vector3.New(-0.2, 1, 10)
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_5 = 2
			local var_55_6 = 0.275

			if 2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_7 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_7:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_8 = arg_52_1:GetWordFromCfg(417241012)
				local var_55_9 = arg_52_1:FormatText(var_55_8.content)

				arg_52_1.text_.text = var_55_9

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 11 <= 0 and var_55_6 or var_55_6 * (utf8.len(var_55_9) / 11)

				if (11 <= 0 and var_55_6 or var_55_6 * (utf8.len(var_55_9) / 11)) > 0 and var_55_6 < var_55_11 then
					arg_52_1.talkMaxDuration = var_55_11
					var_55_5 = var_55_5 + 0.3

					if var_55_11 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_5
					end
				end

				arg_52_1.text_.text = var_55_9
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241012", "story_v_out_417241.awb") ~= 0 then
					local var_55_12 = manager.audio:GetVoiceLength("story_v_out_417241", "417241012", "story_v_out_417241.awb") / 1000

					if var_55_12 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_12 + var_55_5
					end

					if var_55_8.prefab_name ~= "" and arg_52_1.actors_[var_55_8.prefab_name] ~= nil then
						local var_55_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_8.prefab_name].transform, "story_v_out_417241", "417241012", "story_v_out_417241.awb")

						arg_52_1:RecordAudio("417241012", var_55_13)
						arg_52_1:RecordAudio("417241012", var_55_13)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_417241", "417241012", "story_v_out_417241.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_417241", "417241012", "story_v_out_417241.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = var_55_5 + 0.3
			local var_55_15 = math.max(var_55_6, arg_52_1.talkMaxDuration)

			if var_55_5 + 0.3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_14 + var_55_15 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_14) / var_55_15

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_14 + var_55_15 and arg_52_1.time_ < var_55_14 + var_55_15 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1710$naive",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1710$naive",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.966,
				className = "StoryMoveNode",
				startTime = 0.0339999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play417241013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417241013
		arg_58_1.duration_ = 9.9

		local var_58_0 = {
			zh = 4.9,
			ja = 9.9
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
				arg_58_0:Play417241014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.575

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_58_1.callingController_:SetSelectedState("calling")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_1 = arg_58_1:GetWordFromCfg(417241013)
				local var_61_2 = arg_58_1:FormatText(var_61_1.content)

				arg_58_1.text_.text = var_61_2

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 23 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 23)

				if (23 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 23)) > 0 and var_61_0 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end

				arg_58_1.text_.text = var_61_2
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241013", "story_v_out_417241.awb") ~= 0 then
					local var_61_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241013", "story_v_out_417241.awb") / 1000

					if var_61_5 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + 0
					end

					if var_61_1.prefab_name ~= "" and arg_58_1.actors_[var_61_1.prefab_name] ~= nil then
						local var_61_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_1.prefab_name].transform, "story_v_out_417241", "417241013", "story_v_out_417241.awb")

						arg_58_1:RecordAudio("417241013", var_61_6)
						arg_58_1:RecordAudio("417241013", var_61_6)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417241", "417241013", "story_v_out_417241.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417241", "417241013", "story_v_out_417241.awb")
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
	Play417241014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417241014
		arg_62_1.duration_ = 8.83

		local var_62_0 = {
			zh = 7.466,
			ja = 8.833
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
				arg_62_0:Play417241015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 1.05

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
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

				local var_65_1 = arg_62_1:GetWordFromCfg(417241014)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 42 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 42)

				if (42 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 42)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241014", "story_v_out_417241.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241014", "story_v_out_417241.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_417241", "417241014", "story_v_out_417241.awb")

						arg_62_1:RecordAudio("417241014", var_65_6)
						arg_62_1:RecordAudio("417241014", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417241", "417241014", "story_v_out_417241.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417241", "417241014", "story_v_out_417241.awb")
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
	Play417241015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417241015
		arg_66_1.duration_ = 3.33

		local var_66_0 = {
			zh = 3,
			ja = 3.333
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
				arg_66_0:Play417241016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.4

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_66_1.callingController_:SetSelectedState("calling")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_1 = arg_66_1:GetWordFromCfg(417241015)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 16 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 16)

				if (16 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 16)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241015", "story_v_out_417241.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241015", "story_v_out_417241.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_417241", "417241015", "story_v_out_417241.awb")

						arg_66_1:RecordAudio("417241015", var_69_6)
						arg_66_1:RecordAudio("417241015", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417241", "417241015", "story_v_out_417241.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417241", "417241015", "story_v_out_417241.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play417241016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417241016
		arg_70_1.duration_ = 10.03

		local var_70_0 = {
			zh = 9.633,
			ja = 10.033
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
				arg_70_0:Play417241017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 1.125

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_1 = arg_70_1:GetWordFromCfg(417241016)
				local var_73_2 = arg_70_1:FormatText(var_73_1.content)

				arg_70_1.text_.text = var_73_2

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 45 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 45)

				if (45 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 45)) > 0 and var_73_0 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end

				arg_70_1.text_.text = var_73_2
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241016", "story_v_out_417241.awb") ~= 0 then
					local var_73_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241016", "story_v_out_417241.awb") / 1000

					if var_73_5 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + 0
					end

					if var_73_1.prefab_name ~= "" and arg_70_1.actors_[var_73_1.prefab_name] ~= nil then
						local var_73_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_1.prefab_name].transform, "story_v_out_417241", "417241016", "story_v_out_417241.awb")

						arg_70_1:RecordAudio("417241016", var_73_6)
						arg_70_1:RecordAudio("417241016", var_73_6)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417241", "417241016", "story_v_out_417241.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417241", "417241016", "story_v_out_417241.awb")
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
	Play417241017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417241017
		arg_74_1.duration_ = 4.87

		local var_74_0 = {
			zh = 2.5,
			ja = 4.866
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
				arg_74_0:Play417241018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.4

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
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

				local var_77_1 = arg_74_1:GetWordFromCfg(417241017)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 16 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 16)

				if (16 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 16)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241017", "story_v_out_417241.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241017", "story_v_out_417241.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_417241", "417241017", "story_v_out_417241.awb")

						arg_74_1:RecordAudio("417241017", var_77_6)
						arg_74_1:RecordAudio("417241017", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_417241", "417241017", "story_v_out_417241.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_417241", "417241017", "story_v_out_417241.awb")
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
	Play417241018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417241018
		arg_78_1.duration_ = 7.2

		local var_78_0 = {
			zh = 4.1,
			ja = 7.2
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
				arg_78_0:Play417241019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.45

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_78_1.callingController_:SetSelectedState("calling")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_1 = arg_78_1:GetWordFromCfg(417241018)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 18 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 18)

				if (18 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 18)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241018", "story_v_out_417241.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241018", "story_v_out_417241.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_out_417241", "417241018", "story_v_out_417241.awb")

						arg_78_1:RecordAudio("417241018", var_81_6)
						arg_78_1:RecordAudio("417241018", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417241", "417241018", "story_v_out_417241.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417241", "417241018", "story_v_out_417241.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play417241019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417241019
		arg_82_1.duration_ = 3.67

		local var_82_0 = {
			zh = 2.933,
			ja = 3.666
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
				arg_82_0:Play417241020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.325

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:GetWordFromCfg(417241019)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 13 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 13)

				if (13 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 13)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241019", "story_v_out_417241.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241019", "story_v_out_417241.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_417241", "417241019", "story_v_out_417241.awb")

						arg_82_1:RecordAudio("417241019", var_85_6)
						arg_82_1:RecordAudio("417241019", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417241", "417241019", "story_v_out_417241.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417241", "417241019", "story_v_out_417241.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417241020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417241020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play417241021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0.02 < arg_86_1.time_ and arg_86_1.time_ <= 0.02 + arg_89_0 then
				arg_86_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_uav01", "")
			end

			local var_89_1 = 0
			local var_89_2 = 1.2

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_3 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(417241020).content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 48 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 48)

				if (48 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 48)) > 0 and var_89_2 < var_89_5 then
					arg_86_1.talkMaxDuration = var_89_5

					if var_89_5 + var_89_1 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + var_89_1
					end
				end

				arg_86_1.text_.text = var_89_3
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_6 = math.max(var_89_2, arg_86_1.talkMaxDuration)

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_6 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_1) / var_89_6

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_1 + var_89_6 and arg_86_1.time_ < var_89_1 + var_89_6 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play417241021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417241021
		arg_90_1.duration_ = 7.13

		local var_90_0 = {
			zh = 3.366,
			ja = 7.133
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
				arg_90_0:Play417241022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.425

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:GetWordFromCfg(417241021)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 17 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 17)

				if (17 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 17)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241021", "story_v_out_417241.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241021", "story_v_out_417241.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_417241", "417241021", "story_v_out_417241.awb")

						arg_90_1:RecordAudio("417241021", var_93_6)
						arg_90_1:RecordAudio("417241021", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417241", "417241021", "story_v_out_417241.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417241", "417241021", "story_v_out_417241.awb")
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
	Play417241022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417241022
		arg_94_1.duration_ = 8.2

		local var_94_0 = {
			zh = 3.5,
			ja = 8.2
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
				arg_94_0:Play417241023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.5

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_1")

				arg_94_1.callingController_:SetSelectedState("calling")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_1 = arg_94_1:GetWordFromCfg(417241022)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 20 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 20)

				if (20 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 20)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241022", "story_v_out_417241.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241022", "story_v_out_417241.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_417241", "417241022", "story_v_out_417241.awb")

						arg_94_1:RecordAudio("417241022", var_97_6)
						arg_94_1:RecordAudio("417241022", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417241", "417241022", "story_v_out_417241.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417241", "417241022", "story_v_out_417241.awb")
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
	Play417241023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417241023
		arg_98_1.duration_ = 7.27

		local var_98_0 = {
			zh = 2.5,
			ja = 7.266
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
				arg_98_0:Play417241024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.325

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

				local var_101_1 = arg_98_1:GetWordFromCfg(417241023)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 13 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 13)

				if (13 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 13)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241023", "story_v_out_417241.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241023", "story_v_out_417241.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_417241", "417241023", "story_v_out_417241.awb")

						arg_98_1:RecordAudio("417241023", var_101_6)
						arg_98_1:RecordAudio("417241023", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_417241", "417241023", "story_v_out_417241.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_417241", "417241023", "story_v_out_417241.awb")
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
	Play417241024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417241024
		arg_102_1.duration_ = 3.3

		local var_102_0 = {
			zh = 2.2,
			ja = 3.3
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
				arg_102_0:Play417241025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.275

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_2")

				arg_102_1.callingController_:SetSelectedState("calling")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_1 = arg_102_1:GetWordFromCfg(417241024)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 11 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 11)

				if (11 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 11)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241024", "story_v_out_417241.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241024", "story_v_out_417241.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_417241", "417241024", "story_v_out_417241.awb")

						arg_102_1:RecordAudio("417241024", var_105_6)
						arg_102_1:RecordAudio("417241024", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_417241", "417241024", "story_v_out_417241.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_417241", "417241024", "story_v_out_417241.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play417241025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417241025
		arg_106_1.duration_ = 7.3

		local var_106_0 = {
			zh = 5.1,
			ja = 7.3
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
				arg_106_0:Play417241026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.525

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
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

				local var_109_1 = arg_106_1:GetWordFromCfg(417241025)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 21 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 21)

				if (21 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 21)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241025", "story_v_out_417241.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241025", "story_v_out_417241.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_417241", "417241025", "story_v_out_417241.awb")

						arg_106_1:RecordAudio("417241025", var_109_6)
						arg_106_1:RecordAudio("417241025", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_417241", "417241025", "story_v_out_417241.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_417241", "417241025", "story_v_out_417241.awb")
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
	Play417241026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 417241026
		arg_110_1.duration_ = 9.57

		local var_110_0 = {
			zh = 6.7,
			ja = 9.566
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
				arg_110_0:Play417241027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.9

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

				local var_113_1 = arg_110_1:GetWordFromCfg(417241026)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 36 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 36)

				if (36 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 36)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241026", "story_v_out_417241.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241026", "story_v_out_417241.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_417241", "417241026", "story_v_out_417241.awb")

						arg_110_1:RecordAudio("417241026", var_113_6)
						arg_110_1:RecordAudio("417241026", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_417241", "417241026", "story_v_out_417241.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_417241", "417241026", "story_v_out_417241.awb")
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
	Play417241027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 417241027
		arg_114_1.duration_ = 6.4

		local var_114_0 = {
			zh = 4.066,
			ja = 6.4
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
				arg_114_0:Play417241028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.55

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_1")

				arg_114_1.callingController_:SetSelectedState("calling")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_1 = arg_114_1:GetWordFromCfg(417241027)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 22 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 22)

				if (22 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 22)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241027", "story_v_out_417241.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241027", "story_v_out_417241.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_417241", "417241027", "story_v_out_417241.awb")

						arg_114_1:RecordAudio("417241027", var_117_6)
						arg_114_1:RecordAudio("417241027", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_417241", "417241027", "story_v_out_417241.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_417241", "417241027", "story_v_out_417241.awb")
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
	Play417241028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 417241028
		arg_118_1.duration_ = 6.2

		local var_118_0 = {
			zh = 3.466,
			ja = 6.2
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
				arg_118_0:Play417241029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.45

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:GetWordFromCfg(417241028)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 18 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 18)

				if (18 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 18)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241028", "story_v_out_417241.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241028", "story_v_out_417241.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_417241", "417241028", "story_v_out_417241.awb")

						arg_118_1:RecordAudio("417241028", var_121_6)
						arg_118_1:RecordAudio("417241028", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_417241", "417241028", "story_v_out_417241.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_417241", "417241028", "story_v_out_417241.awb")
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
	Play417241029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 417241029
		arg_122_1.duration_ = 3.8

		local var_122_0 = {
			zh = 2.5,
			ja = 3.8
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
				arg_122_0:Play417241030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.375

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_2 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_2:setOnUpdate(LuaHelper.FloatAction(function(arg_126_0)
					arg_122_1.dialogCg_.alpha = arg_126_0
				end))
				var_125_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_1")

				arg_122_1.callingController_:SetSelectedState("calling")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:GetWordFromCfg(417241029)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_6 = 15 <= 0 and var_125_1 or var_125_1 * (utf8.len(var_125_4) / 15)

				if (15 <= 0 and var_125_1 or var_125_1 * (utf8.len(var_125_4) / 15)) > 0 and var_125_1 < var_125_6 then
					arg_122_1.talkMaxDuration = var_125_6
					var_125_0 = var_125_0 + 0.3

					if var_125_6 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241029", "story_v_out_417241.awb") ~= 0 then
					local var_125_7 = manager.audio:GetVoiceLength("story_v_out_417241", "417241029", "story_v_out_417241.awb") / 1000

					if var_125_7 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_0
					end

					if var_125_3.prefab_name ~= "" and arg_122_1.actors_[var_125_3.prefab_name] ~= nil then
						local var_125_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_3.prefab_name].transform, "story_v_out_417241", "417241029", "story_v_out_417241.awb")

						arg_122_1:RecordAudio("417241029", var_125_8)
						arg_122_1:RecordAudio("417241029", var_125_8)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_417241", "417241029", "story_v_out_417241.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_417241", "417241029", "story_v_out_417241.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_9 = var_125_0 + 0.3
			local var_125_10 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 + 0.3 <= arg_122_1.time_ and arg_122_1.time_ < var_125_9 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_9) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_9 + var_125_10 and arg_122_1.time_ < var_125_9 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play417241030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417241030
		arg_128_1.duration_ = 7.87

		local var_128_0 = {
			zh = 6.766,
			ja = 7.866
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
				arg_128_0:Play417241031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.825

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
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

				local var_131_1 = arg_128_1:GetWordFromCfg(417241030)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 33 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 33)

				if (33 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 33)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241030", "story_v_out_417241.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241030", "story_v_out_417241.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_out_417241", "417241030", "story_v_out_417241.awb")

						arg_128_1:RecordAudio("417241030", var_131_6)
						arg_128_1:RecordAudio("417241030", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417241", "417241030", "story_v_out_417241.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417241", "417241030", "story_v_out_417241.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play417241031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417241031
		arg_132_1.duration_ = 9.17

		local var_132_0 = {
			zh = 5.133,
			ja = 9.166
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
				arg_132_0:Play417241032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.575

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:GetWordFromCfg(417241031)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 23 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 23)

				if (23 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 23)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241031", "story_v_out_417241.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241031", "story_v_out_417241.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_out_417241", "417241031", "story_v_out_417241.awb")

						arg_132_1:RecordAudio("417241031", var_135_6)
						arg_132_1:RecordAudio("417241031", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417241", "417241031", "story_v_out_417241.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417241", "417241031", "story_v_out_417241.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play417241032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417241032
		arg_136_1.duration_ = 9

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play417241033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 4 < arg_136_1.time_ and arg_136_1.time_ <= 4 + arg_139_0 then
				arg_136_1.allBtn_.enabled = false
			end

			if arg_136_1.time_ >= 4 + 0.833333333333333 and arg_136_1.time_ < 4 + 0.833333333333333 + arg_139_0 then
				arg_136_1.allBtn_.enabled = true
			end

			local var_139_0 = "I17f"

			if arg_136_1.bgs_.I17f == nil then
				local var_139_1 = Object.Instantiate(arg_136_1.paintGo_)

				var_139_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_139_0)
				var_139_1.name = var_139_0
				var_139_1.transform.parent = arg_136_1.stage_.transform
				var_139_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.bgs_[var_139_0] = var_139_1
			end

			if 2 < arg_136_1.time_ and arg_136_1.time_ <= 2 + arg_139_0 then
				local var_139_2 = arg_136_1.bgs_.I17f

				arg_136_1.bgs_.I17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_139_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_139_3 = var_139_2:GetComponent("SpriteRenderer")

				if var_139_3 and var_139_3.sprite then
					local var_139_4 = 2 * (var_139_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_139_2.transform.localScale = Vector3.New(var_139_4 / var_139_3.sprite.bounds.size.y < var_139_4 * manager.ui.mainCameraCom_.aspect / var_139_3.sprite.bounds.size.x and var_139_4 * manager.ui.mainCameraCom_.aspect / var_139_3.sprite.bounds.size.x or var_139_4 / var_139_3.sprite.bounds.size.y, var_139_4 / var_139_3.sprite.bounds.size.y < var_139_4 * manager.ui.mainCameraCom_.aspect / var_139_3.sprite.bounds.size.x and var_139_4 * manager.ui.mainCameraCom_.aspect / var_139_3.sprite.bounds.size.x or var_139_4 / var_139_3.sprite.bounds.size.y, 0)
				end

				for iter_139_0, iter_139_1 in pairs(arg_136_1.bgs_) do
					if iter_139_0 ~= "I17f" then
						iter_139_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_139_13 = "1034"

			if arg_136_1.actors_["1034"] == nil then
				local var_139_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_139_14) then
					local var_139_15 = Object.Instantiate(var_139_14, arg_136_1.canvasGo_.transform)

					var_139_15.transform:SetSiblingIndex(1)

					var_139_15.name = var_139_13
					var_139_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_136_1.actors_[var_139_13] = var_139_15

					if arg_136_1.isInRecall_ then
						for iter_139_2, iter_139_3 in ipairs((var_139_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_139_3.color = arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_139_16 = arg_136_1.actors_["1034"].transform

			if 1.966 < arg_136_1.time_ and arg_136_1.time_ <= 1.966 + arg_139_0 then
				arg_136_1.var_.moveOldPos1034 = var_139_16.localPosition
				var_139_16.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1034", 7)

				for iter_139_4 = 0, var_139_16.childCount - 1 do
					local var_139_17 = var_139_16:GetChild(iter_139_4)

					if var_139_17.name == "" or not string.find(var_139_17.name, "split") then
						var_139_17.gameObject:SetActive(true)
					else
						var_139_17.gameObject:SetActive(false)
					end
				end
			end

			local var_139_18 = 0.001

			if 1.966 <= arg_136_1.time_ and arg_136_1.time_ < 1.966 + var_139_18 then
				var_139_16.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_136_1.time_ - 1.966) / var_139_18)
			end

			if arg_136_1.time_ >= 1.966 + var_139_18 and arg_136_1.time_ < 1.966 + var_139_18 + arg_139_0 then
				var_139_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_139_19 = arg_136_1.actors_["10115"].transform

			if 1.966 < arg_136_1.time_ and arg_136_1.time_ <= 1.966 + arg_139_0 then
				arg_136_1.var_.moveOldPos10115 = var_139_19.localPosition
				var_139_19.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("10115", 7)

				for iter_139_5 = 0, var_139_19.childCount - 1 do
					local var_139_20 = var_139_19:GetChild(iter_139_5)

					if var_139_20.name == "" or not string.find(var_139_20.name, "split") then
						var_139_20.gameObject:SetActive(true)
					else
						var_139_20.gameObject:SetActive(false)
					end
				end
			end

			local var_139_21 = 0.001

			if 1.966 <= arg_136_1.time_ and arg_136_1.time_ < 1.966 + var_139_21 then
				var_139_19.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_136_1.time_ - 1.966) / var_139_21)
			end

			if arg_136_1.time_ >= 1.966 + var_139_21 and arg_136_1.time_ < 1.966 + var_139_21 + arg_139_0 then
				var_139_19.localPosition = Vector3.New(0, -2000, 0)
			end

			if 4 < arg_136_1.time_ and arg_136_1.time_ <= 4 + arg_139_0 then
				arg_136_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_uav01", "")
			end

			if 1.66666666666667 < arg_136_1.time_ and arg_136_1.time_ <= 1.66666666666667 + arg_139_0 then
				arg_136_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_139_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_136_1.bgmTxt_.text ~= var_139_26 and arg_136_1.bgmTxt_.text ~= "" then
						if arg_136_1.bgmTxt2_.text ~= "" then
							arg_136_1.bgmTxt_.text = arg_136_1.bgmTxt2_.text
						end

						arg_136_1.bgmTxt2_.text = var_139_26

						arg_136_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_136_1.bgmTxt_.text = var_139_26
						arg_136_1.bgmTxt2_.text = var_139_26
					end

					if arg_136_1.bgmTimer then
						arg_136_1.bgmTimer:Stop()

						arg_136_1.bgmTimer = nil
					end

					if arg_136_1.settingData.show_music_name == 1 then
						arg_136_1.musicController:SetSelectedState("show")
						arg_136_1.musicAnimator_:Play("open", 0, 0)

						if arg_136_1.settingData.music_time ~= 0 then
							arg_136_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_136_1.settingData.music_time), function()
								if arg_136_1 == nil or isNil(arg_136_1.bgmTxt_) then
									return
								end

								arg_136_1.musicController:SetSelectedState("hide")
								arg_136_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.66666666666667 < arg_136_1.time_ and arg_136_1.time_ <= 1.66666666666667 + arg_139_0 then
				arg_136_1:AudioAction("play", "music", "bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain.awb")

				local var_139_29 = manager.audio:GetAudioName("bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain")

				if "" ~= "" then
					if arg_136_1.bgmTxt_.text ~= var_139_29 and arg_136_1.bgmTxt_.text ~= "" then
						if arg_136_1.bgmTxt2_.text ~= "" then
							arg_136_1.bgmTxt_.text = arg_136_1.bgmTxt2_.text
						end

						arg_136_1.bgmTxt2_.text = var_139_29

						arg_136_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_136_1.bgmTxt_.text = var_139_29
						arg_136_1.bgmTxt2_.text = var_139_29
					end

					if arg_136_1.bgmTimer then
						arg_136_1.bgmTimer:Stop()

						arg_136_1.bgmTimer = nil
					end

					if arg_136_1.settingData.show_music_name == 1 then
						arg_136_1.musicController:SetSelectedState("show")
						arg_136_1.musicAnimator_:Play("open", 0, 0)

						if arg_136_1.settingData.music_time ~= 0 then
							arg_136_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_136_1.settingData.music_time), function()
								if arg_136_1 == nil or isNil(arg_136_1.bgmTxt_) then
									return
								end

								arg_136_1.musicController:SetSelectedState("hide")
								arg_136_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_136_1.frameCnt_ <= 1 then
				arg_136_1.dialog_:SetActive(false)
			end

			local var_139_30 = 4
			local var_139_31 = 1.3

			if 4 < arg_136_1.time_ and arg_136_1.time_ <= var_139_30 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0

				arg_136_1.dialog_:SetActive(true)

				arg_136_1.dialogCg_.alpha = 0

				local var_139_32 = LeanTween.value(arg_136_1.dialog_, 0, 1, 0.3)

				var_139_32:setOnUpdate(LuaHelper.FloatAction(function(arg_142_0)
					arg_136_1.dialogCg_.alpha = arg_142_0
				end))
				var_139_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_136_1.dialog_)
					var_139_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_136_1.duration_ = arg_136_1.duration_ + 0.3

				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_33 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(417241032).content)

				arg_136_1.text_.text = var_139_33

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_35 = 52 <= 0 and var_139_31 or var_139_31 * (utf8.len(var_139_33) / 52)

				if (52 <= 0 and var_139_31 or var_139_31 * (utf8.len(var_139_33) / 52)) > 0 and var_139_31 < var_139_35 then
					arg_136_1.talkMaxDuration = var_139_35
					var_139_30 = var_139_30 + 0.3

					if var_139_35 + var_139_30 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_35 + var_139_30
					end
				end

				arg_136_1.text_.text = var_139_33
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_36 = var_139_30 + 0.3
			local var_139_37 = math.max(var_139_31, arg_136_1.talkMaxDuration)

			if var_139_30 + 0.3 <= arg_136_1.time_ and arg_136_1.time_ < var_139_36 + var_139_37 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_36) / var_139_37

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_36 + var_139_37 and arg_136_1.time_ < var_139_36 + var_139_37 + arg_139_0 then
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
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play417241033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417241033
		arg_144_1.duration_ = 9.27

		local var_144_0 = {
			zh = 3.733,
			ja = 9.266
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
				arg_144_0:Play417241034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.375

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_144_1.callingController_:SetSelectedState("calling")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_1 = arg_144_1:GetWordFromCfg(417241033)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 15 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 15)

				if (15 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 15)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241033", "story_v_out_417241.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241033", "story_v_out_417241.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_417241", "417241033", "story_v_out_417241.awb")

						arg_144_1:RecordAudio("417241033", var_147_6)
						arg_144_1:RecordAudio("417241033", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_417241", "417241033", "story_v_out_417241.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_417241", "417241033", "story_v_out_417241.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play417241034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417241034
		arg_148_1.duration_ = 9.3

		local var_148_0 = {
			zh = 9,
			ja = 9.3
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
				arg_148_0:Play417241035(arg_148_1)
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
								iter_151_1.color = Color.New(Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, (arg_148_1.time_ - 0) / var_151_0), Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, (arg_148_1.time_ - 0) / var_151_0), (Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, (arg_148_1.time_ - 0) / var_151_0)))
							else
								local var_151_1 = Mathf.Lerp(iter_151_1.color.r, 1, (arg_148_1.time_ - 0) / var_151_0)

								iter_151_1.color = Color.New(var_151_1, var_151_1, var_151_1)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1034"]) and arg_148_1.var_.actorSpriteComps1034 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_151_3 then
						iter_151_3.color = arg_148_1.isInRecall_ and (arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_148_1.var_.actorSpriteComps1034 = nil
			end

			local var_151_2 = arg_148_1.actors_["1034"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1034 = var_151_2.localPosition
				var_151_2.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("1034", 3)

				for iter_151_4 = 0, var_151_2.childCount - 1 do
					local var_151_3 = var_151_2:GetChild(iter_151_4)

					if var_151_3.name == "" or not string.find(var_151_3.name, "split") then
						var_151_3.gameObject:SetActive(true)
					else
						var_151_3.gameObject:SetActive(false)
					end
				end
			end

			local var_151_4 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				var_151_2.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_148_1.time_ - 0) / var_151_4)
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				var_151_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_151_5 = 0
			local var_151_6 = 1.075

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_7 = arg_148_1:GetWordFromCfg(417241034)
				local var_151_8 = arg_148_1:FormatText(var_151_7.content)

				arg_148_1.text_.text = var_151_8

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_10 = 43 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_8) / 43)

				if (43 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_8) / 43)) > 0 and var_151_6 < var_151_10 then
					arg_148_1.talkMaxDuration = var_151_10

					if var_151_10 + var_151_5 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_5
					end
				end

				arg_148_1.text_.text = var_151_8
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241034", "story_v_out_417241.awb") ~= 0 then
					local var_151_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241034", "story_v_out_417241.awb") / 1000

					if var_151_11 + var_151_5 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_11 + var_151_5
					end

					if var_151_7.prefab_name ~= "" and arg_148_1.actors_[var_151_7.prefab_name] ~= nil then
						local var_151_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_7.prefab_name].transform, "story_v_out_417241", "417241034", "story_v_out_417241.awb")

						arg_148_1:RecordAudio("417241034", var_151_12)
						arg_148_1:RecordAudio("417241034", var_151_12)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_417241", "417241034", "story_v_out_417241.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_417241", "417241034", "story_v_out_417241.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_13 = math.max(var_151_6, arg_148_1.talkMaxDuration)

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_13 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_5) / var_151_13

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_5 + var_151_13 and arg_148_1.time_ < var_151_5 + var_151_13 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play417241035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417241035
		arg_152_1.duration_ = 6.27

		local var_152_0 = {
			zh = 3.9,
			ja = 6.266
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
				arg_152_0:Play417241036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.525

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
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

				local var_155_1 = arg_152_1:GetWordFromCfg(417241035)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 21 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 21)

				if (21 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 21)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241035", "story_v_out_417241.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241035", "story_v_out_417241.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_417241", "417241035", "story_v_out_417241.awb")

						arg_152_1:RecordAudio("417241035", var_155_6)
						arg_152_1:RecordAudio("417241035", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_417241", "417241035", "story_v_out_417241.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_417241", "417241035", "story_v_out_417241.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play417241036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417241036
		arg_156_1.duration_ = 8.4

		local var_156_0 = {
			zh = 7.566,
			ja = 8.4
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
				arg_156_0:Play417241037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1034"]) and arg_156_1.var_.actorSpriteComps1034 == nil then
				arg_156_1.var_.actorSpriteComps1034 = arg_156_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_0 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1034"]) then
				if arg_156_1.var_.actorSpriteComps1034 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								iter_159_1.color = Color.New(Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor2.r, (arg_156_1.time_ - 0) / var_159_0), Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor2.g, (arg_156_1.time_ - 0) / var_159_0), (Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor2.b, (arg_156_1.time_ - 0) / var_159_0)))
							else
								local var_159_1 = Mathf.Lerp(iter_159_1.color.r, 0.5, (arg_156_1.time_ - 0) / var_159_0)

								iter_159_1.color = Color.New(var_159_1, var_159_1, var_159_1)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1034"]) and arg_156_1.var_.actorSpriteComps1034 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_159_3 then
						iter_159_3.color = arg_156_1.isInRecall_ and (arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_156_1.var_.actorSpriteComps1034 = nil
			end

			local var_159_2 = 0
			local var_159_3 = 0.775

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_2 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_156_1.callingController_:SetSelectedState("calling")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_4 = arg_156_1:GetWordFromCfg(417241036)
				local var_159_5 = arg_156_1:FormatText(var_159_4.content)

				arg_156_1.text_.text = var_159_5

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_7 = 31 <= 0 and var_159_3 or var_159_3 * (utf8.len(var_159_5) / 31)

				if (31 <= 0 and var_159_3 or var_159_3 * (utf8.len(var_159_5) / 31)) > 0 and var_159_3 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_2
					end
				end

				arg_156_1.text_.text = var_159_5
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241036", "story_v_out_417241.awb") ~= 0 then
					local var_159_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241036", "story_v_out_417241.awb") / 1000

					if var_159_8 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_2
					end

					if var_159_4.prefab_name ~= "" and arg_156_1.actors_[var_159_4.prefab_name] ~= nil then
						local var_159_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_4.prefab_name].transform, "story_v_out_417241", "417241036", "story_v_out_417241.awb")

						arg_156_1:RecordAudio("417241036", var_159_9)
						arg_156_1:RecordAudio("417241036", var_159_9)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_417241", "417241036", "story_v_out_417241.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_417241", "417241036", "story_v_out_417241.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_3, arg_156_1.talkMaxDuration)

			if var_159_2 <= arg_156_1.time_ and arg_156_1.time_ < var_159_2 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_2) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_2 + var_159_10 and arg_156_1.time_ < var_159_2 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play417241037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417241037
		arg_160_1.duration_ = 8

		local var_160_0 = {
			zh = 7.4,
			ja = 8
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play417241038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1034"]) and arg_160_1.var_.actorSpriteComps1034 == nil then
				arg_160_1.var_.actorSpriteComps1034 = arg_160_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_0 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1034"]) then
				if arg_160_1.var_.actorSpriteComps1034 then
					for iter_163_0, iter_163_1 in pairs(arg_160_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_163_1 then
							if arg_160_1.isInRecall_ then
								iter_163_1.color = Color.New(Mathf.Lerp(iter_163_1.color.r, arg_160_1.hightColor1.r, (arg_160_1.time_ - 0) / var_163_0), Mathf.Lerp(iter_163_1.color.g, arg_160_1.hightColor1.g, (arg_160_1.time_ - 0) / var_163_0), (Mathf.Lerp(iter_163_1.color.b, arg_160_1.hightColor1.b, (arg_160_1.time_ - 0) / var_163_0)))
							else
								local var_163_1 = Mathf.Lerp(iter_163_1.color.r, 1, (arg_160_1.time_ - 0) / var_163_0)

								iter_163_1.color = Color.New(var_163_1, var_163_1, var_163_1)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1034"]) and arg_160_1.var_.actorSpriteComps1034 then
				for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_163_3 then
						iter_163_3.color = arg_160_1.isInRecall_ and (arg_160_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_160_1.var_.actorSpriteComps1034 = nil
			end

			local var_163_2 = "10111"

			if arg_160_1.actors_["10111"] == nil then
				local var_163_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10111")

				if not isNil(var_163_3) then
					local var_163_4 = Object.Instantiate(var_163_3, arg_160_1.canvasGo_.transform)

					var_163_4.transform:SetSiblingIndex(1)

					var_163_4.name = var_163_2
					var_163_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_160_1.actors_[var_163_2] = var_163_4

					if arg_160_1.isInRecall_ then
						for iter_163_4, iter_163_5 in ipairs((var_163_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_163_5.color = arg_160_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_163_5 = arg_160_1.actors_["10111"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_5) and arg_160_1.var_.actorSpriteComps10111 == nil then
				arg_160_1.var_.actorSpriteComps10111 = var_163_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_6 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_6 and not isNil(var_163_5) then
				if arg_160_1.var_.actorSpriteComps10111 then
					for iter_163_6, iter_163_7 in pairs(arg_160_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_163_7 then
							if arg_160_1.isInRecall_ then
								iter_163_7.color = Color.New(Mathf.Lerp(iter_163_7.color.r, arg_160_1.hightColor2.r, (arg_160_1.time_ - 0) / var_163_6), Mathf.Lerp(iter_163_7.color.g, arg_160_1.hightColor2.g, (arg_160_1.time_ - 0) / var_163_6), (Mathf.Lerp(iter_163_7.color.b, arg_160_1.hightColor2.b, (arg_160_1.time_ - 0) / var_163_6)))
							else
								local var_163_7 = Mathf.Lerp(iter_163_7.color.r, 0.5, (arg_160_1.time_ - 0) / var_163_6)

								iter_163_7.color = Color.New(var_163_7, var_163_7, var_163_7)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= 0 + var_163_6 and arg_160_1.time_ < 0 + var_163_6 + arg_163_0 and not isNil(var_163_5) and arg_160_1.var_.actorSpriteComps10111 then
				for iter_163_8, iter_163_9 in pairs(arg_160_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_163_9 then
						iter_163_9.color = arg_160_1.isInRecall_ and (arg_160_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_160_1.var_.actorSpriteComps10111 = nil
			end

			local var_163_8 = 0
			local var_163_9 = 0.9

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_8 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_10 = arg_160_1:GetWordFromCfg(417241037)
				local var_163_11 = arg_160_1:FormatText(var_163_10.content)

				arg_160_1.text_.text = var_163_11

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_13 = 36 <= 0 and var_163_9 or var_163_9 * (utf8.len(var_163_11) / 36)

				if (36 <= 0 and var_163_9 or var_163_9 * (utf8.len(var_163_11) / 36)) > 0 and var_163_9 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_8 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_8
					end
				end

				arg_160_1.text_.text = var_163_11
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241037", "story_v_out_417241.awb") ~= 0 then
					local var_163_14 = manager.audio:GetVoiceLength("story_v_out_417241", "417241037", "story_v_out_417241.awb") / 1000

					if var_163_14 + var_163_8 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_14 + var_163_8
					end

					if var_163_10.prefab_name ~= "" and arg_160_1.actors_[var_163_10.prefab_name] ~= nil then
						local var_163_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_10.prefab_name].transform, "story_v_out_417241", "417241037", "story_v_out_417241.awb")

						arg_160_1:RecordAudio("417241037", var_163_15)
						arg_160_1:RecordAudio("417241037", var_163_15)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_417241", "417241037", "story_v_out_417241.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_417241", "417241037", "story_v_out_417241.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_16 = math.max(var_163_9, arg_160_1.talkMaxDuration)

			if var_163_8 <= arg_160_1.time_ and arg_160_1.time_ < var_163_8 + var_163_16 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_8) / var_163_16

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_8 + var_163_16 and arg_160_1.time_ < var_163_8 + var_163_16 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play417241038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 417241038
		arg_164_1.duration_ = 7.37

		local var_164_0 = {
			zh = 4.966,
			ja = 7.366
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
				arg_164_0:Play417241039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.65

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_1 = arg_164_1:GetWordFromCfg(417241038)
				local var_167_2 = arg_164_1:FormatText(var_167_1.content)

				arg_164_1.text_.text = var_167_2

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_4 = 26 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 26)

				if (26 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 26)) > 0 and var_167_0 < var_167_4 then
					arg_164_1.talkMaxDuration = var_167_4

					if var_167_4 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_4 + 0
					end
				end

				arg_164_1.text_.text = var_167_2
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241038", "story_v_out_417241.awb") ~= 0 then
					local var_167_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241038", "story_v_out_417241.awb") / 1000

					if var_167_5 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + 0
					end

					if var_167_1.prefab_name ~= "" and arg_164_1.actors_[var_167_1.prefab_name] ~= nil then
						local var_167_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_1.prefab_name].transform, "story_v_out_417241", "417241038", "story_v_out_417241.awb")

						arg_164_1:RecordAudio("417241038", var_167_6)
						arg_164_1:RecordAudio("417241038", var_167_6)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_417241", "417241038", "story_v_out_417241.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_417241", "417241038", "story_v_out_417241.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_7 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_7 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_7

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_7 and arg_164_1.time_ < 0 + var_167_7 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play417241039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 417241039
		arg_168_1.duration_ = 9.1

		local var_168_0 = {
			zh = 7.966,
			ja = 9.1
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
				arg_168_0:Play417241040(arg_168_1)
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
								iter_171_1.color = Color.New(Mathf.Lerp(iter_171_1.color.r, arg_168_1.hightColor2.r, (arg_168_1.time_ - 0) / var_171_0), Mathf.Lerp(iter_171_1.color.g, arg_168_1.hightColor2.g, (arg_168_1.time_ - 0) / var_171_0), (Mathf.Lerp(iter_171_1.color.b, arg_168_1.hightColor2.b, (arg_168_1.time_ - 0) / var_171_0)))
							else
								local var_171_1 = Mathf.Lerp(iter_171_1.color.r, 0.5, (arg_168_1.time_ - 0) / var_171_0)

								iter_171_1.color = Color.New(var_171_1, var_171_1, var_171_1)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1034"]) and arg_168_1.var_.actorSpriteComps1034 then
				for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_171_3 then
						iter_171_3.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_168_1.var_.actorSpriteComps1034 = nil
			end

			local var_171_2 = 0
			local var_171_3 = 0.9

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_2 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_168_1.callingController_:SetSelectedState("calling")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_4 = arg_168_1:GetWordFromCfg(417241039)
				local var_171_5 = arg_168_1:FormatText(var_171_4.content)

				arg_168_1.text_.text = var_171_5

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_7 = 36 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 36)

				if (36 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 36)) > 0 and var_171_3 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_2
					end
				end

				arg_168_1.text_.text = var_171_5
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241039", "story_v_out_417241.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241039", "story_v_out_417241.awb") / 1000

					if var_171_8 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_2
					end

					if var_171_4.prefab_name ~= "" and arg_168_1.actors_[var_171_4.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_4.prefab_name].transform, "story_v_out_417241", "417241039", "story_v_out_417241.awb")

						arg_168_1:RecordAudio("417241039", var_171_9)
						arg_168_1:RecordAudio("417241039", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_417241", "417241039", "story_v_out_417241.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_417241", "417241039", "story_v_out_417241.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_3, arg_168_1.talkMaxDuration)

			if var_171_2 <= arg_168_1.time_ and arg_168_1.time_ < var_171_2 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_2) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_2 + var_171_10 and arg_168_1.time_ < var_171_2 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play417241040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 417241040
		arg_172_1.duration_ = 7.6

		local var_172_0 = {
			zh = 6.6,
			ja = 7.6
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
				arg_172_0:Play417241041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.775

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_172_1.callingController_:SetSelectedState("calling")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_1 = arg_172_1:GetWordFromCfg(417241040)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 31 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 31)

				if (31 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 31)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241040", "story_v_out_417241.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241040", "story_v_out_417241.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_out_417241", "417241040", "story_v_out_417241.awb")

						arg_172_1:RecordAudio("417241040", var_175_6)
						arg_172_1:RecordAudio("417241040", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_417241", "417241040", "story_v_out_417241.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_417241", "417241040", "story_v_out_417241.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play417241041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 417241041
		arg_176_1.duration_ = 8.23

		local var_176_0 = {
			zh = 4.633,
			ja = 8.233
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
				arg_176_0:Play417241042(arg_176_1)
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

			local var_179_2 = arg_176_1.actors_["10111"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.actorSpriteComps10111 == nil then
				arg_176_1.var_.actorSpriteComps10111 = var_179_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_3 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_3 and not isNil(var_179_2) then
				if arg_176_1.var_.actorSpriteComps10111 then
					for iter_179_4, iter_179_5 in pairs(arg_176_1.var_.actorSpriteComps10111:ToTable()) do
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

			if arg_176_1.time_ >= 0 + var_179_3 and arg_176_1.time_ < 0 + var_179_3 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.actorSpriteComps10111 then
				for iter_179_6, iter_179_7 in pairs(arg_176_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_179_7 then
						iter_179_7.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_176_1.var_.actorSpriteComps10111 = nil
			end

			local var_179_5 = 0
			local var_179_6 = 0.475

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

				local var_179_7 = arg_176_1:GetWordFromCfg(417241041)
				local var_179_8 = arg_176_1:FormatText(var_179_7.content)

				arg_176_1.text_.text = var_179_8

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_10 = 19 <= 0 and var_179_6 or var_179_6 * (utf8.len(var_179_8) / 19)

				if (19 <= 0 and var_179_6 or var_179_6 * (utf8.len(var_179_8) / 19)) > 0 and var_179_6 < var_179_10 then
					arg_176_1.talkMaxDuration = var_179_10

					if var_179_10 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_10 + var_179_5
					end
				end

				arg_176_1.text_.text = var_179_8
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241041", "story_v_out_417241.awb") ~= 0 then
					local var_179_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241041", "story_v_out_417241.awb") / 1000

					if var_179_11 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_11 + var_179_5
					end

					if var_179_7.prefab_name ~= "" and arg_176_1.actors_[var_179_7.prefab_name] ~= nil then
						local var_179_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_7.prefab_name].transform, "story_v_out_417241", "417241041", "story_v_out_417241.awb")

						arg_176_1:RecordAudio("417241041", var_179_12)
						arg_176_1:RecordAudio("417241041", var_179_12)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_417241", "417241041", "story_v_out_417241.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_417241", "417241041", "story_v_out_417241.awb")
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
	Play417241042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 417241042
		arg_180_1.duration_ = 8.53

		local var_180_0 = {
			zh = 5.9,
			ja = 8.533
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
				arg_180_0:Play417241043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["1034"]) and arg_180_1.var_.actorSpriteComps1034 == nil then
				arg_180_1.var_.actorSpriteComps1034 = arg_180_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_0 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["1034"]) then
				if arg_180_1.var_.actorSpriteComps1034 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								iter_183_1.color = Color.New(Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor2.r, (arg_180_1.time_ - 0) / var_183_0), Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor2.g, (arg_180_1.time_ - 0) / var_183_0), (Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor2.b, (arg_180_1.time_ - 0) / var_183_0)))
							else
								local var_183_1 = Mathf.Lerp(iter_183_1.color.r, 0.5, (arg_180_1.time_ - 0) / var_183_0)

								iter_183_1.color = Color.New(var_183_1, var_183_1, var_183_1)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["1034"]) and arg_180_1.var_.actorSpriteComps1034 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_183_3 then
						iter_183_3.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_180_1.var_.actorSpriteComps1034 = nil
			end

			local var_183_2 = 0
			local var_183_3 = 0.65

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_2 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_180_1.callingController_:SetSelectedState("calling")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_4 = arg_180_1:GetWordFromCfg(417241042)
				local var_183_5 = arg_180_1:FormatText(var_183_4.content)

				arg_180_1.text_.text = var_183_5

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_7 = 26 <= 0 and var_183_3 or var_183_3 * (utf8.len(var_183_5) / 26)

				if (26 <= 0 and var_183_3 or var_183_3 * (utf8.len(var_183_5) / 26)) > 0 and var_183_3 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_2
					end
				end

				arg_180_1.text_.text = var_183_5
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241042", "story_v_out_417241.awb") ~= 0 then
					local var_183_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241042", "story_v_out_417241.awb") / 1000

					if var_183_8 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_2
					end

					if var_183_4.prefab_name ~= "" and arg_180_1.actors_[var_183_4.prefab_name] ~= nil then
						local var_183_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_4.prefab_name].transform, "story_v_out_417241", "417241042", "story_v_out_417241.awb")

						arg_180_1:RecordAudio("417241042", var_183_9)
						arg_180_1:RecordAudio("417241042", var_183_9)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_417241", "417241042", "story_v_out_417241.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_417241", "417241042", "story_v_out_417241.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_10 = math.max(var_183_3, arg_180_1.talkMaxDuration)

			if var_183_2 <= arg_180_1.time_ and arg_180_1.time_ < var_183_2 + var_183_10 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_2) / var_183_10

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_2 + var_183_10 and arg_180_1.time_ < var_183_2 + var_183_10 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play417241043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417241043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play417241044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["10111"]) and arg_184_1.var_.actorSpriteComps10111 == nil then
				arg_184_1.var_.actorSpriteComps10111 = arg_184_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_0 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["10111"]) then
				if arg_184_1.var_.actorSpriteComps10111 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								iter_187_1.color = Color.New(Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor2.r, (arg_184_1.time_ - 0) / var_187_0), Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor2.g, (arg_184_1.time_ - 0) / var_187_0), (Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor2.b, (arg_184_1.time_ - 0) / var_187_0)))
							else
								local var_187_1 = Mathf.Lerp(iter_187_1.color.r, 0.5, (arg_184_1.time_ - 0) / var_187_0)

								iter_187_1.color = Color.New(var_187_1, var_187_1, var_187_1)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["10111"]) and arg_184_1.var_.actorSpriteComps10111 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_187_3 then
						iter_187_3.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_184_1.var_.actorSpriteComps10111 = nil
			end

			local var_187_2 = arg_184_1.actors_["1034"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos1034 = var_187_2.localPosition
				var_187_2.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("1034", 7)

				for iter_187_4 = 0, var_187_2.childCount - 1 do
					local var_187_3 = var_187_2:GetChild(iter_187_4)

					if var_187_3.name == "" or not string.find(var_187_3.name, "split") then
						var_187_3.gameObject:SetActive(true)
					else
						var_187_3.gameObject:SetActive(false)
					end
				end
			end

			local var_187_4 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_4 then
				var_187_2.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_184_1.time_ - 0) / var_187_4)
			end

			if arg_184_1.time_ >= 0 + var_187_4 and arg_184_1.time_ < 0 + var_187_4 + arg_187_0 then
				var_187_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_187_5 = arg_184_1.actors_["10111"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos10111 = var_187_5.localPosition
				var_187_5.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10111", 7)

				for iter_187_5 = 0, var_187_5.childCount - 1 do
					local var_187_6 = var_187_5:GetChild(iter_187_5)

					if var_187_6.name == "" or not string.find(var_187_6.name, "split") then
						var_187_6.gameObject:SetActive(true)
					else
						var_187_6.gameObject:SetActive(false)
					end
				end
			end

			local var_187_7 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_7 then
				var_187_5.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10111, Vector3.New(0, -2000, 0), (arg_184_1.time_ - 0) / var_187_7)
			end

			if arg_184_1.time_ >= 0 + var_187_7 and arg_184_1.time_ < 0 + var_187_7 + arg_187_0 then
				var_187_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.1 < arg_184_1.time_ and arg_184_1.time_ <= 0.1 + arg_187_0 then
				arg_184_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_door", "")
			end

			local var_187_9 = 0
			local var_187_10 = 0.925

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_9 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_11 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(417241043).content)

				arg_184_1.text_.text = var_187_11

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_13 = 37 <= 0 and var_187_10 or var_187_10 * (utf8.len(var_187_11) / 37)

				if (37 <= 0 and var_187_10 or var_187_10 * (utf8.len(var_187_11) / 37)) > 0 and var_187_10 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_9 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_9
					end
				end

				arg_184_1.text_.text = var_187_11
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_14 = math.max(var_187_10, arg_184_1.talkMaxDuration)

			if var_187_9 <= arg_184_1.time_ and arg_184_1.time_ < var_187_9 + var_187_14 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_9) / var_187_14

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_9 + var_187_14 and arg_184_1.time_ < var_187_9 + var_187_14 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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
				actorName = "10111",
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
	Play417241044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417241044
		arg_188_1.duration_ = 3.43

		local var_188_0 = {
			zh = 1.366,
			ja = 3.433
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
				arg_188_0:Play417241045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0.175

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_2")

				arg_188_1.callingController_:SetSelectedState("calling")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_1 = arg_188_1:GetWordFromCfg(417241044)
				local var_191_2 = arg_188_1:FormatText(var_191_1.content)

				arg_188_1.text_.text = var_191_2

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_4 = 7 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_2) / 7)

				if (7 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_2) / 7)) > 0 and var_191_0 < var_191_4 then
					arg_188_1.talkMaxDuration = var_191_4

					if var_191_4 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_4 + 0
					end
				end

				arg_188_1.text_.text = var_191_2
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241044", "story_v_out_417241.awb") ~= 0 then
					local var_191_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241044", "story_v_out_417241.awb") / 1000

					if var_191_5 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + 0
					end

					if var_191_1.prefab_name ~= "" and arg_188_1.actors_[var_191_1.prefab_name] ~= nil then
						local var_191_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_1.prefab_name].transform, "story_v_out_417241", "417241044", "story_v_out_417241.awb")

						arg_188_1:RecordAudio("417241044", var_191_6)
						arg_188_1:RecordAudio("417241044", var_191_6)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417241", "417241044", "story_v_out_417241.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417241", "417241044", "story_v_out_417241.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_7 = math.max(var_191_0, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - 0) / var_191_7

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play417241045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 417241045
		arg_192_1.duration_ = 2.57

		local var_192_0 = {
			zh = 1.4,
			ja = 2.566
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
				arg_192_0:Play417241046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1034"]) and arg_192_1.var_.actorSpriteComps1034 == nil then
				arg_192_1.var_.actorSpriteComps1034 = arg_192_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_0 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1034"]) then
				if arg_192_1.var_.actorSpriteComps1034 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								iter_195_1.color = Color.New(Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor1.r, (arg_192_1.time_ - 0) / var_195_0), Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor1.g, (arg_192_1.time_ - 0) / var_195_0), (Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor1.b, (arg_192_1.time_ - 0) / var_195_0)))
							else
								local var_195_1 = Mathf.Lerp(iter_195_1.color.r, 1, (arg_192_1.time_ - 0) / var_195_0)

								iter_195_1.color = Color.New(var_195_1, var_195_1, var_195_1)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1034"]) and arg_192_1.var_.actorSpriteComps1034 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_195_3 then
						iter_195_3.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_192_1.var_.actorSpriteComps1034 = nil
			end

			local var_195_2 = arg_192_1.actors_["1034"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1034 = var_195_2.localPosition
				var_195_2.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1034", 3)

				for iter_195_4 = 0, var_195_2.childCount - 1 do
					local var_195_3 = var_195_2:GetChild(iter_195_4)

					if var_195_3.name == "split_6" or not string.find(var_195_3.name, "split") then
						var_195_3.gameObject:SetActive(true)
					else
						var_195_3.gameObject:SetActive(false)
					end
				end
			end

			local var_195_4 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				var_195_2.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_192_1.time_ - 0) / var_195_4)
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				var_195_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_195_5 = 0
			local var_195_6 = 0.15

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 then
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

				local var_195_7 = arg_192_1:GetWordFromCfg(417241045)
				local var_195_8 = arg_192_1:FormatText(var_195_7.content)

				arg_192_1.text_.text = var_195_8

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_10 = 6 <= 0 and var_195_6 or var_195_6 * (utf8.len(var_195_8) / 6)

				if (6 <= 0 and var_195_6 or var_195_6 * (utf8.len(var_195_8) / 6)) > 0 and var_195_6 < var_195_10 then
					arg_192_1.talkMaxDuration = var_195_10

					if var_195_10 + var_195_5 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_10 + var_195_5
					end
				end

				arg_192_1.text_.text = var_195_8
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241045", "story_v_out_417241.awb") ~= 0 then
					local var_195_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241045", "story_v_out_417241.awb") / 1000

					if var_195_11 + var_195_5 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_11 + var_195_5
					end

					if var_195_7.prefab_name ~= "" and arg_192_1.actors_[var_195_7.prefab_name] ~= nil then
						local var_195_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_7.prefab_name].transform, "story_v_out_417241", "417241045", "story_v_out_417241.awb")

						arg_192_1:RecordAudio("417241045", var_195_12)
						arg_192_1:RecordAudio("417241045", var_195_12)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_417241", "417241045", "story_v_out_417241.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_417241", "417241045", "story_v_out_417241.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_13 = math.max(var_195_6, arg_192_1.talkMaxDuration)

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_13 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_5) / var_195_13

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_5 + var_195_13 and arg_192_1.time_ < var_195_5 + var_195_13 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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

		arg_192_1:InitPlayNodeList()
	end,
	Play417241046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 417241046
		arg_196_1.duration_ = 7.8

		local var_196_0 = {
			zh = 4.766,
			ja = 7.8
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
				arg_196_0:Play417241047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["1034"]) and arg_196_1.var_.actorSpriteComps1034 == nil then
				arg_196_1.var_.actorSpriteComps1034 = arg_196_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_0 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["1034"]) then
				if arg_196_1.var_.actorSpriteComps1034 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_199_1 then
							if arg_196_1.isInRecall_ then
								iter_199_1.color = Color.New(Mathf.Lerp(iter_199_1.color.r, arg_196_1.hightColor2.r, (arg_196_1.time_ - 0) / var_199_0), Mathf.Lerp(iter_199_1.color.g, arg_196_1.hightColor2.g, (arg_196_1.time_ - 0) / var_199_0), (Mathf.Lerp(iter_199_1.color.b, arg_196_1.hightColor2.b, (arg_196_1.time_ - 0) / var_199_0)))
							else
								local var_199_1 = Mathf.Lerp(iter_199_1.color.r, 0.5, (arg_196_1.time_ - 0) / var_199_0)

								iter_199_1.color = Color.New(var_199_1, var_199_1, var_199_1)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["1034"]) and arg_196_1.var_.actorSpriteComps1034 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_199_3 then
						iter_199_3.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_196_1.var_.actorSpriteComps1034 = nil
			end

			local var_199_2 = 0
			local var_199_3 = 0.55

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_2 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_196_1.callingController_:SetSelectedState("calling")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_4 = arg_196_1:GetWordFromCfg(417241046)
				local var_199_5 = arg_196_1:FormatText(var_199_4.content)

				arg_196_1.text_.text = var_199_5

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_7 = 22 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_5) / 22)

				if (22 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_5) / 22)) > 0 and var_199_3 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_2
					end
				end

				arg_196_1.text_.text = var_199_5
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241046", "story_v_out_417241.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241046", "story_v_out_417241.awb") / 1000

					if var_199_8 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_2
					end

					if var_199_4.prefab_name ~= "" and arg_196_1.actors_[var_199_4.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_4.prefab_name].transform, "story_v_out_417241", "417241046", "story_v_out_417241.awb")

						arg_196_1:RecordAudio("417241046", var_199_9)
						arg_196_1:RecordAudio("417241046", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_417241", "417241046", "story_v_out_417241.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_417241", "417241046", "story_v_out_417241.awb")
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

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play417241047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 417241047
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play417241048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["10111"]) and arg_200_1.var_.actorSpriteComps10111 == nil then
				arg_200_1.var_.actorSpriteComps10111 = arg_200_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_0 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["10111"]) then
				if arg_200_1.var_.actorSpriteComps10111 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps10111:ToTable()) do
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

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["10111"]) and arg_200_1.var_.actorSpriteComps10111 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_203_3 then
						iter_203_3.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps10111 = nil
			end

			local var_203_2 = arg_200_1.actors_["1034"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1034 = var_203_2.localPosition
				var_203_2.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("1034", 7)

				for iter_203_4 = 0, var_203_2.childCount - 1 do
					local var_203_3 = var_203_2:GetChild(iter_203_4)

					if var_203_3.name == "" or not string.find(var_203_3.name, "split") then
						var_203_3.gameObject:SetActive(true)
					else
						var_203_3.gameObject:SetActive(false)
					end
				end
			end

			local var_203_4 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				var_203_2.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_200_1.time_ - 0) / var_203_4)
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				var_203_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_203_5 = arg_200_1.actors_["10111"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos10111 = var_203_5.localPosition
				var_203_5.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10111", 7)

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
				var_203_5.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10111, Vector3.New(0, -2000, 0), (arg_200_1.time_ - 0) / var_203_7)
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				var_203_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_203_8 = 0
			local var_203_9 = 1.425

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

				local var_203_10 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(417241047).content)

				arg_200_1.text_.text = var_203_10

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_12 = 57 <= 0 and var_203_9 or var_203_9 * (utf8.len(var_203_10) / 57)

				if (57 <= 0 and var_203_9 or var_203_9 * (utf8.len(var_203_10) / 57)) > 0 and var_203_9 < var_203_12 then
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
				actorName = "10111",
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
	Play417241048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 417241048
		arg_204_1.duration_ = 6.13

		local var_204_0 = {
			zh = 2.8,
			ja = 6.133
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
				arg_204_0:Play417241049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1034"]) and arg_204_1.var_.actorSpriteComps1034 == nil then
				arg_204_1.var_.actorSpriteComps1034 = arg_204_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_0 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1034"]) then
				if arg_204_1.var_.actorSpriteComps1034 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1034"]) and arg_204_1.var_.actorSpriteComps1034 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_207_3 then
						iter_207_3.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_204_1.var_.actorSpriteComps1034 = nil
			end

			local var_207_2 = arg_204_1.actors_["1034"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1034 = var_207_2.localPosition
				var_207_2.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("1034", 3)

				for iter_207_4 = 0, var_207_2.childCount - 1 do
					local var_207_3 = var_207_2:GetChild(iter_207_4)

					if var_207_3.name == "split_3" or not string.find(var_207_3.name, "split") then
						var_207_3.gameObject:SetActive(true)
					else
						var_207_3.gameObject:SetActive(false)
					end
				end
			end

			local var_207_4 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				var_207_2.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_204_1.time_ - 0) / var_207_4)
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				var_207_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_207_5 = 0
			local var_207_6 = 0.35

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_7 = arg_204_1:GetWordFromCfg(417241048)
				local var_207_8 = arg_204_1:FormatText(var_207_7.content)

				arg_204_1.text_.text = var_207_8

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_10 = 14 <= 0 and var_207_6 or var_207_6 * (utf8.len(var_207_8) / 14)

				if (14 <= 0 and var_207_6 or var_207_6 * (utf8.len(var_207_8) / 14)) > 0 and var_207_6 < var_207_10 then
					arg_204_1.talkMaxDuration = var_207_10

					if var_207_10 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_5
					end
				end

				arg_204_1.text_.text = var_207_8
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241048", "story_v_out_417241.awb") ~= 0 then
					local var_207_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241048", "story_v_out_417241.awb") / 1000

					if var_207_11 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_11 + var_207_5
					end

					if var_207_7.prefab_name ~= "" and arg_204_1.actors_[var_207_7.prefab_name] ~= nil then
						local var_207_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_7.prefab_name].transform, "story_v_out_417241", "417241048", "story_v_out_417241.awb")

						arg_204_1:RecordAudio("417241048", var_207_12)
						arg_204_1:RecordAudio("417241048", var_207_12)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_417241", "417241048", "story_v_out_417241.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_417241", "417241048", "story_v_out_417241.awb")
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
				actorName = "1034",
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
	Play417241049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 417241049
		arg_208_1.duration_ = 5.7

		local var_208_0 = {
			zh = 5.199999999999,
			ja = 5.699999999999
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
				arg_208_0:Play417241050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 3.999999999999 < arg_208_1.time_ and arg_208_1.time_ <= 3.999999999999 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			if arg_208_1.time_ >= 3.999999999999 + 0.0666666666676665 and arg_208_1.time_ < 3.999999999999 + 0.0666666666676665 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			local var_211_0 = "ST75"

			if arg_208_1.bgs_.ST75 == nil then
				local var_211_1 = Object.Instantiate(arg_208_1.paintGo_)

				var_211_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_211_0)
				var_211_1.name = var_211_0
				var_211_1.transform.parent = arg_208_1.stage_.transform
				var_211_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_208_1.bgs_[var_211_0] = var_211_1
			end

			if 1.999999999999 < arg_208_1.time_ and arg_208_1.time_ <= 1.999999999999 + arg_211_0 then
				local var_211_2 = arg_208_1.bgs_.ST75

				arg_208_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_211_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_211_3 = var_211_2:GetComponent("SpriteRenderer")

				if var_211_3 and var_211_3.sprite then
					local var_211_4 = 2 * (var_211_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_211_2.transform.localScale = Vector3.New(var_211_4 / var_211_3.sprite.bounds.size.y < var_211_4 * manager.ui.mainCameraCom_.aspect / var_211_3.sprite.bounds.size.x and var_211_4 * manager.ui.mainCameraCom_.aspect / var_211_3.sprite.bounds.size.x or var_211_4 / var_211_3.sprite.bounds.size.y, var_211_4 / var_211_3.sprite.bounds.size.y < var_211_4 * manager.ui.mainCameraCom_.aspect / var_211_3.sprite.bounds.size.x and var_211_4 * manager.ui.mainCameraCom_.aspect / var_211_3.sprite.bounds.size.x or var_211_4 / var_211_3.sprite.bounds.size.y, 0)
				end

				for iter_211_0, iter_211_1 in pairs(arg_208_1.bgs_) do
					if iter_211_0 ~= "ST75" then
						iter_211_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_211_5 = 0

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_6 = 2

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_6 then
				local var_211_7 = Color.New(0, 0, 0)

				var_211_7.a = Mathf.Lerp(0, 1, (arg_208_1.time_ - var_211_5) / var_211_6)
				arg_208_1.mask_.color = var_211_7
			end

			if arg_208_1.time_ >= var_211_5 + var_211_6 and arg_208_1.time_ < var_211_5 + var_211_6 + arg_211_0 then
				local var_211_8 = Color.New(0, 0, 0)

				var_211_8.a = 1
				arg_208_1.mask_.color = var_211_8
			end

			local var_211_9 = 2

			if 2 < arg_208_1.time_ and arg_208_1.time_ <= var_211_9 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_10 = 2

			if var_211_9 <= arg_208_1.time_ and arg_208_1.time_ < var_211_9 + var_211_10 then
				local var_211_11 = Color.New(0, 0, 0)

				var_211_11.a = Mathf.Lerp(1, 0, (arg_208_1.time_ - var_211_9) / var_211_10)
				arg_208_1.mask_.color = var_211_11
			end

			if arg_208_1.time_ >= var_211_9 + var_211_10 and arg_208_1.time_ < var_211_9 + var_211_10 + arg_211_0 then
				local var_211_12 = Color.New(0, 0, 0)

				arg_208_1.mask_.enabled = false
				var_211_12.a = 0
				arg_208_1.mask_.color = var_211_12
			end

			local var_211_13 = "10128"

			if arg_208_1.actors_["10128"] == nil then
				local var_211_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_211_14) then
					local var_211_15 = Object.Instantiate(var_211_14, arg_208_1.canvasGo_.transform)

					var_211_15.transform:SetSiblingIndex(1)

					var_211_15.name = var_211_13
					var_211_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_208_1.actors_[var_211_13] = var_211_15

					if arg_208_1.isInRecall_ then
						for iter_211_2, iter_211_3 in ipairs((var_211_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_211_3.color = arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_211_16 = arg_208_1.actors_["10128"]

			if 3.66666666666667 < arg_208_1.time_ and arg_208_1.time_ <= 3.66666666666667 + arg_211_0 and not isNil(var_211_16) and arg_208_1.var_.actorSpriteComps10128 == nil then
				arg_208_1.var_.actorSpriteComps10128 = var_211_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_17 = 0.2

			if 3.66666666666667 <= arg_208_1.time_ and arg_208_1.time_ < 3.66666666666667 + var_211_17 and not isNil(var_211_16) then
				if arg_208_1.var_.actorSpriteComps10128 then
					for iter_211_4, iter_211_5 in pairs(arg_208_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_211_5 then
							if arg_208_1.isInRecall_ then
								iter_211_5.color = Color.New(Mathf.Lerp(iter_211_5.color.r, arg_208_1.hightColor1.r, (arg_208_1.time_ - 3.66666666666667) / var_211_17), Mathf.Lerp(iter_211_5.color.g, arg_208_1.hightColor1.g, (arg_208_1.time_ - 3.66666666666667) / var_211_17), (Mathf.Lerp(iter_211_5.color.b, arg_208_1.hightColor1.b, (arg_208_1.time_ - 3.66666666666667) / var_211_17)))
							else
								local var_211_18 = Mathf.Lerp(iter_211_5.color.r, 1, (arg_208_1.time_ - 3.66666666666667) / var_211_17)

								iter_211_5.color = Color.New(var_211_18, var_211_18, var_211_18)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= 3.66666666666667 + var_211_17 and arg_208_1.time_ < 3.66666666666667 + var_211_17 + arg_211_0 and not isNil(var_211_16) and arg_208_1.var_.actorSpriteComps10128 then
				for iter_211_6, iter_211_7 in pairs(arg_208_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_211_7 then
						iter_211_7.color = arg_208_1.isInRecall_ and (arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_208_1.var_.actorSpriteComps10128 = nil
			end

			local var_211_19 = arg_208_1.actors_["1034"].transform

			if 2 < arg_208_1.time_ and arg_208_1.time_ <= 2 + arg_211_0 then
				arg_208_1.var_.moveOldPos1034 = var_211_19.localPosition
				var_211_19.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("1034", 7)

				for iter_211_8 = 0, var_211_19.childCount - 1 do
					local var_211_20 = var_211_19:GetChild(iter_211_8)

					if var_211_20.name == "" or not string.find(var_211_20.name, "split") then
						var_211_20.gameObject:SetActive(true)
					else
						var_211_20.gameObject:SetActive(false)
					end
				end
			end

			local var_211_21 = 0.001

			if 2 <= arg_208_1.time_ and arg_208_1.time_ < 2 + var_211_21 then
				var_211_19.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_208_1.time_ - 2) / var_211_21)
			end

			if arg_208_1.time_ >= 2 + var_211_21 and arg_208_1.time_ < 2 + var_211_21 + arg_211_0 then
				var_211_19.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_211_22 = arg_208_1.actors_["10128"].transform

			if 3.66666666666667 < arg_208_1.time_ and arg_208_1.time_ <= 3.66666666666667 + arg_211_0 then
				arg_208_1.var_.moveOldPos10128 = var_211_22.localPosition
				var_211_22.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10128", 3)

				for iter_211_9 = 0, var_211_22.childCount - 1 do
					local var_211_23 = var_211_22:GetChild(iter_211_9)

					if var_211_23.name == "split_5" or not string.find(var_211_23.name, "split") then
						var_211_23.gameObject:SetActive(true)
					else
						var_211_23.gameObject:SetActive(false)
					end
				end
			end

			local var_211_24 = 0.001

			if 3.66666666666667 <= arg_208_1.time_ and arg_208_1.time_ < 3.66666666666667 + var_211_24 then
				var_211_22.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_208_1.time_ - 3.66666666666667) / var_211_24)
			end

			if arg_208_1.time_ >= 3.66666666666667 + var_211_24 and arg_208_1.time_ < 3.66666666666667 + var_211_24 + arg_211_0 then
				var_211_22.localPosition = Vector3.New(0, -347, -300)
			end

			if 3.66666666666667 < arg_208_1.time_ and arg_208_1.time_ <= 3.66666666666667 + arg_211_0 then
				local var_211_25 = arg_208_1.actors_["10128"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_211_25 then
					arg_208_1.var_.alphaOldValue10128 = var_211_25.alpha
					arg_208_1.var_.characterEffect10128 = var_211_25
				end

				arg_208_1.var_.alphaOldValue10128 = 0
			end

			local var_211_26 = 0.333333333333333

			if 3.66666666666667 <= arg_208_1.time_ and arg_208_1.time_ < 3.66666666666667 + var_211_26 then
				if arg_208_1.var_.characterEffect10128 then
					arg_208_1.var_.characterEffect10128.alpha = Mathf.Lerp(arg_208_1.var_.alphaOldValue10128, 1, (arg_208_1.time_ - 3.66666666666667) / var_211_26)
				end
			end

			if arg_208_1.time_ >= 3.66666666666667 + var_211_26 and arg_208_1.time_ < 3.66666666666667 + var_211_26 + arg_211_0 and arg_208_1.var_.characterEffect10128 then
				arg_208_1.var_.characterEffect10128.alpha = 1
			end

			if 1.53333333333333 < arg_208_1.time_ and arg_208_1.time_ <= 1.53333333333333 + arg_211_0 then
				arg_208_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind_loop03", "")
			end

			if 0.2 < arg_208_1.time_ and arg_208_1.time_ <= 0.2 + arg_211_0 then
				arg_208_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_211_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_208_1.bgmTxt_.text ~= var_211_31 and arg_208_1.bgmTxt_.text ~= "" then
						if arg_208_1.bgmTxt2_.text ~= "" then
							arg_208_1.bgmTxt_.text = arg_208_1.bgmTxt2_.text
						end

						arg_208_1.bgmTxt2_.text = var_211_31

						arg_208_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_208_1.bgmTxt_.text = var_211_31
						arg_208_1.bgmTxt2_.text = var_211_31
					end

					if arg_208_1.bgmTimer then
						arg_208_1.bgmTimer:Stop()

						arg_208_1.bgmTimer = nil
					end

					if arg_208_1.settingData.show_music_name == 1 then
						arg_208_1.musicController:SetSelectedState("show")
						arg_208_1.musicAnimator_:Play("open", 0, 0)

						if arg_208_1.settingData.music_time ~= 0 then
							arg_208_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_208_1.settingData.music_time), function()
								if arg_208_1 == nil or isNil(arg_208_1.bgmTxt_) then
									return
								end

								arg_208_1.musicController:SetSelectedState("hide")
								arg_208_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.36666666666667 < arg_208_1.time_ and arg_208_1.time_ <= 1.36666666666667 + arg_211_0 then
				arg_208_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_211_34 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

				if "" ~= "" then
					if arg_208_1.bgmTxt_.text ~= var_211_34 and arg_208_1.bgmTxt_.text ~= "" then
						if arg_208_1.bgmTxt2_.text ~= "" then
							arg_208_1.bgmTxt_.text = arg_208_1.bgmTxt2_.text
						end

						arg_208_1.bgmTxt2_.text = var_211_34

						arg_208_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_208_1.bgmTxt_.text = var_211_34
						arg_208_1.bgmTxt2_.text = var_211_34
					end

					if arg_208_1.bgmTimer then
						arg_208_1.bgmTimer:Stop()

						arg_208_1.bgmTimer = nil
					end

					if arg_208_1.settingData.show_music_name == 1 then
						arg_208_1.musicController:SetSelectedState("show")
						arg_208_1.musicAnimator_:Play("open", 0, 0)

						if arg_208_1.settingData.music_time ~= 0 then
							arg_208_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_208_1.settingData.music_time), function()
								if arg_208_1 == nil or isNil(arg_208_1.bgmTxt_) then
									return
								end

								arg_208_1.musicController:SetSelectedState("hide")
								arg_208_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_35 = 3.999999999999
			local var_211_36 = 0.15

			if 3.999999999999 < arg_208_1.time_ and arg_208_1.time_ <= var_211_35 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_37 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_37:setOnUpdate(LuaHelper.FloatAction(function(arg_214_0)
					arg_208_1.dialogCg_.alpha = arg_214_0
				end))
				var_211_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_38 = arg_208_1:GetWordFromCfg(417241049)
				local var_211_39 = arg_208_1:FormatText(var_211_38.content)

				arg_208_1.text_.text = var_211_39

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_41 = 6 <= 0 and var_211_36 or var_211_36 * (utf8.len(var_211_39) / 6)

				if (6 <= 0 and var_211_36 or var_211_36 * (utf8.len(var_211_39) / 6)) > 0 and var_211_36 < var_211_41 then
					arg_208_1.talkMaxDuration = var_211_41
					var_211_35 = var_211_35 + 0.3

					if var_211_41 + var_211_35 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_41 + var_211_35
					end
				end

				arg_208_1.text_.text = var_211_39
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241049", "story_v_out_417241.awb") ~= 0 then
					local var_211_42 = manager.audio:GetVoiceLength("story_v_out_417241", "417241049", "story_v_out_417241.awb") / 1000

					if var_211_42 + var_211_35 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_42 + var_211_35
					end

					if var_211_38.prefab_name ~= "" and arg_208_1.actors_[var_211_38.prefab_name] ~= nil then
						local var_211_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_38.prefab_name].transform, "story_v_out_417241", "417241049", "story_v_out_417241.awb")

						arg_208_1:RecordAudio("417241049", var_211_43)
						arg_208_1:RecordAudio("417241049", var_211_43)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_417241", "417241049", "story_v_out_417241.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_417241", "417241049", "story_v_out_417241.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_44 = var_211_35 + 0.3
			local var_211_45 = math.max(var_211_36, arg_208_1.talkMaxDuration)

			if var_211_35 + 0.3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_44 + var_211_45 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_44) / var_211_45

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_44 + var_211_45 and arg_208_1.time_ < var_211_44 + var_211_45 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play417241050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 417241050
		arg_216_1.duration_ = 7.27

		local var_216_0 = {
			zh = 4.8,
			ja = 7.266
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
				arg_216_0:Play417241051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos10128 = arg_216_1.actors_["10128"].transform.localPosition
				arg_216_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("10128", 3)

				for iter_219_0 = 0, arg_216_1.actors_["10128"].transform.childCount - 1 do
					local var_219_0 = arg_216_1.actors_["10128"].transform:GetChild(iter_219_0)

					if var_219_0.name == "split_6" or not string.find(var_219_0.name, "split") then
						var_219_0.gameObject:SetActive(true)
					else
						var_219_0.gameObject:SetActive(false)
					end
				end
			end

			local var_219_1 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_1 then
				arg_216_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_216_1.time_ - 0) / var_219_1)
			end

			if arg_216_1.time_ >= 0 + var_219_1 and arg_216_1.time_ < 0 + var_219_1 + arg_219_0 then
				arg_216_1.actors_["10128"].transform.localPosition = Vector3.New(0, -347, -300)
			end

			local var_219_2 = 0
			local var_219_3 = 0.775

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_2 + arg_219_0 then
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

				local var_219_4 = arg_216_1:GetWordFromCfg(417241050)
				local var_219_5 = arg_216_1:FormatText(var_219_4.content)

				arg_216_1.text_.text = var_219_5

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_7 = 31 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_5) / 31)

				if (31 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_5) / 31)) > 0 and var_219_3 < var_219_7 then
					arg_216_1.talkMaxDuration = var_219_7

					if var_219_7 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_2
					end
				end

				arg_216_1.text_.text = var_219_5
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241050", "story_v_out_417241.awb") ~= 0 then
					local var_219_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241050", "story_v_out_417241.awb") / 1000

					if var_219_8 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_2
					end

					if var_219_4.prefab_name ~= "" and arg_216_1.actors_[var_219_4.prefab_name] ~= nil then
						local var_219_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_4.prefab_name].transform, "story_v_out_417241", "417241050", "story_v_out_417241.awb")

						arg_216_1:RecordAudio("417241050", var_219_9)
						arg_216_1:RecordAudio("417241050", var_219_9)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_417241", "417241050", "story_v_out_417241.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_417241", "417241050", "story_v_out_417241.awb")
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
				actorName = "10128",
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
	Play417241051 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 417241051
		arg_220_1.duration_ = 5.4

		local var_220_0 = {
			zh = 3.691999999999,
			ja = 5.4
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
				arg_220_0:Play417241052(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 2.56666666666667 < arg_220_1.time_ and arg_220_1.time_ <= 2.56666666666667 + arg_223_0 then
				arg_220_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_wind_loop03", "")
			end

			if 2.692 < arg_220_1.time_ and arg_220_1.time_ <= 2.692 + arg_223_0 then
				arg_220_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind_loop01", "")
			end

			local var_223_2 = 0
			local var_223_3 = 0.35

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_2 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_4 = arg_220_1:GetWordFromCfg(417241051)
				local var_223_5 = arg_220_1:FormatText(var_223_4.content)

				arg_220_1.text_.text = var_223_5

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_7 = 14 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_5) / 14)

				if (14 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_5) / 14)) > 0 and var_223_3 < var_223_7 then
					arg_220_1.talkMaxDuration = var_223_7

					if var_223_7 + var_223_2 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_7 + var_223_2
					end
				end

				arg_220_1.text_.text = var_223_5
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241051", "story_v_out_417241.awb") ~= 0 then
					local var_223_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241051", "story_v_out_417241.awb") / 1000

					if var_223_8 + var_223_2 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_2
					end

					if var_223_4.prefab_name ~= "" and arg_220_1.actors_[var_223_4.prefab_name] ~= nil then
						local var_223_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_4.prefab_name].transform, "story_v_out_417241", "417241051", "story_v_out_417241.awb")

						arg_220_1:RecordAudio("417241051", var_223_9)
						arg_220_1:RecordAudio("417241051", var_223_9)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_417241", "417241051", "story_v_out_417241.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_417241", "417241051", "story_v_out_417241.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_10 = math.max(var_223_3, arg_220_1.talkMaxDuration)

			if var_223_2 <= arg_220_1.time_ and arg_220_1.time_ < var_223_2 + var_223_10 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_2) / var_223_10

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_2 + var_223_10 and arg_220_1.time_ < var_223_2 + var_223_10 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play417241052 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 417241052
		arg_224_1.duration_ = 5.43

		local var_224_0 = {
			zh = 2.3,
			ja = 5.433
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
				arg_224_0:Play417241053(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0.25

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_1 = arg_224_1:GetWordFromCfg(417241052)
				local var_227_2 = arg_224_1:FormatText(var_227_1.content)

				arg_224_1.text_.text = var_227_2

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_4 = 10 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 10)

				if (10 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 10)) > 0 and var_227_0 < var_227_4 then
					arg_224_1.talkMaxDuration = var_227_4

					if var_227_4 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_4 + 0
					end
				end

				arg_224_1.text_.text = var_227_2
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241052", "story_v_out_417241.awb") ~= 0 then
					local var_227_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241052", "story_v_out_417241.awb") / 1000

					if var_227_5 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + 0
					end

					if var_227_1.prefab_name ~= "" and arg_224_1.actors_[var_227_1.prefab_name] ~= nil then
						local var_227_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_1.prefab_name].transform, "story_v_out_417241", "417241052", "story_v_out_417241.awb")

						arg_224_1:RecordAudio("417241052", var_227_6)
						arg_224_1:RecordAudio("417241052", var_227_6)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_417241", "417241052", "story_v_out_417241.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_417241", "417241052", "story_v_out_417241.awb")
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
	Play417241053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 417241053
		arg_228_1.duration_ = 9

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play417241054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_9000

			if 3.999999999999 < arg_228_1.time_ and arg_228_1.time_ <= 3.999999999999 + arg_231_0 then
				arg_228_1.allBtn_.enabled = false
			end

			if arg_228_1.time_ >= 3.999999999999 + 0.3 and arg_228_1.time_ < 3.999999999999 + 0.3 + arg_231_0 then
				arg_228_1.allBtn_.enabled = true
			end

			local var_231_0 = "I17l"

			if arg_228_1.bgs_.I17l == nil then
				local var_231_1 = Object.Instantiate(arg_228_1.paintGo_)

				var_231_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_231_0)
				var_231_1.name = var_231_0
				var_231_1.transform.parent = arg_228_1.stage_.transform
				var_231_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_228_1.bgs_[var_231_0] = var_231_1
			end

			if 2 < arg_228_1.time_ and arg_228_1.time_ <= 2 + arg_231_0 then
				local var_231_2 = arg_228_1.bgs_.I17l

				arg_228_1.bgs_.I17l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_231_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_231_3 = var_231_2:GetComponent("SpriteRenderer")

				if var_231_3 and var_231_3.sprite then
					local var_231_4 = 2 * (var_231_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_231_2.transform.localScale = Vector3.New(var_231_4 / var_231_3.sprite.bounds.size.y < var_231_4 * manager.ui.mainCameraCom_.aspect / var_231_3.sprite.bounds.size.x and var_231_4 * manager.ui.mainCameraCom_.aspect / var_231_3.sprite.bounds.size.x or var_231_4 / var_231_3.sprite.bounds.size.y, var_231_4 / var_231_3.sprite.bounds.size.y < var_231_4 * manager.ui.mainCameraCom_.aspect / var_231_3.sprite.bounds.size.x and var_231_4 * manager.ui.mainCameraCom_.aspect / var_231_3.sprite.bounds.size.x or var_231_4 / var_231_3.sprite.bounds.size.y, 0)
				end

				for iter_231_0, iter_231_1 in pairs(arg_228_1.bgs_) do
					if iter_231_0 ~= "I17l" then
						iter_231_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_231_5 = 0

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 then
				arg_228_1.mask_.enabled = true
				arg_228_1.mask_.raycastTarget = true

				arg_228_1:SetGaussion(false)
			end

			local var_231_6 = 2

			if var_231_5 <= arg_228_1.time_ and arg_228_1.time_ < var_231_5 + var_231_6 then
				local var_231_7 = Color.New(0, 0, 0)

				var_231_7.a = Mathf.Lerp(0, 1, (arg_228_1.time_ - var_231_5) / var_231_6)
				arg_228_1.mask_.color = var_231_7
			end

			if arg_228_1.time_ >= var_231_5 + var_231_6 and arg_228_1.time_ < var_231_5 + var_231_6 + arg_231_0 then
				local var_231_8 = Color.New(0, 0, 0)

				var_231_8.a = 1
				arg_228_1.mask_.color = var_231_8
			end

			local var_231_9 = 2

			if 2 < arg_228_1.time_ and arg_228_1.time_ <= var_231_9 + arg_231_0 then
				arg_228_1.mask_.enabled = true
				arg_228_1.mask_.raycastTarget = true

				arg_228_1:SetGaussion(false)
			end

			local var_231_10 = 2

			if var_231_9 <= arg_228_1.time_ and arg_228_1.time_ < var_231_9 + var_231_10 then
				local var_231_11 = Color.New(0, 0, 0)

				var_231_11.a = Mathf.Lerp(1, 0, (arg_228_1.time_ - var_231_9) / var_231_10)
				arg_228_1.mask_.color = var_231_11
			end

			if arg_228_1.time_ >= var_231_9 + var_231_10 and arg_228_1.time_ < var_231_9 + var_231_10 + arg_231_0 then
				local var_231_12 = Color.New(0, 0, 0)

				arg_228_1.mask_.enabled = false
				var_231_12.a = 0
				arg_228_1.mask_.color = var_231_12
			end

			local var_231_13 = arg_228_1.actors_["10128"].transform

			if 2 < arg_228_1.time_ and arg_228_1.time_ <= 2 + arg_231_0 then
				arg_228_1.var_.moveOldPos10128 = var_231_13.localPosition
				var_231_13.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10128", 7)

				for iter_231_2 = 0, var_231_13.childCount - 1 do
					local var_231_14 = var_231_13:GetChild(iter_231_2)

					if var_231_14.name == "" or not string.find(var_231_14.name, "split") then
						var_231_14.gameObject:SetActive(true)
					else
						var_231_14.gameObject:SetActive(false)
					end
				end
			end

			local var_231_15 = 0.001

			if 2 <= arg_228_1.time_ and arg_228_1.time_ < 2 + var_231_15 then
				var_231_13.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_228_1.time_ - 2) / var_231_15)
			end

			if arg_228_1.time_ >= 2 + var_231_15 and arg_228_1.time_ < 2 + var_231_15 + arg_231_0 then
				var_231_13.localPosition = Vector3.New(0, -2000, -300)
			end

			if 2 < arg_228_1.time_ and arg_228_1.time_ <= 2 + arg_231_0 then
				local var_231_16 = arg_228_1.var_.effect10531

				if not arg_228_1.var_.effect10531 then
					var_231_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_keep"), manager.ui.mainCamera.transform)
					var_231_16.name = "10531"
					arg_228_1.var_.effect10531 = var_231_16
				else
					var_231_16.transform:SetParent(var_231_9000)
				end

				var_231_16.transform.localPosition = Vector3.New(0, 0, -4.37)
				var_231_16.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_231_18 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_231_3, iter_231_4 in ipairs((var_231_16.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_231_4.transform.localScale = Vector3.New(iter_231_4.transform.localScale.x / var_231_18 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_231_4.transform.localScale.y / var_231_18, iter_231_4.transform.localScale.z)
				end
			end

			if 5.5 < arg_228_1.time_ and arg_228_1.time_ <= 5.5 + arg_231_0 then
				arg_228_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind_parachuting", "")
			end

			if 5.91 < arg_228_1.time_ and arg_228_1.time_ <= 5.91 + arg_231_0 then
				arg_228_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_wind_loop01", "")
			end

			if 6.405 < arg_228_1.time_ and arg_228_1.time_ <= 6.405 + arg_231_0 then
				arg_228_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind_loop02", "")
			end

			if arg_228_1.frameCnt_ <= 1 then
				arg_228_1.dialog_:SetActive(false)
			end

			local var_231_23 = 3.999999999999
			local var_231_24 = 1.2

			if 3.999999999999 < arg_228_1.time_ and arg_228_1.time_ <= var_231_23 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0

				arg_228_1.dialog_:SetActive(true)

				arg_228_1.dialogCg_.alpha = 0

				local var_231_25 = LeanTween.value(arg_228_1.dialog_, 0, 1, 0.3)

				var_231_25:setOnUpdate(LuaHelper.FloatAction(function(arg_232_0)
					arg_228_1.dialogCg_.alpha = arg_232_0
				end))
				var_231_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_228_1.dialog_)
					var_231_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_228_1.duration_ = arg_228_1.duration_ + 0.3

				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_26 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(417241053).content)

				arg_228_1.text_.text = var_231_26

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_28 = 48 <= 0 and var_231_24 or var_231_24 * (utf8.len(var_231_26) / 48)

				if (48 <= 0 and var_231_24 or var_231_24 * (utf8.len(var_231_26) / 48)) > 0 and var_231_24 < var_231_28 then
					arg_228_1.talkMaxDuration = var_231_28
					var_231_23 = var_231_23 + 0.3

					if var_231_28 + var_231_23 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_28 + var_231_23
					end
				end

				arg_228_1.text_.text = var_231_26
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_29 = var_231_23 + 0.3
			local var_231_30 = math.max(var_231_24, arg_228_1.talkMaxDuration)

			if var_231_23 + 0.3 <= arg_228_1.time_ and arg_228_1.time_ < var_231_29 + var_231_30 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_29) / var_231_30

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_29 + var_231_30 and arg_228_1.time_ < var_231_29 + var_231_30 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play417241054 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 417241054
		arg_234_1.duration_ = 9.43

		local var_234_0 = {
			zh = 8.666,
			ja = 9.433
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
				arg_234_0:Play417241055(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 4 < arg_234_1.time_ and arg_234_1.time_ <= 4 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			if arg_234_1.time_ >= 4 + 0.3 and arg_234_1.time_ < 4 + 0.3 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end

			local var_237_0 = "SS1709"

			if arg_234_1.bgs_.SS1709 == nil then
				local var_237_1 = Object.Instantiate(arg_234_1.paintGo_)

				var_237_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_237_0)
				var_237_1.name = var_237_0
				var_237_1.transform.parent = arg_234_1.stage_.transform
				var_237_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.bgs_[var_237_0] = var_237_1
			end

			if 2 < arg_234_1.time_ and arg_234_1.time_ <= 2 + arg_237_0 then
				local var_237_2 = arg_234_1.bgs_.SS1709

				arg_234_1.bgs_.SS1709.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_237_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_237_3 = var_237_2:GetComponent("SpriteRenderer")

				if var_237_3 and var_237_3.sprite then
					local var_237_4 = 2 * (var_237_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_237_2.transform.localScale = Vector3.New(var_237_4 / var_237_3.sprite.bounds.size.y < var_237_4 * manager.ui.mainCameraCom_.aspect / var_237_3.sprite.bounds.size.x and var_237_4 * manager.ui.mainCameraCom_.aspect / var_237_3.sprite.bounds.size.x or var_237_4 / var_237_3.sprite.bounds.size.y, var_237_4 / var_237_3.sprite.bounds.size.y < var_237_4 * manager.ui.mainCameraCom_.aspect / var_237_3.sprite.bounds.size.x and var_237_4 * manager.ui.mainCameraCom_.aspect / var_237_3.sprite.bounds.size.x or var_237_4 / var_237_3.sprite.bounds.size.y, 0)
				end

				for iter_237_0, iter_237_1 in pairs(arg_234_1.bgs_) do
					if iter_237_0 ~= "SS1709" then
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

			local var_237_13 = arg_234_1.bgs_.SS1709.transform

			if 2 < arg_234_1.time_ and arg_234_1.time_ <= 2 + arg_237_0 then
				arg_234_1.var_.moveOldPosSS1709 = var_237_13.localPosition
			end

			local var_237_14 = 0.001

			if 2 <= arg_234_1.time_ and arg_234_1.time_ < 2 + var_237_14 then
				var_237_13.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPosSS1709, Vector3.New(0, 1, 10), (arg_234_1.time_ - 2) / var_237_14)
			end

			if arg_234_1.time_ >= 2 + var_237_14 and arg_234_1.time_ < 2 + var_237_14 + arg_237_0 then
				var_237_13.localPosition = Vector3.New(0, 1, 10)
			end

			local var_237_15 = arg_234_1.bgs_.SS1709.transform

			if 2.034 < arg_234_1.time_ and arg_234_1.time_ <= 2.034 + arg_237_0 then
				arg_234_1.var_.moveOldPosSS1709 = var_237_15.localPosition
			end

			local var_237_16 = 1.966

			if 2.034 <= arg_234_1.time_ and arg_234_1.time_ < 2.034 + var_237_16 then
				var_237_15.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPosSS1709, Vector3.New(0, 1, 9.5), (arg_234_1.time_ - 2.034) / var_237_16)
			end

			if arg_234_1.time_ >= 2.034 + var_237_16 and arg_234_1.time_ < 2.034 + var_237_16 + arg_237_0 then
				var_237_15.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 1.98333333333333 < arg_234_1.time_ and arg_234_1.time_ <= 1.98333333333333 + arg_237_0 then
				if arg_234_1.var_.effect10531 then
					Object.Destroy(arg_234_1.var_.effect10531)

					arg_234_1.var_.effect10531 = nil
				end
			end

			if arg_234_1.frameCnt_ <= 1 then
				arg_234_1.dialog_:SetActive(false)
			end

			local var_237_18 = 4
			local var_237_19 = 0.65

			if 4 < arg_234_1.time_ and arg_234_1.time_ <= var_237_18 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0

				arg_234_1.dialog_:SetActive(true)

				arg_234_1.dialogCg_.alpha = 0

				local var_237_20 = LeanTween.value(arg_234_1.dialog_, 0, 1, 0.3)

				var_237_20:setOnUpdate(LuaHelper.FloatAction(function(arg_238_0)
					arg_234_1.dialogCg_.alpha = arg_238_0
				end))
				var_237_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_234_1.dialog_)
					var_237_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_234_1.duration_ = arg_234_1.duration_ + 0.3

				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_21 = arg_234_1:GetWordFromCfg(417241054)
				local var_237_22 = arg_234_1:FormatText(var_237_21.content)

				arg_234_1.text_.text = var_237_22

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_24 = 26 <= 0 and var_237_19 or var_237_19 * (utf8.len(var_237_22) / 26)

				if (26 <= 0 and var_237_19 or var_237_19 * (utf8.len(var_237_22) / 26)) > 0 and var_237_19 < var_237_24 then
					arg_234_1.talkMaxDuration = var_237_24
					var_237_18 = var_237_18 + 0.3

					if var_237_24 + var_237_18 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_24 + var_237_18
					end
				end

				arg_234_1.text_.text = var_237_22
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241054", "story_v_out_417241.awb") ~= 0 then
					local var_237_25 = manager.audio:GetVoiceLength("story_v_out_417241", "417241054", "story_v_out_417241.awb") / 1000

					if var_237_25 + var_237_18 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_25 + var_237_18
					end

					if var_237_21.prefab_name ~= "" and arg_234_1.actors_[var_237_21.prefab_name] ~= nil then
						local var_237_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_21.prefab_name].transform, "story_v_out_417241", "417241054", "story_v_out_417241.awb")

						arg_234_1:RecordAudio("417241054", var_237_26)
						arg_234_1:RecordAudio("417241054", var_237_26)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_417241", "417241054", "story_v_out_417241.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_417241", "417241054", "story_v_out_417241.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_27 = var_237_18 + 0.3
			local var_237_28 = math.max(var_237_19, arg_234_1.talkMaxDuration)

			if var_237_18 + 0.3 <= arg_234_1.time_ and arg_234_1.time_ < var_237_27 + var_237_28 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_27) / var_237_28

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_27 + var_237_28 and arg_234_1.time_ < var_237_27 + var_237_28 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1709",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1709",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.966,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play417241055 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 417241055
		arg_240_1.duration_ = 7.07

		local var_240_0 = {
			zh = 4.766,
			ja = 7.066
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
				arg_240_0:Play417241056(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.675

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

				local var_243_1 = arg_240_1:GetWordFromCfg(417241055)
				local var_243_2 = arg_240_1:FormatText(var_243_1.content)

				arg_240_1.text_.text = var_243_2

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 27 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 27)

				if (27 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 27)) > 0 and var_243_0 < var_243_4 then
					arg_240_1.talkMaxDuration = var_243_4

					if var_243_4 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_4 + 0
					end
				end

				arg_240_1.text_.text = var_243_2
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241055", "story_v_out_417241.awb") ~= 0 then
					local var_243_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241055", "story_v_out_417241.awb") / 1000

					if var_243_5 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + 0
					end

					if var_243_1.prefab_name ~= "" and arg_240_1.actors_[var_243_1.prefab_name] ~= nil then
						local var_243_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_1.prefab_name].transform, "story_v_out_417241", "417241055", "story_v_out_417241.awb")

						arg_240_1:RecordAudio("417241055", var_243_6)
						arg_240_1:RecordAudio("417241055", var_243_6)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_417241", "417241055", "story_v_out_417241.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_417241", "417241055", "story_v_out_417241.awb")
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
	Play417241056 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 417241056
		arg_244_1.duration_ = 1.87

		local var_244_0 = {
			zh = 1.033,
			ja = 1.866
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
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play417241057(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.075

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[643].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_1 = arg_244_1:GetWordFromCfg(417241056)
				local var_247_2 = arg_244_1:FormatText(var_247_1.content)

				arg_244_1.text_.text = var_247_2

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 3 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 3)

				if (3 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 3)) > 0 and var_247_0 < var_247_4 then
					arg_244_1.talkMaxDuration = var_247_4

					if var_247_4 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_4 + 0
					end
				end

				arg_244_1.text_.text = var_247_2
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241056", "story_v_out_417241.awb") ~= 0 then
					local var_247_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241056", "story_v_out_417241.awb") / 1000

					if var_247_5 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + 0
					end

					if var_247_1.prefab_name ~= "" and arg_244_1.actors_[var_247_1.prefab_name] ~= nil then
						local var_247_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_1.prefab_name].transform, "story_v_out_417241", "417241056", "story_v_out_417241.awb")

						arg_244_1:RecordAudio("417241056", var_247_6)
						arg_244_1:RecordAudio("417241056", var_247_6)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_417241", "417241056", "story_v_out_417241.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_417241", "417241056", "story_v_out_417241.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play417241057 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 417241057
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play417241058(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos10128 = arg_248_1.actors_["10128"].transform.localPosition
				arg_248_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_248_1:CheckSpriteTmpPos("10128", 7)

				for iter_251_0 = 0, arg_248_1.actors_["10128"].transform.childCount - 1 do
					local var_251_0 = arg_248_1.actors_["10128"].transform:GetChild(iter_251_0)

					if var_251_0.name == "" or not string.find(var_251_0.name, "split") then
						var_251_0.gameObject:SetActive(true)
					else
						var_251_0.gameObject:SetActive(false)
					end
				end
			end

			local var_251_1 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_1 then
				arg_248_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_248_1.time_ - 0) / var_251_1)
			end

			if arg_248_1.time_ >= 0 + var_251_1 and arg_248_1.time_ < 0 + var_251_1 + arg_251_0 then
				arg_248_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			if 0.034 < arg_248_1.time_ and arg_248_1.time_ <= 0.034 + arg_251_0 then
				arg_248_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_beep", "")
			end

			local var_251_3 = 0
			local var_251_4 = 1.175

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_3 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_5 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(417241057).content)

				arg_248_1.text_.text = var_251_5

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_7 = 47 <= 0 and var_251_4 or var_251_4 * (utf8.len(var_251_5) / 47)

				if (47 <= 0 and var_251_4 or var_251_4 * (utf8.len(var_251_5) / 47)) > 0 and var_251_4 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_3 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_3
					end
				end

				arg_248_1.text_.text = var_251_5
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_8 = math.max(var_251_4, arg_248_1.talkMaxDuration)

			if var_251_3 <= arg_248_1.time_ and arg_248_1.time_ < var_251_3 + var_251_8 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_3) / var_251_8

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_3 + var_251_8 and arg_248_1.time_ < var_251_3 + var_251_8 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
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

		arg_248_1:InitPlayNodeList()
	end,
	Play417241058 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 417241058
		arg_252_1.duration_ = 5.13

		local var_252_0 = {
			zh = 2.566,
			ja = 5.133
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play417241059(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0.02 < arg_252_1.time_ and arg_252_1.time_ <= 0.02 + arg_255_0 then
				arg_252_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_cannon", "")
			end

			local var_255_1 = 0
			local var_255_2 = 0.35

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_252_1.callingController_:SetSelectedState("calling")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:GetWordFromCfg(417241058)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_6 = 14 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_4) / 14)

				if (14 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_4) / 14)) > 0 and var_255_2 < var_255_6 then
					arg_252_1.talkMaxDuration = var_255_6

					if var_255_6 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_6 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241058", "story_v_out_417241.awb") ~= 0 then
					local var_255_7 = manager.audio:GetVoiceLength("story_v_out_417241", "417241058", "story_v_out_417241.awb") / 1000

					if var_255_7 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_1
					end

					if var_255_3.prefab_name ~= "" and arg_252_1.actors_[var_255_3.prefab_name] ~= nil then
						local var_255_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_3.prefab_name].transform, "story_v_out_417241", "417241058", "story_v_out_417241.awb")

						arg_252_1:RecordAudio("417241058", var_255_8)
						arg_252_1:RecordAudio("417241058", var_255_8)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_417241", "417241058", "story_v_out_417241.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_417241", "417241058", "story_v_out_417241.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_9 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_9 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_9

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_9 and arg_252_1.time_ < var_255_1 + var_255_9 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play417241059 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 417241059
		arg_256_1.duration_ = 4.37

		local var_256_0 = {
			zh = 2.5,
			ja = 4.366
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play417241060(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.4

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_1 = arg_256_1:GetWordFromCfg(417241059)
				local var_259_2 = arg_256_1:FormatText(var_259_1.content)

				arg_256_1.text_.text = var_259_2

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_4 = 16 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 16)

				if (16 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 16)) > 0 and var_259_0 < var_259_4 then
					arg_256_1.talkMaxDuration = var_259_4

					if var_259_4 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_4 + 0
					end
				end

				arg_256_1.text_.text = var_259_2
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241059", "story_v_out_417241.awb") ~= 0 then
					local var_259_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241059", "story_v_out_417241.awb") / 1000

					if var_259_5 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + 0
					end

					if var_259_1.prefab_name ~= "" and arg_256_1.actors_[var_259_1.prefab_name] ~= nil then
						local var_259_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_1.prefab_name].transform, "story_v_out_417241", "417241059", "story_v_out_417241.awb")

						arg_256_1:RecordAudio("417241059", var_259_6)
						arg_256_1:RecordAudio("417241059", var_259_6)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_417241", "417241059", "story_v_out_417241.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_417241", "417241059", "story_v_out_417241.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_7 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_7 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_7

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_7 and arg_256_1.time_ < 0 + var_259_7 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play417241060 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 417241060
		arg_260_1.duration_ = 5.53

		local var_260_0 = {
			zh = 2.2,
			ja = 5.533
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play417241061(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.275

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10111_split_1")

				arg_260_1.callingController_:SetSelectedState("calling")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_1 = arg_260_1:GetWordFromCfg(417241060)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.text_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 11 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 11)

				if (11 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 11)) > 0 and var_263_0 < var_263_4 then
					arg_260_1.talkMaxDuration = var_263_4

					if var_263_4 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_4 + 0
					end
				end

				arg_260_1.text_.text = var_263_2
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241060", "story_v_out_417241.awb") ~= 0 then
					local var_263_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241060", "story_v_out_417241.awb") / 1000

					if var_263_5 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + 0
					end

					if var_263_1.prefab_name ~= "" and arg_260_1.actors_[var_263_1.prefab_name] ~= nil then
						local var_263_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_1.prefab_name].transform, "story_v_out_417241", "417241060", "story_v_out_417241.awb")

						arg_260_1:RecordAudio("417241060", var_263_6)
						arg_260_1:RecordAudio("417241060", var_263_6)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_417241", "417241060", "story_v_out_417241.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_417241", "417241060", "story_v_out_417241.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play417241061 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 417241061
		arg_264_1.duration_ = 5

		local var_264_0 = {
			zh = 3.066,
			ja = 5
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play417241062(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0.45

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_1 = arg_264_1:GetWordFromCfg(417241061)
				local var_267_2 = arg_264_1:FormatText(var_267_1.content)

				arg_264_1.text_.text = var_267_2

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_4 = 18 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 18)

				if (18 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 18)) > 0 and var_267_0 < var_267_4 then
					arg_264_1.talkMaxDuration = var_267_4

					if var_267_4 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_4 + 0
					end
				end

				arg_264_1.text_.text = var_267_2
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241061", "story_v_out_417241.awb") ~= 0 then
					local var_267_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241061", "story_v_out_417241.awb") / 1000

					if var_267_5 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + 0
					end

					if var_267_1.prefab_name ~= "" and arg_264_1.actors_[var_267_1.prefab_name] ~= nil then
						local var_267_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_1.prefab_name].transform, "story_v_out_417241", "417241061", "story_v_out_417241.awb")

						arg_264_1:RecordAudio("417241061", var_267_6)
						arg_264_1:RecordAudio("417241061", var_267_6)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_417241", "417241061", "story_v_out_417241.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_417241", "417241061", "story_v_out_417241.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_7 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_7 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_7

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_7 and arg_264_1.time_ < 0 + var_267_7 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play417241062 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 417241062
		arg_268_1.duration_ = 6.5

		local var_268_0 = {
			zh = 3.466,
			ja = 6.5
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play417241063(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.3

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:GetWordFromCfg(417241062)
				local var_271_2 = arg_268_1:FormatText(var_271_1.content)

				arg_268_1.text_.text = var_271_2

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_4 = 12 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 12)

				if (12 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 12)) > 0 and var_271_0 < var_271_4 then
					arg_268_1.talkMaxDuration = var_271_4

					if var_271_4 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_4 + 0
					end
				end

				arg_268_1.text_.text = var_271_2
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241062", "story_v_out_417241.awb") ~= 0 then
					local var_271_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241062", "story_v_out_417241.awb") / 1000

					if var_271_5 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + 0
					end

					if var_271_1.prefab_name ~= "" and arg_268_1.actors_[var_271_1.prefab_name] ~= nil then
						local var_271_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_1.prefab_name].transform, "story_v_out_417241", "417241062", "story_v_out_417241.awb")

						arg_268_1:RecordAudio("417241062", var_271_6)
						arg_268_1:RecordAudio("417241062", var_271_6)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_417241", "417241062", "story_v_out_417241.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_417241", "417241062", "story_v_out_417241.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_7 and arg_268_1.time_ < 0 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play417241063 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 417241063
		arg_272_1.duration_ = 2.33

		local var_272_0 = {
			zh = 1.39966666666667,
			ja = 2.33266666666667
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play417241064(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_275_0 = 0.5

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 then
				local var_275_1, var_275_2 = math.modf((arg_272_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_275_2 * 0.13, var_275_2 * 0.13, var_275_2 * 0.13) + arg_272_1.var_.shakeOldPos
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 then
				manager.ui.mainCamera.transform.localPosition = arg_272_1.var_.shakeOldPos
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind_parachuting02", "")
			end

			if arg_272_1.frameCnt_ <= 1 then
				arg_272_1.dialog_:SetActive(false)
			end

			local var_275_4 = 0.566666666666667
			local var_275_5 = 0.075

			if 0.566666666666667 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0

				arg_272_1.dialog_:SetActive(true)

				arg_272_1.dialogCg_.alpha = 0

				local var_275_6 = LeanTween.value(arg_272_1.dialog_, 0, 1, 0.3)

				var_275_6:setOnUpdate(LuaHelper.FloatAction(function(arg_276_0)
					arg_272_1.dialogCg_.alpha = arg_276_0
				end))
				var_275_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_272_1.dialog_)
					var_275_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_272_1.duration_ = arg_272_1.duration_ + 0.3

				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_7 = arg_272_1:GetWordFromCfg(417241063)
				local var_275_8 = arg_272_1:FormatText(var_275_7.content)

				arg_272_1.text_.text = var_275_8

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_10 = 3 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_8) / 3)

				if (3 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_8) / 3)) > 0 and var_275_5 < var_275_10 then
					arg_272_1.talkMaxDuration = var_275_10
					var_275_4 = var_275_4 + 0.3

					if var_275_10 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_10 + var_275_4
					end
				end

				arg_272_1.text_.text = var_275_8
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241063", "story_v_out_417241.awb") ~= 0 then
					local var_275_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241063", "story_v_out_417241.awb") / 1000

					if var_275_11 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_11 + var_275_4
					end

					if var_275_7.prefab_name ~= "" and arg_272_1.actors_[var_275_7.prefab_name] ~= nil then
						local var_275_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_7.prefab_name].transform, "story_v_out_417241", "417241063", "story_v_out_417241.awb")

						arg_272_1:RecordAudio("417241063", var_275_12)
						arg_272_1:RecordAudio("417241063", var_275_12)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_417241", "417241063", "story_v_out_417241.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_417241", "417241063", "story_v_out_417241.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_13 = var_275_4 + 0.3
			local var_275_14 = math.max(var_275_5, arg_272_1.talkMaxDuration)

			if var_275_4 + 0.3 <= arg_272_1.time_ and arg_272_1.time_ < var_275_13 + var_275_14 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_13) / var_275_14

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_13 + var_275_14 and arg_272_1.time_ < var_275_13 + var_275_14 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play417241064 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 417241064
		arg_278_1.duration_ = 9

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play417241065(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 4 < arg_278_1.time_ and arg_278_1.time_ <= 4 + arg_281_0 then
				arg_278_1.allBtn_.enabled = false
			end

			if arg_278_1.time_ >= 4 + 1.03333333333333 and arg_278_1.time_ < 4 + 1.03333333333333 + arg_281_0 then
				arg_278_1.allBtn_.enabled = true
			end

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				local var_281_0 = arg_278_1.bgs_.I17f

				arg_278_1.bgs_.I17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_281_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_1 = var_281_0:GetComponent("SpriteRenderer")

				if var_281_1 and var_281_1.sprite then
					local var_281_2 = 2 * (var_281_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_281_0.transform.localScale = Vector3.New(var_281_2 / var_281_1.sprite.bounds.size.y < var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x and var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x or var_281_2 / var_281_1.sprite.bounds.size.y, var_281_2 / var_281_1.sprite.bounds.size.y < var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x and var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x or var_281_2 / var_281_1.sprite.bounds.size.y, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "I17f" then
						iter_281_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_281_3 = 0

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_3 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_4 = 2

			if var_281_3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_3 + var_281_4 then
				local var_281_5 = Color.New(0, 0, 0)

				var_281_5.a = Mathf.Lerp(0, 1, (arg_278_1.time_ - var_281_3) / var_281_4)
				arg_278_1.mask_.color = var_281_5
			end

			if arg_278_1.time_ >= var_281_3 + var_281_4 and arg_278_1.time_ < var_281_3 + var_281_4 + arg_281_0 then
				local var_281_6 = Color.New(0, 0, 0)

				var_281_6.a = 1
				arg_278_1.mask_.color = var_281_6
			end

			local var_281_7 = 2

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_7 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_8 = 2

			if var_281_7 <= arg_278_1.time_ and arg_278_1.time_ < var_281_7 + var_281_8 then
				local var_281_9 = Color.New(0, 0, 0)

				var_281_9.a = Mathf.Lerp(1, 0, (arg_278_1.time_ - var_281_7) / var_281_8)
				arg_278_1.mask_.color = var_281_9
			end

			if arg_278_1.time_ >= var_281_7 + var_281_8 and arg_278_1.time_ < var_281_7 + var_281_8 + arg_281_0 then
				local var_281_10 = Color.New(0, 0, 0)

				arg_278_1.mask_.enabled = false
				var_281_10.a = 0
				arg_278_1.mask_.color = var_281_10
			end

			local var_281_11 = arg_278_1.actors_["10128"].transform

			if 1.96666666666667 < arg_278_1.time_ and arg_278_1.time_ <= 1.96666666666667 + arg_281_0 then
				arg_278_1.var_.moveOldPos10128 = var_281_11.localPosition
				var_281_11.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("10128", 7)

				for iter_281_2 = 0, var_281_11.childCount - 1 do
					local var_281_12 = var_281_11:GetChild(iter_281_2)

					if var_281_12.name == "" or not string.find(var_281_12.name, "split") then
						var_281_12.gameObject:SetActive(true)
					else
						var_281_12.gameObject:SetActive(false)
					end
				end
			end

			local var_281_13 = 0.001

			if 1.96666666666667 <= arg_278_1.time_ and arg_278_1.time_ < 1.96666666666667 + var_281_13 then
				var_281_11.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_278_1.time_ - 1.96666666666667) / var_281_13)
			end

			if arg_278_1.time_ >= 1.96666666666667 + var_281_13 and arg_278_1.time_ < 1.96666666666667 + var_281_13 + arg_281_0 then
				var_281_11.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_281_14 = arg_278_1.actors_["10111"].transform

			if 1.96666666666667 < arg_278_1.time_ and arg_278_1.time_ <= 1.96666666666667 + arg_281_0 then
				arg_278_1.var_.moveOldPos10111 = var_281_14.localPosition
				var_281_14.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("10111", 7)

				for iter_281_3 = 0, var_281_14.childCount - 1 do
					local var_281_15 = var_281_14:GetChild(iter_281_3)

					if var_281_15.name == "" or not string.find(var_281_15.name, "split") then
						var_281_15.gameObject:SetActive(true)
					else
						var_281_15.gameObject:SetActive(false)
					end
				end
			end

			local var_281_16 = 0.001

			if 1.96666666666667 <= arg_278_1.time_ and arg_278_1.time_ < 1.96666666666667 + var_281_16 then
				var_281_14.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10111, Vector3.New(0, -2000, 0), (arg_278_1.time_ - 1.96666666666667) / var_281_16)
			end

			if arg_278_1.time_ >= 1.96666666666667 + var_281_16 and arg_278_1.time_ < 1.96666666666667 + var_281_16 + arg_281_0 then
				var_281_14.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.7 < arg_278_1.time_ and arg_278_1.time_ <= 0.7 + arg_281_0 then
				arg_278_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_wind_loop02", "")
			end

			if 1.46666666666667 < arg_278_1.time_ and arg_278_1.time_ <= 1.46666666666667 + arg_281_0 then
				arg_278_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_19 = 4
			local var_281_20 = 1.775

			if 4 < arg_278_1.time_ and arg_278_1.time_ <= var_281_19 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_21 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_21:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_22 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(417241064).content)

				arg_278_1.text_.text = var_281_22

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_24 = 71 <= 0 and var_281_20 or var_281_20 * (utf8.len(var_281_22) / 71)

				if (71 <= 0 and var_281_20 or var_281_20 * (utf8.len(var_281_22) / 71)) > 0 and var_281_20 < var_281_24 then
					arg_278_1.talkMaxDuration = var_281_24
					var_281_19 = var_281_19 + 0.3

					if var_281_24 + var_281_19 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_24 + var_281_19
					end
				end

				arg_278_1.text_.text = var_281_22
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_25 = var_281_19 + 0.3
			local var_281_26 = math.max(var_281_20, arg_278_1.talkMaxDuration)

			if var_281_19 + 0.3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_25 + var_281_26 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_25) / var_281_26

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_25 + var_281_26 and arg_278_1.time_ < var_281_25 + var_281_26 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play417241065 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 417241065
		arg_284_1.duration_ = 3.47

		local var_284_0 = {
			zh = 2.2,
			ja = 3.466
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play417241066(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 1.16666666666667 < arg_284_1.time_ and arg_284_1.time_ <= 1.16666666666667 + arg_287_0 then
				arg_284_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun02", "")
			end

			local var_287_1 = 0
			local var_287_2 = 0.225

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_1")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_3 = arg_284_1:GetWordFromCfg(417241065)
				local var_287_4 = arg_284_1:FormatText(var_287_3.content)

				arg_284_1.text_.text = var_287_4

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_6 = 9 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_4) / 9)

				if (9 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_4) / 9)) > 0 and var_287_2 < var_287_6 then
					arg_284_1.talkMaxDuration = var_287_6

					if var_287_6 + var_287_1 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_6 + var_287_1
					end
				end

				arg_284_1.text_.text = var_287_4
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241065", "story_v_out_417241.awb") ~= 0 then
					local var_287_7 = manager.audio:GetVoiceLength("story_v_out_417241", "417241065", "story_v_out_417241.awb") / 1000

					if var_287_7 + var_287_1 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_1
					end

					if var_287_3.prefab_name ~= "" and arg_284_1.actors_[var_287_3.prefab_name] ~= nil then
						local var_287_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_3.prefab_name].transform, "story_v_out_417241", "417241065", "story_v_out_417241.awb")

						arg_284_1:RecordAudio("417241065", var_287_8)
						arg_284_1:RecordAudio("417241065", var_287_8)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_417241", "417241065", "story_v_out_417241.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_417241", "417241065", "story_v_out_417241.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_9 = math.max(var_287_2, arg_284_1.talkMaxDuration)

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_9 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_1) / var_287_9

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_1 + var_287_9 and arg_284_1.time_ < var_287_1 + var_287_9 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play417241066 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 417241066
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play417241067(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0.5 < arg_288_1.time_ and arg_288_1.time_ <= 0.5 + arg_291_0 then
				arg_288_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_car02", "")
			end

			local var_291_1 = 0
			local var_291_2 = 1.4

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_3 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(417241066).content)

				arg_288_1.text_.text = var_291_3

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 56 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_3) / 56)

				if (56 <= 0 and var_291_2 or var_291_2 * (utf8.len(var_291_3) / 56)) > 0 and var_291_2 < var_291_5 then
					arg_288_1.talkMaxDuration = var_291_5

					if var_291_5 + var_291_1 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + var_291_1
					end
				end

				arg_288_1.text_.text = var_291_3
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_6 = math.max(var_291_2, arg_288_1.talkMaxDuration)

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_6 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_1) / var_291_6

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_1 + var_291_6 and arg_288_1.time_ < var_291_1 + var_291_6 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play417241067 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 417241067
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play417241068(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 1.56666666666667 < arg_292_1.time_ and arg_292_1.time_ <= 1.56666666666667 + arg_295_0 then
				arg_292_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_metalball", "")
			end

			local var_295_1 = 0
			local var_295_2 = 1.7

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_3 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(417241067).content)

				arg_292_1.text_.text = var_295_3

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 68 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_3) / 68)

				if (68 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_3) / 68)) > 0 and var_295_2 < var_295_5 then
					arg_292_1.talkMaxDuration = var_295_5

					if var_295_5 + var_295_1 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + var_295_1
					end
				end

				arg_292_1.text_.text = var_295_3
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_6 = math.max(var_295_2, arg_292_1.talkMaxDuration)

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_6 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_1) / var_295_6

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_1 + var_295_6 and arg_292_1.time_ < var_295_1 + var_295_6 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play417241068 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 417241068
		arg_296_1.duration_ = 5.03

		local var_296_0 = {
			zh = 3.166,
			ja = 5.033
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
				arg_296_0:Play417241069(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos10128 = arg_296_1.actors_["10128"].transform.localPosition
				arg_296_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10128", 3)

				for iter_299_0 = 0, arg_296_1.actors_["10128"].transform.childCount - 1 do
					local var_299_0 = arg_296_1.actors_["10128"].transform:GetChild(iter_299_0)

					if var_299_0.name == "" or not string.find(var_299_0.name, "split") then
						var_299_0.gameObject:SetActive(true)
					else
						var_299_0.gameObject:SetActive(false)
					end
				end
			end

			local var_299_1 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_1 then
				arg_296_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_296_1.time_ - 0) / var_299_1)
			end

			if arg_296_1.time_ >= 0 + var_299_1 and arg_296_1.time_ < 0 + var_299_1 + arg_299_0 then
				arg_296_1.actors_["10128"].transform.localPosition = Vector3.New(0, -347, -300)
			end

			local var_299_2 = arg_296_1.actors_["10128"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.actorSpriteComps10128 == nil then
				arg_296_1.var_.actorSpriteComps10128 = var_299_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_3 = 0.2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_3 and not isNil(var_299_2) then
				if arg_296_1.var_.actorSpriteComps10128 then
					for iter_299_1, iter_299_2 in pairs(arg_296_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_299_2 then
							if arg_296_1.isInRecall_ then
								iter_299_2.color = Color.New(Mathf.Lerp(iter_299_2.color.r, arg_296_1.hightColor1.r, (arg_296_1.time_ - 0) / var_299_3), Mathf.Lerp(iter_299_2.color.g, arg_296_1.hightColor1.g, (arg_296_1.time_ - 0) / var_299_3), (Mathf.Lerp(iter_299_2.color.b, arg_296_1.hightColor1.b, (arg_296_1.time_ - 0) / var_299_3)))
							else
								local var_299_4 = Mathf.Lerp(iter_299_2.color.r, 1, (arg_296_1.time_ - 0) / var_299_3)

								iter_299_2.color = Color.New(var_299_4, var_299_4, var_299_4)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 0 + var_299_3 and arg_296_1.time_ < 0 + var_299_3 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.actorSpriteComps10128 then
				for iter_299_3, iter_299_4 in pairs(arg_296_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_299_4 then
						iter_299_4.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_296_1.var_.actorSpriteComps10128 = nil
			end

			local var_299_5 = 0
			local var_299_6 = 0.45

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_5 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_7 = arg_296_1:GetWordFromCfg(417241068)
				local var_299_8 = arg_296_1:FormatText(var_299_7.content)

				arg_296_1.text_.text = var_299_8

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_10 = 18 <= 0 and var_299_6 or var_299_6 * (utf8.len(var_299_8) / 18)

				if (18 <= 0 and var_299_6 or var_299_6 * (utf8.len(var_299_8) / 18)) > 0 and var_299_6 < var_299_10 then
					arg_296_1.talkMaxDuration = var_299_10

					if var_299_10 + var_299_5 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_5
					end
				end

				arg_296_1.text_.text = var_299_8
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241068", "story_v_out_417241.awb") ~= 0 then
					local var_299_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241068", "story_v_out_417241.awb") / 1000

					if var_299_11 + var_299_5 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_11 + var_299_5
					end

					if var_299_7.prefab_name ~= "" and arg_296_1.actors_[var_299_7.prefab_name] ~= nil then
						local var_299_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_7.prefab_name].transform, "story_v_out_417241", "417241068", "story_v_out_417241.awb")

						arg_296_1:RecordAudio("417241068", var_299_12)
						arg_296_1:RecordAudio("417241068", var_299_12)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_417241", "417241068", "story_v_out_417241.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_417241", "417241068", "story_v_out_417241.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_13 = math.max(var_299_6, arg_296_1.talkMaxDuration)

			if var_299_5 <= arg_296_1.time_ and arg_296_1.time_ < var_299_5 + var_299_13 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_5) / var_299_13

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_5 + var_299_13 and arg_296_1.time_ < var_299_5 + var_299_13 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
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

		arg_296_1:InitPlayNodeList()
	end,
	Play417241069 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 417241069
		arg_300_1.duration_ = 6.66

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play417241070(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_9000

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos10128 = arg_300_1.actors_["10128"].transform.localPosition
				arg_300_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("10128", 7)

				for iter_303_0 = 0, arg_300_1.actors_["10128"].transform.childCount - 1 do
					local var_303_0 = arg_300_1.actors_["10128"].transform:GetChild(iter_303_0)

					if var_303_0.name == "" or not string.find(var_303_0.name, "split") then
						var_303_0.gameObject:SetActive(true)
					else
						var_303_0.gameObject:SetActive(false)
					end
				end
			end

			local var_303_1 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_1 then
				arg_300_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_300_1.time_ - 0) / var_303_1)
			end

			if arg_300_1.time_ >= 0 + var_303_1 and arg_300_1.time_ < 0 + var_303_1 + arg_303_0 then
				arg_300_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				local var_303_2 = arg_300_1.var_.effect1069

				if not arg_300_1.var_.effect1069 then
					var_303_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_303_2.name = "1069"
					arg_300_1.var_.effect1069 = var_303_2
				else
					var_303_2.transform:SetParent(var_303_9000)
				end

				var_303_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_303_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_303_4 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_303_1, iter_303_2 in ipairs((var_303_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_303_2.transform.localScale = Vector3.New(iter_303_2.transform.localScale.x / var_303_4 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_303_2.transform.localScale.y / var_303_4, iter_303_2.transform.localScale.z)
				end
			end

			local var_303_6 = manager.ui.mainCamera.transform

			if 0.166666666666666 < arg_300_1.time_ and arg_300_1.time_ <= 0.166666666666666 + arg_303_0 then
				arg_300_1.var_.shakeOldPos = var_303_6.localPosition
			end

			local var_303_7 = 0.866666666666667

			if 0.166666666666666 <= arg_300_1.time_ and arg_300_1.time_ < 0.166666666666666 + var_303_7 then
				local var_303_8, var_303_9 = math.modf((arg_300_1.time_ - 0.166666666666666) / 0.066)

				var_303_6.localPosition = Vector3.New(var_303_9 * 0.13, var_303_9 * 0.13, var_303_9 * 0.13) + arg_300_1.var_.shakeOldPos
			end

			if arg_300_1.time_ >= 0.166666666666666 + var_303_7 and arg_300_1.time_ < 0.166666666666666 + var_303_7 + arg_303_0 then
				var_303_6.localPosition = arg_300_1.var_.shakeOldPos
			end

			if 0.02 < arg_300_1.time_ and arg_300_1.time_ <= 0.02 + arg_303_0 then
				arg_300_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_explosion02", "")
			end

			if arg_300_1.frameCnt_ <= 1 then
				arg_300_1.dialog_:SetActive(false)
			end

			local var_303_11 = 1.65833333333333
			local var_303_12 = 1.375

			if 1.65833333333333 < arg_300_1.time_ and arg_300_1.time_ <= var_303_11 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				arg_300_1.dialog_:SetActive(true)

				arg_300_1.dialogCg_.alpha = 0

				local var_303_13 = LeanTween.value(arg_300_1.dialog_, 0, 1, 0.3)

				var_303_13:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_300_1.dialogCg_.alpha = arg_304_0
				end))
				var_303_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_300_1.dialog_)
					var_303_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_300_1.duration_ = arg_300_1.duration_ + 0.3

				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_14 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(417241069).content)

				arg_300_1.text_.text = var_303_14

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_16 = 55 <= 0 and var_303_12 or var_303_12 * (utf8.len(var_303_14) / 55)

				if (55 <= 0 and var_303_12 or var_303_12 * (utf8.len(var_303_14) / 55)) > 0 and var_303_12 < var_303_16 then
					arg_300_1.talkMaxDuration = var_303_16
					var_303_11 = var_303_11 + 0.3

					if var_303_16 + var_303_11 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_16 + var_303_11
					end
				end

				arg_300_1.text_.text = var_303_14
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_17 = var_303_11 + 0.3
			local var_303_18 = math.max(var_303_12, arg_300_1.talkMaxDuration)

			if var_303_11 + 0.3 <= arg_300_1.time_ and arg_300_1.time_ < var_303_17 + var_303_18 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_17) / var_303_18

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_17 + var_303_18 and arg_300_1.time_ < var_303_17 + var_303_18 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
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

		arg_300_1:InitPlayNodeList()
	end,
	Play417241070 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 417241070
		arg_306_1.duration_ = 3.27

		local var_306_0 = {
			zh = 3.266,
			ja = 2.033
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play417241071(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos10115 = arg_306_1.actors_["10115"].transform.localPosition
				arg_306_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("10115", 3)

				for iter_309_0 = 0, arg_306_1.actors_["10115"].transform.childCount - 1 do
					local var_309_0 = arg_306_1.actors_["10115"].transform:GetChild(iter_309_0)

					if var_309_0.name == "split_2" or not string.find(var_309_0.name, "split") then
						var_309_0.gameObject:SetActive(true)
					else
						var_309_0.gameObject:SetActive(false)
					end
				end
			end

			local var_309_1 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_1 then
				arg_306_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_306_1.time_ - 0) / var_309_1)
			end

			if arg_306_1.time_ >= 0 + var_309_1 and arg_306_1.time_ < 0 + var_309_1 + arg_309_0 then
				arg_306_1.actors_["10115"].transform.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_309_2 = arg_306_1.actors_["10115"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.actorSpriteComps10115 == nil then
				arg_306_1.var_.actorSpriteComps10115 = var_309_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_3 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_3 and not isNil(var_309_2) then
				if arg_306_1.var_.actorSpriteComps10115 then
					for iter_309_1, iter_309_2 in pairs(arg_306_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_309_2 then
							if arg_306_1.isInRecall_ then
								iter_309_2.color = Color.New(Mathf.Lerp(iter_309_2.color.r, arg_306_1.hightColor1.r, (arg_306_1.time_ - 0) / var_309_3), Mathf.Lerp(iter_309_2.color.g, arg_306_1.hightColor1.g, (arg_306_1.time_ - 0) / var_309_3), (Mathf.Lerp(iter_309_2.color.b, arg_306_1.hightColor1.b, (arg_306_1.time_ - 0) / var_309_3)))
							else
								local var_309_4 = Mathf.Lerp(iter_309_2.color.r, 1, (arg_306_1.time_ - 0) / var_309_3)

								iter_309_2.color = Color.New(var_309_4, var_309_4, var_309_4)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= 0 + var_309_3 and arg_306_1.time_ < 0 + var_309_3 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.actorSpriteComps10115 then
				for iter_309_3, iter_309_4 in pairs(arg_306_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_309_4 then
						iter_309_4.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_306_1.var_.actorSpriteComps10115 = nil
			end

			local var_309_5 = 0
			local var_309_6 = 0.375

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_5 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_7 = arg_306_1:GetWordFromCfg(417241070)
				local var_309_8 = arg_306_1:FormatText(var_309_7.content)

				arg_306_1.text_.text = var_309_8

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_10 = 15 <= 0 and var_309_6 or var_309_6 * (utf8.len(var_309_8) / 15)

				if (15 <= 0 and var_309_6 or var_309_6 * (utf8.len(var_309_8) / 15)) > 0 and var_309_6 < var_309_10 then
					arg_306_1.talkMaxDuration = var_309_10

					if var_309_10 + var_309_5 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_10 + var_309_5
					end
				end

				arg_306_1.text_.text = var_309_8
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241070", "story_v_out_417241.awb") ~= 0 then
					local var_309_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241070", "story_v_out_417241.awb") / 1000

					if var_309_11 + var_309_5 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_11 + var_309_5
					end

					if var_309_7.prefab_name ~= "" and arg_306_1.actors_[var_309_7.prefab_name] ~= nil then
						local var_309_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_7.prefab_name].transform, "story_v_out_417241", "417241070", "story_v_out_417241.awb")

						arg_306_1:RecordAudio("417241070", var_309_12)
						arg_306_1:RecordAudio("417241070", var_309_12)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_417241", "417241070", "story_v_out_417241.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_417241", "417241070", "story_v_out_417241.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_13 = math.max(var_309_6, arg_306_1.talkMaxDuration)

			if var_309_5 <= arg_306_1.time_ and arg_306_1.time_ < var_309_5 + var_309_13 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_5) / var_309_13

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_5 + var_309_13 and arg_306_1.time_ < var_309_5 + var_309_13 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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
	Play417241071 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 417241071
		arg_310_1.duration_ = 3.07

		local var_310_0 = {
			zh = 2.133,
			ja = 3.066
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play417241072(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["10128"]) and arg_310_1.var_.actorSpriteComps10128 == nil then
				arg_310_1.var_.actorSpriteComps10128 = arg_310_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_0 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["10128"]) then
				if arg_310_1.var_.actorSpriteComps10128 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								iter_313_1.color = Color.New(Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor1.r, (arg_310_1.time_ - 0) / var_313_0), Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor1.g, (arg_310_1.time_ - 0) / var_313_0), (Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor1.b, (arg_310_1.time_ - 0) / var_313_0)))
							else
								local var_313_1 = Mathf.Lerp(iter_313_1.color.r, 1, (arg_310_1.time_ - 0) / var_313_0)

								iter_313_1.color = Color.New(var_313_1, var_313_1, var_313_1)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["10128"]) and arg_310_1.var_.actorSpriteComps10128 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_313_3 then
						iter_313_3.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_310_1.var_.actorSpriteComps10128 = nil
			end

			local var_313_2 = arg_310_1.actors_["10115"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.actorSpriteComps10115 == nil then
				arg_310_1.var_.actorSpriteComps10115 = var_313_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_3 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_3 and not isNil(var_313_2) then
				if arg_310_1.var_.actorSpriteComps10115 then
					for iter_313_4, iter_313_5 in pairs(arg_310_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_313_5 then
							if arg_310_1.isInRecall_ then
								iter_313_5.color = Color.New(Mathf.Lerp(iter_313_5.color.r, arg_310_1.hightColor2.r, (arg_310_1.time_ - 0) / var_313_3), Mathf.Lerp(iter_313_5.color.g, arg_310_1.hightColor2.g, (arg_310_1.time_ - 0) / var_313_3), (Mathf.Lerp(iter_313_5.color.b, arg_310_1.hightColor2.b, (arg_310_1.time_ - 0) / var_313_3)))
							else
								local var_313_4 = Mathf.Lerp(iter_313_5.color.r, 0.5, (arg_310_1.time_ - 0) / var_313_3)

								iter_313_5.color = Color.New(var_313_4, var_313_4, var_313_4)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_3 and arg_310_1.time_ < 0 + var_313_3 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.actorSpriteComps10115 then
				for iter_313_6, iter_313_7 in pairs(arg_310_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_313_7 then
						iter_313_7.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_310_1.var_.actorSpriteComps10115 = nil
			end

			local var_313_5 = arg_310_1.actors_["10115"].transform

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos10115 = var_313_5.localPosition
				var_313_5.localScale = Vector3.New(1, 1, 1)

				arg_310_1:CheckSpriteTmpPos("10115", 2)

				for iter_313_8 = 0, var_313_5.childCount - 1 do
					local var_313_6 = var_313_5:GetChild(iter_313_8)

					if var_313_6.name == "split_2" or not string.find(var_313_6.name, "split") then
						var_313_6.gameObject:SetActive(true)
					else
						var_313_6.gameObject:SetActive(false)
					end
				end
			end

			local var_313_7 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_7 then
				var_313_5.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos10115, Vector3.New(-390, -387.3, -246.2), (arg_310_1.time_ - 0) / var_313_7)
			end

			if arg_310_1.time_ >= 0 + var_313_7 and arg_310_1.time_ < 0 + var_313_7 + arg_313_0 then
				var_313_5.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_313_8 = arg_310_1.actors_["10128"].transform

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos10128 = var_313_8.localPosition
				var_313_8.localScale = Vector3.New(1, 1, 1)

				arg_310_1:CheckSpriteTmpPos("10128", 4)

				for iter_313_9 = 0, var_313_8.childCount - 1 do
					local var_313_9 = var_313_8:GetChild(iter_313_9)

					if var_313_9.name == "split_6" or not string.find(var_313_9.name, "split") then
						var_313_9.gameObject:SetActive(true)
					else
						var_313_9.gameObject:SetActive(false)
					end
				end
			end

			local var_313_10 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_10 then
				var_313_8.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_310_1.time_ - 0) / var_313_10)
			end

			if arg_310_1.time_ >= 0 + var_313_10 and arg_310_1.time_ < 0 + var_313_10 + arg_313_0 then
				var_313_8.localPosition = Vector3.New(390, -347, -300)
			end

			local var_313_11 = 0
			local var_313_12 = 0.25

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_11 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_13 = arg_310_1:GetWordFromCfg(417241071)
				local var_313_14 = arg_310_1:FormatText(var_313_13.content)

				arg_310_1.text_.text = var_313_14

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_16 = 10 <= 0 and var_313_12 or var_313_12 * (utf8.len(var_313_14) / 10)

				if (10 <= 0 and var_313_12 or var_313_12 * (utf8.len(var_313_14) / 10)) > 0 and var_313_12 < var_313_16 then
					arg_310_1.talkMaxDuration = var_313_16

					if var_313_16 + var_313_11 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_16 + var_313_11
					end
				end

				arg_310_1.text_.text = var_313_14
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241071", "story_v_out_417241.awb") ~= 0 then
					local var_313_17 = manager.audio:GetVoiceLength("story_v_out_417241", "417241071", "story_v_out_417241.awb") / 1000

					if var_313_17 + var_313_11 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_17 + var_313_11
					end

					if var_313_13.prefab_name ~= "" and arg_310_1.actors_[var_313_13.prefab_name] ~= nil then
						local var_313_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_13.prefab_name].transform, "story_v_out_417241", "417241071", "story_v_out_417241.awb")

						arg_310_1:RecordAudio("417241071", var_313_18)
						arg_310_1:RecordAudio("417241071", var_313_18)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_417241", "417241071", "story_v_out_417241.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_417241", "417241071", "story_v_out_417241.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_19 = math.max(var_313_12, arg_310_1.talkMaxDuration)

			if var_313_11 <= arg_310_1.time_ and arg_310_1.time_ < var_313_11 + var_313_19 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_11) / var_313_19

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_11 + var_313_19 and arg_310_1.time_ < var_313_11 + var_313_19 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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

		arg_310_1:InitPlayNodeList()
	end,
	Play417241072 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 417241072
		arg_314_1.duration_ = 5.93

		local var_314_0 = {
			zh = 4.366,
			ja = 5.933
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
				arg_314_0:Play417241073(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["10115"]) and arg_314_1.var_.actorSpriteComps10115 == nil then
				arg_314_1.var_.actorSpriteComps10115 = arg_314_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_0 = 0.2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["10115"]) then
				if arg_314_1.var_.actorSpriteComps10115 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["10115"]) and arg_314_1.var_.actorSpriteComps10115 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_317_3 then
						iter_317_3.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_314_1.var_.actorSpriteComps10115 = nil
			end

			local var_317_2 = arg_314_1.actors_["10128"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.actorSpriteComps10128 == nil then
				arg_314_1.var_.actorSpriteComps10128 = var_317_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_3 = 0.2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_3 and not isNil(var_317_2) then
				if arg_314_1.var_.actorSpriteComps10128 then
					for iter_317_4, iter_317_5 in pairs(arg_314_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_317_5 then
							if arg_314_1.isInRecall_ then
								iter_317_5.color = Color.New(Mathf.Lerp(iter_317_5.color.r, arg_314_1.hightColor2.r, (arg_314_1.time_ - 0) / var_317_3), Mathf.Lerp(iter_317_5.color.g, arg_314_1.hightColor2.g, (arg_314_1.time_ - 0) / var_317_3), (Mathf.Lerp(iter_317_5.color.b, arg_314_1.hightColor2.b, (arg_314_1.time_ - 0) / var_317_3)))
							else
								local var_317_4 = Mathf.Lerp(iter_317_5.color.r, 0.5, (arg_314_1.time_ - 0) / var_317_3)

								iter_317_5.color = Color.New(var_317_4, var_317_4, var_317_4)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_3 and arg_314_1.time_ < 0 + var_317_3 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.actorSpriteComps10128 then
				for iter_317_6, iter_317_7 in pairs(arg_314_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_317_7 then
						iter_317_7.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_314_1.var_.actorSpriteComps10128 = nil
			end

			local var_317_5 = 0
			local var_317_6 = 0.4

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_7 = arg_314_1:GetWordFromCfg(417241072)
				local var_317_8 = arg_314_1:FormatText(var_317_7.content)

				arg_314_1.text_.text = var_317_8

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_10 = 16 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_8) / 16)

				if (16 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_8) / 16)) > 0 and var_317_6 < var_317_10 then
					arg_314_1.talkMaxDuration = var_317_10

					if var_317_10 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_10 + var_317_5
					end
				end

				arg_314_1.text_.text = var_317_8
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241072", "story_v_out_417241.awb") ~= 0 then
					local var_317_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241072", "story_v_out_417241.awb") / 1000

					if var_317_11 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_11 + var_317_5
					end

					if var_317_7.prefab_name ~= "" and arg_314_1.actors_[var_317_7.prefab_name] ~= nil then
						local var_317_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_7.prefab_name].transform, "story_v_out_417241", "417241072", "story_v_out_417241.awb")

						arg_314_1:RecordAudio("417241072", var_317_12)
						arg_314_1:RecordAudio("417241072", var_317_12)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_417241", "417241072", "story_v_out_417241.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_417241", "417241072", "story_v_out_417241.awb")
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

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play417241073 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 417241073
		arg_318_1.duration_ = 3.77

		local var_318_0 = {
			zh = 3.166,
			ja = 3.766
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
				arg_318_0:Play417241074(arg_318_1)
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
								iter_321_1.color = Color.New(Mathf.Lerp(iter_321_1.color.r, arg_318_1.hightColor1.r, (arg_318_1.time_ - 0) / var_321_0), Mathf.Lerp(iter_321_1.color.g, arg_318_1.hightColor1.g, (arg_318_1.time_ - 0) / var_321_0), (Mathf.Lerp(iter_321_1.color.b, arg_318_1.hightColor1.b, (arg_318_1.time_ - 0) / var_321_0)))
							else
								local var_321_1 = Mathf.Lerp(iter_321_1.color.r, 1, (arg_318_1.time_ - 0) / var_321_0)

								iter_321_1.color = Color.New(var_321_1, var_321_1, var_321_1)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["10128"]) and arg_318_1.var_.actorSpriteComps10128 then
				for iter_321_2, iter_321_3 in pairs(arg_318_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_321_3 then
						iter_321_3.color = arg_318_1.isInRecall_ and (arg_318_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_318_1.var_.actorSpriteComps10128 = nil
			end

			local var_321_2 = arg_318_1.actors_["10115"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.actorSpriteComps10115 == nil then
				arg_318_1.var_.actorSpriteComps10115 = var_321_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_3 = 0.2

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_3 and not isNil(var_321_2) then
				if arg_318_1.var_.actorSpriteComps10115 then
					for iter_321_4, iter_321_5 in pairs(arg_318_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_321_5 then
							if arg_318_1.isInRecall_ then
								iter_321_5.color = Color.New(Mathf.Lerp(iter_321_5.color.r, arg_318_1.hightColor2.r, (arg_318_1.time_ - 0) / var_321_3), Mathf.Lerp(iter_321_5.color.g, arg_318_1.hightColor2.g, (arg_318_1.time_ - 0) / var_321_3), (Mathf.Lerp(iter_321_5.color.b, arg_318_1.hightColor2.b, (arg_318_1.time_ - 0) / var_321_3)))
							else
								local var_321_4 = Mathf.Lerp(iter_321_5.color.r, 0.5, (arg_318_1.time_ - 0) / var_321_3)

								iter_321_5.color = Color.New(var_321_4, var_321_4, var_321_4)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= 0 + var_321_3 and arg_318_1.time_ < 0 + var_321_3 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.actorSpriteComps10115 then
				for iter_321_6, iter_321_7 in pairs(arg_318_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_321_7 then
						iter_321_7.color = arg_318_1.isInRecall_ and (arg_318_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_318_1.var_.actorSpriteComps10115 = nil
			end

			local var_321_5 = 0
			local var_321_6 = 0.325

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_5 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_7 = arg_318_1:GetWordFromCfg(417241073)
				local var_321_8 = arg_318_1:FormatText(var_321_7.content)

				arg_318_1.text_.text = var_321_8

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_10 = 13 <= 0 and var_321_6 or var_321_6 * (utf8.len(var_321_8) / 13)

				if (13 <= 0 and var_321_6 or var_321_6 * (utf8.len(var_321_8) / 13)) > 0 and var_321_6 < var_321_10 then
					arg_318_1.talkMaxDuration = var_321_10

					if var_321_10 + var_321_5 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_10 + var_321_5
					end
				end

				arg_318_1.text_.text = var_321_8
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241073", "story_v_out_417241.awb") ~= 0 then
					local var_321_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241073", "story_v_out_417241.awb") / 1000

					if var_321_11 + var_321_5 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_11 + var_321_5
					end

					if var_321_7.prefab_name ~= "" and arg_318_1.actors_[var_321_7.prefab_name] ~= nil then
						local var_321_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_7.prefab_name].transform, "story_v_out_417241", "417241073", "story_v_out_417241.awb")

						arg_318_1:RecordAudio("417241073", var_321_12)
						arg_318_1:RecordAudio("417241073", var_321_12)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_417241", "417241073", "story_v_out_417241.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_417241", "417241073", "story_v_out_417241.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_13 = math.max(var_321_6, arg_318_1.talkMaxDuration)

			if var_321_5 <= arg_318_1.time_ and arg_318_1.time_ < var_321_5 + var_321_13 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_5) / var_321_13

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_5 + var_321_13 and arg_318_1.time_ < var_321_5 + var_321_13 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play417241074 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 417241074
		arg_322_1.duration_ = 1.6

		local var_322_0 = {
			zh = 1.6,
			ja = 1.566
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
				arg_322_0:Play417241075(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["10115"]) and arg_322_1.var_.actorSpriteComps10115 == nil then
				arg_322_1.var_.actorSpriteComps10115 = arg_322_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_0 = 0.2

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["10115"]) then
				if arg_322_1.var_.actorSpriteComps10115 then
					for iter_325_0, iter_325_1 in pairs(arg_322_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_325_1 then
							if arg_322_1.isInRecall_ then
								iter_325_1.color = Color.New(Mathf.Lerp(iter_325_1.color.r, arg_322_1.hightColor1.r, (arg_322_1.time_ - 0) / var_325_0), Mathf.Lerp(iter_325_1.color.g, arg_322_1.hightColor1.g, (arg_322_1.time_ - 0) / var_325_0), (Mathf.Lerp(iter_325_1.color.b, arg_322_1.hightColor1.b, (arg_322_1.time_ - 0) / var_325_0)))
							else
								local var_325_1 = Mathf.Lerp(iter_325_1.color.r, 1, (arg_322_1.time_ - 0) / var_325_0)

								iter_325_1.color = Color.New(var_325_1, var_325_1, var_325_1)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["10115"]) and arg_322_1.var_.actorSpriteComps10115 then
				for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_325_3 then
						iter_325_3.color = arg_322_1.isInRecall_ and (arg_322_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_322_1.var_.actorSpriteComps10115 = nil
			end

			local var_325_2 = arg_322_1.actors_["10128"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_2) and arg_322_1.var_.actorSpriteComps10128 == nil then
				arg_322_1.var_.actorSpriteComps10128 = var_325_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_3 = 0.2

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_3 and not isNil(var_325_2) then
				if arg_322_1.var_.actorSpriteComps10128 then
					for iter_325_4, iter_325_5 in pairs(arg_322_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_325_5 then
							if arg_322_1.isInRecall_ then
								iter_325_5.color = Color.New(Mathf.Lerp(iter_325_5.color.r, arg_322_1.hightColor2.r, (arg_322_1.time_ - 0) / var_325_3), Mathf.Lerp(iter_325_5.color.g, arg_322_1.hightColor2.g, (arg_322_1.time_ - 0) / var_325_3), (Mathf.Lerp(iter_325_5.color.b, arg_322_1.hightColor2.b, (arg_322_1.time_ - 0) / var_325_3)))
							else
								local var_325_4 = Mathf.Lerp(iter_325_5.color.r, 0.5, (arg_322_1.time_ - 0) / var_325_3)

								iter_325_5.color = Color.New(var_325_4, var_325_4, var_325_4)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= 0 + var_325_3 and arg_322_1.time_ < 0 + var_325_3 + arg_325_0 and not isNil(var_325_2) and arg_322_1.var_.actorSpriteComps10128 then
				for iter_325_6, iter_325_7 in pairs(arg_322_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_325_7 then
						iter_325_7.color = arg_322_1.isInRecall_ and (arg_322_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_322_1.var_.actorSpriteComps10128 = nil
			end

			local var_325_5 = 0
			local var_325_6 = 0.2

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_5 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_7 = arg_322_1:GetWordFromCfg(417241074)
				local var_325_8 = arg_322_1:FormatText(var_325_7.content)

				arg_322_1.text_.text = var_325_8

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_10 = 8 <= 0 and var_325_6 or var_325_6 * (utf8.len(var_325_8) / 8)

				if (8 <= 0 and var_325_6 or var_325_6 * (utf8.len(var_325_8) / 8)) > 0 and var_325_6 < var_325_10 then
					arg_322_1.talkMaxDuration = var_325_10

					if var_325_10 + var_325_5 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_10 + var_325_5
					end
				end

				arg_322_1.text_.text = var_325_8
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241074", "story_v_out_417241.awb") ~= 0 then
					local var_325_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241074", "story_v_out_417241.awb") / 1000

					if var_325_11 + var_325_5 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_11 + var_325_5
					end

					if var_325_7.prefab_name ~= "" and arg_322_1.actors_[var_325_7.prefab_name] ~= nil then
						local var_325_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_7.prefab_name].transform, "story_v_out_417241", "417241074", "story_v_out_417241.awb")

						arg_322_1:RecordAudio("417241074", var_325_12)
						arg_322_1:RecordAudio("417241074", var_325_12)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_417241", "417241074", "story_v_out_417241.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_417241", "417241074", "story_v_out_417241.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_13 = math.max(var_325_6, arg_322_1.talkMaxDuration)

			if var_325_5 <= arg_322_1.time_ and arg_322_1.time_ < var_325_5 + var_325_13 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_5) / var_325_13

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_5 + var_325_13 and arg_322_1.time_ < var_325_5 + var_325_13 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play417241075 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 417241075
		arg_326_1.duration_ = 7.87

		local var_326_0 = {
			zh = 5.966,
			ja = 7.866
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
				arg_326_0:Play417241076(arg_326_1)
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

			local var_329_2 = arg_326_1.actors_["10115"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_2) and arg_326_1.var_.actorSpriteComps10115 == nil then
				arg_326_1.var_.actorSpriteComps10115 = var_329_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_3 = 0.2

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_3 and not isNil(var_329_2) then
				if arg_326_1.var_.actorSpriteComps10115 then
					for iter_329_4, iter_329_5 in pairs(arg_326_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_329_5 then
							if arg_326_1.isInRecall_ then
								iter_329_5.color = Color.New(Mathf.Lerp(iter_329_5.color.r, arg_326_1.hightColor2.r, (arg_326_1.time_ - 0) / var_329_3), Mathf.Lerp(iter_329_5.color.g, arg_326_1.hightColor2.g, (arg_326_1.time_ - 0) / var_329_3), (Mathf.Lerp(iter_329_5.color.b, arg_326_1.hightColor2.b, (arg_326_1.time_ - 0) / var_329_3)))
							else
								local var_329_4 = Mathf.Lerp(iter_329_5.color.r, 0.5, (arg_326_1.time_ - 0) / var_329_3)

								iter_329_5.color = Color.New(var_329_4, var_329_4, var_329_4)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= 0 + var_329_3 and arg_326_1.time_ < 0 + var_329_3 + arg_329_0 and not isNil(var_329_2) and arg_326_1.var_.actorSpriteComps10115 then
				for iter_329_6, iter_329_7 in pairs(arg_326_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_329_7 then
						iter_329_7.color = arg_326_1.isInRecall_ and (arg_326_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_326_1.var_.actorSpriteComps10115 = nil
			end

			local var_329_5 = 0
			local var_329_6 = 0.625

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_5 + arg_329_0 then
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

				local var_329_7 = arg_326_1:GetWordFromCfg(417241075)
				local var_329_8 = arg_326_1:FormatText(var_329_7.content)

				arg_326_1.text_.text = var_329_8

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_10 = 25 <= 0 and var_329_6 or var_329_6 * (utf8.len(var_329_8) / 25)

				if (25 <= 0 and var_329_6 or var_329_6 * (utf8.len(var_329_8) / 25)) > 0 and var_329_6 < var_329_10 then
					arg_326_1.talkMaxDuration = var_329_10

					if var_329_10 + var_329_5 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_10 + var_329_5
					end
				end

				arg_326_1.text_.text = var_329_8
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241075", "story_v_out_417241.awb") ~= 0 then
					local var_329_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241075", "story_v_out_417241.awb") / 1000

					if var_329_11 + var_329_5 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_11 + var_329_5
					end

					if var_329_7.prefab_name ~= "" and arg_326_1.actors_[var_329_7.prefab_name] ~= nil then
						local var_329_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_7.prefab_name].transform, "story_v_out_417241", "417241075", "story_v_out_417241.awb")

						arg_326_1:RecordAudio("417241075", var_329_12)
						arg_326_1:RecordAudio("417241075", var_329_12)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_417241", "417241075", "story_v_out_417241.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_417241", "417241075", "story_v_out_417241.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_13 = math.max(var_329_6, arg_326_1.talkMaxDuration)

			if var_329_5 <= arg_326_1.time_ and arg_326_1.time_ < var_329_5 + var_329_13 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_5) / var_329_13

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_5 + var_329_13 and arg_326_1.time_ < var_329_5 + var_329_13 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play417241076 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 417241076
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play417241077(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["10128"]) and arg_330_1.var_.actorSpriteComps10128 == nil then
				arg_330_1.var_.actorSpriteComps10128 = arg_330_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_0 = 0.2

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["10128"]) then
				if arg_330_1.var_.actorSpriteComps10128 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								iter_333_1.color = Color.New(Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor2.r, (arg_330_1.time_ - 0) / var_333_0), Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor2.g, (arg_330_1.time_ - 0) / var_333_0), (Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor2.b, (arg_330_1.time_ - 0) / var_333_0)))
							else
								local var_333_1 = Mathf.Lerp(iter_333_1.color.r, 0.5, (arg_330_1.time_ - 0) / var_333_0)

								iter_333_1.color = Color.New(var_333_1, var_333_1, var_333_1)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["10128"]) and arg_330_1.var_.actorSpriteComps10128 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_333_3 then
						iter_333_3.color = arg_330_1.isInRecall_ and (arg_330_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_330_1.var_.actorSpriteComps10128 = nil
			end

			local var_333_2 = arg_330_1.actors_["10115"].transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos10115 = var_333_2.localPosition
				var_333_2.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("10115", 7)

				for iter_333_4 = 0, var_333_2.childCount - 1 do
					local var_333_3 = var_333_2:GetChild(iter_333_4)

					if var_333_3.name == "" or not string.find(var_333_3.name, "split") then
						var_333_3.gameObject:SetActive(true)
					else
						var_333_3.gameObject:SetActive(false)
					end
				end
			end

			local var_333_4 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				var_333_2.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_330_1.time_ - 0) / var_333_4)
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				var_333_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_333_5 = arg_330_1.actors_["10128"].transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos10128 = var_333_5.localPosition
				var_333_5.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("10128", 7)

				for iter_333_5 = 0, var_333_5.childCount - 1 do
					local var_333_6 = var_333_5:GetChild(iter_333_5)

					if var_333_6.name == "" or not string.find(var_333_6.name, "split") then
						var_333_6.gameObject:SetActive(true)
					else
						var_333_6.gameObject:SetActive(false)
					end
				end
			end

			local var_333_7 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 then
				var_333_5.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_330_1.time_ - 0) / var_333_7)
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 then
				var_333_5.localPosition = Vector3.New(0, -2000, -300)
			end

			if 1 < arg_330_1.time_ and arg_330_1.time_ <= 1 + arg_333_0 then
				arg_330_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_ui", "")
			end

			local var_333_9 = 0
			local var_333_10 = 1.3

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_9 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_11 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(417241076).content)

				arg_330_1.text_.text = var_333_11

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_13 = 52 <= 0 and var_333_10 or var_333_10 * (utf8.len(var_333_11) / 52)

				if (52 <= 0 and var_333_10 or var_333_10 * (utf8.len(var_333_11) / 52)) > 0 and var_333_10 < var_333_13 then
					arg_330_1.talkMaxDuration = var_333_13

					if var_333_13 + var_333_9 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_13 + var_333_9
					end
				end

				arg_330_1.text_.text = var_333_11
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_14 = math.max(var_333_10, arg_330_1.talkMaxDuration)

			if var_333_9 <= arg_330_1.time_ and arg_330_1.time_ < var_333_9 + var_333_14 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_9) / var_333_14

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_9 + var_333_14 and arg_330_1.time_ < var_333_9 + var_333_14 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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

		arg_330_1:InitPlayNodeList()
	end,
	Play417241077 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 417241077
		arg_334_1.duration_ = 4.83

		local var_334_0 = {
			zh = 2.7,
			ja = 4.833
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
				arg_334_0:Play417241078(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.35

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_1 = arg_334_1:GetWordFromCfg(417241077)
				local var_337_2 = arg_334_1:FormatText(var_337_1.content)

				arg_334_1.text_.text = var_337_2

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 14 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 14)

				if (14 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 14)) > 0 and var_337_0 < var_337_4 then
					arg_334_1.talkMaxDuration = var_337_4

					if var_337_4 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_4 + 0
					end
				end

				arg_334_1.text_.text = var_337_2
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241077", "story_v_out_417241.awb") ~= 0 then
					local var_337_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241077", "story_v_out_417241.awb") / 1000

					if var_337_5 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + 0
					end

					if var_337_1.prefab_name ~= "" and arg_334_1.actors_[var_337_1.prefab_name] ~= nil then
						local var_337_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_1.prefab_name].transform, "story_v_out_417241", "417241077", "story_v_out_417241.awb")

						arg_334_1:RecordAudio("417241077", var_337_6)
						arg_334_1:RecordAudio("417241077", var_337_6)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_417241", "417241077", "story_v_out_417241.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_417241", "417241077", "story_v_out_417241.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_7 and arg_334_1.time_ < 0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play417241078 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 417241078
		arg_338_1.duration_ = 9

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play417241079(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 3.999999999999 < arg_338_1.time_ and arg_338_1.time_ <= 3.999999999999 + arg_341_0 then
				arg_338_1.allBtn_.enabled = false
			end

			if arg_338_1.time_ >= 3.999999999999 + 0.3 and arg_338_1.time_ < 3.999999999999 + 0.3 + arg_341_0 then
				arg_338_1.allBtn_.enabled = true
			end

			if 2 < arg_338_1.time_ and arg_338_1.time_ <= 2 + arg_341_0 then
				local var_341_0 = arg_338_1.bgs_.ST73

				arg_338_1.bgs_.ST73.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_341_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_341_1 = var_341_0:GetComponent("SpriteRenderer")

				if var_341_1 and var_341_1.sprite then
					local var_341_2 = 2 * (var_341_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_341_0.transform.localScale = Vector3.New(var_341_2 / var_341_1.sprite.bounds.size.y < var_341_2 * manager.ui.mainCameraCom_.aspect / var_341_1.sprite.bounds.size.x and var_341_2 * manager.ui.mainCameraCom_.aspect / var_341_1.sprite.bounds.size.x or var_341_2 / var_341_1.sprite.bounds.size.y, var_341_2 / var_341_1.sprite.bounds.size.y < var_341_2 * manager.ui.mainCameraCom_.aspect / var_341_1.sprite.bounds.size.x and var_341_2 * manager.ui.mainCameraCom_.aspect / var_341_1.sprite.bounds.size.x or var_341_2 / var_341_1.sprite.bounds.size.y, 0)
				end

				for iter_341_0, iter_341_1 in pairs(arg_338_1.bgs_) do
					if iter_341_0 ~= "ST73" then
						iter_341_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_341_3 = 0

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_3 + arg_341_0 then
				arg_338_1.mask_.enabled = true
				arg_338_1.mask_.raycastTarget = true

				arg_338_1:SetGaussion(false)
			end

			local var_341_4 = 2

			if var_341_3 <= arg_338_1.time_ and arg_338_1.time_ < var_341_3 + var_341_4 then
				local var_341_5 = Color.New(0, 0, 0)

				var_341_5.a = Mathf.Lerp(0, 1, (arg_338_1.time_ - var_341_3) / var_341_4)
				arg_338_1.mask_.color = var_341_5
			end

			if arg_338_1.time_ >= var_341_3 + var_341_4 and arg_338_1.time_ < var_341_3 + var_341_4 + arg_341_0 then
				local var_341_6 = Color.New(0, 0, 0)

				var_341_6.a = 1
				arg_338_1.mask_.color = var_341_6
			end

			local var_341_7 = 2

			if 2 < arg_338_1.time_ and arg_338_1.time_ <= var_341_7 + arg_341_0 then
				arg_338_1.mask_.enabled = true
				arg_338_1.mask_.raycastTarget = true

				arg_338_1:SetGaussion(false)
			end

			local var_341_8 = 2

			if var_341_7 <= arg_338_1.time_ and arg_338_1.time_ < var_341_7 + var_341_8 then
				local var_341_9 = Color.New(0, 0, 0)

				var_341_9.a = Mathf.Lerp(1, 0, (arg_338_1.time_ - var_341_7) / var_341_8)
				arg_338_1.mask_.color = var_341_9
			end

			if arg_338_1.time_ >= var_341_7 + var_341_8 and arg_338_1.time_ < var_341_7 + var_341_8 + arg_341_0 then
				local var_341_10 = Color.New(0, 0, 0)

				arg_338_1.mask_.enabled = false
				var_341_10.a = 0
				arg_338_1.mask_.color = var_341_10
			end

			if 0.9 < arg_338_1.time_ and arg_338_1.time_ <= 0.9 + arg_341_0 then
				arg_338_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 1.63333333333333 < arg_338_1.time_ and arg_338_1.time_ <= 1.63333333333333 + arg_341_0 then
				arg_338_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_riot", "")
			end

			if arg_338_1.frameCnt_ <= 1 then
				arg_338_1.dialog_:SetActive(false)
			end

			local var_341_13 = 3.999999999999
			local var_341_14 = 1.6

			if 3.999999999999 < arg_338_1.time_ and arg_338_1.time_ <= var_341_13 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0

				arg_338_1.dialog_:SetActive(true)

				arg_338_1.dialogCg_.alpha = 0

				local var_341_15 = LeanTween.value(arg_338_1.dialog_, 0, 1, 0.3)

				var_341_15:setOnUpdate(LuaHelper.FloatAction(function(arg_342_0)
					arg_338_1.dialogCg_.alpha = arg_342_0
				end))
				var_341_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_338_1.dialog_)
					var_341_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_338_1.duration_ = arg_338_1.duration_ + 0.3

				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_16 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(417241078).content)

				arg_338_1.text_.text = var_341_16

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_18 = 64 <= 0 and var_341_14 or var_341_14 * (utf8.len(var_341_16) / 64)

				if (64 <= 0 and var_341_14 or var_341_14 * (utf8.len(var_341_16) / 64)) > 0 and var_341_14 < var_341_18 then
					arg_338_1.talkMaxDuration = var_341_18
					var_341_13 = var_341_13 + 0.3

					if var_341_18 + var_341_13 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_18 + var_341_13
					end
				end

				arg_338_1.text_.text = var_341_16
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_19 = var_341_13 + 0.3
			local var_341_20 = math.max(var_341_14, arg_338_1.talkMaxDuration)

			if var_341_13 + 0.3 <= arg_338_1.time_ and arg_338_1.time_ < var_341_19 + var_341_20 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_19) / var_341_20

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_19 + var_341_20 and arg_338_1.time_ < var_341_19 + var_341_20 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play417241079 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 417241079
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play417241080(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0.02 < arg_344_1.time_ and arg_344_1.time_ <= 0.02 + arg_347_0 then
				arg_344_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_beetle03", "")
			end

			local var_347_1 = 0
			local var_347_2 = 1.4

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_3 = arg_344_1:FormatText(arg_344_1:GetWordFromCfg(417241079).content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 56 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_3) / 56)

				if (56 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_3) / 56)) > 0 and var_347_2 < var_347_5 then
					arg_344_1.talkMaxDuration = var_347_5

					if var_347_5 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + var_347_1
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_6 = math.max(var_347_2, arg_344_1.talkMaxDuration)

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_6 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_1) / var_347_6

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_1 + var_347_6 and arg_344_1.time_ < var_347_1 + var_347_6 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play417241080 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 417241080
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play417241081(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0.375 < arg_348_1.time_ and arg_348_1.time_ <= 0.375 + arg_351_0 then
				arg_348_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_upload", "")
			end

			local var_351_1 = 0
			local var_351_2 = 0.375

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_3 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(417241080).content)

				arg_348_1.text_.text = var_351_3

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 15 <= 0 and var_351_2 or var_351_2 * (utf8.len(var_351_3) / 15)

				if (15 <= 0 and var_351_2 or var_351_2 * (utf8.len(var_351_3) / 15)) > 0 and var_351_2 < var_351_5 then
					arg_348_1.talkMaxDuration = var_351_5

					if var_351_5 + var_351_1 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + var_351_1
					end
				end

				arg_348_1.text_.text = var_351_3
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_6 = math.max(var_351_2, arg_348_1.talkMaxDuration)

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_6 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_1) / var_351_6

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_1 + var_351_6 and arg_348_1.time_ < var_351_1 + var_351_6 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play417241081 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 417241081
		arg_352_1.duration_ = 7

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play417241082(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 1 < arg_352_1.time_ and arg_352_1.time_ <= 1 + arg_355_0 then
				local var_355_0 = arg_352_1.bgs_.I17f

				arg_352_1.bgs_.I17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_355_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_355_1 = var_355_0:GetComponent("SpriteRenderer")

				if var_355_1 and var_355_1.sprite then
					local var_355_2 = 2 * (var_355_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_355_0.transform.localScale = Vector3.New(var_355_2 / var_355_1.sprite.bounds.size.y < var_355_2 * manager.ui.mainCameraCom_.aspect / var_355_1.sprite.bounds.size.x and var_355_2 * manager.ui.mainCameraCom_.aspect / var_355_1.sprite.bounds.size.x or var_355_2 / var_355_1.sprite.bounds.size.y, var_355_2 / var_355_1.sprite.bounds.size.y < var_355_2 * manager.ui.mainCameraCom_.aspect / var_355_1.sprite.bounds.size.x and var_355_2 * manager.ui.mainCameraCom_.aspect / var_355_1.sprite.bounds.size.x or var_355_2 / var_355_1.sprite.bounds.size.y, 0)
				end

				for iter_355_0, iter_355_1 in pairs(arg_352_1.bgs_) do
					if iter_355_0 ~= "I17f" then
						iter_355_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_355_3 = 0

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_3 + arg_355_0 then
				arg_352_1.mask_.enabled = true
				arg_352_1.mask_.raycastTarget = true

				arg_352_1:SetGaussion(false)
			end

			local var_355_4 = 1

			if var_355_3 <= arg_352_1.time_ and arg_352_1.time_ < var_355_3 + var_355_4 then
				local var_355_5 = Color.New(0, 0, 0)

				var_355_5.a = Mathf.Lerp(0, 1, (arg_352_1.time_ - var_355_3) / var_355_4)
				arg_352_1.mask_.color = var_355_5
			end

			if arg_352_1.time_ >= var_355_3 + var_355_4 and arg_352_1.time_ < var_355_3 + var_355_4 + arg_355_0 then
				local var_355_6 = Color.New(0, 0, 0)

				var_355_6.a = 1
				arg_352_1.mask_.color = var_355_6
			end

			local var_355_7 = 1

			if 1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_7 + arg_355_0 then
				arg_352_1.mask_.enabled = true
				arg_352_1.mask_.raycastTarget = true

				arg_352_1:SetGaussion(false)
			end

			local var_355_8 = 1

			if var_355_7 <= arg_352_1.time_ and arg_352_1.time_ < var_355_7 + var_355_8 then
				local var_355_9 = Color.New(0, 0, 0)

				var_355_9.a = Mathf.Lerp(1, 0, (arg_352_1.time_ - var_355_7) / var_355_8)
				arg_352_1.mask_.color = var_355_9
			end

			if arg_352_1.time_ >= var_355_7 + var_355_8 and arg_352_1.time_ < var_355_7 + var_355_8 + arg_355_0 then
				local var_355_10 = Color.New(0, 0, 0)

				arg_352_1.mask_.enabled = false
				var_355_10.a = 0
				arg_352_1.mask_.color = var_355_10
			end

			if 2 < arg_352_1.time_ and arg_352_1.time_ <= 2 + arg_355_0 then
				arg_352_1:AudioAction("play", "effect", "se_story_11", "se_story_11_microphone", "")
			end

			if 0.02 < arg_352_1.time_ and arg_352_1.time_ <= 0.02 + arg_355_0 then
				arg_352_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_riot", "")
			end

			if 0.833333333333333 < arg_352_1.time_ and arg_352_1.time_ <= 0.833333333333333 + arg_355_0 then
				arg_352_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_352_1.frameCnt_ <= 1 then
				arg_352_1.dialog_:SetActive(false)
			end

			local var_355_14 = 2
			local var_355_15 = 0.05

			if 2 < arg_352_1.time_ and arg_352_1.time_ <= var_355_14 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0

				arg_352_1.dialog_:SetActive(true)

				arg_352_1.dialogCg_.alpha = 0

				local var_355_16 = LeanTween.value(arg_352_1.dialog_, 0, 1, 0.3)

				var_355_16:setOnUpdate(LuaHelper.FloatAction(function(arg_356_0)
					arg_352_1.dialogCg_.alpha = arg_356_0
				end))
				var_355_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_352_1.dialog_)
					var_355_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_352_1.duration_ = arg_352_1.duration_ + 0.3

				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_17 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(417241081).content)

				arg_352_1.text_.text = var_355_17

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_19 = 2 <= 0 and var_355_15 or var_355_15 * (utf8.len(var_355_17) / 2)

				if (2 <= 0 and var_355_15 or var_355_15 * (utf8.len(var_355_17) / 2)) > 0 and var_355_15 < var_355_19 then
					arg_352_1.talkMaxDuration = var_355_19
					var_355_14 = var_355_14 + 0.3

					if var_355_19 + var_355_14 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_19 + var_355_14
					end
				end

				arg_352_1.text_.text = var_355_17
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_20 = var_355_14 + 0.3
			local var_355_21 = math.max(var_355_15, arg_352_1.talkMaxDuration)

			if var_355_14 + 0.3 <= arg_352_1.time_ and arg_352_1.time_ < var_355_20 + var_355_21 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_20) / var_355_21

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_20 + var_355_21 and arg_352_1.time_ < var_355_20 + var_355_21 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play417241082 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 417241082
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play417241083(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 1.525

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_1 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(417241082).content)

				arg_358_1.text_.text = var_361_1

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_3 = 61 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 61)

				if (61 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 61)) > 0 and var_361_0 < var_361_3 then
					arg_358_1.talkMaxDuration = var_361_3

					if var_361_3 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_3 + 0
					end
				end

				arg_358_1.text_.text = var_361_1
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_4 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_4

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play417241083 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 417241083
		arg_362_1.duration_ = 1.87

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play417241084(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.fswbg_:SetActive(true)
				arg_362_1.dialog_:SetActive(false)

				arg_362_1.fswtw_.percent = 0
				arg_362_1.fswt_.text = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(417241083).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.fswt_)

				arg_362_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_362_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_362_1.fswtw_:SetDirty()

				arg_362_1.typewritterCharCountI18N = 0

				SetActive(arg_362_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_362_1:ShowNextGo(false)
			end

			local var_365_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.var_.oldValueTypewriter = arg_362_1.fswtw_.percent

				SetActive(arg_362_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_362_1:ShowNextGo(false)
			end

			local var_365_1 = 9
			local var_365_2 = 0.6
			local var_365_3, var_365_4 = arg_362_1:GetPercentByPara(arg_362_1:FormatText(arg_362_1:GetWordFromCfg(417241083).content), 1)

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0

				local var_365_5 = var_365_1 <= 0 and var_365_2 or var_365_2 * ((var_365_4 - arg_362_1.typewritterCharCountI18N) / var_365_1)

				if (var_365_1 <= 0 and var_365_2 or var_365_2 * ((var_365_4 - arg_362_1.typewritterCharCountI18N) / var_365_1)) > 0 and var_365_2 < var_365_5 then
					arg_362_1.talkMaxDuration = var_365_5

					if var_365_5 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + var_365_0
					end
				end
			end

			local var_365_6 = math.max(0.6, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_6 then
				arg_362_1.fswtw_.percent = Mathf.Lerp(arg_362_1.var_.oldValueTypewriter, var_365_3, (arg_362_1.time_ - var_365_0) / var_365_6)
				arg_362_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_362_1.fswtw_:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_6 and arg_362_1.time_ < var_365_0 + var_365_6 + arg_365_0 then
				arg_362_1.fswtw_.percent = var_365_3

				arg_362_1.fswtw_:SetDirty()
				arg_362_1:ShowNextGo(true)

				arg_362_1.typewritterCharCountI18N = var_365_4
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				local var_365_7 = arg_362_1.fswbg_.transform:Find("textbox/adapt/content") or arg_362_1.fswbg_.transform:Find("textbox/content")
				local var_365_8 = arg_362_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_365_9 = var_365_7:GetComponent("RectTransform")

				var_365_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleLeft
				var_365_9.offsetMin = Vector2.New(0, 0)
				var_365_9.offsetMax = Vector2.New(0, 0)
			end

			local var_365_10 = 0.0999999999999999
			local var_365_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241083", "story_v_out_417241.awb") / 1000

			if var_365_11 > 0 and 1.766 < var_365_11 and var_365_11 + var_365_10 > arg_362_1.duration_ then
				arg_362_1.duration_ = var_365_11 + var_365_10
			end

			if var_365_10 < arg_362_1.time_ and arg_362_1.time_ <= var_365_10 + arg_365_0 then
				arg_362_1:AudioAction("play", "voice", "story_v_out_417241", "417241083", "story_v_out_417241.awb")
			end

			local var_365_13 = arg_362_1.actors_["10831"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				local var_365_14 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_365_14 then
					var_365_14.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_365_14.radialBlurScale = 0
					var_365_14.radialBlurGradient = 1
					var_365_14.radialBlurIntensity = 1

					if var_365_13 then
						var_365_14.radialBlurTarget = var_365_13.transform
					end
				end
			end

			local var_365_15 = 1

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_15 then
				local var_365_16 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_365_16 then
					var_365_16.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_365_16.radialBlurScale = Mathf.Lerp(0, 0, (arg_362_1.time_ - 0) / var_365_15)
					var_365_16.radialBlurGradient = Mathf.Lerp(1, 1, (arg_362_1.time_ - 0) / var_365_15)
					var_365_16.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_362_1.time_ - 0) / var_365_15)
				end
			end

			if arg_362_1.time_ >= 0 + var_365_15 and arg_362_1.time_ < 0 + var_365_15 + arg_365_0 then
				local var_365_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_365_17 then
					var_365_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_365_17.radialBlurScale = 0
					var_365_17.radialBlurGradient = 1
					var_365_17.radialBlurIntensity = 1
				end
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play417241084 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 417241084
		arg_366_1.duration_ = 9.1

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play417241085(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.oldValueTypewriter = arg_366_1.fswtw_.percent

				SetActive(arg_366_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_366_1:ShowNextGo(false)
			end

			local var_369_0 = 31
			local var_369_1 = 2.06666666666667
			local var_369_2, var_369_3 = arg_366_1:GetPercentByPara(arg_366_1:FormatText(arg_366_1:GetWordFromCfg(417241083).content), 2)

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0

				local var_369_4 = var_369_0 <= 0 and var_369_1 or var_369_1 * ((var_369_3 - arg_366_1.typewritterCharCountI18N) / var_369_0)

				if (var_369_0 <= 0 and var_369_1 or var_369_1 * ((var_369_3 - arg_366_1.typewritterCharCountI18N) / var_369_0)) > 0 and var_369_1 < var_369_4 then
					arg_366_1.talkMaxDuration = var_369_4

					if var_369_4 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_4 + 0
					end
				end
			end

			local var_369_5 = math.max(2.06666666666667, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_5 then
				arg_366_1.fswtw_.percent = Mathf.Lerp(arg_366_1.var_.oldValueTypewriter, var_369_2, (arg_366_1.time_ - 0) / var_369_5)
				arg_366_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_366_1.fswtw_:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_5 and arg_366_1.time_ < 0 + var_369_5 + arg_369_0 then
				arg_366_1.fswtw_.percent = var_369_2

				arg_366_1.fswtw_:SetDirty()
				arg_366_1:ShowNextGo(true)

				arg_366_1.typewritterCharCountI18N = var_369_3
			end

			local var_369_6 = 0
			local var_369_7 = manager.audio:GetVoiceLength("story_v_out_417241", "417241084", "story_v_out_417241.awb") / 1000

			if var_369_7 > 0 and 9.1 < var_369_7 and var_369_7 + var_369_6 > arg_366_1.duration_ then
				arg_366_1.duration_ = var_369_7 + var_369_6
			end

			if var_369_6 < arg_366_1.time_ and arg_366_1.time_ <= var_369_6 + arg_369_0 then
				arg_366_1:AudioAction("play", "voice", "story_v_out_417241", "417241084", "story_v_out_417241.awb")
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play417241085 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 417241085
		arg_370_1.duration_ = 3.47

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play417241086(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.oldValueTypewriter = arg_370_1.fswtw_.percent

				SetActive(arg_370_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_370_1:ShowNextGo(false)
			end

			local var_373_0 = 12
			local var_373_1 = 0.8
			local var_373_2, var_373_3 = arg_370_1:GetPercentByPara(arg_370_1:FormatText(arg_370_1:GetWordFromCfg(417241083).content), 3)

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0

				local var_373_4 = var_373_0 <= 0 and var_373_1 or var_373_1 * ((var_373_3 - arg_370_1.typewritterCharCountI18N) / var_373_0)

				if (var_373_0 <= 0 and var_373_1 or var_373_1 * ((var_373_3 - arg_370_1.typewritterCharCountI18N) / var_373_0)) > 0 and var_373_1 < var_373_4 then
					arg_370_1.talkMaxDuration = var_373_4

					if var_373_4 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_4 + 0
					end
				end
			end

			local var_373_5 = math.max(0.8, arg_370_1.talkMaxDuration)

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_5 then
				arg_370_1.fswtw_.percent = Mathf.Lerp(arg_370_1.var_.oldValueTypewriter, var_373_2, (arg_370_1.time_ - 0) / var_373_5)
				arg_370_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_370_1.fswtw_:SetDirty()
			end

			if arg_370_1.time_ >= 0 + var_373_5 and arg_370_1.time_ < 0 + var_373_5 + arg_373_0 then
				arg_370_1.fswtw_.percent = var_373_2

				arg_370_1.fswtw_:SetDirty()
				arg_370_1:ShowNextGo(true)

				arg_370_1.typewritterCharCountI18N = var_373_3
			end

			local var_373_6 = 0
			local var_373_7 = manager.audio:GetVoiceLength("story_v_out_417241", "417241085", "story_v_out_417241.awb") / 1000

			if var_373_7 > 0 and 1.3 < var_373_7 and var_373_7 + var_373_6 > arg_370_1.duration_ then
				arg_370_1.duration_ = var_373_7 + var_373_6
			end

			if var_373_6 < arg_370_1.time_ and arg_370_1.time_ <= var_373_6 + arg_373_0 then
				arg_370_1:AudioAction("play", "voice", "story_v_out_417241", "417241085", "story_v_out_417241.awb")
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play417241086 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 417241086
		arg_374_1.duration_ = 12.83

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play417241087(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.oldValueTypewriter = arg_374_1.fswtw_.percent

				SetActive(arg_374_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_374_1:ShowNextGo(false)
			end

			local var_377_0 = 47
			local var_377_1 = 3.13333333333333
			local var_377_2, var_377_3 = arg_374_1:GetPercentByPara(arg_374_1:FormatText(arg_374_1:GetWordFromCfg(417241083).content), 4)

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0

				local var_377_4 = var_377_0 <= 0 and var_377_1 or var_377_1 * ((var_377_3 - arg_374_1.typewritterCharCountI18N) / var_377_0)

				if (var_377_0 <= 0 and var_377_1 or var_377_1 * ((var_377_3 - arg_374_1.typewritterCharCountI18N) / var_377_0)) > 0 and var_377_1 < var_377_4 then
					arg_374_1.talkMaxDuration = var_377_4

					if var_377_4 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_4 + 0
					end
				end
			end

			local var_377_5 = math.max(3.13333333333333, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_5 then
				arg_374_1.fswtw_.percent = Mathf.Lerp(arg_374_1.var_.oldValueTypewriter, var_377_2, (arg_374_1.time_ - 0) / var_377_5)
				arg_374_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_374_1.fswtw_:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_5 and arg_374_1.time_ < 0 + var_377_5 + arg_377_0 then
				arg_374_1.fswtw_.percent = var_377_2

				arg_374_1.fswtw_:SetDirty()
				arg_374_1:ShowNextGo(true)

				arg_374_1.typewritterCharCountI18N = var_377_3
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:AudioAction("play", "music", "story_v_out_417241", "417241086", "story_v_out_417241.awb")

				local var_377_8 = manager.audio:GetAudioName("story_v_out_417241", "417241086")

				if "" ~= "" then
					if arg_374_1.bgmTxt_.text ~= var_377_8 and arg_374_1.bgmTxt_.text ~= "" then
						if arg_374_1.bgmTxt2_.text ~= "" then
							arg_374_1.bgmTxt_.text = arg_374_1.bgmTxt2_.text
						end

						arg_374_1.bgmTxt2_.text = var_377_8

						arg_374_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_374_1.bgmTxt_.text = var_377_8
						arg_374_1.bgmTxt2_.text = var_377_8
					end

					if arg_374_1.bgmTimer then
						arg_374_1.bgmTimer:Stop()

						arg_374_1.bgmTimer = nil
					end

					if arg_374_1.settingData.show_music_name == 1 then
						arg_374_1.musicController:SetSelectedState("show")
						arg_374_1.musicAnimator_:Play("open", 0, 0)

						if arg_374_1.settingData.music_time ~= 0 then
							arg_374_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_374_1.settingData.music_time), function()
								if arg_374_1 == nil or isNil(arg_374_1.bgmTxt_) then
									return
								end

								arg_374_1.musicController:SetSelectedState("hide")
								arg_374_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play417241087 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 417241087
		arg_379_1.duration_ = 2.17

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play417241088(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.oldValueTypewriter = arg_379_1.fswtw_.percent

				SetActive(arg_379_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_379_1:ShowNextGo(false)
			end

			local var_382_0 = 0
			local var_382_1 = 0.8
			local var_382_2, var_382_3 = arg_379_1:GetPercentByPara(arg_379_1:FormatText(arg_379_1:GetWordFromCfg(417241083).content), 4)

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0

				local var_382_4 = var_382_0 <= 0 and var_382_1 or var_382_1 * ((var_382_3 - arg_379_1.typewritterCharCountI18N) / var_382_0)

				if (var_382_0 <= 0 and var_382_1 or var_382_1 * ((var_382_3 - arg_379_1.typewritterCharCountI18N) / var_382_0)) > 0 and var_382_1 < var_382_4 then
					arg_379_1.talkMaxDuration = var_382_4

					if var_382_4 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_4 + 0
					end
				end
			end

			local var_382_5 = math.max(0.8, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_5 then
				arg_379_1.fswtw_.percent = Mathf.Lerp(arg_379_1.var_.oldValueTypewriter, var_382_2, (arg_379_1.time_ - 0) / var_382_5)
				arg_379_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_379_1.fswtw_:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_5 and arg_379_1.time_ < 0 + var_382_5 + arg_382_0 then
				arg_379_1.fswtw_.percent = var_382_2

				arg_379_1.fswtw_:SetDirty()
				arg_379_1:ShowNextGo(true)

				arg_379_1.typewritterCharCountI18N = var_382_3
			end

			local var_382_6 = 0
			local var_382_7 = manager.audio:GetVoiceLength("story_v_out_417241", "417241087", "story_v_out_417241.awb") / 1000

			if var_382_7 > 0 and 2.166 < var_382_7 and var_382_7 + var_382_6 > arg_379_1.duration_ then
				arg_379_1.duration_ = var_382_7 + var_382_6
			end

			if var_382_6 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1:AudioAction("play", "voice", "story_v_out_417241", "417241087", "story_v_out_417241.awb")
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play417241088 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 417241088
		arg_383_1.duration_ = 3.2

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play417241089(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.oldValueTypewriter = arg_383_1.fswtw_.percent

				SetActive(arg_383_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_383_1:ShowNextGo(false)
			end

			local var_386_0 = 27
			local var_386_1 = 1.8
			local var_386_2, var_386_3 = arg_383_1:GetPercentByPara(arg_383_1:FormatText(arg_383_1:GetWordFromCfg(417241083).content), 5)

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				local var_386_4 = var_386_0 <= 0 and var_386_1 or var_386_1 * ((var_386_3 - arg_383_1.typewritterCharCountI18N) / var_386_0)

				if (var_386_0 <= 0 and var_386_1 or var_386_1 * ((var_386_3 - arg_383_1.typewritterCharCountI18N) / var_386_0)) > 0 and var_386_1 < var_386_4 then
					arg_383_1.talkMaxDuration = var_386_4

					if var_386_4 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_4 + 0
					end
				end
			end

			local var_386_5 = math.max(1.8, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_5 then
				arg_383_1.fswtw_.percent = Mathf.Lerp(arg_383_1.var_.oldValueTypewriter, var_386_2, (arg_383_1.time_ - 0) / var_386_5)
				arg_383_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_383_1.fswtw_:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_5 and arg_383_1.time_ < 0 + var_386_5 + arg_386_0 then
				arg_383_1.fswtw_.percent = var_386_2

				arg_383_1.fswtw_:SetDirty()
				arg_383_1:ShowNextGo(true)

				arg_383_1.typewritterCharCountI18N = var_386_3
			end

			local var_386_6 = 0
			local var_386_7 = manager.audio:GetVoiceLength("story_v_out_417241", "417241088", "story_v_out_417241.awb") / 1000

			if var_386_7 > 0 and 3.2 < var_386_7 and var_386_7 + var_386_6 > arg_383_1.duration_ then
				arg_383_1.duration_ = var_386_7 + var_386_6
			end

			if var_386_6 < arg_383_1.time_ and arg_383_1.time_ <= var_386_6 + arg_386_0 then
				arg_383_1:AudioAction("play", "voice", "story_v_out_417241", "417241088", "story_v_out_417241.awb")
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play417241089 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 417241089
		arg_387_1.duration_ = 15.17

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play417241090(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.oldValueTypewriter = arg_387_1.fswtw_.percent

				SetActive(arg_387_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_387_1:ShowNextGo(false)
			end

			local var_390_0 = 48
			local var_390_1 = 3.2
			local var_390_2, var_390_3 = arg_387_1:GetPercentByPara(arg_387_1:FormatText(arg_387_1:GetWordFromCfg(417241083).content), 6)

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0

				local var_390_4 = var_390_0 <= 0 and var_390_1 or var_390_1 * ((var_390_3 - arg_387_1.typewritterCharCountI18N) / var_390_0)

				if (var_390_0 <= 0 and var_390_1 or var_390_1 * ((var_390_3 - arg_387_1.typewritterCharCountI18N) / var_390_0)) > 0 and var_390_1 < var_390_4 then
					arg_387_1.talkMaxDuration = var_390_4

					if var_390_4 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_4 + 0
					end
				end
			end

			local var_390_5 = math.max(3.2, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_5 then
				arg_387_1.fswtw_.percent = Mathf.Lerp(arg_387_1.var_.oldValueTypewriter, var_390_2, (arg_387_1.time_ - 0) / var_390_5)
				arg_387_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_387_1.fswtw_:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_5 and arg_387_1.time_ < 0 + var_390_5 + arg_390_0 then
				arg_387_1.fswtw_.percent = var_390_2

				arg_387_1.fswtw_:SetDirty()
				arg_387_1:ShowNextGo(true)

				arg_387_1.typewritterCharCountI18N = var_390_3
			end

			local var_390_6 = 0
			local var_390_7 = manager.audio:GetVoiceLength("story_v_out_417241", "417241089", "story_v_out_417241.awb") / 1000

			if var_390_7 > 0 and 15.166 < var_390_7 and var_390_7 + var_390_6 > arg_387_1.duration_ then
				arg_387_1.duration_ = var_390_7 + var_390_6
			end

			if var_390_6 < arg_387_1.time_ and arg_387_1.time_ <= var_390_6 + arg_390_0 then
				arg_387_1:AudioAction("play", "voice", "story_v_out_417241", "417241089", "story_v_out_417241.awb")
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play417241090 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 417241090
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play417241091(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.fswbg_:SetActive(false)
				arg_391_1.dialog_:SetActive(false)
				SetActive(arg_391_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_391_1:ShowNextGo(false)
			end

			local var_394_0 = arg_391_1.actors_["10831"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				local var_394_1 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_394_1 then
					var_394_1.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_394_1.radialBlurScale = 0
					var_394_1.radialBlurGradient = 1
					var_394_1.radialBlurIntensity = 1

					if var_394_0 then
						var_394_1.radialBlurTarget = var_394_0.transform
					end
				end
			end

			local var_394_2 = 0.0166666666666667

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_2 then
				local var_394_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_394_3 then
					var_394_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_394_3.radialBlurScale = Mathf.Lerp(0, 0, (arg_391_1.time_ - 0) / var_394_2)
					var_394_3.radialBlurGradient = Mathf.Lerp(1, 1, (arg_391_1.time_ - 0) / var_394_2)
					var_394_3.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_391_1.time_ - 0) / var_394_2)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_2 and arg_391_1.time_ < 0 + var_394_2 + arg_394_0 then
				local var_394_4 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_394_4 then
					var_394_4.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_394_4.radialBlurScale = 0
					var_394_4.radialBlurGradient = 1
					var_394_4.radialBlurIntensity = 1
				end
			end

			local var_394_5 = 0
			local var_394_6 = 1.15

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_5 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_7 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(417241090).content)

				arg_391_1.text_.text = var_394_7

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_9 = 46 <= 0 and var_394_6 or var_394_6 * (utf8.len(var_394_7) / 46)

				if (46 <= 0 and var_394_6 or var_394_6 * (utf8.len(var_394_7) / 46)) > 0 and var_394_6 < var_394_9 then
					arg_391_1.talkMaxDuration = var_394_9

					if var_394_9 + var_394_5 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_9 + var_394_5
					end
				end

				arg_391_1.text_.text = var_394_7
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_6, arg_391_1.talkMaxDuration)

			if var_394_5 <= arg_391_1.time_ and arg_391_1.time_ < var_394_5 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_5) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_5 + var_394_10 and arg_391_1.time_ < var_394_5 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play417241091 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 417241091
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play417241092(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0.65

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_1 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(417241091).content)

				arg_395_1.text_.text = var_398_1

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_3 = 26 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 26)

				if (26 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 26)) > 0 and var_398_0 < var_398_3 then
					arg_395_1.talkMaxDuration = var_398_3

					if var_398_3 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_3 + 0
					end
				end

				arg_395_1.text_.text = var_398_1
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_4 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_4 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_4

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_4 and arg_395_1.time_ < 0 + var_398_4 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play417241092 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 417241092
		arg_399_1.duration_ = 5.67

		local var_399_0 = {
			zh = 2.6,
			ja = 5.666
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play417241093(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["10115"]) and arg_399_1.var_.actorSpriteComps10115 == nil then
				arg_399_1.var_.actorSpriteComps10115 = arg_399_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_0 = 0.2

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["10115"]) then
				if arg_399_1.var_.actorSpriteComps10115 then
					for iter_402_0, iter_402_1 in pairs(arg_399_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_402_1 then
							if arg_399_1.isInRecall_ then
								iter_402_1.color = Color.New(Mathf.Lerp(iter_402_1.color.r, arg_399_1.hightColor1.r, (arg_399_1.time_ - 0) / var_402_0), Mathf.Lerp(iter_402_1.color.g, arg_399_1.hightColor1.g, (arg_399_1.time_ - 0) / var_402_0), (Mathf.Lerp(iter_402_1.color.b, arg_399_1.hightColor1.b, (arg_399_1.time_ - 0) / var_402_0)))
							else
								local var_402_1 = Mathf.Lerp(iter_402_1.color.r, 1, (arg_399_1.time_ - 0) / var_402_0)

								iter_402_1.color = Color.New(var_402_1, var_402_1, var_402_1)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["10115"]) and arg_399_1.var_.actorSpriteComps10115 then
				for iter_402_2, iter_402_3 in pairs(arg_399_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_402_3 then
						iter_402_3.color = arg_399_1.isInRecall_ and (arg_399_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_399_1.var_.actorSpriteComps10115 = nil
			end

			local var_402_2 = arg_399_1.actors_["10115"].transform

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos10115 = var_402_2.localPosition
				var_402_2.localScale = Vector3.New(1, 1, 1)

				arg_399_1:CheckSpriteTmpPos("10115", 3)

				for iter_402_4 = 0, var_402_2.childCount - 1 do
					local var_402_3 = var_402_2:GetChild(iter_402_4)

					if var_402_3.name == "" or not string.find(var_402_3.name, "split") then
						var_402_3.gameObject:SetActive(true)
					else
						var_402_3.gameObject:SetActive(false)
					end
				end
			end

			local var_402_4 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				var_402_2.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_399_1.time_ - 0) / var_402_4)
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				var_402_2.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_402_5 = 0
			local var_402_6 = 0.3

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_5 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_7 = arg_399_1:GetWordFromCfg(417241092)
				local var_402_8 = arg_399_1:FormatText(var_402_7.content)

				arg_399_1.text_.text = var_402_8

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_10 = 12 <= 0 and var_402_6 or var_402_6 * (utf8.len(var_402_8) / 12)

				if (12 <= 0 and var_402_6 or var_402_6 * (utf8.len(var_402_8) / 12)) > 0 and var_402_6 < var_402_10 then
					arg_399_1.talkMaxDuration = var_402_10

					if var_402_10 + var_402_5 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_10 + var_402_5
					end
				end

				arg_399_1.text_.text = var_402_8
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241092", "story_v_out_417241.awb") ~= 0 then
					local var_402_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241092", "story_v_out_417241.awb") / 1000

					if var_402_11 + var_402_5 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_11 + var_402_5
					end

					if var_402_7.prefab_name ~= "" and arg_399_1.actors_[var_402_7.prefab_name] ~= nil then
						local var_402_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_7.prefab_name].transform, "story_v_out_417241", "417241092", "story_v_out_417241.awb")

						arg_399_1:RecordAudio("417241092", var_402_12)
						arg_399_1:RecordAudio("417241092", var_402_12)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_417241", "417241092", "story_v_out_417241.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_417241", "417241092", "story_v_out_417241.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_13 = math.max(var_402_6, arg_399_1.talkMaxDuration)

			if var_402_5 <= arg_399_1.time_ and arg_399_1.time_ < var_402_5 + var_402_13 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_5) / var_402_13

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_5 + var_402_13 and arg_399_1.time_ < var_402_5 + var_402_13 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play417241093 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 417241093
		arg_403_1.duration_ = 5.9

		local var_403_0 = {
			zh = 2.866,
			ja = 5.9
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play417241094(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["10128"]) and arg_403_1.var_.actorSpriteComps10128 == nil then
				arg_403_1.var_.actorSpriteComps10128 = arg_403_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_0 = 0.2

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["10128"]) then
				if arg_403_1.var_.actorSpriteComps10128 then
					for iter_406_0, iter_406_1 in pairs(arg_403_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_406_1 then
							if arg_403_1.isInRecall_ then
								iter_406_1.color = Color.New(Mathf.Lerp(iter_406_1.color.r, arg_403_1.hightColor1.r, (arg_403_1.time_ - 0) / var_406_0), Mathf.Lerp(iter_406_1.color.g, arg_403_1.hightColor1.g, (arg_403_1.time_ - 0) / var_406_0), (Mathf.Lerp(iter_406_1.color.b, arg_403_1.hightColor1.b, (arg_403_1.time_ - 0) / var_406_0)))
							else
								local var_406_1 = Mathf.Lerp(iter_406_1.color.r, 1, (arg_403_1.time_ - 0) / var_406_0)

								iter_406_1.color = Color.New(var_406_1, var_406_1, var_406_1)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["10128"]) and arg_403_1.var_.actorSpriteComps10128 then
				for iter_406_2, iter_406_3 in pairs(arg_403_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_406_3 then
						iter_406_3.color = arg_403_1.isInRecall_ and (arg_403_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_403_1.var_.actorSpriteComps10128 = nil
			end

			local var_406_2 = arg_403_1.actors_["10115"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.actorSpriteComps10115 == nil then
				arg_403_1.var_.actorSpriteComps10115 = var_406_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_3 = 0.2

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_3 and not isNil(var_406_2) then
				if arg_403_1.var_.actorSpriteComps10115 then
					for iter_406_4, iter_406_5 in pairs(arg_403_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_406_5 then
							if arg_403_1.isInRecall_ then
								iter_406_5.color = Color.New(Mathf.Lerp(iter_406_5.color.r, arg_403_1.hightColor2.r, (arg_403_1.time_ - 0) / var_406_3), Mathf.Lerp(iter_406_5.color.g, arg_403_1.hightColor2.g, (arg_403_1.time_ - 0) / var_406_3), (Mathf.Lerp(iter_406_5.color.b, arg_403_1.hightColor2.b, (arg_403_1.time_ - 0) / var_406_3)))
							else
								local var_406_4 = Mathf.Lerp(iter_406_5.color.r, 0.5, (arg_403_1.time_ - 0) / var_406_3)

								iter_406_5.color = Color.New(var_406_4, var_406_4, var_406_4)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= 0 + var_406_3 and arg_403_1.time_ < 0 + var_406_3 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.actorSpriteComps10115 then
				for iter_406_6, iter_406_7 in pairs(arg_403_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_406_7 then
						iter_406_7.color = arg_403_1.isInRecall_ and (arg_403_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_403_1.var_.actorSpriteComps10115 = nil
			end

			local var_406_5 = arg_403_1.actors_["10115"].transform

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos10115 = var_406_5.localPosition
				var_406_5.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("10115", 2)

				for iter_406_8 = 0, var_406_5.childCount - 1 do
					local var_406_6 = var_406_5:GetChild(iter_406_8)

					if var_406_6.name == "" or not string.find(var_406_6.name, "split") then
						var_406_6.gameObject:SetActive(true)
					else
						var_406_6.gameObject:SetActive(false)
					end
				end
			end

			local var_406_7 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_7 then
				var_406_5.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos10115, Vector3.New(-390, -387.3, -246.2), (arg_403_1.time_ - 0) / var_406_7)
			end

			if arg_403_1.time_ >= 0 + var_406_7 and arg_403_1.time_ < 0 + var_406_7 + arg_406_0 then
				var_406_5.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_406_8 = arg_403_1.actors_["10128"].transform

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos10128 = var_406_8.localPosition
				var_406_8.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("10128", 4)

				for iter_406_9 = 0, var_406_8.childCount - 1 do
					local var_406_9 = var_406_8:GetChild(iter_406_9)

					if var_406_9.name == "" or not string.find(var_406_9.name, "split") then
						var_406_9.gameObject:SetActive(true)
					else
						var_406_9.gameObject:SetActive(false)
					end
				end
			end

			local var_406_10 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_10 then
				var_406_8.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_403_1.time_ - 0) / var_406_10)
			end

			if arg_403_1.time_ >= 0 + var_406_10 and arg_403_1.time_ < 0 + var_406_10 + arg_406_0 then
				var_406_8.localPosition = Vector3.New(390, -347, -300)
			end

			local var_406_11 = 0
			local var_406_12 = 0.4

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_11 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_13 = arg_403_1:GetWordFromCfg(417241093)
				local var_406_14 = arg_403_1:FormatText(var_406_13.content)

				arg_403_1.text_.text = var_406_14

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_16 = 16 <= 0 and var_406_12 or var_406_12 * (utf8.len(var_406_14) / 16)

				if (16 <= 0 and var_406_12 or var_406_12 * (utf8.len(var_406_14) / 16)) > 0 and var_406_12 < var_406_16 then
					arg_403_1.talkMaxDuration = var_406_16

					if var_406_16 + var_406_11 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_16 + var_406_11
					end
				end

				arg_403_1.text_.text = var_406_14
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241093", "story_v_out_417241.awb") ~= 0 then
					local var_406_17 = manager.audio:GetVoiceLength("story_v_out_417241", "417241093", "story_v_out_417241.awb") / 1000

					if var_406_17 + var_406_11 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_17 + var_406_11
					end

					if var_406_13.prefab_name ~= "" and arg_403_1.actors_[var_406_13.prefab_name] ~= nil then
						local var_406_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_13.prefab_name].transform, "story_v_out_417241", "417241093", "story_v_out_417241.awb")

						arg_403_1:RecordAudio("417241093", var_406_18)
						arg_403_1:RecordAudio("417241093", var_406_18)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_417241", "417241093", "story_v_out_417241.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_417241", "417241093", "story_v_out_417241.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_19 = math.max(var_406_12, arg_403_1.talkMaxDuration)

			if var_406_11 <= arg_403_1.time_ and arg_403_1.time_ < var_406_11 + var_406_19 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_11) / var_406_19

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_11 + var_406_19 and arg_403_1.time_ < var_406_11 + var_406_19 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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

		arg_403_1:InitPlayNodeList()
	end,
	Play417241094 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 417241094
		arg_407_1.duration_ = 1.93

		local var_407_0 = {
			zh = 1.9,
			ja = 1.933
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play417241095(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.225

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_1 = arg_407_1:GetWordFromCfg(417241094)
				local var_410_2 = arg_407_1:FormatText(var_410_1.content)

				arg_407_1.text_.text = var_410_2

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_4 = 9 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 9)

				if (9 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 9)) > 0 and var_410_0 < var_410_4 then
					arg_407_1.talkMaxDuration = var_410_4

					if var_410_4 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_4 + 0
					end
				end

				arg_407_1.text_.text = var_410_2
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241094", "story_v_out_417241.awb") ~= 0 then
					local var_410_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241094", "story_v_out_417241.awb") / 1000

					if var_410_5 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + 0
					end

					if var_410_1.prefab_name ~= "" and arg_407_1.actors_[var_410_1.prefab_name] ~= nil then
						local var_410_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_1.prefab_name].transform, "story_v_out_417241", "417241094", "story_v_out_417241.awb")

						arg_407_1:RecordAudio("417241094", var_410_6)
						arg_407_1:RecordAudio("417241094", var_410_6)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_417241", "417241094", "story_v_out_417241.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_417241", "417241094", "story_v_out_417241.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_7 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_7 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_7

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_7 and arg_407_1.time_ < 0 + var_410_7 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play417241095 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 417241095
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play417241096(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos10115 = arg_411_1.actors_["10115"].transform.localPosition
				arg_411_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10115", 7)

				for iter_414_0 = 0, arg_411_1.actors_["10115"].transform.childCount - 1 do
					local var_414_0 = arg_411_1.actors_["10115"].transform:GetChild(iter_414_0)

					if var_414_0.name == "" or not string.find(var_414_0.name, "split") then
						var_414_0.gameObject:SetActive(true)
					else
						var_414_0.gameObject:SetActive(false)
					end
				end
			end

			local var_414_1 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_1 then
				arg_411_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_411_1.time_ - 0) / var_414_1)
			end

			if arg_411_1.time_ >= 0 + var_414_1 and arg_411_1.time_ < 0 + var_414_1 + arg_414_0 then
				arg_411_1.actors_["10115"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_414_2 = arg_411_1.actors_["10128"].transform

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos10128 = var_414_2.localPosition
				var_414_2.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10128", 7)

				for iter_414_1 = 0, var_414_2.childCount - 1 do
					local var_414_3 = var_414_2:GetChild(iter_414_1)

					if var_414_3.name == "" or not string.find(var_414_3.name, "split") then
						var_414_3.gameObject:SetActive(true)
					else
						var_414_3.gameObject:SetActive(false)
					end
				end
			end

			local var_414_4 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				var_414_2.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_411_1.time_ - 0) / var_414_4)
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				var_414_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_414_5 = 0
			local var_414_6 = 0.4

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_5 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_7 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(417241095).content)

				arg_411_1.text_.text = var_414_7

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_9 = 16 <= 0 and var_414_6 or var_414_6 * (utf8.len(var_414_7) / 16)

				if (16 <= 0 and var_414_6 or var_414_6 * (utf8.len(var_414_7) / 16)) > 0 and var_414_6 < var_414_9 then
					arg_411_1.talkMaxDuration = var_414_9

					if var_414_9 + var_414_5 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_9 + var_414_5
					end
				end

				arg_411_1.text_.text = var_414_7
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_10 = math.max(var_414_6, arg_411_1.talkMaxDuration)

			if var_414_5 <= arg_411_1.time_ and arg_411_1.time_ < var_414_5 + var_414_10 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_5) / var_414_10

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_5 + var_414_10 and arg_411_1.time_ < var_414_5 + var_414_10 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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

		arg_411_1:InitPlayNodeList()
	end,
	Play417241096 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 417241096
		arg_415_1.duration_ = 7.1

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play417241097(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.fswbg_:SetActive(true)
				arg_415_1.dialog_:SetActive(false)

				arg_415_1.fswtw_.percent = 0
				arg_415_1.fswt_.text = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(417241096).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.fswt_)

				arg_415_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_415_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_415_1.fswtw_:SetDirty()

				arg_415_1.typewritterCharCountI18N = 0

				SetActive(arg_415_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_415_1:ShowNextGo(false)
			end

			local var_418_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.var_.oldValueTypewriter = arg_415_1.fswtw_.percent

				SetActive(arg_415_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_415_1:ShowNextGo(false)
			end

			local var_418_1 = 37
			local var_418_2 = 2.46666666666667
			local var_418_3, var_418_4 = arg_415_1:GetPercentByPara(arg_415_1:FormatText(arg_415_1:GetWordFromCfg(417241096).content), 1)

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				local var_418_5 = var_418_1 <= 0 and var_418_2 or var_418_2 * ((var_418_4 - arg_415_1.typewritterCharCountI18N) / var_418_1)

				if (var_418_1 <= 0 and var_418_2 or var_418_2 * ((var_418_4 - arg_415_1.typewritterCharCountI18N) / var_418_1)) > 0 and var_418_2 < var_418_5 then
					arg_415_1.talkMaxDuration = var_418_5

					if var_418_5 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + var_418_0
					end
				end
			end

			local var_418_6 = math.max(2.46666666666667, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_6 then
				arg_415_1.fswtw_.percent = Mathf.Lerp(arg_415_1.var_.oldValueTypewriter, var_418_3, (arg_415_1.time_ - var_418_0) / var_418_6)
				arg_415_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_415_1.fswtw_:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_6 and arg_415_1.time_ < var_418_0 + var_418_6 + arg_418_0 then
				arg_415_1.fswtw_.percent = var_418_3

				arg_415_1.fswtw_:SetDirty()
				arg_415_1:ShowNextGo(true)

				arg_415_1.typewritterCharCountI18N = var_418_4
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				local var_418_7 = arg_415_1.fswbg_.transform:Find("textbox/adapt/content") or arg_415_1.fswbg_.transform:Find("textbox/content")
				local var_418_8 = arg_415_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_418_9 = var_418_7:GetComponent("RectTransform")

				var_418_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleLeft
				var_418_9.offsetMin = Vector2.New(0, 0)
				var_418_9.offsetMax = Vector2.New(0, 0)
			end

			local var_418_10 = 0.0999999999999999
			local var_418_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241096", "story_v_out_417241.awb") / 1000

			if var_418_11 > 0 and 7 < var_418_11 and var_418_11 + var_418_10 > arg_415_1.duration_ then
				arg_415_1.duration_ = var_418_11 + var_418_10
			end

			if var_418_10 < arg_415_1.time_ and arg_415_1.time_ <= var_418_10 + arg_418_0 then
				arg_415_1:AudioAction("play", "voice", "story_v_out_417241", "417241096", "story_v_out_417241.awb")
			end

			local var_418_13 = arg_415_1.actors_["10832"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				local var_418_14 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_418_14 then
					var_418_14.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_418_14.radialBlurScale = 0
					var_418_14.radialBlurGradient = 1
					var_418_14.radialBlurIntensity = 1

					if var_418_13 then
						var_418_14.radialBlurTarget = var_418_13.transform
					end
				end
			end

			local var_418_15 = 0.0999999999999999

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_15 then
				local var_418_16 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_418_16 then
					var_418_16.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_418_16.radialBlurScale = Mathf.Lerp(0, 0, (arg_415_1.time_ - 0) / var_418_15)
					var_418_16.radialBlurGradient = Mathf.Lerp(1, 1, (arg_415_1.time_ - 0) / var_418_15)
					var_418_16.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_415_1.time_ - 0) / var_418_15)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_15 and arg_415_1.time_ < 0 + var_418_15 + arg_418_0 then
				local var_418_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_418_17 then
					var_418_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_418_17.radialBlurScale = 0
					var_418_17.radialBlurGradient = 1
					var_418_17.radialBlurIntensity = 1
				end
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play417241097 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 417241097
		arg_419_1.duration_ = 3.3

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play417241098(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.oldValueTypewriter = arg_419_1.fswtw_.percent

				SetActive(arg_419_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_419_1:ShowNextGo(false)
			end

			local var_422_0 = 23
			local var_422_1 = 1.53333333333333
			local var_422_2, var_422_3 = arg_419_1:GetPercentByPara(arg_419_1:FormatText(arg_419_1:GetWordFromCfg(417241096).content), 2)

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0

				local var_422_4 = var_422_0 <= 0 and var_422_1 or var_422_1 * ((var_422_3 - arg_419_1.typewritterCharCountI18N) / var_422_0)

				if (var_422_0 <= 0 and var_422_1 or var_422_1 * ((var_422_3 - arg_419_1.typewritterCharCountI18N) / var_422_0)) > 0 and var_422_1 < var_422_4 then
					arg_419_1.talkMaxDuration = var_422_4

					if var_422_4 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_4 + 0
					end
				end
			end

			local var_422_5 = math.max(1.53333333333333, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_5 then
				arg_419_1.fswtw_.percent = Mathf.Lerp(arg_419_1.var_.oldValueTypewriter, var_422_2, (arg_419_1.time_ - 0) / var_422_5)
				arg_419_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_419_1.fswtw_:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_5 and arg_419_1.time_ < 0 + var_422_5 + arg_422_0 then
				arg_419_1.fswtw_.percent = var_422_2

				arg_419_1.fswtw_:SetDirty()
				arg_419_1:ShowNextGo(true)

				arg_419_1.typewritterCharCountI18N = var_422_3
			end

			local var_422_6 = 0
			local var_422_7 = manager.audio:GetVoiceLength("story_v_out_417241", "417241097", "story_v_out_417241.awb") / 1000

			if var_422_7 > 0 and 3.3 < var_422_7 and var_422_7 + var_422_6 > arg_419_1.duration_ then
				arg_419_1.duration_ = var_422_7 + var_422_6
			end

			if var_422_6 < arg_419_1.time_ and arg_419_1.time_ <= var_422_6 + arg_422_0 then
				arg_419_1:AudioAction("play", "voice", "story_v_out_417241", "417241097", "story_v_out_417241.awb")
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play417241098 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 417241098
		arg_423_1.duration_ = 6.67

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play417241099(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.oldValueTypewriter = arg_423_1.fswtw_.percent

				SetActive(arg_423_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_423_1:ShowNextGo(false)
			end

			local var_426_0 = 38
			local var_426_1 = 2.53333333333333
			local var_426_2, var_426_3 = arg_423_1:GetPercentByPara(arg_423_1:FormatText(arg_423_1:GetWordFromCfg(417241096).content), 3)

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0

				local var_426_4 = var_426_0 <= 0 and var_426_1 or var_426_1 * ((var_426_3 - arg_423_1.typewritterCharCountI18N) / var_426_0)

				if (var_426_0 <= 0 and var_426_1 or var_426_1 * ((var_426_3 - arg_423_1.typewritterCharCountI18N) / var_426_0)) > 0 and var_426_1 < var_426_4 then
					arg_423_1.talkMaxDuration = var_426_4

					if var_426_4 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_4 + 0
					end
				end
			end

			local var_426_5 = math.max(2.53333333333333, arg_423_1.talkMaxDuration)

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_5 then
				arg_423_1.fswtw_.percent = Mathf.Lerp(arg_423_1.var_.oldValueTypewriter, var_426_2, (arg_423_1.time_ - 0) / var_426_5)
				arg_423_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_423_1.fswtw_:SetDirty()
			end

			if arg_423_1.time_ >= 0 + var_426_5 and arg_423_1.time_ < 0 + var_426_5 + arg_426_0 then
				arg_423_1.fswtw_.percent = var_426_2

				arg_423_1.fswtw_:SetDirty()
				arg_423_1:ShowNextGo(true)

				arg_423_1.typewritterCharCountI18N = var_426_3
			end

			local var_426_6 = 0
			local var_426_7 = manager.audio:GetVoiceLength("story_v_out_417241", "417241098", "story_v_out_417241.awb") / 1000

			if var_426_7 > 0 and 6.666 < var_426_7 and var_426_7 + var_426_6 > arg_423_1.duration_ then
				arg_423_1.duration_ = var_426_7 + var_426_6
			end

			if var_426_6 < arg_423_1.time_ and arg_423_1.time_ <= var_426_6 + arg_426_0 then
				arg_423_1:AudioAction("play", "voice", "story_v_out_417241", "417241098", "story_v_out_417241.awb")
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play417241099 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 417241099
		arg_427_1.duration_ = 4.93

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play417241100(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.oldValueTypewriter = arg_427_1.fswtw_.percent

				SetActive(arg_427_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_427_1:ShowNextGo(false)
			end

			local var_430_0 = 31
			local var_430_1 = 2.06666666666667
			local var_430_2, var_430_3 = arg_427_1:GetPercentByPara(arg_427_1:FormatText(arg_427_1:GetWordFromCfg(417241096).content), 4)

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0

				local var_430_4 = var_430_0 <= 0 and var_430_1 or var_430_1 * ((var_430_3 - arg_427_1.typewritterCharCountI18N) / var_430_0)

				if (var_430_0 <= 0 and var_430_1 or var_430_1 * ((var_430_3 - arg_427_1.typewritterCharCountI18N) / var_430_0)) > 0 and var_430_1 < var_430_4 then
					arg_427_1.talkMaxDuration = var_430_4

					if var_430_4 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_4 + 0
					end
				end
			end

			local var_430_5 = math.max(2.06666666666667, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_5 then
				arg_427_1.fswtw_.percent = Mathf.Lerp(arg_427_1.var_.oldValueTypewriter, var_430_2, (arg_427_1.time_ - 0) / var_430_5)
				arg_427_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_427_1.fswtw_:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_5 and arg_427_1.time_ < 0 + var_430_5 + arg_430_0 then
				arg_427_1.fswtw_.percent = var_430_2

				arg_427_1.fswtw_:SetDirty()
				arg_427_1:ShowNextGo(true)

				arg_427_1.typewritterCharCountI18N = var_430_3
			end

			local var_430_6 = 0
			local var_430_7 = manager.audio:GetVoiceLength("story_v_out_417241", "417241099", "story_v_out_417241.awb") / 1000

			if var_430_7 > 0 and 4.933 < var_430_7 and var_430_7 + var_430_6 > arg_427_1.duration_ then
				arg_427_1.duration_ = var_430_7 + var_430_6
			end

			if var_430_6 < arg_427_1.time_ and arg_427_1.time_ <= var_430_6 + arg_430_0 then
				arg_427_1:AudioAction("play", "voice", "story_v_out_417241", "417241099", "story_v_out_417241.awb")
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play417241100 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 417241100
		arg_431_1.duration_ = 4.4

		local var_431_0 = {
			zh = 4.4,
			ja = 2.6
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play417241101(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["10128"]) and arg_431_1.var_.actorSpriteComps10128 == nil then
				arg_431_1.var_.actorSpriteComps10128 = arg_431_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_0 = 0.2

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["10128"]) then
				if arg_431_1.var_.actorSpriteComps10128 then
					for iter_434_0, iter_434_1 in pairs(arg_431_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_434_1 then
							if arg_431_1.isInRecall_ then
								iter_434_1.color = Color.New(Mathf.Lerp(iter_434_1.color.r, arg_431_1.hightColor1.r, (arg_431_1.time_ - 0) / var_434_0), Mathf.Lerp(iter_434_1.color.g, arg_431_1.hightColor1.g, (arg_431_1.time_ - 0) / var_434_0), (Mathf.Lerp(iter_434_1.color.b, arg_431_1.hightColor1.b, (arg_431_1.time_ - 0) / var_434_0)))
							else
								local var_434_1 = Mathf.Lerp(iter_434_1.color.r, 1, (arg_431_1.time_ - 0) / var_434_0)

								iter_434_1.color = Color.New(var_434_1, var_434_1, var_434_1)
							end
						end
					end
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["10128"]) and arg_431_1.var_.actorSpriteComps10128 then
				for iter_434_2, iter_434_3 in pairs(arg_431_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_434_3 then
						iter_434_3.color = arg_431_1.isInRecall_ and (arg_431_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_431_1.var_.actorSpriteComps10128 = nil
			end

			local var_434_2 = arg_431_1.actors_["10128"].transform

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.var_.moveOldPos10128 = var_434_2.localPosition
				var_434_2.localScale = Vector3.New(1, 1, 1)

				arg_431_1:CheckSpriteTmpPos("10128", 3)

				for iter_434_4 = 0, var_434_2.childCount - 1 do
					local var_434_3 = var_434_2:GetChild(iter_434_4)

					if var_434_3.name == "" or not string.find(var_434_3.name, "split") then
						var_434_3.gameObject:SetActive(true)
					else
						var_434_3.gameObject:SetActive(false)
					end
				end
			end

			local var_434_4 = 0.001

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				var_434_2.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_431_1.time_ - 0) / var_434_4)
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				var_434_2.localPosition = Vector3.New(0, -347, -300)
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.fswbg_:SetActive(false)
				arg_431_1.dialog_:SetActive(false)
				SetActive(arg_431_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_431_1:ShowNextGo(false)
			end

			local var_434_5 = arg_431_1.actors_["10831"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				local var_434_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_434_6 then
					var_434_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_434_6.radialBlurScale = 0
					var_434_6.radialBlurGradient = 1
					var_434_6.radialBlurIntensity = 1

					if var_434_5 then
						var_434_6.radialBlurTarget = var_434_5.transform
					end
				end
			end

			local var_434_7 = 0.0166666666666667

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_7 then
				local var_434_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_434_8 then
					var_434_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_434_8.radialBlurScale = Mathf.Lerp(0, 0, (arg_431_1.time_ - 0) / var_434_7)
					var_434_8.radialBlurGradient = Mathf.Lerp(1, 1, (arg_431_1.time_ - 0) / var_434_7)
					var_434_8.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_431_1.time_ - 0) / var_434_7)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_7 and arg_431_1.time_ < 0 + var_434_7 + arg_434_0 then
				local var_434_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_434_9 then
					var_434_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_434_9.radialBlurScale = 0
					var_434_9.radialBlurGradient = 1
					var_434_9.radialBlurIntensity = 1
				end
			end

			local var_434_10 = 0
			local var_434_11 = 0.575

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_10 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_12 = arg_431_1:GetWordFromCfg(417241100)
				local var_434_13 = arg_431_1:FormatText(var_434_12.content)

				arg_431_1.text_.text = var_434_13

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_15 = 23 <= 0 and var_434_11 or var_434_11 * (utf8.len(var_434_13) / 23)

				if (23 <= 0 and var_434_11 or var_434_11 * (utf8.len(var_434_13) / 23)) > 0 and var_434_11 < var_434_15 then
					arg_431_1.talkMaxDuration = var_434_15

					if var_434_15 + var_434_10 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_15 + var_434_10
					end
				end

				arg_431_1.text_.text = var_434_13
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241100", "story_v_out_417241.awb") ~= 0 then
					local var_434_16 = manager.audio:GetVoiceLength("story_v_out_417241", "417241100", "story_v_out_417241.awb") / 1000

					if var_434_16 + var_434_10 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_16 + var_434_10
					end

					if var_434_12.prefab_name ~= "" and arg_431_1.actors_[var_434_12.prefab_name] ~= nil then
						local var_434_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_12.prefab_name].transform, "story_v_out_417241", "417241100", "story_v_out_417241.awb")

						arg_431_1:RecordAudio("417241100", var_434_17)
						arg_431_1:RecordAudio("417241100", var_434_17)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_417241", "417241100", "story_v_out_417241.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_417241", "417241100", "story_v_out_417241.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_18 = math.max(var_434_11, arg_431_1.talkMaxDuration)

			if var_434_10 <= arg_431_1.time_ and arg_431_1.time_ < var_434_10 + var_434_18 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_10) / var_434_18

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_10 + var_434_18 and arg_431_1.time_ < var_434_10 + var_434_18 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
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

		arg_431_1:InitPlayNodeList()
	end,
	Play417241101 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 417241101
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play417241102(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["10128"]) and arg_435_1.var_.actorSpriteComps10128 == nil then
				arg_435_1.var_.actorSpriteComps10128 = arg_435_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_0 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["10128"]) then
				if arg_435_1.var_.actorSpriteComps10128 then
					for iter_438_0, iter_438_1 in pairs(arg_435_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_438_1 then
							if arg_435_1.isInRecall_ then
								iter_438_1.color = Color.New(Mathf.Lerp(iter_438_1.color.r, arg_435_1.hightColor2.r, (arg_435_1.time_ - 0) / var_438_0), Mathf.Lerp(iter_438_1.color.g, arg_435_1.hightColor2.g, (arg_435_1.time_ - 0) / var_438_0), (Mathf.Lerp(iter_438_1.color.b, arg_435_1.hightColor2.b, (arg_435_1.time_ - 0) / var_438_0)))
							else
								local var_438_1 = Mathf.Lerp(iter_438_1.color.r, 0.5, (arg_435_1.time_ - 0) / var_438_0)

								iter_438_1.color = Color.New(var_438_1, var_438_1, var_438_1)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["10128"]) and arg_435_1.var_.actorSpriteComps10128 then
				for iter_438_2, iter_438_3 in pairs(arg_435_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_438_3 then
						iter_438_3.color = arg_435_1.isInRecall_ and (arg_435_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_435_1.var_.actorSpriteComps10128 = nil
			end

			local var_438_2 = 0
			local var_438_3 = 1.45

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_2 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_4 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(417241101).content)

				arg_435_1.text_.text = var_438_4

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_6 = 58 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_4) / 58)

				if (58 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_4) / 58)) > 0 and var_438_3 < var_438_6 then
					arg_435_1.talkMaxDuration = var_438_6

					if var_438_6 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_6 + var_438_2
					end
				end

				arg_435_1.text_.text = var_438_4
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_7 = math.max(var_438_3, arg_435_1.talkMaxDuration)

			if var_438_2 <= arg_435_1.time_ and arg_435_1.time_ < var_438_2 + var_438_7 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_2) / var_438_7

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_2 + var_438_7 and arg_435_1.time_ < var_438_2 + var_438_7 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play417241102 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 417241102
		arg_439_1.duration_ = 3.4

		local var_439_0 = {
			zh = 3.266,
			ja = 3.4
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play417241103(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["10128"]) and arg_439_1.var_.actorSpriteComps10128 == nil then
				arg_439_1.var_.actorSpriteComps10128 = arg_439_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_442_0 = 0.2

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["10128"]) then
				if arg_439_1.var_.actorSpriteComps10128 then
					for iter_442_0, iter_442_1 in pairs(arg_439_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_442_1 then
							if arg_439_1.isInRecall_ then
								iter_442_1.color = Color.New(Mathf.Lerp(iter_442_1.color.r, arg_439_1.hightColor1.r, (arg_439_1.time_ - 0) / var_442_0), Mathf.Lerp(iter_442_1.color.g, arg_439_1.hightColor1.g, (arg_439_1.time_ - 0) / var_442_0), (Mathf.Lerp(iter_442_1.color.b, arg_439_1.hightColor1.b, (arg_439_1.time_ - 0) / var_442_0)))
							else
								local var_442_1 = Mathf.Lerp(iter_442_1.color.r, 1, (arg_439_1.time_ - 0) / var_442_0)

								iter_442_1.color = Color.New(var_442_1, var_442_1, var_442_1)
							end
						end
					end
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["10128"]) and arg_439_1.var_.actorSpriteComps10128 then
				for iter_442_2, iter_442_3 in pairs(arg_439_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_442_3 then
						iter_442_3.color = arg_439_1.isInRecall_ and (arg_439_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_439_1.var_.actorSpriteComps10128 = nil
			end

			local var_442_2 = 0
			local var_442_3 = 0.375

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_2 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_4 = arg_439_1:GetWordFromCfg(417241102)
				local var_442_5 = arg_439_1:FormatText(var_442_4.content)

				arg_439_1.text_.text = var_442_5

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_7 = 15 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_5) / 15)

				if (15 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_5) / 15)) > 0 and var_442_3 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_2
					end
				end

				arg_439_1.text_.text = var_442_5
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241102", "story_v_out_417241.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241102", "story_v_out_417241.awb") / 1000

					if var_442_8 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_2
					end

					if var_442_4.prefab_name ~= "" and arg_439_1.actors_[var_442_4.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_4.prefab_name].transform, "story_v_out_417241", "417241102", "story_v_out_417241.awb")

						arg_439_1:RecordAudio("417241102", var_442_9)
						arg_439_1:RecordAudio("417241102", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_417241", "417241102", "story_v_out_417241.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_417241", "417241102", "story_v_out_417241.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_3, arg_439_1.talkMaxDuration)

			if var_442_2 <= arg_439_1.time_ and arg_439_1.time_ < var_442_2 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_2) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_2 + var_442_10 and arg_439_1.time_ < var_442_2 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play417241103 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 417241103
		arg_443_1.duration_ = 8.93

		local var_443_0 = {
			zh = 8.766,
			ja = 8.933
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play417241104(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 1.125

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_1 = arg_443_1:GetWordFromCfg(417241103)
				local var_446_2 = arg_443_1:FormatText(var_446_1.content)

				arg_443_1.text_.text = var_446_2

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_4 = 45 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_2) / 45)

				if (45 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_2) / 45)) > 0 and var_446_0 < var_446_4 then
					arg_443_1.talkMaxDuration = var_446_4

					if var_446_4 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_4 + 0
					end
				end

				arg_443_1.text_.text = var_446_2
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241103", "story_v_out_417241.awb") ~= 0 then
					local var_446_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241103", "story_v_out_417241.awb") / 1000

					if var_446_5 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_5 + 0
					end

					if var_446_1.prefab_name ~= "" and arg_443_1.actors_[var_446_1.prefab_name] ~= nil then
						local var_446_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_1.prefab_name].transform, "story_v_out_417241", "417241103", "story_v_out_417241.awb")

						arg_443_1:RecordAudio("417241103", var_446_6)
						arg_443_1:RecordAudio("417241103", var_446_6)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_417241", "417241103", "story_v_out_417241.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_417241", "417241103", "story_v_out_417241.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_7 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_7 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_7

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_7 and arg_443_1.time_ < 0 + var_446_7 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play417241104 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 417241104
		arg_447_1.duration_ = 6.97

		local var_447_0 = {
			zh = 5.666,
			ja = 6.966
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play417241105(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0.625

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_1 = arg_447_1:GetWordFromCfg(417241104)
				local var_450_2 = arg_447_1:FormatText(var_450_1.content)

				arg_447_1.text_.text = var_450_2

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_4 = 25 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 25)

				if (25 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 25)) > 0 and var_450_0 < var_450_4 then
					arg_447_1.talkMaxDuration = var_450_4

					if var_450_4 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_4 + 0
					end
				end

				arg_447_1.text_.text = var_450_2
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241104", "story_v_out_417241.awb") ~= 0 then
					local var_450_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241104", "story_v_out_417241.awb") / 1000

					if var_450_5 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_5 + 0
					end

					if var_450_1.prefab_name ~= "" and arg_447_1.actors_[var_450_1.prefab_name] ~= nil then
						local var_450_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_1.prefab_name].transform, "story_v_out_417241", "417241104", "story_v_out_417241.awb")

						arg_447_1:RecordAudio("417241104", var_450_6)
						arg_447_1:RecordAudio("417241104", var_450_6)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_417241", "417241104", "story_v_out_417241.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_417241", "417241104", "story_v_out_417241.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_7 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_7 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_7

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_7 and arg_447_1.time_ < 0 + var_450_7 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play417241105 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 417241105
		arg_451_1.duration_ = 9.53

		local var_451_0 = {
			zh = 8.233,
			ja = 9.533
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play417241106(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 1

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_1 = arg_451_1:GetWordFromCfg(417241105)
				local var_454_2 = arg_451_1:FormatText(var_454_1.content)

				arg_451_1.text_.text = var_454_2

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_4 = 40 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_2) / 40)

				if (40 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_2) / 40)) > 0 and var_454_0 < var_454_4 then
					arg_451_1.talkMaxDuration = var_454_4

					if var_454_4 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_4 + 0
					end
				end

				arg_451_1.text_.text = var_454_2
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241105", "story_v_out_417241.awb") ~= 0 then
					local var_454_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241105", "story_v_out_417241.awb") / 1000

					if var_454_5 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_5 + 0
					end

					if var_454_1.prefab_name ~= "" and arg_451_1.actors_[var_454_1.prefab_name] ~= nil then
						local var_454_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_1.prefab_name].transform, "story_v_out_417241", "417241105", "story_v_out_417241.awb")

						arg_451_1:RecordAudio("417241105", var_454_6)
						arg_451_1:RecordAudio("417241105", var_454_6)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_417241", "417241105", "story_v_out_417241.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_417241", "417241105", "story_v_out_417241.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_7 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_7 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_7

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_7 and arg_451_1.time_ < 0 + var_454_7 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play417241106 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 417241106
		arg_455_1.duration_ = 16.83

		local var_455_0 = {
			zh = 13.466,
			ja = 16.833
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play417241107(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 1.675

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_1 = arg_455_1:GetWordFromCfg(417241106)
				local var_458_2 = arg_455_1:FormatText(var_458_1.content)

				arg_455_1.text_.text = var_458_2

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_4 = 67 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 67)

				if (67 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_2) / 67)) > 0 and var_458_0 < var_458_4 then
					arg_455_1.talkMaxDuration = var_458_4

					if var_458_4 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_4 + 0
					end
				end

				arg_455_1.text_.text = var_458_2
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241106", "story_v_out_417241.awb") ~= 0 then
					local var_458_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241106", "story_v_out_417241.awb") / 1000

					if var_458_5 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + 0
					end

					if var_458_1.prefab_name ~= "" and arg_455_1.actors_[var_458_1.prefab_name] ~= nil then
						local var_458_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_1.prefab_name].transform, "story_v_out_417241", "417241106", "story_v_out_417241.awb")

						arg_455_1:RecordAudio("417241106", var_458_6)
						arg_455_1:RecordAudio("417241106", var_458_6)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_417241", "417241106", "story_v_out_417241.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_417241", "417241106", "story_v_out_417241.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_7 = math.max(var_458_0, arg_455_1.talkMaxDuration)

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_7 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - 0) / var_458_7

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= 0 + var_458_7 and arg_455_1.time_ < 0 + var_458_7 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play417241107 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 417241107
		arg_459_1.duration_ = 14.3

		local var_459_0 = {
			zh = 13.8,
			ja = 14.3
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play417241108(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 1.7

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_1 = arg_459_1:GetWordFromCfg(417241107)
				local var_462_2 = arg_459_1:FormatText(var_462_1.content)

				arg_459_1.text_.text = var_462_2

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_4 = 68 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_2) / 68)

				if (68 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_2) / 68)) > 0 and var_462_0 < var_462_4 then
					arg_459_1.talkMaxDuration = var_462_4

					if var_462_4 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_4 + 0
					end
				end

				arg_459_1.text_.text = var_462_2
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241107", "story_v_out_417241.awb") ~= 0 then
					local var_462_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241107", "story_v_out_417241.awb") / 1000

					if var_462_5 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_5 + 0
					end

					if var_462_1.prefab_name ~= "" and arg_459_1.actors_[var_462_1.prefab_name] ~= nil then
						local var_462_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_1.prefab_name].transform, "story_v_out_417241", "417241107", "story_v_out_417241.awb")

						arg_459_1:RecordAudio("417241107", var_462_6)
						arg_459_1:RecordAudio("417241107", var_462_6)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_417241", "417241107", "story_v_out_417241.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_417241", "417241107", "story_v_out_417241.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_7 = math.max(var_462_0, arg_459_1.talkMaxDuration)

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_7 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - 0) / var_462_7

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= 0 + var_462_7 and arg_459_1.time_ < 0 + var_462_7 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play417241108 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 417241108
		arg_463_1.duration_ = 8.9

		local var_463_0 = {
			zh = 8.9,
			ja = 8.633
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
				arg_463_0:Play417241109(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0.9

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_1 = arg_463_1:GetWordFromCfg(417241108)
				local var_466_2 = arg_463_1:FormatText(var_466_1.content)

				arg_463_1.text_.text = var_466_2

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_4 = 36 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_2) / 36)

				if (36 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_2) / 36)) > 0 and var_466_0 < var_466_4 then
					arg_463_1.talkMaxDuration = var_466_4

					if var_466_4 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_4 + 0
					end
				end

				arg_463_1.text_.text = var_466_2
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241108", "story_v_out_417241.awb") ~= 0 then
					local var_466_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241108", "story_v_out_417241.awb") / 1000

					if var_466_5 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_5 + 0
					end

					if var_466_1.prefab_name ~= "" and arg_463_1.actors_[var_466_1.prefab_name] ~= nil then
						local var_466_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_1.prefab_name].transform, "story_v_out_417241", "417241108", "story_v_out_417241.awb")

						arg_463_1:RecordAudio("417241108", var_466_6)
						arg_463_1:RecordAudio("417241108", var_466_6)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_417241", "417241108", "story_v_out_417241.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_417241", "417241108", "story_v_out_417241.awb")
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
	Play417241109 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 417241109
		arg_467_1.duration_ = 11.57

		local var_467_0 = {
			zh = 7.966,
			ja = 11.566
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
				arg_467_0:Play417241110(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 1.05

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_1 = arg_467_1:GetWordFromCfg(417241109)
				local var_470_2 = arg_467_1:FormatText(var_470_1.content)

				arg_467_1.text_.text = var_470_2

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_4 = 42 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 42)

				if (42 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_2) / 42)) > 0 and var_470_0 < var_470_4 then
					arg_467_1.talkMaxDuration = var_470_4

					if var_470_4 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_4 + 0
					end
				end

				arg_467_1.text_.text = var_470_2
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241109", "story_v_out_417241.awb") ~= 0 then
					local var_470_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241109", "story_v_out_417241.awb") / 1000

					if var_470_5 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_5 + 0
					end

					if var_470_1.prefab_name ~= "" and arg_467_1.actors_[var_470_1.prefab_name] ~= nil then
						local var_470_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_1.prefab_name].transform, "story_v_out_417241", "417241109", "story_v_out_417241.awb")

						arg_467_1:RecordAudio("417241109", var_470_6)
						arg_467_1:RecordAudio("417241109", var_470_6)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_417241", "417241109", "story_v_out_417241.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_417241", "417241109", "story_v_out_417241.awb")
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
	Play417241110 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 417241110
		arg_471_1.duration_ = 12.4

		local var_471_0 = {
			zh = 12.4,
			ja = 11.366
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
				arg_471_0:Play417241111(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 1.3

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_1 = arg_471_1:GetWordFromCfg(417241110)
				local var_474_2 = arg_471_1:FormatText(var_474_1.content)

				arg_471_1.text_.text = var_474_2

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_4 = 52 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 52)

				if (52 <= 0 and var_474_0 or var_474_0 * (utf8.len(var_474_2) / 52)) > 0 and var_474_0 < var_474_4 then
					arg_471_1.talkMaxDuration = var_474_4

					if var_474_4 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_4 + 0
					end
				end

				arg_471_1.text_.text = var_474_2
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241110", "story_v_out_417241.awb") ~= 0 then
					local var_474_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241110", "story_v_out_417241.awb") / 1000

					if var_474_5 + 0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_5 + 0
					end

					if var_474_1.prefab_name ~= "" and arg_471_1.actors_[var_474_1.prefab_name] ~= nil then
						local var_474_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_1.prefab_name].transform, "story_v_out_417241", "417241110", "story_v_out_417241.awb")

						arg_471_1:RecordAudio("417241110", var_474_6)
						arg_471_1:RecordAudio("417241110", var_474_6)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_417241", "417241110", "story_v_out_417241.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_417241", "417241110", "story_v_out_417241.awb")
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
	Play417241111 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 417241111
		arg_475_1.duration_ = 7.53

		local var_475_0 = {
			zh = 4.766,
			ja = 7.533
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
				arg_475_0:Play417241112(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0.525

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_1 = arg_475_1:GetWordFromCfg(417241111)
				local var_478_2 = arg_475_1:FormatText(var_478_1.content)

				arg_475_1.text_.text = var_478_2

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_4 = 21 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_2) / 21)

				if (21 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_2) / 21)) > 0 and var_478_0 < var_478_4 then
					arg_475_1.talkMaxDuration = var_478_4

					if var_478_4 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_4 + 0
					end
				end

				arg_475_1.text_.text = var_478_2
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241111", "story_v_out_417241.awb") ~= 0 then
					local var_478_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241111", "story_v_out_417241.awb") / 1000

					if var_478_5 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_5 + 0
					end

					if var_478_1.prefab_name ~= "" and arg_475_1.actors_[var_478_1.prefab_name] ~= nil then
						local var_478_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_1.prefab_name].transform, "story_v_out_417241", "417241111", "story_v_out_417241.awb")

						arg_475_1:RecordAudio("417241111", var_478_6)
						arg_475_1:RecordAudio("417241111", var_478_6)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_417241", "417241111", "story_v_out_417241.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_417241", "417241111", "story_v_out_417241.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_7 = math.max(var_478_0, arg_475_1.talkMaxDuration)

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_7 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - 0) / var_478_7

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= 0 + var_478_7 and arg_475_1.time_ < 0 + var_478_7 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play417241112 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 417241112
		arg_479_1.duration_ = 8.37

		local var_479_0 = {
			zh = 7.966,
			ja = 8.366
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play417241113(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0.8

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_1 = arg_479_1:GetWordFromCfg(417241112)
				local var_482_2 = arg_479_1:FormatText(var_482_1.content)

				arg_479_1.text_.text = var_482_2

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_4 = 32 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 32)

				if (32 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_2) / 32)) > 0 and var_482_0 < var_482_4 then
					arg_479_1.talkMaxDuration = var_482_4

					if var_482_4 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_4 + 0
					end
				end

				arg_479_1.text_.text = var_482_2
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241112", "story_v_out_417241.awb") ~= 0 then
					local var_482_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241112", "story_v_out_417241.awb") / 1000

					if var_482_5 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_5 + 0
					end

					if var_482_1.prefab_name ~= "" and arg_479_1.actors_[var_482_1.prefab_name] ~= nil then
						local var_482_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_1.prefab_name].transform, "story_v_out_417241", "417241112", "story_v_out_417241.awb")

						arg_479_1:RecordAudio("417241112", var_482_6)
						arg_479_1:RecordAudio("417241112", var_482_6)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_417241", "417241112", "story_v_out_417241.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_417241", "417241112", "story_v_out_417241.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_7 = math.max(var_482_0, arg_479_1.talkMaxDuration)

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_7 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - 0) / var_482_7

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= 0 + var_482_7 and arg_479_1.time_ < 0 + var_482_7 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play417241113 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 417241113
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play417241114(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos10128 = arg_483_1.actors_["10128"].transform.localPosition
				arg_483_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_483_1:CheckSpriteTmpPos("10128", 7)

				for iter_486_0 = 0, arg_483_1.actors_["10128"].transform.childCount - 1 do
					local var_486_0 = arg_483_1.actors_["10128"].transform:GetChild(iter_486_0)

					if var_486_0.name == "" or not string.find(var_486_0.name, "split") then
						var_486_0.gameObject:SetActive(true)
					else
						var_486_0.gameObject:SetActive(false)
					end
				end
			end

			local var_486_1 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_1 then
				arg_483_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_483_1.time_ - 0) / var_486_1)
			end

			if arg_483_1.time_ >= 0 + var_486_1 and arg_483_1.time_ < 0 + var_486_1 + arg_486_0 then
				arg_483_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			if 0.2 < arg_483_1.time_ and arg_483_1.time_ <= 0.2 + arg_486_0 then
				arg_483_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_plane02", "")
			end

			local var_486_3 = 0
			local var_486_4 = 1.025

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_3 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_5 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(417241113).content)

				arg_483_1.text_.text = var_486_5

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_7 = 41 <= 0 and var_486_4 or var_486_4 * (utf8.len(var_486_5) / 41)

				if (41 <= 0 and var_486_4 or var_486_4 * (utf8.len(var_486_5) / 41)) > 0 and var_486_4 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_3 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_3
					end
				end

				arg_483_1.text_.text = var_486_5
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_8 = math.max(var_486_4, arg_483_1.talkMaxDuration)

			if var_486_3 <= arg_483_1.time_ and arg_483_1.time_ < var_486_3 + var_486_8 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_3) / var_486_8

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_3 + var_486_8 and arg_483_1.time_ < var_486_3 + var_486_8 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
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

		arg_483_1:InitPlayNodeList()
	end,
	Play417241114 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 417241114
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play417241115(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 1.675

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_1 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(417241114).content)

				arg_487_1.text_.text = var_490_1

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_3 = 67 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 67)

				if (67 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 67)) > 0 and var_490_0 < var_490_3 then
					arg_487_1.talkMaxDuration = var_490_3

					if var_490_3 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_3 + 0
					end
				end

				arg_487_1.text_.text = var_490_1
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_4 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_4 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_4

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_4 and arg_487_1.time_ < 0 + var_490_4 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play417241115 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 417241115
		arg_491_1.duration_ = 12.8

		local var_491_0 = {
			zh = 12.8,
			ja = 11.266
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
				arg_491_0:Play417241116(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(arg_491_1.actors_["10111"]) and arg_491_1.var_.actorSpriteComps10111 == nil then
				arg_491_1.var_.actorSpriteComps10111 = arg_491_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_0 = 0.2

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 and not isNil(arg_491_1.actors_["10111"]) then
				if arg_491_1.var_.actorSpriteComps10111 then
					for iter_494_0, iter_494_1 in pairs(arg_491_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_494_1 then
							if arg_491_1.isInRecall_ then
								iter_494_1.color = Color.New(Mathf.Lerp(iter_494_1.color.r, arg_491_1.hightColor1.r, (arg_491_1.time_ - 0) / var_494_0), Mathf.Lerp(iter_494_1.color.g, arg_491_1.hightColor1.g, (arg_491_1.time_ - 0) / var_494_0), (Mathf.Lerp(iter_494_1.color.b, arg_491_1.hightColor1.b, (arg_491_1.time_ - 0) / var_494_0)))
							else
								local var_494_1 = Mathf.Lerp(iter_494_1.color.r, 1, (arg_491_1.time_ - 0) / var_494_0)

								iter_494_1.color = Color.New(var_494_1, var_494_1, var_494_1)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 and not isNil(arg_491_1.actors_["10111"]) and arg_491_1.var_.actorSpriteComps10111 then
				for iter_494_2, iter_494_3 in pairs(arg_491_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_494_3 then
						iter_494_3.color = arg_491_1.isInRecall_ and (arg_491_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_491_1.var_.actorSpriteComps10111 = nil
			end

			local var_494_2 = arg_491_1.actors_["10111"].transform

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos10111 = var_494_2.localPosition
				var_494_2.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("10111", 3)

				for iter_494_4 = 0, var_494_2.childCount - 1 do
					local var_494_3 = var_494_2:GetChild(iter_494_4)

					if var_494_3.name == "split_6" or not string.find(var_494_3.name, "split") then
						var_494_3.gameObject:SetActive(true)
					else
						var_494_3.gameObject:SetActive(false)
					end
				end
			end

			local var_494_4 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_4 then
				var_494_2.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10111, Vector3.New(0, -361.1, -274.6), (arg_491_1.time_ - 0) / var_494_4)
			end

			if arg_491_1.time_ >= 0 + var_494_4 and arg_491_1.time_ < 0 + var_494_4 + arg_494_0 then
				var_494_2.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_494_5 = 0
			local var_494_6 = 1.25

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_5 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_7 = arg_491_1:GetWordFromCfg(417241115)
				local var_494_8 = arg_491_1:FormatText(var_494_7.content)

				arg_491_1.text_.text = var_494_8

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_10 = 50 <= 0 and var_494_6 or var_494_6 * (utf8.len(var_494_8) / 50)

				if (50 <= 0 and var_494_6 or var_494_6 * (utf8.len(var_494_8) / 50)) > 0 and var_494_6 < var_494_10 then
					arg_491_1.talkMaxDuration = var_494_10

					if var_494_10 + var_494_5 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_10 + var_494_5
					end
				end

				arg_491_1.text_.text = var_494_8
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241115", "story_v_out_417241.awb") ~= 0 then
					local var_494_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241115", "story_v_out_417241.awb") / 1000

					if var_494_11 + var_494_5 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_11 + var_494_5
					end

					if var_494_7.prefab_name ~= "" and arg_491_1.actors_[var_494_7.prefab_name] ~= nil then
						local var_494_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_7.prefab_name].transform, "story_v_out_417241", "417241115", "story_v_out_417241.awb")

						arg_491_1:RecordAudio("417241115", var_494_12)
						arg_491_1:RecordAudio("417241115", var_494_12)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_417241", "417241115", "story_v_out_417241.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_417241", "417241115", "story_v_out_417241.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_13 = math.max(var_494_6, arg_491_1.talkMaxDuration)

			if var_494_5 <= arg_491_1.time_ and arg_491_1.time_ < var_494_5 + var_494_13 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_5) / var_494_13

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_5 + var_494_13 and arg_491_1.time_ < var_494_5 + var_494_13 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
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

		arg_491_1:InitPlayNodeList()
	end,
	Play417241116 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 417241116
		arg_495_1.duration_ = 10.4

		local var_495_0 = {
			zh = 10.266,
			ja = 10.4
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play417241117(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.95

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_1 = arg_495_1:GetWordFromCfg(417241116)
				local var_498_2 = arg_495_1:FormatText(var_498_1.content)

				arg_495_1.text_.text = var_498_2

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 38 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 38)

				if (38 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 38)) > 0 and var_498_0 < var_498_4 then
					arg_495_1.talkMaxDuration = var_498_4

					if var_498_4 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_4 + 0
					end
				end

				arg_495_1.text_.text = var_498_2
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241116", "story_v_out_417241.awb") ~= 0 then
					local var_498_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241116", "story_v_out_417241.awb") / 1000

					if var_498_5 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + 0
					end

					if var_498_1.prefab_name ~= "" and arg_495_1.actors_[var_498_1.prefab_name] ~= nil then
						local var_498_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_1.prefab_name].transform, "story_v_out_417241", "417241116", "story_v_out_417241.awb")

						arg_495_1:RecordAudio("417241116", var_498_6)
						arg_495_1:RecordAudio("417241116", var_498_6)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_417241", "417241116", "story_v_out_417241.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_417241", "417241116", "story_v_out_417241.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play417241117 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 417241117
		arg_499_1.duration_ = 3.73

		local var_499_0 = {
			zh = 3.6,
			ja = 3.733
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play417241118(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["10115"]) and arg_499_1.var_.actorSpriteComps10115 == nil then
				arg_499_1.var_.actorSpriteComps10115 = arg_499_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_0 = 0.2

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["10115"]) then
				if arg_499_1.var_.actorSpriteComps10115 then
					for iter_502_0, iter_502_1 in pairs(arg_499_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_502_1 then
							if arg_499_1.isInRecall_ then
								iter_502_1.color = Color.New(Mathf.Lerp(iter_502_1.color.r, arg_499_1.hightColor1.r, (arg_499_1.time_ - 0) / var_502_0), Mathf.Lerp(iter_502_1.color.g, arg_499_1.hightColor1.g, (arg_499_1.time_ - 0) / var_502_0), (Mathf.Lerp(iter_502_1.color.b, arg_499_1.hightColor1.b, (arg_499_1.time_ - 0) / var_502_0)))
							else
								local var_502_1 = Mathf.Lerp(iter_502_1.color.r, 1, (arg_499_1.time_ - 0) / var_502_0)

								iter_502_1.color = Color.New(var_502_1, var_502_1, var_502_1)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["10115"]) and arg_499_1.var_.actorSpriteComps10115 then
				for iter_502_2, iter_502_3 in pairs(arg_499_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_502_3 then
						iter_502_3.color = arg_499_1.isInRecall_ and (arg_499_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_499_1.var_.actorSpriteComps10115 = nil
			end

			local var_502_2 = arg_499_1.actors_["10111"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_2) and arg_499_1.var_.actorSpriteComps10111 == nil then
				arg_499_1.var_.actorSpriteComps10111 = var_502_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_3 = 0.2

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_3 and not isNil(var_502_2) then
				if arg_499_1.var_.actorSpriteComps10111 then
					for iter_502_4, iter_502_5 in pairs(arg_499_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_502_5 then
							if arg_499_1.isInRecall_ then
								iter_502_5.color = Color.New(Mathf.Lerp(iter_502_5.color.r, arg_499_1.hightColor2.r, (arg_499_1.time_ - 0) / var_502_3), Mathf.Lerp(iter_502_5.color.g, arg_499_1.hightColor2.g, (arg_499_1.time_ - 0) / var_502_3), (Mathf.Lerp(iter_502_5.color.b, arg_499_1.hightColor2.b, (arg_499_1.time_ - 0) / var_502_3)))
							else
								local var_502_4 = Mathf.Lerp(iter_502_5.color.r, 0.5, (arg_499_1.time_ - 0) / var_502_3)

								iter_502_5.color = Color.New(var_502_4, var_502_4, var_502_4)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= 0 + var_502_3 and arg_499_1.time_ < 0 + var_502_3 + arg_502_0 and not isNil(var_502_2) and arg_499_1.var_.actorSpriteComps10111 then
				for iter_502_6, iter_502_7 in pairs(arg_499_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_502_7 then
						iter_502_7.color = arg_499_1.isInRecall_ and (arg_499_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_499_1.var_.actorSpriteComps10111 = nil
			end

			local var_502_5 = arg_499_1.actors_["10111"].transform

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos10111 = var_502_5.localPosition
				var_502_5.localScale = Vector3.New(1, 1, 1)

				arg_499_1:CheckSpriteTmpPos("10111", 2)

				for iter_502_8 = 0, var_502_5.childCount - 1 do
					local var_502_6 = var_502_5:GetChild(iter_502_8)

					if var_502_6.name == "" or not string.find(var_502_6.name, "split") then
						var_502_6.gameObject:SetActive(true)
					else
						var_502_6.gameObject:SetActive(false)
					end
				end
			end

			local var_502_7 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 then
				var_502_5.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10111, Vector3.New(-390, -361.1, -274.6), (arg_499_1.time_ - 0) / var_502_7)
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 then
				var_502_5.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_502_8 = arg_499_1.actors_["10115"].transform

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos10115 = var_502_8.localPosition
				var_502_8.localScale = Vector3.New(1, 1, 1)

				arg_499_1:CheckSpriteTmpPos("10115", 4)

				for iter_502_9 = 0, var_502_8.childCount - 1 do
					local var_502_9 = var_502_8:GetChild(iter_502_9)

					if var_502_9.name == "" or not string.find(var_502_9.name, "split") then
						var_502_9.gameObject:SetActive(true)
					else
						var_502_9.gameObject:SetActive(false)
					end
				end
			end

			local var_502_10 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_10 then
				var_502_8.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_499_1.time_ - 0) / var_502_10)
			end

			if arg_499_1.time_ >= 0 + var_502_10 and arg_499_1.time_ < 0 + var_502_10 + arg_502_0 then
				var_502_8.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_502_11 = 0
			local var_502_12 = 0.3

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_11 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_13 = arg_499_1:GetWordFromCfg(417241117)
				local var_502_14 = arg_499_1:FormatText(var_502_13.content)

				arg_499_1.text_.text = var_502_14

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_16 = 12 <= 0 and var_502_12 or var_502_12 * (utf8.len(var_502_14) / 12)

				if (12 <= 0 and var_502_12 or var_502_12 * (utf8.len(var_502_14) / 12)) > 0 and var_502_12 < var_502_16 then
					arg_499_1.talkMaxDuration = var_502_16

					if var_502_16 + var_502_11 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_16 + var_502_11
					end
				end

				arg_499_1.text_.text = var_502_14
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241117", "story_v_out_417241.awb") ~= 0 then
					local var_502_17 = manager.audio:GetVoiceLength("story_v_out_417241", "417241117", "story_v_out_417241.awb") / 1000

					if var_502_17 + var_502_11 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_17 + var_502_11
					end

					if var_502_13.prefab_name ~= "" and arg_499_1.actors_[var_502_13.prefab_name] ~= nil then
						local var_502_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_13.prefab_name].transform, "story_v_out_417241", "417241117", "story_v_out_417241.awb")

						arg_499_1:RecordAudio("417241117", var_502_18)
						arg_499_1:RecordAudio("417241117", var_502_18)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_417241", "417241117", "story_v_out_417241.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_417241", "417241117", "story_v_out_417241.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_19 = math.max(var_502_12, arg_499_1.talkMaxDuration)

			if var_502_11 <= arg_499_1.time_ and arg_499_1.time_ < var_502_11 + var_502_19 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_11) / var_502_19

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_11 + var_502_19 and arg_499_1.time_ < var_502_11 + var_502_19 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play417241118 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 417241118
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play417241119(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(arg_503_1.actors_["10115"]) and arg_503_1.var_.actorSpriteComps10115 == nil then
				arg_503_1.var_.actorSpriteComps10115 = arg_503_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_506_0 = 0.2

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 and not isNil(arg_503_1.actors_["10115"]) then
				if arg_503_1.var_.actorSpriteComps10115 then
					for iter_506_0, iter_506_1 in pairs(arg_503_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_506_1 then
							if arg_503_1.isInRecall_ then
								iter_506_1.color = Color.New(Mathf.Lerp(iter_506_1.color.r, arg_503_1.hightColor2.r, (arg_503_1.time_ - 0) / var_506_0), Mathf.Lerp(iter_506_1.color.g, arg_503_1.hightColor2.g, (arg_503_1.time_ - 0) / var_506_0), (Mathf.Lerp(iter_506_1.color.b, arg_503_1.hightColor2.b, (arg_503_1.time_ - 0) / var_506_0)))
							else
								local var_506_1 = Mathf.Lerp(iter_506_1.color.r, 0.5, (arg_503_1.time_ - 0) / var_506_0)

								iter_506_1.color = Color.New(var_506_1, var_506_1, var_506_1)
							end
						end
					end
				end
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 and not isNil(arg_503_1.actors_["10115"]) and arg_503_1.var_.actorSpriteComps10115 then
				for iter_506_2, iter_506_3 in pairs(arg_503_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_506_3 then
						iter_506_3.color = arg_503_1.isInRecall_ and (arg_503_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_503_1.var_.actorSpriteComps10115 = nil
			end

			local var_506_2 = arg_503_1.actors_["10111"].transform

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos10111 = var_506_2.localPosition
				var_506_2.localScale = Vector3.New(1, 1, 1)

				arg_503_1:CheckSpriteTmpPos("10111", 7)

				for iter_506_4 = 0, var_506_2.childCount - 1 do
					local var_506_3 = var_506_2:GetChild(iter_506_4)

					if var_506_3.name == "" or not string.find(var_506_3.name, "split") then
						var_506_3.gameObject:SetActive(true)
					else
						var_506_3.gameObject:SetActive(false)
					end
				end
			end

			local var_506_4 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_4 then
				var_506_2.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10111, Vector3.New(0, -2000, 0), (arg_503_1.time_ - 0) / var_506_4)
			end

			if arg_503_1.time_ >= 0 + var_506_4 and arg_503_1.time_ < 0 + var_506_4 + arg_506_0 then
				var_506_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_506_5 = arg_503_1.actors_["10115"].transform

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos10115 = var_506_5.localPosition
				var_506_5.localScale = Vector3.New(1, 1, 1)

				arg_503_1:CheckSpriteTmpPos("10115", 7)

				for iter_506_5 = 0, var_506_5.childCount - 1 do
					local var_506_6 = var_506_5:GetChild(iter_506_5)

					if var_506_6.name == "" or not string.find(var_506_6.name, "split") then
						var_506_6.gameObject:SetActive(true)
					else
						var_506_6.gameObject:SetActive(false)
					end
				end
			end

			local var_506_7 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_7 then
				var_506_5.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_503_1.time_ - 0) / var_506_7)
			end

			if arg_503_1.time_ >= 0 + var_506_7 and arg_503_1.time_ < 0 + var_506_7 + arg_506_0 then
				var_506_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_506_8 = 0
			local var_506_9 = 0.8

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_8 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_10 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(417241118).content)

				arg_503_1.text_.text = var_506_10

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_12 = 32 <= 0 and var_506_9 or var_506_9 * (utf8.len(var_506_10) / 32)

				if (32 <= 0 and var_506_9 or var_506_9 * (utf8.len(var_506_10) / 32)) > 0 and var_506_9 < var_506_12 then
					arg_503_1.talkMaxDuration = var_506_12

					if var_506_12 + var_506_8 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_12 + var_506_8
					end
				end

				arg_503_1.text_.text = var_506_10
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_13 = math.max(var_506_9, arg_503_1.talkMaxDuration)

			if var_506_8 <= arg_503_1.time_ and arg_503_1.time_ < var_506_8 + var_506_13 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_8) / var_506_13

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_8 + var_506_13 and arg_503_1.time_ < var_506_8 + var_506_13 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play417241119 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 417241119
		arg_507_1.duration_ = 9.23

		local var_507_0 = {
			zh = 6.766,
			ja = 9.233
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play417241120(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(arg_507_1.actors_["10111"]) and arg_507_1.var_.actorSpriteComps10111 == nil then
				arg_507_1.var_.actorSpriteComps10111 = arg_507_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_0 = 0.2

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 and not isNil(arg_507_1.actors_["10111"]) then
				if arg_507_1.var_.actorSpriteComps10111 then
					for iter_510_0, iter_510_1 in pairs(arg_507_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_510_1 then
							if arg_507_1.isInRecall_ then
								iter_510_1.color = Color.New(Mathf.Lerp(iter_510_1.color.r, arg_507_1.hightColor1.r, (arg_507_1.time_ - 0) / var_510_0), Mathf.Lerp(iter_510_1.color.g, arg_507_1.hightColor1.g, (arg_507_1.time_ - 0) / var_510_0), (Mathf.Lerp(iter_510_1.color.b, arg_507_1.hightColor1.b, (arg_507_1.time_ - 0) / var_510_0)))
							else
								local var_510_1 = Mathf.Lerp(iter_510_1.color.r, 1, (arg_507_1.time_ - 0) / var_510_0)

								iter_510_1.color = Color.New(var_510_1, var_510_1, var_510_1)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 and not isNil(arg_507_1.actors_["10111"]) and arg_507_1.var_.actorSpriteComps10111 then
				for iter_510_2, iter_510_3 in pairs(arg_507_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_510_3 then
						iter_510_3.color = arg_507_1.isInRecall_ and (arg_507_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_507_1.var_.actorSpriteComps10111 = nil
			end

			local var_510_2 = arg_507_1.actors_["10111"].transform

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos10111 = var_510_2.localPosition
				var_510_2.localScale = Vector3.New(1, 1, 1)

				arg_507_1:CheckSpriteTmpPos("10111", 3)

				for iter_510_4 = 0, var_510_2.childCount - 1 do
					local var_510_3 = var_510_2:GetChild(iter_510_4)

					if var_510_3.name == "" or not string.find(var_510_3.name, "split") then
						var_510_3.gameObject:SetActive(true)
					else
						var_510_3.gameObject:SetActive(false)
					end
				end
			end

			local var_510_4 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_4 then
				var_510_2.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos10111, Vector3.New(0, -361.1, -274.6), (arg_507_1.time_ - 0) / var_510_4)
			end

			if arg_507_1.time_ >= 0 + var_510_4 and arg_507_1.time_ < 0 + var_510_4 + arg_510_0 then
				var_510_2.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_510_5 = 0
			local var_510_6 = 0.75

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_5 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_7 = arg_507_1:GetWordFromCfg(417241119)
				local var_510_8 = arg_507_1:FormatText(var_510_7.content)

				arg_507_1.text_.text = var_510_8

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_10 = 30 <= 0 and var_510_6 or var_510_6 * (utf8.len(var_510_8) / 30)

				if (30 <= 0 and var_510_6 or var_510_6 * (utf8.len(var_510_8) / 30)) > 0 and var_510_6 < var_510_10 then
					arg_507_1.talkMaxDuration = var_510_10

					if var_510_10 + var_510_5 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_10 + var_510_5
					end
				end

				arg_507_1.text_.text = var_510_8
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241119", "story_v_out_417241.awb") ~= 0 then
					local var_510_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241119", "story_v_out_417241.awb") / 1000

					if var_510_11 + var_510_5 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_11 + var_510_5
					end

					if var_510_7.prefab_name ~= "" and arg_507_1.actors_[var_510_7.prefab_name] ~= nil then
						local var_510_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_7.prefab_name].transform, "story_v_out_417241", "417241119", "story_v_out_417241.awb")

						arg_507_1:RecordAudio("417241119", var_510_12)
						arg_507_1:RecordAudio("417241119", var_510_12)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_417241", "417241119", "story_v_out_417241.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_417241", "417241119", "story_v_out_417241.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_13 = math.max(var_510_6, arg_507_1.talkMaxDuration)

			if var_510_5 <= arg_507_1.time_ and arg_507_1.time_ < var_510_5 + var_510_13 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_5) / var_510_13

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_5 + var_510_13 and arg_507_1.time_ < var_510_5 + var_510_13 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
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

		arg_507_1:InitPlayNodeList()
	end,
	Play417241120 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 417241120
		arg_511_1.duration_ = 6.67

		local var_511_0 = {
			zh = 3.533,
			ja = 6.666
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play417241121(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["10115"]) and arg_511_1.var_.actorSpriteComps10115 == nil then
				arg_511_1.var_.actorSpriteComps10115 = arg_511_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_0 = 0.2

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["10115"]) then
				if arg_511_1.var_.actorSpriteComps10115 then
					for iter_514_0, iter_514_1 in pairs(arg_511_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_514_1 then
							if arg_511_1.isInRecall_ then
								iter_514_1.color = Color.New(Mathf.Lerp(iter_514_1.color.r, arg_511_1.hightColor1.r, (arg_511_1.time_ - 0) / var_514_0), Mathf.Lerp(iter_514_1.color.g, arg_511_1.hightColor1.g, (arg_511_1.time_ - 0) / var_514_0), (Mathf.Lerp(iter_514_1.color.b, arg_511_1.hightColor1.b, (arg_511_1.time_ - 0) / var_514_0)))
							else
								local var_514_1 = Mathf.Lerp(iter_514_1.color.r, 1, (arg_511_1.time_ - 0) / var_514_0)

								iter_514_1.color = Color.New(var_514_1, var_514_1, var_514_1)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["10115"]) and arg_511_1.var_.actorSpriteComps10115 then
				for iter_514_2, iter_514_3 in pairs(arg_511_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_514_3 then
						iter_514_3.color = arg_511_1.isInRecall_ and (arg_511_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_511_1.var_.actorSpriteComps10115 = nil
			end

			local var_514_2 = arg_511_1.actors_["10111"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_2) and arg_511_1.var_.actorSpriteComps10111 == nil then
				arg_511_1.var_.actorSpriteComps10111 = var_514_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_3 = 0.2

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_3 and not isNil(var_514_2) then
				if arg_511_1.var_.actorSpriteComps10111 then
					for iter_514_4, iter_514_5 in pairs(arg_511_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_514_5 then
							if arg_511_1.isInRecall_ then
								iter_514_5.color = Color.New(Mathf.Lerp(iter_514_5.color.r, arg_511_1.hightColor2.r, (arg_511_1.time_ - 0) / var_514_3), Mathf.Lerp(iter_514_5.color.g, arg_511_1.hightColor2.g, (arg_511_1.time_ - 0) / var_514_3), (Mathf.Lerp(iter_514_5.color.b, arg_511_1.hightColor2.b, (arg_511_1.time_ - 0) / var_514_3)))
							else
								local var_514_4 = Mathf.Lerp(iter_514_5.color.r, 0.5, (arg_511_1.time_ - 0) / var_514_3)

								iter_514_5.color = Color.New(var_514_4, var_514_4, var_514_4)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= 0 + var_514_3 and arg_511_1.time_ < 0 + var_514_3 + arg_514_0 and not isNil(var_514_2) and arg_511_1.var_.actorSpriteComps10111 then
				for iter_514_6, iter_514_7 in pairs(arg_511_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_514_7 then
						iter_514_7.color = arg_511_1.isInRecall_ and (arg_511_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_511_1.var_.actorSpriteComps10111 = nil
			end

			local var_514_5 = arg_511_1.actors_["10111"].transform

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos10111 = var_514_5.localPosition
				var_514_5.localScale = Vector3.New(1, 1, 1)

				arg_511_1:CheckSpriteTmpPos("10111", 2)

				for iter_514_8 = 0, var_514_5.childCount - 1 do
					local var_514_6 = var_514_5:GetChild(iter_514_8)

					if var_514_6.name == "" or not string.find(var_514_6.name, "split") then
						var_514_6.gameObject:SetActive(true)
					else
						var_514_6.gameObject:SetActive(false)
					end
				end
			end

			local var_514_7 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_7 then
				var_514_5.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos10111, Vector3.New(-390, -361.1, -274.6), (arg_511_1.time_ - 0) / var_514_7)
			end

			if arg_511_1.time_ >= 0 + var_514_7 and arg_511_1.time_ < 0 + var_514_7 + arg_514_0 then
				var_514_5.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_514_8 = arg_511_1.actors_["10115"].transform

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos10115 = var_514_8.localPosition
				var_514_8.localScale = Vector3.New(1, 1, 1)

				arg_511_1:CheckSpriteTmpPos("10115", 4)

				for iter_514_9 = 0, var_514_8.childCount - 1 do
					local var_514_9 = var_514_8:GetChild(iter_514_9)

					if var_514_9.name == "" or not string.find(var_514_9.name, "split") then
						var_514_9.gameObject:SetActive(true)
					else
						var_514_9.gameObject:SetActive(false)
					end
				end
			end

			local var_514_10 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_10 then
				var_514_8.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos10115, Vector3.New(390, -387.3, -246.2), (arg_511_1.time_ - 0) / var_514_10)
			end

			if arg_511_1.time_ >= 0 + var_514_10 and arg_511_1.time_ < 0 + var_514_10 + arg_514_0 then
				var_514_8.localPosition = Vector3.New(390, -387.3, -246.2)
			end

			local var_514_11 = 0
			local var_514_12 = 0.375

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_11 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_13 = arg_511_1:GetWordFromCfg(417241120)
				local var_514_14 = arg_511_1:FormatText(var_514_13.content)

				arg_511_1.text_.text = var_514_14

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_16 = 15 <= 0 and var_514_12 or var_514_12 * (utf8.len(var_514_14) / 15)

				if (15 <= 0 and var_514_12 or var_514_12 * (utf8.len(var_514_14) / 15)) > 0 and var_514_12 < var_514_16 then
					arg_511_1.talkMaxDuration = var_514_16

					if var_514_16 + var_514_11 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_16 + var_514_11
					end
				end

				arg_511_1.text_.text = var_514_14
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241120", "story_v_out_417241.awb") ~= 0 then
					local var_514_17 = manager.audio:GetVoiceLength("story_v_out_417241", "417241120", "story_v_out_417241.awb") / 1000

					if var_514_17 + var_514_11 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_17 + var_514_11
					end

					if var_514_13.prefab_name ~= "" and arg_511_1.actors_[var_514_13.prefab_name] ~= nil then
						local var_514_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_13.prefab_name].transform, "story_v_out_417241", "417241120", "story_v_out_417241.awb")

						arg_511_1:RecordAudio("417241120", var_514_18)
						arg_511_1:RecordAudio("417241120", var_514_18)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_417241", "417241120", "story_v_out_417241.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_417241", "417241120", "story_v_out_417241.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_19 = math.max(var_514_12, arg_511_1.talkMaxDuration)

			if var_514_11 <= arg_511_1.time_ and arg_511_1.time_ < var_514_11 + var_514_19 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_11) / var_514_19

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_11 + var_514_19 and arg_511_1.time_ < var_514_11 + var_514_19 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play417241121 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 417241121
		arg_515_1.duration_ = 2.7

		local var_515_0 = {
			zh = 1.5,
			ja = 2.7
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play417241122(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(arg_515_1.actors_["10111"]) and arg_515_1.var_.actorSpriteComps10111 == nil then
				arg_515_1.var_.actorSpriteComps10111 = arg_515_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_518_0 = 0.2

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 and not isNil(arg_515_1.actors_["10111"]) then
				if arg_515_1.var_.actorSpriteComps10111 then
					for iter_518_0, iter_518_1 in pairs(arg_515_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_518_1 then
							if arg_515_1.isInRecall_ then
								iter_518_1.color = Color.New(Mathf.Lerp(iter_518_1.color.r, arg_515_1.hightColor1.r, (arg_515_1.time_ - 0) / var_518_0), Mathf.Lerp(iter_518_1.color.g, arg_515_1.hightColor1.g, (arg_515_1.time_ - 0) / var_518_0), (Mathf.Lerp(iter_518_1.color.b, arg_515_1.hightColor1.b, (arg_515_1.time_ - 0) / var_518_0)))
							else
								local var_518_1 = Mathf.Lerp(iter_518_1.color.r, 1, (arg_515_1.time_ - 0) / var_518_0)

								iter_518_1.color = Color.New(var_518_1, var_518_1, var_518_1)
							end
						end
					end
				end
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 and not isNil(arg_515_1.actors_["10111"]) and arg_515_1.var_.actorSpriteComps10111 then
				for iter_518_2, iter_518_3 in pairs(arg_515_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_518_3 then
						iter_518_3.color = arg_515_1.isInRecall_ and (arg_515_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_515_1.var_.actorSpriteComps10111 = nil
			end

			local var_518_2 = arg_515_1.actors_["10115"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_2) and arg_515_1.var_.actorSpriteComps10115 == nil then
				arg_515_1.var_.actorSpriteComps10115 = var_518_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_518_3 = 0.2

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_3 and not isNil(var_518_2) then
				if arg_515_1.var_.actorSpriteComps10115 then
					for iter_518_4, iter_518_5 in pairs(arg_515_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_518_5 then
							if arg_515_1.isInRecall_ then
								iter_518_5.color = Color.New(Mathf.Lerp(iter_518_5.color.r, arg_515_1.hightColor2.r, (arg_515_1.time_ - 0) / var_518_3), Mathf.Lerp(iter_518_5.color.g, arg_515_1.hightColor2.g, (arg_515_1.time_ - 0) / var_518_3), (Mathf.Lerp(iter_518_5.color.b, arg_515_1.hightColor2.b, (arg_515_1.time_ - 0) / var_518_3)))
							else
								local var_518_4 = Mathf.Lerp(iter_518_5.color.r, 0.5, (arg_515_1.time_ - 0) / var_518_3)

								iter_518_5.color = Color.New(var_518_4, var_518_4, var_518_4)
							end
						end
					end
				end
			end

			if arg_515_1.time_ >= 0 + var_518_3 and arg_515_1.time_ < 0 + var_518_3 + arg_518_0 and not isNil(var_518_2) and arg_515_1.var_.actorSpriteComps10115 then
				for iter_518_6, iter_518_7 in pairs(arg_515_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_518_7 then
						iter_518_7.color = arg_515_1.isInRecall_ and (arg_515_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_515_1.var_.actorSpriteComps10115 = nil
			end

			local var_518_5 = 0
			local var_518_6 = 0.15

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_5 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_7 = arg_515_1:GetWordFromCfg(417241121)
				local var_518_8 = arg_515_1:FormatText(var_518_7.content)

				arg_515_1.text_.text = var_518_8

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_10 = 6 <= 0 and var_518_6 or var_518_6 * (utf8.len(var_518_8) / 6)

				if (6 <= 0 and var_518_6 or var_518_6 * (utf8.len(var_518_8) / 6)) > 0 and var_518_6 < var_518_10 then
					arg_515_1.talkMaxDuration = var_518_10

					if var_518_10 + var_518_5 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_10 + var_518_5
					end
				end

				arg_515_1.text_.text = var_518_8
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241121", "story_v_out_417241.awb") ~= 0 then
					local var_518_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241121", "story_v_out_417241.awb") / 1000

					if var_518_11 + var_518_5 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_11 + var_518_5
					end

					if var_518_7.prefab_name ~= "" and arg_515_1.actors_[var_518_7.prefab_name] ~= nil then
						local var_518_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_7.prefab_name].transform, "story_v_out_417241", "417241121", "story_v_out_417241.awb")

						arg_515_1:RecordAudio("417241121", var_518_12)
						arg_515_1:RecordAudio("417241121", var_518_12)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_417241", "417241121", "story_v_out_417241.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_417241", "417241121", "story_v_out_417241.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_13 = math.max(var_518_6, arg_515_1.talkMaxDuration)

			if var_518_5 <= arg_515_1.time_ and arg_515_1.time_ < var_518_5 + var_518_13 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_5) / var_518_13

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_5 + var_518_13 and arg_515_1.time_ < var_518_5 + var_518_13 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play417241122 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 417241122
		arg_519_1.duration_ = 5.93

		local var_519_0 = {
			zh = 5.766,
			ja = 5.933
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play417241123(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(arg_519_1.actors_["10115"]) and arg_519_1.var_.actorSpriteComps10115 == nil then
				arg_519_1.var_.actorSpriteComps10115 = arg_519_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_0 = 0.2

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 and not isNil(arg_519_1.actors_["10115"]) then
				if arg_519_1.var_.actorSpriteComps10115 then
					for iter_522_0, iter_522_1 in pairs(arg_519_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_522_1 then
							if arg_519_1.isInRecall_ then
								iter_522_1.color = Color.New(Mathf.Lerp(iter_522_1.color.r, arg_519_1.hightColor1.r, (arg_519_1.time_ - 0) / var_522_0), Mathf.Lerp(iter_522_1.color.g, arg_519_1.hightColor1.g, (arg_519_1.time_ - 0) / var_522_0), (Mathf.Lerp(iter_522_1.color.b, arg_519_1.hightColor1.b, (arg_519_1.time_ - 0) / var_522_0)))
							else
								local var_522_1 = Mathf.Lerp(iter_522_1.color.r, 1, (arg_519_1.time_ - 0) / var_522_0)

								iter_522_1.color = Color.New(var_522_1, var_522_1, var_522_1)
							end
						end
					end
				end
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 and not isNil(arg_519_1.actors_["10115"]) and arg_519_1.var_.actorSpriteComps10115 then
				for iter_522_2, iter_522_3 in pairs(arg_519_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_522_3 then
						iter_522_3.color = arg_519_1.isInRecall_ and (arg_519_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_519_1.var_.actorSpriteComps10115 = nil
			end

			local var_522_2 = arg_519_1.actors_["10111"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_2) and arg_519_1.var_.actorSpriteComps10111 == nil then
				arg_519_1.var_.actorSpriteComps10111 = var_522_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_3 = 0.2

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_3 and not isNil(var_522_2) then
				if arg_519_1.var_.actorSpriteComps10111 then
					for iter_522_4, iter_522_5 in pairs(arg_519_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_522_5 then
							if arg_519_1.isInRecall_ then
								iter_522_5.color = Color.New(Mathf.Lerp(iter_522_5.color.r, arg_519_1.hightColor2.r, (arg_519_1.time_ - 0) / var_522_3), Mathf.Lerp(iter_522_5.color.g, arg_519_1.hightColor2.g, (arg_519_1.time_ - 0) / var_522_3), (Mathf.Lerp(iter_522_5.color.b, arg_519_1.hightColor2.b, (arg_519_1.time_ - 0) / var_522_3)))
							else
								local var_522_4 = Mathf.Lerp(iter_522_5.color.r, 0.5, (arg_519_1.time_ - 0) / var_522_3)

								iter_522_5.color = Color.New(var_522_4, var_522_4, var_522_4)
							end
						end
					end
				end
			end

			if arg_519_1.time_ >= 0 + var_522_3 and arg_519_1.time_ < 0 + var_522_3 + arg_522_0 and not isNil(var_522_2) and arg_519_1.var_.actorSpriteComps10111 then
				for iter_522_6, iter_522_7 in pairs(arg_519_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_522_7 then
						iter_522_7.color = arg_519_1.isInRecall_ and (arg_519_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_519_1.var_.actorSpriteComps10111 = nil
			end

			local var_522_5 = 0
			local var_522_6 = 0.75

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_5 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_7 = arg_519_1:GetWordFromCfg(417241122)
				local var_522_8 = arg_519_1:FormatText(var_522_7.content)

				arg_519_1.text_.text = var_522_8

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_10 = 30 <= 0 and var_522_6 or var_522_6 * (utf8.len(var_522_8) / 30)

				if (30 <= 0 and var_522_6 or var_522_6 * (utf8.len(var_522_8) / 30)) > 0 and var_522_6 < var_522_10 then
					arg_519_1.talkMaxDuration = var_522_10

					if var_522_10 + var_522_5 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_10 + var_522_5
					end
				end

				arg_519_1.text_.text = var_522_8
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241122", "story_v_out_417241.awb") ~= 0 then
					local var_522_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241122", "story_v_out_417241.awb") / 1000

					if var_522_11 + var_522_5 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_11 + var_522_5
					end

					if var_522_7.prefab_name ~= "" and arg_519_1.actors_[var_522_7.prefab_name] ~= nil then
						local var_522_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_7.prefab_name].transform, "story_v_out_417241", "417241122", "story_v_out_417241.awb")

						arg_519_1:RecordAudio("417241122", var_522_12)
						arg_519_1:RecordAudio("417241122", var_522_12)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_417241", "417241122", "story_v_out_417241.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_417241", "417241122", "story_v_out_417241.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_13 = math.max(var_522_6, arg_519_1.talkMaxDuration)

			if var_522_5 <= arg_519_1.time_ and arg_519_1.time_ < var_522_5 + var_522_13 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_5) / var_522_13

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_5 + var_522_13 and arg_519_1.time_ < var_522_5 + var_522_13 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play417241123 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 417241123
		arg_523_1.duration_ = 12.87

		local var_523_0 = {
			zh = 8.133,
			ja = 12.866
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play417241124(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 1.025

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_1 = arg_523_1:GetWordFromCfg(417241123)
				local var_526_2 = arg_523_1:FormatText(var_526_1.content)

				arg_523_1.text_.text = var_526_2

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_4 = 41 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_2) / 41)

				if (41 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_2) / 41)) > 0 and var_526_0 < var_526_4 then
					arg_523_1.talkMaxDuration = var_526_4

					if var_526_4 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_4 + 0
					end
				end

				arg_523_1.text_.text = var_526_2
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241123", "story_v_out_417241.awb") ~= 0 then
					local var_526_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241123", "story_v_out_417241.awb") / 1000

					if var_526_5 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_5 + 0
					end

					if var_526_1.prefab_name ~= "" and arg_523_1.actors_[var_526_1.prefab_name] ~= nil then
						local var_526_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_1.prefab_name].transform, "story_v_out_417241", "417241123", "story_v_out_417241.awb")

						arg_523_1:RecordAudio("417241123", var_526_6)
						arg_523_1:RecordAudio("417241123", var_526_6)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_417241", "417241123", "story_v_out_417241.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_417241", "417241123", "story_v_out_417241.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_7 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_7 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_7

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_7 and arg_523_1.time_ < 0 + var_526_7 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play417241124 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 417241124
		arg_527_1.duration_ = 14.1

		local var_527_0 = {
			zh = 9.866,
			ja = 14.1
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play417241125(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 1.3

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_1 = arg_527_1:GetWordFromCfg(417241124)
				local var_530_2 = arg_527_1:FormatText(var_530_1.content)

				arg_527_1.text_.text = var_530_2

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_4 = 52 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 52)

				if (52 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 52)) > 0 and var_530_0 < var_530_4 then
					arg_527_1.talkMaxDuration = var_530_4

					if var_530_4 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_4 + 0
					end
				end

				arg_527_1.text_.text = var_530_2
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241124", "story_v_out_417241.awb") ~= 0 then
					local var_530_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241124", "story_v_out_417241.awb") / 1000

					if var_530_5 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_5 + 0
					end

					if var_530_1.prefab_name ~= "" and arg_527_1.actors_[var_530_1.prefab_name] ~= nil then
						local var_530_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_1.prefab_name].transform, "story_v_out_417241", "417241124", "story_v_out_417241.awb")

						arg_527_1:RecordAudio("417241124", var_530_6)
						arg_527_1:RecordAudio("417241124", var_530_6)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_417241", "417241124", "story_v_out_417241.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_417241", "417241124", "story_v_out_417241.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_7 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_7 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_7

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_7 and arg_527_1.time_ < 0 + var_530_7 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play417241125 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 417241125
		arg_531_1.duration_ = 11.2

		local var_531_0 = {
			zh = 7,
			ja = 11.2
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play417241126(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(arg_531_1.actors_["10111"]) and arg_531_1.var_.actorSpriteComps10111 == nil then
				arg_531_1.var_.actorSpriteComps10111 = arg_531_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_534_0 = 0.2

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 and not isNil(arg_531_1.actors_["10111"]) then
				if arg_531_1.var_.actorSpriteComps10111 then
					for iter_534_0, iter_534_1 in pairs(arg_531_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_534_1 then
							if arg_531_1.isInRecall_ then
								iter_534_1.color = Color.New(Mathf.Lerp(iter_534_1.color.r, arg_531_1.hightColor1.r, (arg_531_1.time_ - 0) / var_534_0), Mathf.Lerp(iter_534_1.color.g, arg_531_1.hightColor1.g, (arg_531_1.time_ - 0) / var_534_0), (Mathf.Lerp(iter_534_1.color.b, arg_531_1.hightColor1.b, (arg_531_1.time_ - 0) / var_534_0)))
							else
								local var_534_1 = Mathf.Lerp(iter_534_1.color.r, 1, (arg_531_1.time_ - 0) / var_534_0)

								iter_534_1.color = Color.New(var_534_1, var_534_1, var_534_1)
							end
						end
					end
				end
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 and not isNil(arg_531_1.actors_["10111"]) and arg_531_1.var_.actorSpriteComps10111 then
				for iter_534_2, iter_534_3 in pairs(arg_531_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_534_3 then
						iter_534_3.color = arg_531_1.isInRecall_ and (arg_531_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_531_1.var_.actorSpriteComps10111 = nil
			end

			local var_534_2 = arg_531_1.actors_["10115"]

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(var_534_2) and arg_531_1.var_.actorSpriteComps10115 == nil then
				arg_531_1.var_.actorSpriteComps10115 = var_534_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_534_3 = 0.2

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_3 and not isNil(var_534_2) then
				if arg_531_1.var_.actorSpriteComps10115 then
					for iter_534_4, iter_534_5 in pairs(arg_531_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_534_5 then
							if arg_531_1.isInRecall_ then
								iter_534_5.color = Color.New(Mathf.Lerp(iter_534_5.color.r, arg_531_1.hightColor2.r, (arg_531_1.time_ - 0) / var_534_3), Mathf.Lerp(iter_534_5.color.g, arg_531_1.hightColor2.g, (arg_531_1.time_ - 0) / var_534_3), (Mathf.Lerp(iter_534_5.color.b, arg_531_1.hightColor2.b, (arg_531_1.time_ - 0) / var_534_3)))
							else
								local var_534_4 = Mathf.Lerp(iter_534_5.color.r, 0.5, (arg_531_1.time_ - 0) / var_534_3)

								iter_534_5.color = Color.New(var_534_4, var_534_4, var_534_4)
							end
						end
					end
				end
			end

			if arg_531_1.time_ >= 0 + var_534_3 and arg_531_1.time_ < 0 + var_534_3 + arg_534_0 and not isNil(var_534_2) and arg_531_1.var_.actorSpriteComps10115 then
				for iter_534_6, iter_534_7 in pairs(arg_531_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_534_7 then
						iter_534_7.color = arg_531_1.isInRecall_ and (arg_531_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_531_1.var_.actorSpriteComps10115 = nil
			end

			local var_534_5 = 0
			local var_534_6 = 0.775

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_5 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_7 = arg_531_1:GetWordFromCfg(417241125)
				local var_534_8 = arg_531_1:FormatText(var_534_7.content)

				arg_531_1.text_.text = var_534_8

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_10 = 31 <= 0 and var_534_6 or var_534_6 * (utf8.len(var_534_8) / 31)

				if (31 <= 0 and var_534_6 or var_534_6 * (utf8.len(var_534_8) / 31)) > 0 and var_534_6 < var_534_10 then
					arg_531_1.talkMaxDuration = var_534_10

					if var_534_10 + var_534_5 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_10 + var_534_5
					end
				end

				arg_531_1.text_.text = var_534_8
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241125", "story_v_out_417241.awb") ~= 0 then
					local var_534_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241125", "story_v_out_417241.awb") / 1000

					if var_534_11 + var_534_5 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_11 + var_534_5
					end

					if var_534_7.prefab_name ~= "" and arg_531_1.actors_[var_534_7.prefab_name] ~= nil then
						local var_534_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_7.prefab_name].transform, "story_v_out_417241", "417241125", "story_v_out_417241.awb")

						arg_531_1:RecordAudio("417241125", var_534_12)
						arg_531_1:RecordAudio("417241125", var_534_12)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_417241", "417241125", "story_v_out_417241.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_417241", "417241125", "story_v_out_417241.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_13 = math.max(var_534_6, arg_531_1.talkMaxDuration)

			if var_534_5 <= arg_531_1.time_ and arg_531_1.time_ < var_534_5 + var_534_13 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_5) / var_534_13

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_5 + var_534_13 and arg_531_1.time_ < var_534_5 + var_534_13 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play417241126 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 417241126
		arg_535_1.duration_ = 6.8

		local var_535_0 = {
			zh = 4.266,
			ja = 6.8
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play417241127(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0.525

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_1 = arg_535_1:GetWordFromCfg(417241126)
				local var_538_2 = arg_535_1:FormatText(var_538_1.content)

				arg_535_1.text_.text = var_538_2

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_4 = 21 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 21)

				if (21 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 21)) > 0 and var_538_0 < var_538_4 then
					arg_535_1.talkMaxDuration = var_538_4

					if var_538_4 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_4 + 0
					end
				end

				arg_535_1.text_.text = var_538_2
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241126", "story_v_out_417241.awb") ~= 0 then
					local var_538_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241126", "story_v_out_417241.awb") / 1000

					if var_538_5 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_5 + 0
					end

					if var_538_1.prefab_name ~= "" and arg_535_1.actors_[var_538_1.prefab_name] ~= nil then
						local var_538_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_1.prefab_name].transform, "story_v_out_417241", "417241126", "story_v_out_417241.awb")

						arg_535_1:RecordAudio("417241126", var_538_6)
						arg_535_1:RecordAudio("417241126", var_538_6)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_417241", "417241126", "story_v_out_417241.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_417241", "417241126", "story_v_out_417241.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_7 = math.max(var_538_0, arg_535_1.talkMaxDuration)

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_7 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - 0) / var_538_7

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= 0 + var_538_7 and arg_535_1.time_ < 0 + var_538_7 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play417241127 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 417241127
		arg_539_1.duration_ = 5.4

		local var_539_0 = {
			zh = 5.4,
			ja = 5.366
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play417241128(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(arg_539_1.actors_["10115"]) and arg_539_1.var_.actorSpriteComps10115 == nil then
				arg_539_1.var_.actorSpriteComps10115 = arg_539_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_542_0 = 0.2

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 and not isNil(arg_539_1.actors_["10115"]) then
				if arg_539_1.var_.actorSpriteComps10115 then
					for iter_542_0, iter_542_1 in pairs(arg_539_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_542_1 then
							if arg_539_1.isInRecall_ then
								iter_542_1.color = Color.New(Mathf.Lerp(iter_542_1.color.r, arg_539_1.hightColor1.r, (arg_539_1.time_ - 0) / var_542_0), Mathf.Lerp(iter_542_1.color.g, arg_539_1.hightColor1.g, (arg_539_1.time_ - 0) / var_542_0), (Mathf.Lerp(iter_542_1.color.b, arg_539_1.hightColor1.b, (arg_539_1.time_ - 0) / var_542_0)))
							else
								local var_542_1 = Mathf.Lerp(iter_542_1.color.r, 1, (arg_539_1.time_ - 0) / var_542_0)

								iter_542_1.color = Color.New(var_542_1, var_542_1, var_542_1)
							end
						end
					end
				end
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 and not isNil(arg_539_1.actors_["10115"]) and arg_539_1.var_.actorSpriteComps10115 then
				for iter_542_2, iter_542_3 in pairs(arg_539_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_542_3 then
						iter_542_3.color = arg_539_1.isInRecall_ and (arg_539_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_539_1.var_.actorSpriteComps10115 = nil
			end

			local var_542_2 = arg_539_1.actors_["10111"]

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(var_542_2) and arg_539_1.var_.actorSpriteComps10111 == nil then
				arg_539_1.var_.actorSpriteComps10111 = var_542_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_542_3 = 0.2

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_3 and not isNil(var_542_2) then
				if arg_539_1.var_.actorSpriteComps10111 then
					for iter_542_4, iter_542_5 in pairs(arg_539_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_542_5 then
							if arg_539_1.isInRecall_ then
								iter_542_5.color = Color.New(Mathf.Lerp(iter_542_5.color.r, arg_539_1.hightColor2.r, (arg_539_1.time_ - 0) / var_542_3), Mathf.Lerp(iter_542_5.color.g, arg_539_1.hightColor2.g, (arg_539_1.time_ - 0) / var_542_3), (Mathf.Lerp(iter_542_5.color.b, arg_539_1.hightColor2.b, (arg_539_1.time_ - 0) / var_542_3)))
							else
								local var_542_4 = Mathf.Lerp(iter_542_5.color.r, 0.5, (arg_539_1.time_ - 0) / var_542_3)

								iter_542_5.color = Color.New(var_542_4, var_542_4, var_542_4)
							end
						end
					end
				end
			end

			if arg_539_1.time_ >= 0 + var_542_3 and arg_539_1.time_ < 0 + var_542_3 + arg_542_0 and not isNil(var_542_2) and arg_539_1.var_.actorSpriteComps10111 then
				for iter_542_6, iter_542_7 in pairs(arg_539_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_542_7 then
						iter_542_7.color = arg_539_1.isInRecall_ and (arg_539_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_539_1.var_.actorSpriteComps10111 = nil
			end

			local var_542_5 = 0
			local var_542_6 = 0.45

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_5 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_7 = arg_539_1:GetWordFromCfg(417241127)
				local var_542_8 = arg_539_1:FormatText(var_542_7.content)

				arg_539_1.text_.text = var_542_8

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_10 = 18 <= 0 and var_542_6 or var_542_6 * (utf8.len(var_542_8) / 18)

				if (18 <= 0 and var_542_6 or var_542_6 * (utf8.len(var_542_8) / 18)) > 0 and var_542_6 < var_542_10 then
					arg_539_1.talkMaxDuration = var_542_10

					if var_542_10 + var_542_5 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_10 + var_542_5
					end
				end

				arg_539_1.text_.text = var_542_8
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241127", "story_v_out_417241.awb") ~= 0 then
					local var_542_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241127", "story_v_out_417241.awb") / 1000

					if var_542_11 + var_542_5 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_11 + var_542_5
					end

					if var_542_7.prefab_name ~= "" and arg_539_1.actors_[var_542_7.prefab_name] ~= nil then
						local var_542_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_7.prefab_name].transform, "story_v_out_417241", "417241127", "story_v_out_417241.awb")

						arg_539_1:RecordAudio("417241127", var_542_12)
						arg_539_1:RecordAudio("417241127", var_542_12)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_417241", "417241127", "story_v_out_417241.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_417241", "417241127", "story_v_out_417241.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_13 = math.max(var_542_6, arg_539_1.talkMaxDuration)

			if var_542_5 <= arg_539_1.time_ and arg_539_1.time_ < var_542_5 + var_542_13 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_5) / var_542_13

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_5 + var_542_13 and arg_539_1.time_ < var_542_5 + var_542_13 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play417241128 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 417241128
		arg_543_1.duration_ = 5.73

		local var_543_0 = {
			zh = 2.033,
			ja = 5.733
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play417241129(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(arg_543_1.actors_["10111"]) and arg_543_1.var_.actorSpriteComps10111 == nil then
				arg_543_1.var_.actorSpriteComps10111 = arg_543_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_546_0 = 0.2

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 and not isNil(arg_543_1.actors_["10111"]) then
				if arg_543_1.var_.actorSpriteComps10111 then
					for iter_546_0, iter_546_1 in pairs(arg_543_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_546_1 then
							if arg_543_1.isInRecall_ then
								iter_546_1.color = Color.New(Mathf.Lerp(iter_546_1.color.r, arg_543_1.hightColor1.r, (arg_543_1.time_ - 0) / var_546_0), Mathf.Lerp(iter_546_1.color.g, arg_543_1.hightColor1.g, (arg_543_1.time_ - 0) / var_546_0), (Mathf.Lerp(iter_546_1.color.b, arg_543_1.hightColor1.b, (arg_543_1.time_ - 0) / var_546_0)))
							else
								local var_546_1 = Mathf.Lerp(iter_546_1.color.r, 1, (arg_543_1.time_ - 0) / var_546_0)

								iter_546_1.color = Color.New(var_546_1, var_546_1, var_546_1)
							end
						end
					end
				end
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 and not isNil(arg_543_1.actors_["10111"]) and arg_543_1.var_.actorSpriteComps10111 then
				for iter_546_2, iter_546_3 in pairs(arg_543_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_546_3 then
						iter_546_3.color = arg_543_1.isInRecall_ and (arg_543_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_543_1.var_.actorSpriteComps10111 = nil
			end

			local var_546_2 = arg_543_1.actors_["10115"]

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(var_546_2) and arg_543_1.var_.actorSpriteComps10115 == nil then
				arg_543_1.var_.actorSpriteComps10115 = var_546_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_546_3 = 0.2

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_3 and not isNil(var_546_2) then
				if arg_543_1.var_.actorSpriteComps10115 then
					for iter_546_4, iter_546_5 in pairs(arg_543_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_546_5 then
							if arg_543_1.isInRecall_ then
								iter_546_5.color = Color.New(Mathf.Lerp(iter_546_5.color.r, arg_543_1.hightColor2.r, (arg_543_1.time_ - 0) / var_546_3), Mathf.Lerp(iter_546_5.color.g, arg_543_1.hightColor2.g, (arg_543_1.time_ - 0) / var_546_3), (Mathf.Lerp(iter_546_5.color.b, arg_543_1.hightColor2.b, (arg_543_1.time_ - 0) / var_546_3)))
							else
								local var_546_4 = Mathf.Lerp(iter_546_5.color.r, 0.5, (arg_543_1.time_ - 0) / var_546_3)

								iter_546_5.color = Color.New(var_546_4, var_546_4, var_546_4)
							end
						end
					end
				end
			end

			if arg_543_1.time_ >= 0 + var_546_3 and arg_543_1.time_ < 0 + var_546_3 + arg_546_0 and not isNil(var_546_2) and arg_543_1.var_.actorSpriteComps10115 then
				for iter_546_6, iter_546_7 in pairs(arg_543_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_546_7 then
						iter_546_7.color = arg_543_1.isInRecall_ and (arg_543_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_543_1.var_.actorSpriteComps10115 = nil
			end

			local var_546_5 = 0
			local var_546_6 = 0.2

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_5 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_7 = arg_543_1:GetWordFromCfg(417241128)
				local var_546_8 = arg_543_1:FormatText(var_546_7.content)

				arg_543_1.text_.text = var_546_8

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_10 = 8 <= 0 and var_546_6 or var_546_6 * (utf8.len(var_546_8) / 8)

				if (8 <= 0 and var_546_6 or var_546_6 * (utf8.len(var_546_8) / 8)) > 0 and var_546_6 < var_546_10 then
					arg_543_1.talkMaxDuration = var_546_10

					if var_546_10 + var_546_5 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_10 + var_546_5
					end
				end

				arg_543_1.text_.text = var_546_8
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241128", "story_v_out_417241.awb") ~= 0 then
					local var_546_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241128", "story_v_out_417241.awb") / 1000

					if var_546_11 + var_546_5 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_11 + var_546_5
					end

					if var_546_7.prefab_name ~= "" and arg_543_1.actors_[var_546_7.prefab_name] ~= nil then
						local var_546_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_7.prefab_name].transform, "story_v_out_417241", "417241128", "story_v_out_417241.awb")

						arg_543_1:RecordAudio("417241128", var_546_12)
						arg_543_1:RecordAudio("417241128", var_546_12)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_417241", "417241128", "story_v_out_417241.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_417241", "417241128", "story_v_out_417241.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_13 = math.max(var_546_6, arg_543_1.talkMaxDuration)

			if var_546_5 <= arg_543_1.time_ and arg_543_1.time_ < var_546_5 + var_546_13 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_5) / var_546_13

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_5 + var_546_13 and arg_543_1.time_ < var_546_5 + var_546_13 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play417241129 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 417241129
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play417241130(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(arg_547_1.actors_["10111"]) and arg_547_1.var_.actorSpriteComps10111 == nil then
				arg_547_1.var_.actorSpriteComps10111 = arg_547_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_550_0 = 0.2

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 and not isNil(arg_547_1.actors_["10111"]) then
				if arg_547_1.var_.actorSpriteComps10111 then
					for iter_550_0, iter_550_1 in pairs(arg_547_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_550_1 then
							if arg_547_1.isInRecall_ then
								iter_550_1.color = Color.New(Mathf.Lerp(iter_550_1.color.r, arg_547_1.hightColor2.r, (arg_547_1.time_ - 0) / var_550_0), Mathf.Lerp(iter_550_1.color.g, arg_547_1.hightColor2.g, (arg_547_1.time_ - 0) / var_550_0), (Mathf.Lerp(iter_550_1.color.b, arg_547_1.hightColor2.b, (arg_547_1.time_ - 0) / var_550_0)))
							else
								local var_550_1 = Mathf.Lerp(iter_550_1.color.r, 0.5, (arg_547_1.time_ - 0) / var_550_0)

								iter_550_1.color = Color.New(var_550_1, var_550_1, var_550_1)
							end
						end
					end
				end
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 and not isNil(arg_547_1.actors_["10111"]) and arg_547_1.var_.actorSpriteComps10111 then
				for iter_550_2, iter_550_3 in pairs(arg_547_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_550_3 then
						iter_550_3.color = arg_547_1.isInRecall_ and (arg_547_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_547_1.var_.actorSpriteComps10111 = nil
			end

			local var_550_2 = arg_547_1.actors_["10111"].transform

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.var_.moveOldPos10111 = var_550_2.localPosition
				var_550_2.localScale = Vector3.New(1, 1, 1)

				arg_547_1:CheckSpriteTmpPos("10111", 7)

				for iter_550_4 = 0, var_550_2.childCount - 1 do
					local var_550_3 = var_550_2:GetChild(iter_550_4)

					if var_550_3.name == "" or not string.find(var_550_3.name, "split") then
						var_550_3.gameObject:SetActive(true)
					else
						var_550_3.gameObject:SetActive(false)
					end
				end
			end

			local var_550_4 = 0.001

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_4 then
				var_550_2.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos10111, Vector3.New(0, -2000, 0), (arg_547_1.time_ - 0) / var_550_4)
			end

			if arg_547_1.time_ >= 0 + var_550_4 and arg_547_1.time_ < 0 + var_550_4 + arg_550_0 then
				var_550_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_550_5 = arg_547_1.actors_["10115"].transform

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.var_.moveOldPos10115 = var_550_5.localPosition
				var_550_5.localScale = Vector3.New(1, 1, 1)

				arg_547_1:CheckSpriteTmpPos("10115", 7)

				for iter_550_5 = 0, var_550_5.childCount - 1 do
					local var_550_6 = var_550_5:GetChild(iter_550_5)

					if var_550_6.name == "" or not string.find(var_550_6.name, "split") then
						var_550_6.gameObject:SetActive(true)
					else
						var_550_6.gameObject:SetActive(false)
					end
				end
			end

			local var_550_7 = 0.001

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_7 then
				var_550_5.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_547_1.time_ - 0) / var_550_7)
			end

			if arg_547_1.time_ >= 0 + var_550_7 and arg_547_1.time_ < 0 + var_550_7 + arg_550_0 then
				var_550_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.2 < arg_547_1.time_ and arg_547_1.time_ <= 0.2 + arg_550_0 then
				arg_547_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_car01", "")
			end

			local var_550_9 = 0
			local var_550_10 = 1.55

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_9 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, false)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_11 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(417241129).content)

				arg_547_1.text_.text = var_550_11

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_13 = 62 <= 0 and var_550_10 or var_550_10 * (utf8.len(var_550_11) / 62)

				if (62 <= 0 and var_550_10 or var_550_10 * (utf8.len(var_550_11) / 62)) > 0 and var_550_10 < var_550_13 then
					arg_547_1.talkMaxDuration = var_550_13

					if var_550_13 + var_550_9 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_13 + var_550_9
					end
				end

				arg_547_1.text_.text = var_550_11
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_14 = math.max(var_550_10, arg_547_1.talkMaxDuration)

			if var_550_9 <= arg_547_1.time_ and arg_547_1.time_ < var_550_9 + var_550_14 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_9) / var_550_14

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_9 + var_550_14 and arg_547_1.time_ < var_550_9 + var_550_14 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play417241130 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 417241130
		arg_551_1.duration_ = 7.57

		local var_551_0 = {
			zh = 4.166,
			ja = 7.566
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play417241131(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 and not isNil(arg_551_1.actors_["10115"]) and arg_551_1.var_.actorSpriteComps10115 == nil then
				arg_551_1.var_.actorSpriteComps10115 = arg_551_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_554_0 = 0.2

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_0 and not isNil(arg_551_1.actors_["10115"]) then
				if arg_551_1.var_.actorSpriteComps10115 then
					for iter_554_0, iter_554_1 in pairs(arg_551_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_554_1 then
							if arg_551_1.isInRecall_ then
								iter_554_1.color = Color.New(Mathf.Lerp(iter_554_1.color.r, arg_551_1.hightColor1.r, (arg_551_1.time_ - 0) / var_554_0), Mathf.Lerp(iter_554_1.color.g, arg_551_1.hightColor1.g, (arg_551_1.time_ - 0) / var_554_0), (Mathf.Lerp(iter_554_1.color.b, arg_551_1.hightColor1.b, (arg_551_1.time_ - 0) / var_554_0)))
							else
								local var_554_1 = Mathf.Lerp(iter_554_1.color.r, 1, (arg_551_1.time_ - 0) / var_554_0)

								iter_554_1.color = Color.New(var_554_1, var_554_1, var_554_1)
							end
						end
					end
				end
			end

			if arg_551_1.time_ >= 0 + var_554_0 and arg_551_1.time_ < 0 + var_554_0 + arg_554_0 and not isNil(arg_551_1.actors_["10115"]) and arg_551_1.var_.actorSpriteComps10115 then
				for iter_554_2, iter_554_3 in pairs(arg_551_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_554_3 then
						iter_554_3.color = arg_551_1.isInRecall_ and (arg_551_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_551_1.var_.actorSpriteComps10115 = nil
			end

			local var_554_2 = arg_551_1.actors_["10115"].transform

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.var_.moveOldPos10115 = var_554_2.localPosition
				var_554_2.localScale = Vector3.New(1, 1, 1)

				arg_551_1:CheckSpriteTmpPos("10115", 3)

				for iter_554_4 = 0, var_554_2.childCount - 1 do
					local var_554_3 = var_554_2:GetChild(iter_554_4)

					if var_554_3.name == "split_2" or not string.find(var_554_3.name, "split") then
						var_554_3.gameObject:SetActive(true)
					else
						var_554_3.gameObject:SetActive(false)
					end
				end
			end

			local var_554_4 = 0.001

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_4 then
				var_554_2.localPosition = Vector3.Lerp(arg_551_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_551_1.time_ - 0) / var_554_4)
			end

			if arg_551_1.time_ >= 0 + var_554_4 and arg_551_1.time_ < 0 + var_554_4 + arg_554_0 then
				var_554_2.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_554_5 = 0
			local var_554_6 = 0.5

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_5 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_7 = arg_551_1:GetWordFromCfg(417241130)
				local var_554_8 = arg_551_1:FormatText(var_554_7.content)

				arg_551_1.text_.text = var_554_8

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_10 = 20 <= 0 and var_554_6 or var_554_6 * (utf8.len(var_554_8) / 20)

				if (20 <= 0 and var_554_6 or var_554_6 * (utf8.len(var_554_8) / 20)) > 0 and var_554_6 < var_554_10 then
					arg_551_1.talkMaxDuration = var_554_10

					if var_554_10 + var_554_5 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_10 + var_554_5
					end
				end

				arg_551_1.text_.text = var_554_8
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241130", "story_v_out_417241.awb") ~= 0 then
					local var_554_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241130", "story_v_out_417241.awb") / 1000

					if var_554_11 + var_554_5 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_11 + var_554_5
					end

					if var_554_7.prefab_name ~= "" and arg_551_1.actors_[var_554_7.prefab_name] ~= nil then
						local var_554_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_7.prefab_name].transform, "story_v_out_417241", "417241130", "story_v_out_417241.awb")

						arg_551_1:RecordAudio("417241130", var_554_12)
						arg_551_1:RecordAudio("417241130", var_554_12)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_417241", "417241130", "story_v_out_417241.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_417241", "417241130", "story_v_out_417241.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_13 = math.max(var_554_6, arg_551_1.talkMaxDuration)

			if var_554_5 <= arg_551_1.time_ and arg_551_1.time_ < var_554_5 + var_554_13 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_5) / var_554_13

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_5 + var_554_13 and arg_551_1.time_ < var_554_5 + var_554_13 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_551_1:InitPlayNodeList()
	end,
	Play417241131 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 417241131
		arg_555_1.duration_ = 3.3

		local var_555_0 = {
			zh = 2.466,
			ja = 3.3
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play417241132(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(arg_555_1.actors_["1034"]) and arg_555_1.var_.actorSpriteComps1034 == nil then
				arg_555_1.var_.actorSpriteComps1034 = arg_555_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_558_0 = 0.2

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 and not isNil(arg_555_1.actors_["1034"]) then
				if arg_555_1.var_.actorSpriteComps1034 then
					for iter_558_0, iter_558_1 in pairs(arg_555_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_558_1 then
							if arg_555_1.isInRecall_ then
								iter_558_1.color = Color.New(Mathf.Lerp(iter_558_1.color.r, arg_555_1.hightColor1.r, (arg_555_1.time_ - 0) / var_558_0), Mathf.Lerp(iter_558_1.color.g, arg_555_1.hightColor1.g, (arg_555_1.time_ - 0) / var_558_0), (Mathf.Lerp(iter_558_1.color.b, arg_555_1.hightColor1.b, (arg_555_1.time_ - 0) / var_558_0)))
							else
								local var_558_1 = Mathf.Lerp(iter_558_1.color.r, 1, (arg_555_1.time_ - 0) / var_558_0)

								iter_558_1.color = Color.New(var_558_1, var_558_1, var_558_1)
							end
						end
					end
				end
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 and not isNil(arg_555_1.actors_["1034"]) and arg_555_1.var_.actorSpriteComps1034 then
				for iter_558_2, iter_558_3 in pairs(arg_555_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_558_3 then
						iter_558_3.color = arg_555_1.isInRecall_ and (arg_555_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_555_1.var_.actorSpriteComps1034 = nil
			end

			local var_558_2 = arg_555_1.actors_["10115"]

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(var_558_2) and arg_555_1.var_.actorSpriteComps10115 == nil then
				arg_555_1.var_.actorSpriteComps10115 = var_558_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_558_3 = 0.2

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_3 and not isNil(var_558_2) then
				if arg_555_1.var_.actorSpriteComps10115 then
					for iter_558_4, iter_558_5 in pairs(arg_555_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_558_5 then
							if arg_555_1.isInRecall_ then
								iter_558_5.color = Color.New(Mathf.Lerp(iter_558_5.color.r, arg_555_1.hightColor2.r, (arg_555_1.time_ - 0) / var_558_3), Mathf.Lerp(iter_558_5.color.g, arg_555_1.hightColor2.g, (arg_555_1.time_ - 0) / var_558_3), (Mathf.Lerp(iter_558_5.color.b, arg_555_1.hightColor2.b, (arg_555_1.time_ - 0) / var_558_3)))
							else
								local var_558_4 = Mathf.Lerp(iter_558_5.color.r, 0.5, (arg_555_1.time_ - 0) / var_558_3)

								iter_558_5.color = Color.New(var_558_4, var_558_4, var_558_4)
							end
						end
					end
				end
			end

			if arg_555_1.time_ >= 0 + var_558_3 and arg_555_1.time_ < 0 + var_558_3 + arg_558_0 and not isNil(var_558_2) and arg_555_1.var_.actorSpriteComps10115 then
				for iter_558_6, iter_558_7 in pairs(arg_555_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_558_7 then
						iter_558_7.color = arg_555_1.isInRecall_ and (arg_555_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_555_1.var_.actorSpriteComps10115 = nil
			end

			local var_558_5 = arg_555_1.actors_["1034"].transform

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.var_.moveOldPos1034 = var_558_5.localPosition
				var_558_5.localScale = Vector3.New(1, 1, 1)

				arg_555_1:CheckSpriteTmpPos("1034", 4)

				for iter_558_8 = 0, var_558_5.childCount - 1 do
					local var_558_6 = var_558_5:GetChild(iter_558_8)

					if var_558_6.name == "split_6" or not string.find(var_558_6.name, "split") then
						var_558_6.gameObject:SetActive(true)
					else
						var_558_6.gameObject:SetActive(false)
					end
				end
			end

			local var_558_7 = 0.001

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_7 then
				var_558_5.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_555_1.time_ - 0) / var_558_7)
			end

			if arg_555_1.time_ >= 0 + var_558_7 and arg_555_1.time_ < 0 + var_558_7 + arg_558_0 then
				var_558_5.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_558_8 = arg_555_1.actors_["10115"].transform

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.var_.moveOldPos10115 = var_558_8.localPosition
				var_558_8.localScale = Vector3.New(1, 1, 1)

				arg_555_1:CheckSpriteTmpPos("10115", 2)

				for iter_558_9 = 0, var_558_8.childCount - 1 do
					local var_558_9 = var_558_8:GetChild(iter_558_9)

					if var_558_9.name == "split_2" or not string.find(var_558_9.name, "split") then
						var_558_9.gameObject:SetActive(true)
					else
						var_558_9.gameObject:SetActive(false)
					end
				end
			end

			local var_558_10 = 0.001

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_10 then
				var_558_8.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos10115, Vector3.New(-390, -387.3, -246.2), (arg_555_1.time_ - 0) / var_558_10)
			end

			if arg_555_1.time_ >= 0 + var_558_10 and arg_555_1.time_ < 0 + var_558_10 + arg_558_0 then
				var_558_8.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_558_11 = 0
			local var_558_12 = 0.325

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_11 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_13 = arg_555_1:GetWordFromCfg(417241131)
				local var_558_14 = arg_555_1:FormatText(var_558_13.content)

				arg_555_1.text_.text = var_558_14

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_16 = 13 <= 0 and var_558_12 or var_558_12 * (utf8.len(var_558_14) / 13)

				if (13 <= 0 and var_558_12 or var_558_12 * (utf8.len(var_558_14) / 13)) > 0 and var_558_12 < var_558_16 then
					arg_555_1.talkMaxDuration = var_558_16

					if var_558_16 + var_558_11 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_16 + var_558_11
					end
				end

				arg_555_1.text_.text = var_558_14
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241131", "story_v_out_417241.awb") ~= 0 then
					local var_558_17 = manager.audio:GetVoiceLength("story_v_out_417241", "417241131", "story_v_out_417241.awb") / 1000

					if var_558_17 + var_558_11 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_17 + var_558_11
					end

					if var_558_13.prefab_name ~= "" and arg_555_1.actors_[var_558_13.prefab_name] ~= nil then
						local var_558_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_13.prefab_name].transform, "story_v_out_417241", "417241131", "story_v_out_417241.awb")

						arg_555_1:RecordAudio("417241131", var_558_18)
						arg_555_1:RecordAudio("417241131", var_558_18)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_out_417241", "417241131", "story_v_out_417241.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_out_417241", "417241131", "story_v_out_417241.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_19 = math.max(var_558_12, arg_555_1.talkMaxDuration)

			if var_558_11 <= arg_555_1.time_ and arg_555_1.time_ < var_558_11 + var_558_19 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_11) / var_558_19

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_11 + var_558_19 and arg_555_1.time_ < var_558_11 + var_558_19 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
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
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_555_1:InitPlayNodeList()
	end,
	Play417241132 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 417241132
		arg_559_1.duration_ = 6.6

		local var_559_0 = {
			zh = 4.633,
			ja = 6.6
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play417241133(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0.675

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_1 = arg_559_1:GetWordFromCfg(417241132)
				local var_562_2 = arg_559_1:FormatText(var_562_1.content)

				arg_559_1.text_.text = var_562_2

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_4 = 27 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_2) / 27)

				if (27 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_2) / 27)) > 0 and var_562_0 < var_562_4 then
					arg_559_1.talkMaxDuration = var_562_4

					if var_562_4 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_4 + 0
					end
				end

				arg_559_1.text_.text = var_562_2
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241132", "story_v_out_417241.awb") ~= 0 then
					local var_562_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241132", "story_v_out_417241.awb") / 1000

					if var_562_5 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_5 + 0
					end

					if var_562_1.prefab_name ~= "" and arg_559_1.actors_[var_562_1.prefab_name] ~= nil then
						local var_562_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_1.prefab_name].transform, "story_v_out_417241", "417241132", "story_v_out_417241.awb")

						arg_559_1:RecordAudio("417241132", var_562_6)
						arg_559_1:RecordAudio("417241132", var_562_6)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_out_417241", "417241132", "story_v_out_417241.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_out_417241", "417241132", "story_v_out_417241.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_7 = math.max(var_562_0, arg_559_1.talkMaxDuration)

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_7 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - 0) / var_562_7

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= 0 + var_562_7 and arg_559_1.time_ < 0 + var_562_7 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play417241133 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 417241133
		arg_563_1.duration_ = 6.33

		local var_563_0 = {
			zh = 4.233,
			ja = 6.333
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play417241134(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 and not isNil(arg_563_1.actors_["10115"]) and arg_563_1.var_.actorSpriteComps10115 == nil then
				arg_563_1.var_.actorSpriteComps10115 = arg_563_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_566_0 = 0.2

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_0 and not isNil(arg_563_1.actors_["10115"]) then
				if arg_563_1.var_.actorSpriteComps10115 then
					for iter_566_0, iter_566_1 in pairs(arg_563_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_566_1 then
							if arg_563_1.isInRecall_ then
								iter_566_1.color = Color.New(Mathf.Lerp(iter_566_1.color.r, arg_563_1.hightColor1.r, (arg_563_1.time_ - 0) / var_566_0), Mathf.Lerp(iter_566_1.color.g, arg_563_1.hightColor1.g, (arg_563_1.time_ - 0) / var_566_0), (Mathf.Lerp(iter_566_1.color.b, arg_563_1.hightColor1.b, (arg_563_1.time_ - 0) / var_566_0)))
							else
								local var_566_1 = Mathf.Lerp(iter_566_1.color.r, 1, (arg_563_1.time_ - 0) / var_566_0)

								iter_566_1.color = Color.New(var_566_1, var_566_1, var_566_1)
							end
						end
					end
				end
			end

			if arg_563_1.time_ >= 0 + var_566_0 and arg_563_1.time_ < 0 + var_566_0 + arg_566_0 and not isNil(arg_563_1.actors_["10115"]) and arg_563_1.var_.actorSpriteComps10115 then
				for iter_566_2, iter_566_3 in pairs(arg_563_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_566_3 then
						iter_566_3.color = arg_563_1.isInRecall_ and (arg_563_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_563_1.var_.actorSpriteComps10115 = nil
			end

			local var_566_2 = arg_563_1.actors_["1034"]

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 and not isNil(var_566_2) and arg_563_1.var_.actorSpriteComps1034 == nil then
				arg_563_1.var_.actorSpriteComps1034 = var_566_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_566_3 = 0.2

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_3 and not isNil(var_566_2) then
				if arg_563_1.var_.actorSpriteComps1034 then
					for iter_566_4, iter_566_5 in pairs(arg_563_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_566_5 then
							if arg_563_1.isInRecall_ then
								iter_566_5.color = Color.New(Mathf.Lerp(iter_566_5.color.r, arg_563_1.hightColor2.r, (arg_563_1.time_ - 0) / var_566_3), Mathf.Lerp(iter_566_5.color.g, arg_563_1.hightColor2.g, (arg_563_1.time_ - 0) / var_566_3), (Mathf.Lerp(iter_566_5.color.b, arg_563_1.hightColor2.b, (arg_563_1.time_ - 0) / var_566_3)))
							else
								local var_566_4 = Mathf.Lerp(iter_566_5.color.r, 0.5, (arg_563_1.time_ - 0) / var_566_3)

								iter_566_5.color = Color.New(var_566_4, var_566_4, var_566_4)
							end
						end
					end
				end
			end

			if arg_563_1.time_ >= 0 + var_566_3 and arg_563_1.time_ < 0 + var_566_3 + arg_566_0 and not isNil(var_566_2) and arg_563_1.var_.actorSpriteComps1034 then
				for iter_566_6, iter_566_7 in pairs(arg_563_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_566_7 then
						iter_566_7.color = arg_563_1.isInRecall_ and (arg_563_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_563_1.var_.actorSpriteComps1034 = nil
			end

			local var_566_5 = arg_563_1.actors_["10115"].transform

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1.var_.moveOldPos10115 = var_566_5.localPosition
				var_566_5.localScale = Vector3.New(1, 1, 1)

				arg_563_1:CheckSpriteTmpPos("10115", 2)

				for iter_566_8 = 0, var_566_5.childCount - 1 do
					local var_566_6 = var_566_5:GetChild(iter_566_8)

					if var_566_6.name == "split_6" or not string.find(var_566_6.name, "split") then
						var_566_6.gameObject:SetActive(true)
					else
						var_566_6.gameObject:SetActive(false)
					end
				end
			end

			local var_566_7 = 0.001

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_7 then
				var_566_5.localPosition = Vector3.Lerp(arg_563_1.var_.moveOldPos10115, Vector3.New(-390, -387.3, -246.2), (arg_563_1.time_ - 0) / var_566_7)
			end

			if arg_563_1.time_ >= 0 + var_566_7 and arg_563_1.time_ < 0 + var_566_7 + arg_566_0 then
				var_566_5.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_566_8 = 0
			local var_566_9 = 0.575

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_8 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_10 = arg_563_1:GetWordFromCfg(417241133)
				local var_566_11 = arg_563_1:FormatText(var_566_10.content)

				arg_563_1.text_.text = var_566_11

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_13 = 23 <= 0 and var_566_9 or var_566_9 * (utf8.len(var_566_11) / 23)

				if (23 <= 0 and var_566_9 or var_566_9 * (utf8.len(var_566_11) / 23)) > 0 and var_566_9 < var_566_13 then
					arg_563_1.talkMaxDuration = var_566_13

					if var_566_13 + var_566_8 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_13 + var_566_8
					end
				end

				arg_563_1.text_.text = var_566_11
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241133", "story_v_out_417241.awb") ~= 0 then
					local var_566_14 = manager.audio:GetVoiceLength("story_v_out_417241", "417241133", "story_v_out_417241.awb") / 1000

					if var_566_14 + var_566_8 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_14 + var_566_8
					end

					if var_566_10.prefab_name ~= "" and arg_563_1.actors_[var_566_10.prefab_name] ~= nil then
						local var_566_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_10.prefab_name].transform, "story_v_out_417241", "417241133", "story_v_out_417241.awb")

						arg_563_1:RecordAudio("417241133", var_566_15)
						arg_563_1:RecordAudio("417241133", var_566_15)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_417241", "417241133", "story_v_out_417241.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_417241", "417241133", "story_v_out_417241.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_16 = math.max(var_566_9, arg_563_1.talkMaxDuration)

			if var_566_8 <= arg_563_1.time_ and arg_563_1.time_ < var_566_8 + var_566_16 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_8) / var_566_16

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_8 + var_566_16 and arg_563_1.time_ < var_566_8 + var_566_16 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_563_1:InitPlayNodeList()
	end,
	Play417241134 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 417241134
		arg_567_1.duration_ = 8.7

		local var_567_0 = {
			zh = 5.433,
			ja = 8.7
		}
		local var_567_1 = manager.audio:GetLocalizationFlag()

		if var_567_0[var_567_1] ~= nil then
			arg_567_1.duration_ = var_567_0[var_567_1]
		end

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play417241135(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(arg_567_1.actors_["1034"]) and arg_567_1.var_.actorSpriteComps1034 == nil then
				arg_567_1.var_.actorSpriteComps1034 = arg_567_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_570_0 = 0.2

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 and not isNil(arg_567_1.actors_["1034"]) then
				if arg_567_1.var_.actorSpriteComps1034 then
					for iter_570_0, iter_570_1 in pairs(arg_567_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_570_1 then
							if arg_567_1.isInRecall_ then
								iter_570_1.color = Color.New(Mathf.Lerp(iter_570_1.color.r, arg_567_1.hightColor1.r, (arg_567_1.time_ - 0) / var_570_0), Mathf.Lerp(iter_570_1.color.g, arg_567_1.hightColor1.g, (arg_567_1.time_ - 0) / var_570_0), (Mathf.Lerp(iter_570_1.color.b, arg_567_1.hightColor1.b, (arg_567_1.time_ - 0) / var_570_0)))
							else
								local var_570_1 = Mathf.Lerp(iter_570_1.color.r, 1, (arg_567_1.time_ - 0) / var_570_0)

								iter_570_1.color = Color.New(var_570_1, var_570_1, var_570_1)
							end
						end
					end
				end
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 and not isNil(arg_567_1.actors_["1034"]) and arg_567_1.var_.actorSpriteComps1034 then
				for iter_570_2, iter_570_3 in pairs(arg_567_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_570_3 then
						iter_570_3.color = arg_567_1.isInRecall_ and (arg_567_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_567_1.var_.actorSpriteComps1034 = nil
			end

			local var_570_2 = arg_567_1.actors_["10115"]

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(var_570_2) and arg_567_1.var_.actorSpriteComps10115 == nil then
				arg_567_1.var_.actorSpriteComps10115 = var_570_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_570_3 = 0.2

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_3 and not isNil(var_570_2) then
				if arg_567_1.var_.actorSpriteComps10115 then
					for iter_570_4, iter_570_5 in pairs(arg_567_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_570_5 then
							if arg_567_1.isInRecall_ then
								iter_570_5.color = Color.New(Mathf.Lerp(iter_570_5.color.r, arg_567_1.hightColor2.r, (arg_567_1.time_ - 0) / var_570_3), Mathf.Lerp(iter_570_5.color.g, arg_567_1.hightColor2.g, (arg_567_1.time_ - 0) / var_570_3), (Mathf.Lerp(iter_570_5.color.b, arg_567_1.hightColor2.b, (arg_567_1.time_ - 0) / var_570_3)))
							else
								local var_570_4 = Mathf.Lerp(iter_570_5.color.r, 0.5, (arg_567_1.time_ - 0) / var_570_3)

								iter_570_5.color = Color.New(var_570_4, var_570_4, var_570_4)
							end
						end
					end
				end
			end

			if arg_567_1.time_ >= 0 + var_570_3 and arg_567_1.time_ < 0 + var_570_3 + arg_570_0 and not isNil(var_570_2) and arg_567_1.var_.actorSpriteComps10115 then
				for iter_570_6, iter_570_7 in pairs(arg_567_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_570_7 then
						iter_570_7.color = arg_567_1.isInRecall_ and (arg_567_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_567_1.var_.actorSpriteComps10115 = nil
			end

			local var_570_5 = 0
			local var_570_6 = 0.7

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_5 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_7 = arg_567_1:GetWordFromCfg(417241134)
				local var_570_8 = arg_567_1:FormatText(var_570_7.content)

				arg_567_1.text_.text = var_570_8

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_10 = 28 <= 0 and var_570_6 or var_570_6 * (utf8.len(var_570_8) / 28)

				if (28 <= 0 and var_570_6 or var_570_6 * (utf8.len(var_570_8) / 28)) > 0 and var_570_6 < var_570_10 then
					arg_567_1.talkMaxDuration = var_570_10

					if var_570_10 + var_570_5 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_10 + var_570_5
					end
				end

				arg_567_1.text_.text = var_570_8
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241134", "story_v_out_417241.awb") ~= 0 then
					local var_570_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241134", "story_v_out_417241.awb") / 1000

					if var_570_11 + var_570_5 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_11 + var_570_5
					end

					if var_570_7.prefab_name ~= "" and arg_567_1.actors_[var_570_7.prefab_name] ~= nil then
						local var_570_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_7.prefab_name].transform, "story_v_out_417241", "417241134", "story_v_out_417241.awb")

						arg_567_1:RecordAudio("417241134", var_570_12)
						arg_567_1:RecordAudio("417241134", var_570_12)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_out_417241", "417241134", "story_v_out_417241.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_out_417241", "417241134", "story_v_out_417241.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_13 = math.max(var_570_6, arg_567_1.talkMaxDuration)

			if var_570_5 <= arg_567_1.time_ and arg_567_1.time_ < var_570_5 + var_570_13 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_5) / var_570_13

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_5 + var_570_13 and arg_567_1.time_ < var_570_5 + var_570_13 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play417241135 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 417241135
		arg_571_1.duration_ = 8.03

		local var_571_0 = {
			zh = 8,
			ja = 8.033
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play417241136(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(arg_571_1.actors_["10115"]) and arg_571_1.var_.actorSpriteComps10115 == nil then
				arg_571_1.var_.actorSpriteComps10115 = arg_571_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_574_0 = 0.2

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 and not isNil(arg_571_1.actors_["10115"]) then
				if arg_571_1.var_.actorSpriteComps10115 then
					for iter_574_0, iter_574_1 in pairs(arg_571_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_574_1 then
							if arg_571_1.isInRecall_ then
								iter_574_1.color = Color.New(Mathf.Lerp(iter_574_1.color.r, arg_571_1.hightColor1.r, (arg_571_1.time_ - 0) / var_574_0), Mathf.Lerp(iter_574_1.color.g, arg_571_1.hightColor1.g, (arg_571_1.time_ - 0) / var_574_0), (Mathf.Lerp(iter_574_1.color.b, arg_571_1.hightColor1.b, (arg_571_1.time_ - 0) / var_574_0)))
							else
								local var_574_1 = Mathf.Lerp(iter_574_1.color.r, 1, (arg_571_1.time_ - 0) / var_574_0)

								iter_574_1.color = Color.New(var_574_1, var_574_1, var_574_1)
							end
						end
					end
				end
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 and not isNil(arg_571_1.actors_["10115"]) and arg_571_1.var_.actorSpriteComps10115 then
				for iter_574_2, iter_574_3 in pairs(arg_571_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_574_3 then
						iter_574_3.color = arg_571_1.isInRecall_ and (arg_571_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_571_1.var_.actorSpriteComps10115 = nil
			end

			local var_574_2 = arg_571_1.actors_["1034"]

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(var_574_2) and arg_571_1.var_.actorSpriteComps1034 == nil then
				arg_571_1.var_.actorSpriteComps1034 = var_574_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_574_3 = 0.2

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_3 and not isNil(var_574_2) then
				if arg_571_1.var_.actorSpriteComps1034 then
					for iter_574_4, iter_574_5 in pairs(arg_571_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_574_5 then
							if arg_571_1.isInRecall_ then
								iter_574_5.color = Color.New(Mathf.Lerp(iter_574_5.color.r, arg_571_1.hightColor2.r, (arg_571_1.time_ - 0) / var_574_3), Mathf.Lerp(iter_574_5.color.g, arg_571_1.hightColor2.g, (arg_571_1.time_ - 0) / var_574_3), (Mathf.Lerp(iter_574_5.color.b, arg_571_1.hightColor2.b, (arg_571_1.time_ - 0) / var_574_3)))
							else
								local var_574_4 = Mathf.Lerp(iter_574_5.color.r, 0.5, (arg_571_1.time_ - 0) / var_574_3)

								iter_574_5.color = Color.New(var_574_4, var_574_4, var_574_4)
							end
						end
					end
				end
			end

			if arg_571_1.time_ >= 0 + var_574_3 and arg_571_1.time_ < 0 + var_574_3 + arg_574_0 and not isNil(var_574_2) and arg_571_1.var_.actorSpriteComps1034 then
				for iter_574_6, iter_574_7 in pairs(arg_571_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_574_7 then
						iter_574_7.color = arg_571_1.isInRecall_ and (arg_571_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_571_1.var_.actorSpriteComps1034 = nil
			end

			local var_574_5 = 0
			local var_574_6 = 0.575

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_5 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_7 = arg_571_1:GetWordFromCfg(417241135)
				local var_574_8 = arg_571_1:FormatText(var_574_7.content)

				arg_571_1.text_.text = var_574_8

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_10 = 23 <= 0 and var_574_6 or var_574_6 * (utf8.len(var_574_8) / 23)

				if (23 <= 0 and var_574_6 or var_574_6 * (utf8.len(var_574_8) / 23)) > 0 and var_574_6 < var_574_10 then
					arg_571_1.talkMaxDuration = var_574_10

					if var_574_10 + var_574_5 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_10 + var_574_5
					end
				end

				arg_571_1.text_.text = var_574_8
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241135", "story_v_out_417241.awb") ~= 0 then
					local var_574_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241135", "story_v_out_417241.awb") / 1000

					if var_574_11 + var_574_5 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_11 + var_574_5
					end

					if var_574_7.prefab_name ~= "" and arg_571_1.actors_[var_574_7.prefab_name] ~= nil then
						local var_574_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_7.prefab_name].transform, "story_v_out_417241", "417241135", "story_v_out_417241.awb")

						arg_571_1:RecordAudio("417241135", var_574_12)
						arg_571_1:RecordAudio("417241135", var_574_12)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_417241", "417241135", "story_v_out_417241.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_417241", "417241135", "story_v_out_417241.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_13 = math.max(var_574_6, arg_571_1.talkMaxDuration)

			if var_574_5 <= arg_571_1.time_ and arg_571_1.time_ < var_574_5 + var_574_13 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_5) / var_574_13

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_5 + var_574_13 and arg_571_1.time_ < var_574_5 + var_574_13 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play417241136 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 417241136
		arg_575_1.duration_ = 6.43

		local var_575_0 = {
			zh = 4.1,
			ja = 6.433
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play417241137(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0.375

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_1 = arg_575_1:GetWordFromCfg(417241136)
				local var_578_2 = arg_575_1:FormatText(var_578_1.content)

				arg_575_1.text_.text = var_578_2

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_4 = 15 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_2) / 15)

				if (15 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_2) / 15)) > 0 and var_578_0 < var_578_4 then
					arg_575_1.talkMaxDuration = var_578_4

					if var_578_4 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_4 + 0
					end
				end

				arg_575_1.text_.text = var_578_2
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241136", "story_v_out_417241.awb") ~= 0 then
					local var_578_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241136", "story_v_out_417241.awb") / 1000

					if var_578_5 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_5 + 0
					end

					if var_578_1.prefab_name ~= "" and arg_575_1.actors_[var_578_1.prefab_name] ~= nil then
						local var_578_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_1.prefab_name].transform, "story_v_out_417241", "417241136", "story_v_out_417241.awb")

						arg_575_1:RecordAudio("417241136", var_578_6)
						arg_575_1:RecordAudio("417241136", var_578_6)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_417241", "417241136", "story_v_out_417241.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_417241", "417241136", "story_v_out_417241.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_7 = math.max(var_578_0, arg_575_1.talkMaxDuration)

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_7 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - 0) / var_578_7

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= 0 + var_578_7 and arg_575_1.time_ < 0 + var_578_7 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play417241137 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 417241137
		arg_579_1.duration_ = 4.5

		local var_579_0 = {
			zh = 4.066,
			ja = 4.5
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play417241138(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(arg_579_1.actors_["1034"]) and arg_579_1.var_.actorSpriteComps1034 == nil then
				arg_579_1.var_.actorSpriteComps1034 = arg_579_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_582_0 = 0.2

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_0 and not isNil(arg_579_1.actors_["1034"]) then
				if arg_579_1.var_.actorSpriteComps1034 then
					for iter_582_0, iter_582_1 in pairs(arg_579_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_582_1 then
							if arg_579_1.isInRecall_ then
								iter_582_1.color = Color.New(Mathf.Lerp(iter_582_1.color.r, arg_579_1.hightColor1.r, (arg_579_1.time_ - 0) / var_582_0), Mathf.Lerp(iter_582_1.color.g, arg_579_1.hightColor1.g, (arg_579_1.time_ - 0) / var_582_0), (Mathf.Lerp(iter_582_1.color.b, arg_579_1.hightColor1.b, (arg_579_1.time_ - 0) / var_582_0)))
							else
								local var_582_1 = Mathf.Lerp(iter_582_1.color.r, 1, (arg_579_1.time_ - 0) / var_582_0)

								iter_582_1.color = Color.New(var_582_1, var_582_1, var_582_1)
							end
						end
					end
				end
			end

			if arg_579_1.time_ >= 0 + var_582_0 and arg_579_1.time_ < 0 + var_582_0 + arg_582_0 and not isNil(arg_579_1.actors_["1034"]) and arg_579_1.var_.actorSpriteComps1034 then
				for iter_582_2, iter_582_3 in pairs(arg_579_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_582_3 then
						iter_582_3.color = arg_579_1.isInRecall_ and (arg_579_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_579_1.var_.actorSpriteComps1034 = nil
			end

			local var_582_2 = arg_579_1.actors_["10115"]

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(var_582_2) and arg_579_1.var_.actorSpriteComps10115 == nil then
				arg_579_1.var_.actorSpriteComps10115 = var_582_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_582_3 = 0.2

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_3 and not isNil(var_582_2) then
				if arg_579_1.var_.actorSpriteComps10115 then
					for iter_582_4, iter_582_5 in pairs(arg_579_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_582_5 then
							if arg_579_1.isInRecall_ then
								iter_582_5.color = Color.New(Mathf.Lerp(iter_582_5.color.r, arg_579_1.hightColor2.r, (arg_579_1.time_ - 0) / var_582_3), Mathf.Lerp(iter_582_5.color.g, arg_579_1.hightColor2.g, (arg_579_1.time_ - 0) / var_582_3), (Mathf.Lerp(iter_582_5.color.b, arg_579_1.hightColor2.b, (arg_579_1.time_ - 0) / var_582_3)))
							else
								local var_582_4 = Mathf.Lerp(iter_582_5.color.r, 0.5, (arg_579_1.time_ - 0) / var_582_3)

								iter_582_5.color = Color.New(var_582_4, var_582_4, var_582_4)
							end
						end
					end
				end
			end

			if arg_579_1.time_ >= 0 + var_582_3 and arg_579_1.time_ < 0 + var_582_3 + arg_582_0 and not isNil(var_582_2) and arg_579_1.var_.actorSpriteComps10115 then
				for iter_582_6, iter_582_7 in pairs(arg_579_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_582_7 then
						iter_582_7.color = arg_579_1.isInRecall_ and (arg_579_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_579_1.var_.actorSpriteComps10115 = nil
			end

			local var_582_5 = 0
			local var_582_6 = 0.5

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_5 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_7 = arg_579_1:GetWordFromCfg(417241137)
				local var_582_8 = arg_579_1:FormatText(var_582_7.content)

				arg_579_1.text_.text = var_582_8

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_10 = 20 <= 0 and var_582_6 or var_582_6 * (utf8.len(var_582_8) / 20)

				if (20 <= 0 and var_582_6 or var_582_6 * (utf8.len(var_582_8) / 20)) > 0 and var_582_6 < var_582_10 then
					arg_579_1.talkMaxDuration = var_582_10

					if var_582_10 + var_582_5 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_10 + var_582_5
					end
				end

				arg_579_1.text_.text = var_582_8
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241137", "story_v_out_417241.awb") ~= 0 then
					local var_582_11 = manager.audio:GetVoiceLength("story_v_out_417241", "417241137", "story_v_out_417241.awb") / 1000

					if var_582_11 + var_582_5 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_11 + var_582_5
					end

					if var_582_7.prefab_name ~= "" and arg_579_1.actors_[var_582_7.prefab_name] ~= nil then
						local var_582_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_7.prefab_name].transform, "story_v_out_417241", "417241137", "story_v_out_417241.awb")

						arg_579_1:RecordAudio("417241137", var_582_12)
						arg_579_1:RecordAudio("417241137", var_582_12)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_out_417241", "417241137", "story_v_out_417241.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_out_417241", "417241137", "story_v_out_417241.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_13 = math.max(var_582_6, arg_579_1.talkMaxDuration)

			if var_582_5 <= arg_579_1.time_ and arg_579_1.time_ < var_582_5 + var_582_13 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_5) / var_582_13

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_5 + var_582_13 and arg_579_1.time_ < var_582_5 + var_582_13 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play417241138 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 417241138
		arg_583_1.duration_ = 9.67

		local var_583_0 = {
			zh = 6.1,
			ja = 9.666
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play417241139(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0.65

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_1 = arg_583_1:GetWordFromCfg(417241138)
				local var_586_2 = arg_583_1:FormatText(var_586_1.content)

				arg_583_1.text_.text = var_586_2

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_4 = 26 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_2) / 26)

				if (26 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_2) / 26)) > 0 and var_586_0 < var_586_4 then
					arg_583_1.talkMaxDuration = var_586_4

					if var_586_4 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_4 + 0
					end
				end

				arg_583_1.text_.text = var_586_2
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241138", "story_v_out_417241.awb") ~= 0 then
					local var_586_5 = manager.audio:GetVoiceLength("story_v_out_417241", "417241138", "story_v_out_417241.awb") / 1000

					if var_586_5 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_5 + 0
					end

					if var_586_1.prefab_name ~= "" and arg_583_1.actors_[var_586_1.prefab_name] ~= nil then
						local var_586_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_1.prefab_name].transform, "story_v_out_417241", "417241138", "story_v_out_417241.awb")

						arg_583_1:RecordAudio("417241138", var_586_6)
						arg_583_1:RecordAudio("417241138", var_586_6)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_417241", "417241138", "story_v_out_417241.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_417241", "417241138", "story_v_out_417241.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_7 = math.max(var_586_0, arg_583_1.talkMaxDuration)

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_7 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - 0) / var_586_7

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= 0 + var_586_7 and arg_583_1.time_ < 0 + var_586_7 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play417241139 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 417241139
		arg_587_1.duration_ = 5.2

		local var_587_0 = {
			zh = 3.866,
			ja = 5.2
		}
		local var_587_1 = manager.audio:GetLocalizationFlag()

		if var_587_0[var_587_1] ~= nil then
			arg_587_1.duration_ = var_587_0[var_587_1]
		end

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play417241140(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 and not isNil(arg_587_1.actors_["10115"]) and arg_587_1.var_.actorSpriteComps10115 == nil then
				arg_587_1.var_.actorSpriteComps10115 = arg_587_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_590_0 = 0.2

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_0 and not isNil(arg_587_1.actors_["10115"]) then
				if arg_587_1.var_.actorSpriteComps10115 then
					for iter_590_0, iter_590_1 in pairs(arg_587_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_590_1 then
							if arg_587_1.isInRecall_ then
								iter_590_1.color = Color.New(Mathf.Lerp(iter_590_1.color.r, arg_587_1.hightColor1.r, (arg_587_1.time_ - 0) / var_590_0), Mathf.Lerp(iter_590_1.color.g, arg_587_1.hightColor1.g, (arg_587_1.time_ - 0) / var_590_0), (Mathf.Lerp(iter_590_1.color.b, arg_587_1.hightColor1.b, (arg_587_1.time_ - 0) / var_590_0)))
							else
								local var_590_1 = Mathf.Lerp(iter_590_1.color.r, 1, (arg_587_1.time_ - 0) / var_590_0)

								iter_590_1.color = Color.New(var_590_1, var_590_1, var_590_1)
							end
						end
					end
				end
			end

			if arg_587_1.time_ >= 0 + var_590_0 and arg_587_1.time_ < 0 + var_590_0 + arg_590_0 and not isNil(arg_587_1.actors_["10115"]) and arg_587_1.var_.actorSpriteComps10115 then
				for iter_590_2, iter_590_3 in pairs(arg_587_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_590_3 then
						iter_590_3.color = arg_587_1.isInRecall_ and (arg_587_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_587_1.var_.actorSpriteComps10115 = nil
			end

			local var_590_2 = arg_587_1.actors_["1034"]

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 and not isNil(var_590_2) and arg_587_1.var_.actorSpriteComps1034 == nil then
				arg_587_1.var_.actorSpriteComps1034 = var_590_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_590_3 = 0.2

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_3 and not isNil(var_590_2) then
				if arg_587_1.var_.actorSpriteComps1034 then
					for iter_590_4, iter_590_5 in pairs(arg_587_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_590_5 then
							if arg_587_1.isInRecall_ then
								iter_590_5.color = Color.New(Mathf.Lerp(iter_590_5.color.r, arg_587_1.hightColor2.r, (arg_587_1.time_ - 0) / var_590_3), Mathf.Lerp(iter_590_5.color.g, arg_587_1.hightColor2.g, (arg_587_1.time_ - 0) / var_590_3), (Mathf.Lerp(iter_590_5.color.b, arg_587_1.hightColor2.b, (arg_587_1.time_ - 0) / var_590_3)))
							else
								local var_590_4 = Mathf.Lerp(iter_590_5.color.r, 0.5, (arg_587_1.time_ - 0) / var_590_3)

								iter_590_5.color = Color.New(var_590_4, var_590_4, var_590_4)
							end
						end
					end
				end
			end

			if arg_587_1.time_ >= 0 + var_590_3 and arg_587_1.time_ < 0 + var_590_3 + arg_590_0 and not isNil(var_590_2) and arg_587_1.var_.actorSpriteComps1034 then
				for iter_590_6, iter_590_7 in pairs(arg_587_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_590_7 then
						iter_590_7.color = arg_587_1.isInRecall_ and (arg_587_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_587_1.var_.actorSpriteComps1034 = nil
			end

			local var_590_5 = arg_587_1.actors_["1034"].transform

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.var_.moveOldPos1034 = var_590_5.localPosition
				var_590_5.localScale = Vector3.New(1, 1, 1)

				arg_587_1:CheckSpriteTmpPos("1034", 7)

				for iter_590_8 = 0, var_590_5.childCount - 1 do
					local var_590_6 = var_590_5:GetChild(iter_590_8)

					if var_590_6.name == "" or not string.find(var_590_6.name, "split") then
						var_590_6.gameObject:SetActive(true)
					else
						var_590_6.gameObject:SetActive(false)
					end
				end
			end

			local var_590_7 = 0.001

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_7 then
				var_590_5.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_587_1.time_ - 0) / var_590_7)
			end

			if arg_587_1.time_ >= 0 + var_590_7 and arg_587_1.time_ < 0 + var_590_7 + arg_590_0 then
				var_590_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_590_8 = arg_587_1.actors_["10115"].transform

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.var_.moveOldPos10115 = var_590_8.localPosition
				var_590_8.localScale = Vector3.New(1, 1, 1)

				arg_587_1:CheckSpriteTmpPos("10115", 3)

				for iter_590_9 = 0, var_590_8.childCount - 1 do
					local var_590_9 = var_590_8:GetChild(iter_590_9)

					if var_590_9.name == "split_6" or not string.find(var_590_9.name, "split") then
						var_590_9.gameObject:SetActive(true)
					else
						var_590_9.gameObject:SetActive(false)
					end
				end
			end

			local var_590_10 = 0.001

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_10 then
				var_590_8.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_587_1.time_ - 0) / var_590_10)
			end

			if arg_587_1.time_ >= 0 + var_590_10 and arg_587_1.time_ < 0 + var_590_10 + arg_590_0 then
				var_590_8.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_590_11 = 0
			local var_590_12 = 0.35

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_11 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				arg_587_1.leftNameTxt_.text = arg_587_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_13 = arg_587_1:GetWordFromCfg(417241139)
				local var_590_14 = arg_587_1:FormatText(var_590_13.content)

				arg_587_1.text_.text = var_590_14

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_16 = 14 <= 0 and var_590_12 or var_590_12 * (utf8.len(var_590_14) / 14)

				if (14 <= 0 and var_590_12 or var_590_12 * (utf8.len(var_590_14) / 14)) > 0 and var_590_12 < var_590_16 then
					arg_587_1.talkMaxDuration = var_590_16

					if var_590_16 + var_590_11 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_16 + var_590_11
					end
				end

				arg_587_1.text_.text = var_590_14
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241139", "story_v_out_417241.awb") ~= 0 then
					local var_590_17 = manager.audio:GetVoiceLength("story_v_out_417241", "417241139", "story_v_out_417241.awb") / 1000

					if var_590_17 + var_590_11 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_17 + var_590_11
					end

					if var_590_13.prefab_name ~= "" and arg_587_1.actors_[var_590_13.prefab_name] ~= nil then
						local var_590_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_13.prefab_name].transform, "story_v_out_417241", "417241139", "story_v_out_417241.awb")

						arg_587_1:RecordAudio("417241139", var_590_18)
						arg_587_1:RecordAudio("417241139", var_590_18)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_out_417241", "417241139", "story_v_out_417241.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_out_417241", "417241139", "story_v_out_417241.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_19 = math.max(var_590_12, arg_587_1.talkMaxDuration)

			if var_590_11 <= arg_587_1.time_ and arg_587_1.time_ < var_590_11 + var_590_19 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_11) / var_590_19

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_11 + var_590_19 and arg_587_1.time_ < var_590_11 + var_590_19 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {
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
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_587_1:InitPlayNodeList()
	end,
	Play417241140 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 417241140
		arg_591_1.duration_ = 2.8

		local var_591_0 = {
			zh = 2.8,
			ja = 1.866
		}
		local var_591_1 = manager.audio:GetLocalizationFlag()

		if var_591_0[var_591_1] ~= nil then
			arg_591_1.duration_ = var_591_0[var_591_1]
		end

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
			arg_591_1.auto_ = false
		end

		function arg_591_1.playNext_(arg_593_0)
			arg_591_1.onStoryFinished_()
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.var_.moveOldPos10115 = arg_591_1.actors_["10115"].transform.localPosition
				arg_591_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_591_1:CheckSpriteTmpPos("10115", 3)

				for iter_594_0 = 0, arg_591_1.actors_["10115"].transform.childCount - 1 do
					local var_594_0 = arg_591_1.actors_["10115"].transform:GetChild(iter_594_0)

					if var_594_0.name == "split_6" or not string.find(var_594_0.name, "split") then
						var_594_0.gameObject:SetActive(true)
					else
						var_594_0.gameObject:SetActive(false)
					end
				end
			end

			local var_594_1 = 0.001

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_1 then
				arg_591_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_591_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_591_1.time_ - 0) / var_594_1)
			end

			if arg_591_1.time_ >= 0 + var_594_1 and arg_591_1.time_ < 0 + var_594_1 + arg_594_0 then
				arg_591_1.actors_["10115"].transform.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_594_2 = 0
			local var_594_3 = 0.225

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_2 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_4 = arg_591_1:GetWordFromCfg(417241140)
				local var_594_5 = arg_591_1:FormatText(var_594_4.content)

				arg_591_1.text_.text = var_594_5

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_7 = 9 <= 0 and var_594_3 or var_594_3 * (utf8.len(var_594_5) / 9)

				if (9 <= 0 and var_594_3 or var_594_3 * (utf8.len(var_594_5) / 9)) > 0 and var_594_3 < var_594_7 then
					arg_591_1.talkMaxDuration = var_594_7

					if var_594_7 + var_594_2 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_7 + var_594_2
					end
				end

				arg_591_1.text_.text = var_594_5
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417241", "417241140", "story_v_out_417241.awb") ~= 0 then
					local var_594_8 = manager.audio:GetVoiceLength("story_v_out_417241", "417241140", "story_v_out_417241.awb") / 1000

					if var_594_8 + var_594_2 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_8 + var_594_2
					end

					if var_594_4.prefab_name ~= "" and arg_591_1.actors_[var_594_4.prefab_name] ~= nil then
						local var_594_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_4.prefab_name].transform, "story_v_out_417241", "417241140", "story_v_out_417241.awb")

						arg_591_1:RecordAudio("417241140", var_594_9)
						arg_591_1:RecordAudio("417241140", var_594_9)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_out_417241", "417241140", "story_v_out_417241.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_out_417241", "417241140", "story_v_out_417241.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_10 = math.max(var_594_3, arg_591_1.talkMaxDuration)

			if var_594_2 <= arg_591_1.time_ and arg_591_1.time_ < var_594_2 + var_594_10 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_2) / var_594_10

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_2 + var_594_10 and arg_591_1.time_ < var_594_2 + var_594_10 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_591_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/SS1710",
		"TextureConfig/Background/I17f",
		"TextureConfig/Background/ST75",
		"TextureConfig/Background/I17l",
		"TextureConfig/Background/SS1709"
	},
	voices = {
		"story_v_out_417241.awb"
	}
}
