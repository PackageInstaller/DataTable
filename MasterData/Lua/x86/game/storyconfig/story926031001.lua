return {
	Play926031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926031001
		arg_1_1.duration_ = 4.7

		local var_1_0 = {
			zh = 4.7,
			ja = 3.9
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
				arg_1_0:Play926031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0114 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0114")
				var_4_0.name = "ST0114"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0114 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0114

				arg_1_1.bgs_.ST0114.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0114" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

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

			local var_4_9 = "128404"

			if arg_1_1.actors_["128404"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_4_10) then
					local var_4_11 = Object.Instantiate(var_4_10, arg_1_1.canvasGo_.transform)

					var_4_11.transform:SetSiblingIndex(1)

					var_4_11.name = var_4_9
					var_4_11.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_9] = var_4_11

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs((var_4_11:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_12 = arg_1_1.actors_["128404"]

			if 1.675 < arg_1_1.time_ and arg_1_1.time_ <= 1.675 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps128404 == nil then
				arg_1_1.var_.actorSpriteComps128404 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 1.675 <= arg_1_1.time_ and arg_1_1.time_ < 1.675 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps128404 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.675) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.675) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.675) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 1.675) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.675 + var_4_13 and arg_1_1.time_ < 1.675 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps128404 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps128404 = nil
			end

			local var_4_15 = arg_1_1.actors_["128404"].transform

			if 1.675 < arg_1_1.time_ and arg_1_1.time_ <= 1.675 + arg_4_0 then
				arg_1_1.var_.moveOldPos128404 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("128404", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "split_2" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 1.675 <= arg_1_1.time_ and arg_1_1.time_ < 1.675 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_1_1.time_ - 1.675) / var_4_17)
			end

			if arg_1_1.time_ >= 1.675 + var_4_17 and arg_1_1.time_ < 1.675 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-16.1, -362, -375)
			end

			if 1.675 < arg_1_1.time_ and arg_1_1.time_ <= 1.675 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["128404"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue128404 = var_4_18.alpha
					arg_1_1.var_.characterEffect128404 = var_4_18
				end

				arg_1_1.var_.alphaOldValue128404 = 0
			end

			local var_4_19 = 0.325

			if 1.675 <= arg_1_1.time_ and arg_1_1.time_ < 1.675 + var_4_19 then
				if arg_1_1.var_.characterEffect128404 then
					arg_1_1.var_.characterEffect128404.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue128404, 1, (arg_1_1.time_ - 1.675) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.675 + var_4_19 and arg_1_1.time_ < 1.675 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect128404 then
				arg_1_1.var_.characterEffect128404.alpha = 1
			end

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			if 0.7 < arg_1_1.time_ and arg_1_1.time_ <= 0.7 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern.awb")

				local var_4_26 = manager.audio:GetAudioName("bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_26 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_26

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_26
						arg_1_1.bgmTxt2_.text = var_4_26
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

			local var_4_27 = 2
			local var_4_28 = 0.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_29 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_29:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_30 = arg_1_1:GetWordFromCfg(926031001)
				local var_4_31 = arg_1_1:FormatText(var_4_30.content)

				arg_1_1.text_.text = var_4_31

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 5 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 5)

				if (5 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 5)) > 0 and var_4_28 < var_4_33 then
					arg_1_1.talkMaxDuration = var_4_33
					var_4_27 = var_4_27 + 0.3

					if var_4_33 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_27
					end
				end

				arg_1_1.text_.text = var_4_31
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031001", "story_v_out_926031.awb") ~= 0 then
					local var_4_34 = manager.audio:GetVoiceLength("story_v_out_926031", "926031001", "story_v_out_926031.awb") / 1000

					if var_4_34 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_27
					end

					if var_4_30.prefab_name ~= "" and arg_1_1.actors_[var_4_30.prefab_name] ~= nil then
						local var_4_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_30.prefab_name].transform, "story_v_out_926031", "926031001", "story_v_out_926031.awb")

						arg_1_1:RecordAudio("926031001", var_4_35)
						arg_1_1:RecordAudio("926031001", var_4_35)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926031", "926031001", "story_v_out_926031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926031", "926031001", "story_v_out_926031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_27 + 0.3
			local var_4_37 = math.max(var_4_28, arg_1_1.talkMaxDuration)

			if var_4_27 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.675,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play926031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 926031002
		arg_9_1.duration_ = 9.43

		local var_9_0 = {
			zh = 6.766,
			ja = 9.433
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play926031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["104701"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "104701"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["104701"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["104701"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps104701 == nil then
				arg_9_1.var_.actorSpriteComps104701 = var_12_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_3 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 and not isNil(var_12_2) then
				if arg_9_1.var_.actorSpriteComps104701 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_12_3 then
							if arg_9_1.isInRecall_ then
								iter_12_3.color = Color.New(Mathf.Lerp(iter_12_3.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_3), Mathf.Lerp(iter_12_3.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_3), (Mathf.Lerp(iter_12_3.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_3)))
							else
								local var_12_4 = Mathf.Lerp(iter_12_3.color.r, 1, (arg_9_1.time_ - 0) / var_12_3)

								iter_12_3.color = Color.New(var_12_4, var_12_4, var_12_4)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps104701 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_12_5 then
						iter_12_5.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps104701 = nil
			end

			local var_12_5 = arg_9_1.actors_["128404"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps128404 == nil then
				arg_9_1.var_.actorSpriteComps128404 = var_12_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.actorSpriteComps128404 then
					for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_12_7 then
							if arg_9_1.isInRecall_ then
								iter_12_7.color = Color.New(Mathf.Lerp(iter_12_7.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_6), Mathf.Lerp(iter_12_7.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_6), (Mathf.Lerp(iter_12_7.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_6)))
							else
								local var_12_7 = Mathf.Lerp(iter_12_7.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_6)

								iter_12_7.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps128404 then
				for iter_12_8, iter_12_9 in pairs(arg_9_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_12_9 then
						iter_12_9.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps128404 = nil
			end

			local var_12_8 = arg_9_1.actors_["128404"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos128404 = var_12_8.localPosition
				var_12_8.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("128404", 7)

				for iter_12_10 = 0, var_12_8.childCount - 1 do
					local var_12_9 = var_12_8:GetChild(iter_12_10)

					if var_12_9.name == "" or not string.find(var_12_9.name, "split") then
						var_12_9.gameObject:SetActive(true)
					else
						var_12_9.gameObject:SetActive(false)
					end
				end
			end

			local var_12_10 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_10 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_9_1.time_ - 0) / var_12_10)
			end

			if arg_9_1.time_ >= 0 + var_12_10 and arg_9_1.time_ < 0 + var_12_10 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_11 = arg_9_1.actors_["104701"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos104701 = var_12_11.localPosition
				var_12_11.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("104701", 3)

				for iter_12_11 = 0, var_12_11.childCount - 1 do
					local var_12_12 = var_12_11:GetChild(iter_12_11)

					if var_12_12.name == "" or not string.find(var_12_12.name, "split") then
						var_12_12.gameObject:SetActive(true)
					else
						var_12_12.gameObject:SetActive(false)
					end
				end
			end

			local var_12_13 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_13 then
				var_12_11.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_9_1.time_ - 0) / var_12_13)
			end

			if arg_9_1.time_ >= 0 + var_12_13 and arg_9_1.time_ < 0 + var_12_13 + arg_12_0 then
				var_12_11.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_12_14 = 0
			local var_12_15 = 0.675

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_16 = arg_9_1:GetWordFromCfg(926031002)
				local var_12_17 = arg_9_1:FormatText(var_12_16.content)

				arg_9_1.text_.text = var_12_17

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 27 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 27)

				if (27 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 27)) > 0 and var_12_15 < var_12_19 then
					arg_9_1.talkMaxDuration = var_12_19

					if var_12_19 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_19 + var_12_14
					end
				end

				arg_9_1.text_.text = var_12_17
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031002", "story_v_out_926031.awb") ~= 0 then
					local var_12_20 = manager.audio:GetVoiceLength("story_v_out_926031", "926031002", "story_v_out_926031.awb") / 1000

					if var_12_20 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_20 + var_12_14
					end

					if var_12_16.prefab_name ~= "" and arg_9_1.actors_[var_12_16.prefab_name] ~= nil then
						local var_12_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_16.prefab_name].transform, "story_v_out_926031", "926031002", "story_v_out_926031.awb")

						arg_9_1:RecordAudio("926031002", var_12_21)
						arg_9_1:RecordAudio("926031002", var_12_21)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_926031", "926031002", "story_v_out_926031.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_926031", "926031002", "story_v_out_926031.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_22 = math.max(var_12_15, arg_9_1.talkMaxDuration)

			if var_12_14 <= arg_9_1.time_ and arg_9_1.time_ < var_12_14 + var_12_22 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_14) / var_12_22

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_14 + var_12_22 and arg_9_1.time_ < var_12_14 + var_12_22 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play926031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 926031003
		arg_13_1.duration_ = 9.67

		local var_13_0 = {
			zh = 7.533,
			ja = 9.666
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
				arg_13_0:Play926031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.85

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(926031003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 34)

				if (34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 34)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031003", "story_v_out_926031.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_926031", "926031003", "story_v_out_926031.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_926031", "926031003", "story_v_out_926031.awb")

						arg_13_1:RecordAudio("926031003", var_16_6)
						arg_13_1:RecordAudio("926031003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_926031", "926031003", "story_v_out_926031.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_926031", "926031003", "story_v_out_926031.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play926031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 926031004
		arg_17_1.duration_ = 7.5

		local var_17_0 = {
			zh = 4.7,
			ja = 7.5
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
				arg_17_0:Play926031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["128404"]) and arg_17_1.var_.actorSpriteComps128404 == nil then
				arg_17_1.var_.actorSpriteComps128404 = arg_17_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["128404"]) then
				if arg_17_1.var_.actorSpriteComps128404 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								iter_20_1.color = Color.New(Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_0), Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_0), (Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_0)))
							else
								local var_20_1 = Mathf.Lerp(iter_20_1.color.r, 1, (arg_17_1.time_ - 0) / var_20_0)

								iter_20_1.color = Color.New(var_20_1, var_20_1, var_20_1)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["128404"]) and arg_17_1.var_.actorSpriteComps128404 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps128404 = nil
			end

			local var_20_2 = arg_17_1.actors_["104701"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps104701 == nil then
				arg_17_1.var_.actorSpriteComps104701 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps104701 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								iter_20_5.color = Color.New(Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_5.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_5.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps104701 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_20_7 then
						iter_20_7.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps104701 = nil
			end

			local var_20_5 = arg_17_1.actors_["104701"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos104701 = var_20_5.localPosition
				var_20_5.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("104701", 7)

				for iter_20_8 = 0, var_20_5.childCount - 1 do
					local var_20_6 = var_20_5:GetChild(iter_20_8)

					if var_20_6.name == "" or not string.find(var_20_6.name, "split") then
						var_20_6.gameObject:SetActive(true)
					else
						var_20_6.gameObject:SetActive(false)
					end
				end
			end

			local var_20_7 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_17_1.time_ - 0) / var_20_7)
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_8 = arg_17_1.actors_["128404"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos128404 = var_20_8.localPosition
				var_20_8.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("128404", 3)

				for iter_20_9 = 0, var_20_8.childCount - 1 do
					local var_20_9 = var_20_8:GetChild(iter_20_9)

					if var_20_9.name == "" or not string.find(var_20_9.name, "split") then
						var_20_9.gameObject:SetActive(true)
					else
						var_20_9.gameObject:SetActive(false)
					end
				end
			end

			local var_20_10 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_10 then
				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_17_1.time_ - 0) / var_20_10)
			end

			if arg_17_1.time_ >= 0 + var_20_10 and arg_17_1.time_ < 0 + var_20_10 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_20_11 = 0
			local var_20_12 = 0.6

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_13 = arg_17_1:GetWordFromCfg(926031004)
				local var_20_14 = arg_17_1:FormatText(var_20_13.content)

				arg_17_1.text_.text = var_20_14

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_16 = 24 <= 0 and var_20_12 or var_20_12 * (utf8.len(var_20_14) / 24)

				if (24 <= 0 and var_20_12 or var_20_12 * (utf8.len(var_20_14) / 24)) > 0 and var_20_12 < var_20_16 then
					arg_17_1.talkMaxDuration = var_20_16

					if var_20_16 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_11
					end
				end

				arg_17_1.text_.text = var_20_14
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031004", "story_v_out_926031.awb") ~= 0 then
					local var_20_17 = manager.audio:GetVoiceLength("story_v_out_926031", "926031004", "story_v_out_926031.awb") / 1000

					if var_20_17 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_11
					end

					if var_20_13.prefab_name ~= "" and arg_17_1.actors_[var_20_13.prefab_name] ~= nil then
						local var_20_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_13.prefab_name].transform, "story_v_out_926031", "926031004", "story_v_out_926031.awb")

						arg_17_1:RecordAudio("926031004", var_20_18)
						arg_17_1:RecordAudio("926031004", var_20_18)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_926031", "926031004", "story_v_out_926031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_926031", "926031004", "story_v_out_926031.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_19 = math.max(var_20_12, arg_17_1.talkMaxDuration)

			if var_20_11 <= arg_17_1.time_ and arg_17_1.time_ < var_20_11 + var_20_19 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_11) / var_20_19

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_11 + var_20_19 and arg_17_1.time_ < var_20_11 + var_20_19 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play926031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 926031005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play926031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["128404"]) and arg_21_1.var_.actorSpriteComps128404 == nil then
				arg_21_1.var_.actorSpriteComps128404 = arg_21_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["128404"]) then
				if arg_21_1.var_.actorSpriteComps128404 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								iter_24_1.color = Color.New(Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_0), Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_0), (Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_0)))
							else
								local var_24_1 = Mathf.Lerp(iter_24_1.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_0)

								iter_24_1.color = Color.New(var_24_1, var_24_1, var_24_1)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["128404"]) and arg_21_1.var_.actorSpriteComps128404 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps128404 = nil
			end

			local var_24_2 = 0
			local var_24_3 = 0.575

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_4 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(926031005).content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 23 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 23)

				if (23 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 23)) > 0 and var_24_3 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_7 and arg_21_1.time_ < var_24_2 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play926031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 926031006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play926031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(926031006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 17 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 17)

				if (17 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 17)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play926031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 926031007
		arg_29_1.duration_ = 5.37

		local var_29_0 = {
			zh = 4.266,
			ja = 5.366
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
				arg_29_0:Play926031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["106103"] == nil then
				local var_32_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106103")

				if not isNil(var_32_0) then
					local var_32_1 = Object.Instantiate(var_32_0, arg_29_1.canvasGo_.transform)

					var_32_1.transform:SetSiblingIndex(1)

					var_32_1.name = "106103"
					var_32_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_29_1.actors_["106103"] = var_32_1

					if arg_29_1.isInRecall_ then
						for iter_32_0, iter_32_1 in ipairs((var_32_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_32_1.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_32_2 = arg_29_1.actors_["106103"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps106103 == nil then
				arg_29_1.var_.actorSpriteComps106103 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps106103 then
					for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_32_3 then
							if arg_29_1.isInRecall_ then
								iter_32_3.color = Color.New(Mathf.Lerp(iter_32_3.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_3.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_3.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_3.color.r, 1, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_3.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps106103 then
				for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_32_5 then
						iter_32_5.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps106103 = nil
			end

			local var_32_5 = arg_29_1.actors_["104701"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos104701 = var_32_5.localPosition
				var_32_5.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("104701", 7)

				for iter_32_6 = 0, var_32_5.childCount - 1 do
					local var_32_6 = var_32_5:GetChild(iter_32_6)

					if var_32_6.name == "" or not string.find(var_32_6.name, "split") then
						var_32_6.gameObject:SetActive(true)
					else
						var_32_6.gameObject:SetActive(false)
					end
				end
			end

			local var_32_7 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_29_1.time_ - 0) / var_32_7)
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_8 = arg_29_1.actors_["128404"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos128404 = var_32_8.localPosition
				var_32_8.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("128404", 7)

				for iter_32_7 = 0, var_32_8.childCount - 1 do
					local var_32_9 = var_32_8:GetChild(iter_32_7)

					if var_32_9.name == "" or not string.find(var_32_9.name, "split") then
						var_32_9.gameObject:SetActive(true)
					else
						var_32_9.gameObject:SetActive(false)
					end
				end
			end

			local var_32_10 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_10 then
				var_32_8.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_29_1.time_ - 0) / var_32_10)
			end

			if arg_29_1.time_ >= 0 + var_32_10 and arg_29_1.time_ < 0 + var_32_10 + arg_32_0 then
				var_32_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_11 = arg_29_1.actors_["106103"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos106103 = var_32_11.localPosition
				var_32_11.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("106103", 3)

				for iter_32_8 = 0, var_32_11.childCount - 1 do
					local var_32_12 = var_32_11:GetChild(iter_32_8)

					if var_32_12.name == "split_3" or not string.find(var_32_12.name, "split") then
						var_32_12.gameObject:SetActive(true)
					else
						var_32_12.gameObject:SetActive(false)
					end
				end
			end

			local var_32_13 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_13 then
				var_32_11.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_29_1.time_ - 0) / var_32_13)
			end

			if arg_29_1.time_ >= 0 + var_32_13 and arg_29_1.time_ < 0 + var_32_13 + arg_32_0 then
				var_32_11.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_32_14 = 0
			local var_32_15 = 0.425

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_16 = arg_29_1:GetWordFromCfg(926031007)
				local var_32_17 = arg_29_1:FormatText(var_32_16.content)

				arg_29_1.text_.text = var_32_17

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_19 = 17 <= 0 and var_32_15 or var_32_15 * (utf8.len(var_32_17) / 17)

				if (17 <= 0 and var_32_15 or var_32_15 * (utf8.len(var_32_17) / 17)) > 0 and var_32_15 < var_32_19 then
					arg_29_1.talkMaxDuration = var_32_19

					if var_32_19 + var_32_14 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_14
					end
				end

				arg_29_1.text_.text = var_32_17
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031007", "story_v_out_926031.awb") ~= 0 then
					local var_32_20 = manager.audio:GetVoiceLength("story_v_out_926031", "926031007", "story_v_out_926031.awb") / 1000

					if var_32_20 + var_32_14 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_14
					end

					if var_32_16.prefab_name ~= "" and arg_29_1.actors_[var_32_16.prefab_name] ~= nil then
						local var_32_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_16.prefab_name].transform, "story_v_out_926031", "926031007", "story_v_out_926031.awb")

						arg_29_1:RecordAudio("926031007", var_32_21)
						arg_29_1:RecordAudio("926031007", var_32_21)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926031", "926031007", "story_v_out_926031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926031", "926031007", "story_v_out_926031.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_22 = math.max(var_32_15, arg_29_1.talkMaxDuration)

			if var_32_14 <= arg_29_1.time_ and arg_29_1.time_ < var_32_14 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_14) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_14 + var_32_22 and arg_29_1.time_ < var_32_14 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play926031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 926031008
		arg_33_1.duration_ = 4.3

		local var_33_0 = {
			zh = 3.2,
			ja = 4.3
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
				arg_33_0:Play926031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["104701"]) and arg_33_1.var_.actorSpriteComps104701 == nil then
				arg_33_1.var_.actorSpriteComps104701 = arg_33_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["104701"]) then
				if arg_33_1.var_.actorSpriteComps104701 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								iter_36_1.color = Color.New(Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_0), Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_0), (Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_0)))
							else
								local var_36_1 = Mathf.Lerp(iter_36_1.color.r, 1, (arg_33_1.time_ - 0) / var_36_0)

								iter_36_1.color = Color.New(var_36_1, var_36_1, var_36_1)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["104701"]) and arg_33_1.var_.actorSpriteComps104701 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps104701 = nil
			end

			local var_36_2 = arg_33_1.actors_["106103"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps106103 == nil then
				arg_33_1.var_.actorSpriteComps106103 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps106103 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								iter_36_5.color = Color.New(Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_5.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_5.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps106103 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_36_7 then
						iter_36_7.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps106103 = nil
			end

			local var_36_5 = 0
			local var_36_6 = 0.325

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_1")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_7 = arg_33_1:GetWordFromCfg(926031008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 13 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 13)

				if (13 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 13)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031008", "story_v_out_926031.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031008", "story_v_out_926031.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_926031", "926031008", "story_v_out_926031.awb")

						arg_33_1:RecordAudio("926031008", var_36_12)
						arg_33_1:RecordAudio("926031008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_926031", "926031008", "story_v_out_926031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_926031", "926031008", "story_v_out_926031.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_13 and arg_33_1.time_ < var_36_5 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play926031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 926031009
		arg_37_1.duration_ = 1.67

		local var_37_0 = {
			zh = 1.366,
			ja = 1.666
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
				arg_37_0:Play926031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["106103"]) and arg_37_1.var_.actorSpriteComps106103 == nil then
				arg_37_1.var_.actorSpriteComps106103 = arg_37_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["106103"]) then
				if arg_37_1.var_.actorSpriteComps106103 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								iter_40_1.color = Color.New(Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_0), Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_0), (Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_0)))
							else
								local var_40_1 = Mathf.Lerp(iter_40_1.color.r, 1, (arg_37_1.time_ - 0) / var_40_0)

								iter_40_1.color = Color.New(var_40_1, var_40_1, var_40_1)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["106103"]) and arg_37_1.var_.actorSpriteComps106103 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps106103 = nil
			end

			local var_40_2 = arg_37_1.actors_["104701"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps104701 == nil then
				arg_37_1.var_.actorSpriteComps104701 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps104701 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								iter_40_5.color = Color.New(Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_5.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_5.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps104701 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_40_7 then
						iter_40_7.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps104701 = nil
			end

			local var_40_5 = arg_37_1.actors_["106103"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos106103 = var_40_5.localPosition
				var_40_5.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("106103", 3)

				for iter_40_8 = 0, var_40_5.childCount - 1 do
					local var_40_6 = var_40_5:GetChild(iter_40_8)

					if var_40_6.name == "split_4" or not string.find(var_40_6.name, "split") then
						var_40_6.gameObject:SetActive(true)
					else
						var_40_6.gameObject:SetActive(false)
					end
				end
			end

			local var_40_7 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_37_1.time_ - 0) / var_40_7)
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_40_8 = 0
			local var_40_9 = 0.125

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(926031009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 5 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 5)

				if (5 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 5)) > 0 and var_40_9 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031009", "story_v_out_926031.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_926031", "926031009", "story_v_out_926031.awb") / 1000

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_926031", "926031009", "story_v_out_926031.awb")

						arg_37_1:RecordAudio("926031009", var_40_15)
						arg_37_1:RecordAudio("926031009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_926031", "926031009", "story_v_out_926031.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_926031", "926031009", "story_v_out_926031.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_16 and arg_37_1.time_ < var_40_8 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play926031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 926031010
		arg_41_1.duration_ = 6.67

		local var_41_0 = {
			zh = 4.066,
			ja = 6.666
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
				arg_41_0:Play926031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["104701"]) and arg_41_1.var_.actorSpriteComps104701 == nil then
				arg_41_1.var_.actorSpriteComps104701 = arg_41_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["104701"]) then
				if arg_41_1.var_.actorSpriteComps104701 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 1, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["104701"]) and arg_41_1.var_.actorSpriteComps104701 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps104701 = nil
			end

			local var_44_2 = arg_41_1.actors_["106103"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps106103 == nil then
				arg_41_1.var_.actorSpriteComps106103 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps106103 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								iter_44_5.color = Color.New(Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_5.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_5.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps106103 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_44_7 then
						iter_44_7.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps106103 = nil
			end

			local var_44_5 = 0
			local var_44_6 = 0.45

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_1")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_7 = arg_41_1:GetWordFromCfg(926031010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 18 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 18)

				if (18 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 18)) > 0 and var_44_6 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031010", "story_v_out_926031.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031010", "story_v_out_926031.awb") / 1000

					if var_44_11 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_5
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_926031", "926031010", "story_v_out_926031.awb")

						arg_41_1:RecordAudio("926031010", var_44_12)
						arg_41_1:RecordAudio("926031010", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_926031", "926031010", "story_v_out_926031.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_926031", "926031010", "story_v_out_926031.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_13 = math.max(var_44_6, arg_41_1.talkMaxDuration)

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_13 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_5) / var_44_13

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_5 + var_44_13 and arg_41_1.time_ < var_44_5 + var_44_13 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play926031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 926031011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play926031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["104701"]) and arg_45_1.var_.actorSpriteComps104701 == nil then
				arg_45_1.var_.actorSpriteComps104701 = arg_45_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["104701"]) then
				if arg_45_1.var_.actorSpriteComps104701 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								iter_48_1.color = Color.New(Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_0), Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_0), (Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_0)))
							else
								local var_48_1 = Mathf.Lerp(iter_48_1.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_0)

								iter_48_1.color = Color.New(var_48_1, var_48_1, var_48_1)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["104701"]) and arg_45_1.var_.actorSpriteComps104701 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps104701 = nil
			end

			local var_48_2 = arg_45_1.actors_["106103"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos106103 = var_48_2.localPosition
				var_48_2.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("106103", 7)

				for iter_48_4 = 0, var_48_2.childCount - 1 do
					local var_48_3 = var_48_2:GetChild(iter_48_4)

					if var_48_3.name == "" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_2.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_45_1.time_ - 0) / var_48_4)
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_5 = 0
			local var_48_6 = 1.4

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(926031011).content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 56 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_7) / 56)

				if (56 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_7) / 56)) > 0 and var_48_6 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_10 and arg_45_1.time_ < var_48_5 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play926031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 926031012
		arg_49_1.duration_ = 7.23

		local var_49_0 = {
			zh = 7.133,
			ja = 7.233
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
				arg_49_0:Play926031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["104701"]) and arg_49_1.var_.actorSpriteComps104701 == nil then
				arg_49_1.var_.actorSpriteComps104701 = arg_49_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["104701"]) then
				if arg_49_1.var_.actorSpriteComps104701 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								iter_52_1.color = Color.New(Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_0), Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_0), (Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_0)))
							else
								local var_52_1 = Mathf.Lerp(iter_52_1.color.r, 1, (arg_49_1.time_ - 0) / var_52_0)

								iter_52_1.color = Color.New(var_52_1, var_52_1, var_52_1)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["104701"]) and arg_49_1.var_.actorSpriteComps104701 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps104701 = nil
			end

			local var_52_2 = arg_49_1.actors_["104701"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos104701 = var_52_2.localPosition
				var_52_2.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("104701", 3)

				for iter_52_4 = 0, var_52_2.childCount - 1 do
					local var_52_3 = var_52_2:GetChild(iter_52_4)

					if var_52_3.name == "split_1" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_2.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_49_1.time_ - 0) / var_52_4)
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_2.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_52_5 = 0
			local var_52_6 = 0.875

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(926031012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 35 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 35)

				if (35 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 35)) > 0 and var_52_6 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031012", "story_v_out_926031.awb") ~= 0 then
					local var_52_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031012", "story_v_out_926031.awb") / 1000

					if var_52_11 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_5
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_926031", "926031012", "story_v_out_926031.awb")

						arg_49_1:RecordAudio("926031012", var_52_12)
						arg_49_1:RecordAudio("926031012", var_52_12)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_926031", "926031012", "story_v_out_926031.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_926031", "926031012", "story_v_out_926031.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_13 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_13 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_13

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_13 and arg_49_1.time_ < var_52_5 + var_52_13 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
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
	Play926031013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 926031013
		arg_53_1.duration_ = 8.8

		local var_53_0 = {
			zh = 7.533,
			ja = 8.8
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
				arg_53_0:Play926031014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.725

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(926031013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 29 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 29)

				if (29 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 29)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031013", "story_v_out_926031.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_926031", "926031013", "story_v_out_926031.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_926031", "926031013", "story_v_out_926031.awb")

						arg_53_1:RecordAudio("926031013", var_56_6)
						arg_53_1:RecordAudio("926031013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_926031", "926031013", "story_v_out_926031.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_926031", "926031013", "story_v_out_926031.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play926031014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 926031014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play926031015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["104701"]) and arg_57_1.var_.actorSpriteComps104701 == nil then
				arg_57_1.var_.actorSpriteComps104701 = arg_57_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["104701"]) then
				if arg_57_1.var_.actorSpriteComps104701 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								iter_60_1.color = Color.New(Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_0), Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_0), (Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_0)))
							else
								local var_60_1 = Mathf.Lerp(iter_60_1.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_0)

								iter_60_1.color = Color.New(var_60_1, var_60_1, var_60_1)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["104701"]) and arg_57_1.var_.actorSpriteComps104701 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps104701 = nil
			end

			local var_60_2 = arg_57_1.actors_["104701"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos104701 = var_60_2.localPosition
				var_60_2.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("104701", 7)

				for iter_60_4 = 0, var_60_2.childCount - 1 do
					local var_60_3 = var_60_2:GetChild(iter_60_4)

					if var_60_3.name == "" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_57_1.time_ - 0) / var_60_4)
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_5 = 0
			local var_60_6 = 1.3

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(926031014).content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 52 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_7) / 52)

				if (52 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_7) / 52)) > 0 and var_60_6 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_10 and arg_57_1.time_ < var_60_5 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play926031015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 926031015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play926031016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.55

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(926031015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 22 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 22)

				if (22 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 22)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play926031016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 926031016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play926031017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.325

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(926031016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 13)

				if (13 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 13)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play926031017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 926031017
		arg_69_1.duration_ = 3.37

		local var_69_0 = {
			zh = 2.933,
			ja = 3.366
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
				arg_69_0:Play926031018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["106103"]) and arg_69_1.var_.actorSpriteComps106103 == nil then
				arg_69_1.var_.actorSpriteComps106103 = arg_69_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["106103"]) then
				if arg_69_1.var_.actorSpriteComps106103 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								iter_72_1.color = Color.New(Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_0), Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_0), (Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_0)))
							else
								local var_72_1 = Mathf.Lerp(iter_72_1.color.r, 1, (arg_69_1.time_ - 0) / var_72_0)

								iter_72_1.color = Color.New(var_72_1, var_72_1, var_72_1)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["106103"]) and arg_69_1.var_.actorSpriteComps106103 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps106103 = nil
			end

			local var_72_2 = arg_69_1.actors_["106103"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos106103 = var_72_2.localPosition
				var_72_2.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("106103", 3)

				for iter_72_4 = 0, var_72_2.childCount - 1 do
					local var_72_3 = var_72_2:GetChild(iter_72_4)

					if var_72_3.name == "split_4" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_2.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_69_1.time_ - 0) / var_72_4)
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_2.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_72_5 = 0
			local var_72_6 = 0.25

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:GetWordFromCfg(926031017)
				local var_72_8 = arg_69_1:FormatText(var_72_7.content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 10 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 10)

				if (10 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 10)) > 0 and var_72_6 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031017", "story_v_out_926031.awb") ~= 0 then
					local var_72_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031017", "story_v_out_926031.awb") / 1000

					if var_72_11 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_5
					end

					if var_72_7.prefab_name ~= "" and arg_69_1.actors_[var_72_7.prefab_name] ~= nil then
						local var_72_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_7.prefab_name].transform, "story_v_out_926031", "926031017", "story_v_out_926031.awb")

						arg_69_1:RecordAudio("926031017", var_72_12)
						arg_69_1:RecordAudio("926031017", var_72_12)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_926031", "926031017", "story_v_out_926031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_926031", "926031017", "story_v_out_926031.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_6, arg_69_1.talkMaxDuration)

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_5) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_5 + var_72_13 and arg_69_1.time_ < var_72_5 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
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
	Play926031018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 926031018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play926031019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["106103"]) and arg_73_1.var_.actorSpriteComps106103 == nil then
				arg_73_1.var_.actorSpriteComps106103 = arg_73_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["106103"]) then
				if arg_73_1.var_.actorSpriteComps106103 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								iter_76_1.color = Color.New(Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_0), Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_0), (Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_0)))
							else
								local var_76_1 = Mathf.Lerp(iter_76_1.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_0)

								iter_76_1.color = Color.New(var_76_1, var_76_1, var_76_1)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["106103"]) and arg_73_1.var_.actorSpriteComps106103 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps106103 = nil
			end

			local var_76_2 = arg_73_1.actors_["106103"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos106103 = var_76_2.localPosition
				var_76_2.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("106103", 7)

				for iter_76_4 = 0, var_76_2.childCount - 1 do
					local var_76_3 = var_76_2:GetChild(iter_76_4)

					if var_76_3.name == "" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_2.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_73_1.time_ - 0) / var_76_4)
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_76_5 = 0
			local var_76_6 = 1.175

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(926031018).content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 47 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_7) / 47)

				if (47 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_7) / 47)) > 0 and var_76_6 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_6, arg_73_1.talkMaxDuration)

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_5) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_5 + var_76_10 and arg_73_1.time_ < var_76_5 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
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
	Play926031019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 926031019
		arg_77_1.duration_ = 1.7

		local var_77_0 = {
			zh = 1.7,
			ja = 1.166
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
				arg_77_0:Play926031020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["106103"]) and arg_77_1.var_.actorSpriteComps106103 == nil then
				arg_77_1.var_.actorSpriteComps106103 = arg_77_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["106103"]) then
				if arg_77_1.var_.actorSpriteComps106103 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								iter_80_1.color = Color.New(Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_0), Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_0), (Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_0)))
							else
								local var_80_1 = Mathf.Lerp(iter_80_1.color.r, 1, (arg_77_1.time_ - 0) / var_80_0)

								iter_80_1.color = Color.New(var_80_1, var_80_1, var_80_1)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["106103"]) and arg_77_1.var_.actorSpriteComps106103 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps106103 = nil
			end

			local var_80_2 = 0
			local var_80_3 = 0.1

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_4 = arg_77_1:GetWordFromCfg(926031019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 4 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 4)

				if (4 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 4)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031019", "story_v_out_926031.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031019", "story_v_out_926031.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_926031", "926031019", "story_v_out_926031.awb")

						arg_77_1:RecordAudio("926031019", var_80_9)
						arg_77_1:RecordAudio("926031019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_926031", "926031019", "story_v_out_926031.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_926031", "926031019", "story_v_out_926031.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play926031020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 926031020
		arg_81_1.duration_ = 3.2

		local var_81_0 = {
			zh = 2.066,
			ja = 3.2
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play926031021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["104701"]) and arg_81_1.var_.actorSpriteComps104701 == nil then
				arg_81_1.var_.actorSpriteComps104701 = arg_81_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["104701"]) then
				if arg_81_1.var_.actorSpriteComps104701 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								iter_84_1.color = Color.New(Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_0), Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_0), (Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_0)))
							else
								local var_84_1 = Mathf.Lerp(iter_84_1.color.r, 1, (arg_81_1.time_ - 0) / var_84_0)

								iter_84_1.color = Color.New(var_84_1, var_84_1, var_84_1)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["104701"]) and arg_81_1.var_.actorSpriteComps104701 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps104701 = nil
			end

			local var_84_2 = arg_81_1.actors_["106103"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps106103 == nil then
				arg_81_1.var_.actorSpriteComps106103 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps106103 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_84_5 then
							if arg_81_1.isInRecall_ then
								iter_84_5.color = Color.New(Mathf.Lerp(iter_84_5.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_5.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_5.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_5.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_5.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps106103 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_84_7 then
						iter_84_7.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps106103 = nil
			end

			local var_84_5 = arg_81_1.actors_["104701"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos104701 = var_84_5.localPosition
				var_84_5.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("104701", 3)

				for iter_84_8 = 0, var_84_5.childCount - 1 do
					local var_84_6 = var_84_5:GetChild(iter_84_8)

					if var_84_6.name == "split_1" or not string.find(var_84_6.name, "split") then
						var_84_6.gameObject:SetActive(true)
					else
						var_84_6.gameObject:SetActive(false)
					end
				end
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_5.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_81_1.time_ - 0) / var_84_7)
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_5.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_84_8 = 0
			local var_84_9 = 0.175

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(926031020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 7 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 7)

				if (7 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 7)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031020", "story_v_out_926031.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_926031", "926031020", "story_v_out_926031.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_926031", "926031020", "story_v_out_926031.awb")

						arg_81_1:RecordAudio("926031020", var_84_15)
						arg_81_1:RecordAudio("926031020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_926031", "926031020", "story_v_out_926031.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_926031", "926031020", "story_v_out_926031.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play926031021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 926031021
		arg_85_1.duration_ = 2.03

		local var_85_0 = {
			zh = 1.5,
			ja = 2.033
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
				arg_85_0:Play926031022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["106103"]) and arg_85_1.var_.actorSpriteComps106103 == nil then
				arg_85_1.var_.actorSpriteComps106103 = arg_85_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["106103"]) then
				if arg_85_1.var_.actorSpriteComps106103 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								iter_88_1.color = Color.New(Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_0), Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_0), (Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_0)))
							else
								local var_88_1 = Mathf.Lerp(iter_88_1.color.r, 1, (arg_85_1.time_ - 0) / var_88_0)

								iter_88_1.color = Color.New(var_88_1, var_88_1, var_88_1)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["106103"]) and arg_85_1.var_.actorSpriteComps106103 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps106103 = nil
			end

			local var_88_2 = arg_85_1.actors_["104701"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps104701 == nil then
				arg_85_1.var_.actorSpriteComps104701 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps104701 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								iter_88_5.color = Color.New(Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_5.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_5.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps104701 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_88_7 then
						iter_88_7.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps104701 = nil
			end

			local var_88_5 = 0
			local var_88_6 = 0.125

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_7 = arg_85_1:GetWordFromCfg(926031021)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 5 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 5)

				if (5 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 5)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031021", "story_v_out_926031.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031021", "story_v_out_926031.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_926031", "926031021", "story_v_out_926031.awb")

						arg_85_1:RecordAudio("926031021", var_88_12)
						arg_85_1:RecordAudio("926031021", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_926031", "926031021", "story_v_out_926031.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_926031", "926031021", "story_v_out_926031.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_13 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_13 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_13

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_13 and arg_85_1.time_ < var_88_5 + var_88_13 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play926031022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 926031022
		arg_89_1.duration_ = 7.17

		local var_89_0 = {
			zh = 4.933,
			ja = 7.166
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
				arg_89_0:Play926031023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["104701"]) and arg_89_1.var_.actorSpriteComps104701 == nil then
				arg_89_1.var_.actorSpriteComps104701 = arg_89_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["104701"]) then
				if arg_89_1.var_.actorSpriteComps104701 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								iter_92_1.color = Color.New(Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_0), Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_0), (Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_0)))
							else
								local var_92_1 = Mathf.Lerp(iter_92_1.color.r, 1, (arg_89_1.time_ - 0) / var_92_0)

								iter_92_1.color = Color.New(var_92_1, var_92_1, var_92_1)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["104701"]) and arg_89_1.var_.actorSpriteComps104701 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_92_3 then
						iter_92_3.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps104701 = nil
			end

			local var_92_2 = arg_89_1.actors_["106103"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps106103 == nil then
				arg_89_1.var_.actorSpriteComps106103 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps106103 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_92_5 then
							if arg_89_1.isInRecall_ then
								iter_92_5.color = Color.New(Mathf.Lerp(iter_92_5.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_3), Mathf.Lerp(iter_92_5.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_3), (Mathf.Lerp(iter_92_5.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_3)))
							else
								local var_92_4 = Mathf.Lerp(iter_92_5.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_3)

								iter_92_5.color = Color.New(var_92_4, var_92_4, var_92_4)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps106103 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_92_7 then
						iter_92_7.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps106103 = nil
			end

			local var_92_5 = arg_89_1.actors_["104701"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos104701 = var_92_5.localPosition
				var_92_5.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("104701", 3)

				for iter_92_8 = 0, var_92_5.childCount - 1 do
					local var_92_6 = var_92_5:GetChild(iter_92_8)

					if var_92_6.name == "split_2" or not string.find(var_92_6.name, "split") then
						var_92_6.gameObject:SetActive(true)
					else
						var_92_6.gameObject:SetActive(false)
					end
				end
			end

			local var_92_7 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				var_92_5.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_89_1.time_ - 0) / var_92_7)
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				var_92_5.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_92_8 = 0
			local var_92_9 = 0.425

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(926031022)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 17 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 17)

				if (17 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 17)) > 0 and var_92_9 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031022", "story_v_out_926031.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_926031", "926031022", "story_v_out_926031.awb") / 1000

					if var_92_14 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_8
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_out_926031", "926031022", "story_v_out_926031.awb")

						arg_89_1:RecordAudio("926031022", var_92_15)
						arg_89_1:RecordAudio("926031022", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_926031", "926031022", "story_v_out_926031.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_926031", "926031022", "story_v_out_926031.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_9, arg_89_1.talkMaxDuration)

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_8) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_8 + var_92_16 and arg_89_1.time_ < var_92_8 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
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
	Play926031023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 926031023
		arg_93_1.duration_ = 3.8

		local var_93_0 = {
			zh = 3.8,
			ja = 3.4
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
				arg_93_0:Play926031024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["106103"]) and arg_93_1.var_.actorSpriteComps106103 == nil then
				arg_93_1.var_.actorSpriteComps106103 = arg_93_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["106103"]) then
				if arg_93_1.var_.actorSpriteComps106103 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								iter_96_1.color = Color.New(Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_0), Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_0), (Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_0)))
							else
								local var_96_1 = Mathf.Lerp(iter_96_1.color.r, 1, (arg_93_1.time_ - 0) / var_96_0)

								iter_96_1.color = Color.New(var_96_1, var_96_1, var_96_1)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["106103"]) and arg_93_1.var_.actorSpriteComps106103 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps106103 = nil
			end

			local var_96_2 = arg_93_1.actors_["104701"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps104701 == nil then
				arg_93_1.var_.actorSpriteComps104701 = var_96_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_3 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.actorSpriteComps104701 then
					for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_96_5 then
							if arg_93_1.isInRecall_ then
								iter_96_5.color = Color.New(Mathf.Lerp(iter_96_5.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_3), Mathf.Lerp(iter_96_5.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_3), (Mathf.Lerp(iter_96_5.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_3)))
							else
								local var_96_4 = Mathf.Lerp(iter_96_5.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_3)

								iter_96_5.color = Color.New(var_96_4, var_96_4, var_96_4)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps104701 then
				for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_96_7 then
						iter_96_7.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps104701 = nil
			end

			local var_96_5 = arg_93_1.actors_["106103"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos106103 = var_96_5.localPosition
				var_96_5.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("106103", 3)

				for iter_96_8 = 0, var_96_5.childCount - 1 do
					local var_96_6 = var_96_5:GetChild(iter_96_8)

					if var_96_6.name == "split_4" or not string.find(var_96_6.name, "split") then
						var_96_6.gameObject:SetActive(true)
					else
						var_96_6.gameObject:SetActive(false)
					end
				end
			end

			local var_96_7 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				var_96_5.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_93_1.time_ - 0) / var_96_7)
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				var_96_5.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_96_8 = arg_93_1.actors_["104701"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos104701 = var_96_8.localPosition
				var_96_8.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("104701", 7)

				for iter_96_9 = 0, var_96_8.childCount - 1 do
					local var_96_9 = var_96_8:GetChild(iter_96_9)

					if var_96_9.name == "" or not string.find(var_96_9.name, "split") then
						var_96_9.gameObject:SetActive(true)
					else
						var_96_9.gameObject:SetActive(false)
					end
				end
			end

			local var_96_10 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_10 then
				var_96_8.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_93_1.time_ - 0) / var_96_10)
			end

			if arg_93_1.time_ >= 0 + var_96_10 and arg_93_1.time_ < 0 + var_96_10 + arg_96_0 then
				var_96_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_96_11 = 0
			local var_96_12 = 0.225

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_13 = arg_93_1:GetWordFromCfg(926031023)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 9 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 9)

				if (9 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 9)) > 0 and var_96_12 < var_96_16 then
					arg_93_1.talkMaxDuration = var_96_16

					if var_96_16 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_11
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031023", "story_v_out_926031.awb") ~= 0 then
					local var_96_17 = manager.audio:GetVoiceLength("story_v_out_926031", "926031023", "story_v_out_926031.awb") / 1000

					if var_96_17 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_11
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_926031", "926031023", "story_v_out_926031.awb")

						arg_93_1:RecordAudio("926031023", var_96_18)
						arg_93_1:RecordAudio("926031023", var_96_18)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_926031", "926031023", "story_v_out_926031.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_926031", "926031023", "story_v_out_926031.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_19 = math.max(var_96_12, arg_93_1.talkMaxDuration)

			if var_96_11 <= arg_93_1.time_ and arg_93_1.time_ < var_96_11 + var_96_19 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_11) / var_96_19

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_11 + var_96_19 and arg_93_1.time_ < var_96_11 + var_96_19 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play926031024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 926031024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play926031025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["106103"]) and arg_97_1.var_.actorSpriteComps106103 == nil then
				arg_97_1.var_.actorSpriteComps106103 = arg_97_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["106103"]) then
				if arg_97_1.var_.actorSpriteComps106103 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								iter_100_1.color = Color.New(Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_0), Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_0), (Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_0)))
							else
								local var_100_1 = Mathf.Lerp(iter_100_1.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_0)

								iter_100_1.color = Color.New(var_100_1, var_100_1, var_100_1)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["106103"]) and arg_97_1.var_.actorSpriteComps106103 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps106103 = nil
			end

			local var_100_2 = arg_97_1.actors_["104701"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos104701 = var_100_2.localPosition
				var_100_2.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("104701", 7)

				for iter_100_4 = 0, var_100_2.childCount - 1 do
					local var_100_3 = var_100_2:GetChild(iter_100_4)

					if var_100_3.name == "" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_97_1.time_ - 0) / var_100_4)
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_5 = arg_97_1.actors_["106103"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos106103 = var_100_5.localPosition
				var_100_5.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("106103", 7)

				for iter_100_5 = 0, var_100_5.childCount - 1 do
					local var_100_6 = var_100_5:GetChild(iter_100_5)

					if var_100_6.name == "split_4" or not string.find(var_100_6.name, "split") then
						var_100_6.gameObject:SetActive(true)
					else
						var_100_6.gameObject:SetActive(false)
					end
				end
			end

			local var_100_7 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				var_100_5.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_97_1.time_ - 0) / var_100_7)
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				var_100_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_8 = 0
			local var_100_9 = 0.925

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(926031024).content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_12 = 37 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_10) / 37)

				if (37 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_10) / 37)) > 0 and var_100_9 < var_100_12 then
					arg_97_1.talkMaxDuration = var_100_12

					if var_100_12 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_13 and arg_97_1.time_ < var_100_8 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play926031025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 926031025
		arg_101_1.duration_ = 13.73

		local var_101_0 = {
			zh = 9.1,
			ja = 13.733
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play926031026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["128404"]) and arg_101_1.var_.actorSpriteComps128404 == nil then
				arg_101_1.var_.actorSpriteComps128404 = arg_101_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["128404"]) then
				if arg_101_1.var_.actorSpriteComps128404 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								iter_104_1.color = Color.New(Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_0), Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_0), (Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_0)))
							else
								local var_104_1 = Mathf.Lerp(iter_104_1.color.r, 1, (arg_101_1.time_ - 0) / var_104_0)

								iter_104_1.color = Color.New(var_104_1, var_104_1, var_104_1)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["128404"]) and arg_101_1.var_.actorSpriteComps128404 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_104_3 then
						iter_104_3.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps128404 = nil
			end

			local var_104_2 = arg_101_1.actors_["128404"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos128404 = var_104_2.localPosition
				var_104_2.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("128404", 3)

				for iter_104_4 = 0, var_104_2.childCount - 1 do
					local var_104_3 = var_104_2:GetChild(iter_104_4)

					if var_104_3.name == "split_2" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				var_104_2.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_101_1.time_ - 0) / var_104_4)
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				var_104_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_104_5 = 0
			local var_104_6 = 1.225

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_7 = arg_101_1:GetWordFromCfg(926031025)
				local var_104_8 = arg_101_1:FormatText(var_104_7.content)

				arg_101_1.text_.text = var_104_8

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_10 = 49 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_8) / 49)

				if (49 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_8) / 49)) > 0 and var_104_6 < var_104_10 then
					arg_101_1.talkMaxDuration = var_104_10

					if var_104_10 + var_104_5 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_5
					end
				end

				arg_101_1.text_.text = var_104_8
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031025", "story_v_out_926031.awb") ~= 0 then
					local var_104_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031025", "story_v_out_926031.awb") / 1000

					if var_104_11 + var_104_5 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_5
					end

					if var_104_7.prefab_name ~= "" and arg_101_1.actors_[var_104_7.prefab_name] ~= nil then
						local var_104_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_7.prefab_name].transform, "story_v_out_926031", "926031025", "story_v_out_926031.awb")

						arg_101_1:RecordAudio("926031025", var_104_12)
						arg_101_1:RecordAudio("926031025", var_104_12)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_926031", "926031025", "story_v_out_926031.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_926031", "926031025", "story_v_out_926031.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_13 = math.max(var_104_6, arg_101_1.talkMaxDuration)

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_13 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_5) / var_104_13

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_5 + var_104_13 and arg_101_1.time_ < var_104_5 + var_104_13 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play926031026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 926031026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play926031027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["128404"]) and arg_105_1.var_.actorSpriteComps128404 == nil then
				arg_105_1.var_.actorSpriteComps128404 = arg_105_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_0 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["128404"]) then
				if arg_105_1.var_.actorSpriteComps128404 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								iter_108_1.color = Color.New(Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor2.r, (arg_105_1.time_ - 0) / var_108_0), Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor2.g, (arg_105_1.time_ - 0) / var_108_0), (Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor2.b, (arg_105_1.time_ - 0) / var_108_0)))
							else
								local var_108_1 = Mathf.Lerp(iter_108_1.color.r, 0.5, (arg_105_1.time_ - 0) / var_108_0)

								iter_108_1.color = Color.New(var_108_1, var_108_1, var_108_1)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["128404"]) and arg_105_1.var_.actorSpriteComps128404 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps128404 = nil
			end

			local var_108_2 = 0
			local var_108_3 = 0.425

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_4 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(926031026).content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_6 = 17 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_4) / 17)

				if (17 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_4) / 17)) > 0 and var_108_3 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_7 and arg_105_1.time_ < var_108_2 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play926031027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 926031027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play926031028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.325

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(926031027).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 53 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 53)

				if (53 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 53)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play926031028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 926031028
		arg_113_1.duration_ = 8.87

		local var_113_0 = {
			zh = 8.866,
			ja = 8.366
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
				arg_113_0:Play926031029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["106103"]) and arg_113_1.var_.actorSpriteComps106103 == nil then
				arg_113_1.var_.actorSpriteComps106103 = arg_113_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["106103"]) then
				if arg_113_1.var_.actorSpriteComps106103 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								iter_116_1.color = Color.New(Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor1.r, (arg_113_1.time_ - 0) / var_116_0), Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor1.g, (arg_113_1.time_ - 0) / var_116_0), (Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor1.b, (arg_113_1.time_ - 0) / var_116_0)))
							else
								local var_116_1 = Mathf.Lerp(iter_116_1.color.r, 1, (arg_113_1.time_ - 0) / var_116_0)

								iter_116_1.color = Color.New(var_116_1, var_116_1, var_116_1)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["106103"]) and arg_113_1.var_.actorSpriteComps106103 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_116_3 then
						iter_116_3.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps106103 = nil
			end

			local var_116_2 = arg_113_1.actors_["106103"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos106103 = var_116_2.localPosition
				var_116_2.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("106103", 3)

				for iter_116_4 = 0, var_116_2.childCount - 1 do
					local var_116_3 = var_116_2:GetChild(iter_116_4)

					if var_116_3.name == "split_4" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_2.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_113_1.time_ - 0) / var_116_4)
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_2.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_116_5 = arg_113_1.actors_["128404"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos128404 = var_116_5.localPosition
				var_116_5.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("128404", 7)

				for iter_116_5 = 0, var_116_5.childCount - 1 do
					local var_116_6 = var_116_5:GetChild(iter_116_5)

					if var_116_6.name == "split_2" or not string.find(var_116_6.name, "split") then
						var_116_6.gameObject:SetActive(true)
					else
						var_116_6.gameObject:SetActive(false)
					end
				end
			end

			local var_116_7 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				var_116_5.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_113_1.time_ - 0) / var_116_7)
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				var_116_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_116_8 = 0
			local var_116_9 = 0.775

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(926031028)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 31 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 31)

				if (31 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 31)) > 0 and var_116_9 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031028", "story_v_out_926031.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_926031", "926031028", "story_v_out_926031.awb") / 1000

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end

					if var_116_10.prefab_name ~= "" and arg_113_1.actors_[var_116_10.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_10.prefab_name].transform, "story_v_out_926031", "926031028", "story_v_out_926031.awb")

						arg_113_1:RecordAudio("926031028", var_116_15)
						arg_113_1:RecordAudio("926031028", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_926031", "926031028", "story_v_out_926031.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_926031", "926031028", "story_v_out_926031.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_16 and arg_113_1.time_ < var_116_8 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play926031029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 926031029
		arg_117_1.duration_ = 2.93

		local var_117_0 = {
			zh = 1.6,
			ja = 2.933
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play926031030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if arg_117_1.actors_["10144"] == nil then
				local var_120_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_120_0) then
					local var_120_1 = Object.Instantiate(var_120_0, arg_117_1.canvasGo_.transform)

					var_120_1.transform:SetSiblingIndex(1)

					var_120_1.name = "10144"
					var_120_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_117_1.actors_["10144"] = var_120_1

					if arg_117_1.isInRecall_ then
						for iter_120_0, iter_120_1 in ipairs((var_120_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_120_1.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_120_2 = arg_117_1.actors_["10144"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10144 == nil then
				arg_117_1.var_.actorSpriteComps10144 = var_120_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_3 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.actorSpriteComps10144 then
					for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_120_3 then
							if arg_117_1.isInRecall_ then
								iter_120_3.color = Color.New(Mathf.Lerp(iter_120_3.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_3), Mathf.Lerp(iter_120_3.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_3), (Mathf.Lerp(iter_120_3.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_3)))
							else
								local var_120_4 = Mathf.Lerp(iter_120_3.color.r, 1, (arg_117_1.time_ - 0) / var_120_3)

								iter_120_3.color = Color.New(var_120_4, var_120_4, var_120_4)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10144 then
				for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_120_5 then
						iter_120_5.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps10144 = nil
			end

			local var_120_5 = arg_117_1.actors_["106103"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps106103 == nil then
				arg_117_1.var_.actorSpriteComps106103 = var_120_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_6 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_6 and not isNil(var_120_5) then
				if arg_117_1.var_.actorSpriteComps106103 then
					for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_120_7 then
							if arg_117_1.isInRecall_ then
								iter_120_7.color = Color.New(Mathf.Lerp(iter_120_7.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_6), Mathf.Lerp(iter_120_7.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_6), (Mathf.Lerp(iter_120_7.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_6)))
							else
								local var_120_7 = Mathf.Lerp(iter_120_7.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_6)

								iter_120_7.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_6 and arg_117_1.time_ < 0 + var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps106103 then
				for iter_120_8, iter_120_9 in pairs(arg_117_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_120_9 then
						iter_120_9.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps106103 = nil
			end

			local var_120_8 = arg_117_1.actors_["10144"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10144 = var_120_8.localPosition
				var_120_8.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10144", 3)

				for iter_120_10 = 0, var_120_8.childCount - 1 do
					local var_120_9 = var_120_8:GetChild(iter_120_10)

					if var_120_9.name == "split_7" or not string.find(var_120_9.name, "split") then
						var_120_9.gameObject:SetActive(true)
					else
						var_120_9.gameObject:SetActive(false)
					end
				end
			end

			local var_120_10 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_10 then
				var_120_8.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_117_1.time_ - 0) / var_120_10)
			end

			if arg_117_1.time_ >= 0 + var_120_10 and arg_117_1.time_ < 0 + var_120_10 + arg_120_0 then
				var_120_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_120_11 = arg_117_1.actors_["106103"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos106103 = var_120_11.localPosition
				var_120_11.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("106103", 7)

				for iter_120_11 = 0, var_120_11.childCount - 1 do
					local var_120_12 = var_120_11:GetChild(iter_120_11)

					if var_120_12.name == "split_4" or not string.find(var_120_12.name, "split") then
						var_120_12.gameObject:SetActive(true)
					else
						var_120_12.gameObject:SetActive(false)
					end
				end
			end

			local var_120_13 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_13 then
				var_120_11.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_117_1.time_ - 0) / var_120_13)
			end

			if arg_117_1.time_ >= 0 + var_120_13 and arg_117_1.time_ < 0 + var_120_13 + arg_120_0 then
				var_120_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_120_14 = 0
			local var_120_15 = 0.225

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_16 = arg_117_1:GetWordFromCfg(926031029)
				local var_120_17 = arg_117_1:FormatText(var_120_16.content)

				arg_117_1.text_.text = var_120_17

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_19 = 9 <= 0 and var_120_15 or var_120_15 * (utf8.len(var_120_17) / 9)

				if (9 <= 0 and var_120_15 or var_120_15 * (utf8.len(var_120_17) / 9)) > 0 and var_120_15 < var_120_19 then
					arg_117_1.talkMaxDuration = var_120_19

					if var_120_19 + var_120_14 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_19 + var_120_14
					end
				end

				arg_117_1.text_.text = var_120_17
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031029", "story_v_out_926031.awb") ~= 0 then
					local var_120_20 = manager.audio:GetVoiceLength("story_v_out_926031", "926031029", "story_v_out_926031.awb") / 1000

					if var_120_20 + var_120_14 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_20 + var_120_14
					end

					if var_120_16.prefab_name ~= "" and arg_117_1.actors_[var_120_16.prefab_name] ~= nil then
						local var_120_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_16.prefab_name].transform, "story_v_out_926031", "926031029", "story_v_out_926031.awb")

						arg_117_1:RecordAudio("926031029", var_120_21)
						arg_117_1:RecordAudio("926031029", var_120_21)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_926031", "926031029", "story_v_out_926031.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_926031", "926031029", "story_v_out_926031.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_22 = math.max(var_120_15, arg_117_1.talkMaxDuration)

			if var_120_14 <= arg_117_1.time_ and arg_117_1.time_ < var_120_14 + var_120_22 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_14) / var_120_22

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_14 + var_120_22 and arg_117_1.time_ < var_120_14 + var_120_22 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play926031030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 926031030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play926031031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10144"]) and arg_121_1.var_.actorSpriteComps10144 == nil then
				arg_121_1.var_.actorSpriteComps10144 = arg_121_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10144"]) then
				if arg_121_1.var_.actorSpriteComps10144 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								iter_124_1.color = Color.New(Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_0), Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_0), (Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_0)))
							else
								local var_124_1 = Mathf.Lerp(iter_124_1.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_0)

								iter_124_1.color = Color.New(var_124_1, var_124_1, var_124_1)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10144"]) and arg_121_1.var_.actorSpriteComps10144 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps10144 = nil
			end

			local var_124_2 = arg_121_1.actors_["10144"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10144 = var_124_2.localPosition
				var_124_2.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10144", 7)

				for iter_124_4 = 0, var_124_2.childCount - 1 do
					local var_124_3 = var_124_2:GetChild(iter_124_4)

					if var_124_3.name == "" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_121_1.time_ - 0) / var_124_4)
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_5 = arg_121_1.actors_["106103"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos106103 = var_124_5.localPosition
				var_124_5.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("106103", 7)

				for iter_124_5 = 0, var_124_5.childCount - 1 do
					local var_124_6 = var_124_5:GetChild(iter_124_5)

					if var_124_6.name == "" or not string.find(var_124_6.name, "split") then
						var_124_6.gameObject:SetActive(true)
					else
						var_124_6.gameObject:SetActive(false)
					end
				end
			end

			local var_124_7 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				var_124_5.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_121_1.time_ - 0) / var_124_7)
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				var_124_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_121_1.time_ and arg_121_1.time_ <= 0.034 + arg_124_0 then
				arg_121_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_plate", "")
			end

			local var_124_9 = 0
			local var_124_10 = 0.7

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_11 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(926031030).content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 28 <= 0 and var_124_10 or var_124_10 * (utf8.len(var_124_11) / 28)

				if (28 <= 0 and var_124_10 or var_124_10 * (utf8.len(var_124_11) / 28)) > 0 and var_124_10 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_9 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_9
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_10, arg_121_1.talkMaxDuration)

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_9) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_9 + var_124_14 and arg_121_1.time_ < var_124_9 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play926031031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 926031031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play926031032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.3

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(926031031).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 12 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 12)

				if (12 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 12)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play926031032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 926031032
		arg_129_1.duration_ = 2.9

		local var_129_0 = {
			zh = 2.233,
			ja = 2.9
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play926031033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10144"]) and arg_129_1.var_.actorSpriteComps10144 == nil then
				arg_129_1.var_.actorSpriteComps10144 = arg_129_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10144"]) then
				if arg_129_1.var_.actorSpriteComps10144 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								iter_132_1.color = Color.New(Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_0), Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_0), (Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_0)))
							else
								local var_132_1 = Mathf.Lerp(iter_132_1.color.r, 1, (arg_129_1.time_ - 0) / var_132_0)

								iter_132_1.color = Color.New(var_132_1, var_132_1, var_132_1)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10144"]) and arg_129_1.var_.actorSpriteComps10144 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_132_3 then
						iter_132_3.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10144 = nil
			end

			local var_132_2 = arg_129_1.actors_["10144"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10144 = var_132_2.localPosition
				var_132_2.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10144", 3)

				for iter_132_4 = 0, var_132_2.childCount - 1 do
					local var_132_3 = var_132_2:GetChild(iter_132_4)

					if var_132_3.name == "" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				var_132_2.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_129_1.time_ - 0) / var_132_4)
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				var_132_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_132_5 = 0
			local var_132_6 = 0.25

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_7 = arg_129_1:GetWordFromCfg(926031032)
				local var_132_8 = arg_129_1:FormatText(var_132_7.content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 10 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 10)

				if (10 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 10)) > 0 and var_132_6 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_5
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031032", "story_v_out_926031.awb") ~= 0 then
					local var_132_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031032", "story_v_out_926031.awb") / 1000

					if var_132_11 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_5
					end

					if var_132_7.prefab_name ~= "" and arg_129_1.actors_[var_132_7.prefab_name] ~= nil then
						local var_132_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_7.prefab_name].transform, "story_v_out_926031", "926031032", "story_v_out_926031.awb")

						arg_129_1:RecordAudio("926031032", var_132_12)
						arg_129_1:RecordAudio("926031032", var_132_12)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_926031", "926031032", "story_v_out_926031.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_926031", "926031032", "story_v_out_926031.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_6, arg_129_1.talkMaxDuration)

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_5) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_5 + var_132_13 and arg_129_1.time_ < var_132_5 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play926031033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 926031033
		arg_133_1.duration_ = 6.63

		local var_133_0 = {
			zh = 4,
			ja = 6.633
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play926031034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10144 = arg_133_1.actors_["10144"].transform.localPosition
				arg_133_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10144", 3)

				for iter_136_0 = 0, arg_133_1.actors_["10144"].transform.childCount - 1 do
					local var_136_0 = arg_133_1.actors_["10144"].transform:GetChild(iter_136_0)

					if var_136_0.name == "split_2" or not string.find(var_136_0.name, "split") then
						var_136_0.gameObject:SetActive(true)
					else
						var_136_0.gameObject:SetActive(false)
					end
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_133_1.time_ - 0) / var_136_1)
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_136_2 = 0
			local var_136_3 = 0.475

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:GetWordFromCfg(926031033)
				local var_136_5 = arg_133_1:FormatText(var_136_4.content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 19 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 19)

				if (19 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 19)) > 0 and var_136_3 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031033", "story_v_out_926031.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031033", "story_v_out_926031.awb") / 1000

					if var_136_8 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_2
					end

					if var_136_4.prefab_name ~= "" and arg_133_1.actors_[var_136_4.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_4.prefab_name].transform, "story_v_out_926031", "926031033", "story_v_out_926031.awb")

						arg_133_1:RecordAudio("926031033", var_136_9)
						arg_133_1:RecordAudio("926031033", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_926031", "926031033", "story_v_out_926031.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_926031", "926031033", "story_v_out_926031.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_10 and arg_133_1.time_ < var_136_2 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play926031034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 926031034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play926031035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["10144"]) and arg_137_1.var_.actorSpriteComps10144 == nil then
				arg_137_1.var_.actorSpriteComps10144 = arg_137_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["10144"]) then
				if arg_137_1.var_.actorSpriteComps10144 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								iter_140_1.color = Color.New(Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 0) / var_140_0), Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 0) / var_140_0), (Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 0) / var_140_0)))
							else
								local var_140_1 = Mathf.Lerp(iter_140_1.color.r, 0.5, (arg_137_1.time_ - 0) / var_140_0)

								iter_140_1.color = Color.New(var_140_1, var_140_1, var_140_1)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["10144"]) and arg_137_1.var_.actorSpriteComps10144 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_140_3 then
						iter_140_3.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps10144 = nil
			end

			local var_140_2 = 0
			local var_140_3 = 0.175

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_4 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(926031034).content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 7 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 7)

				if (7 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 7)) > 0 and var_140_3 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_7 and arg_137_1.time_ < var_140_2 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play926031035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 926031035
		arg_141_1.duration_ = 8

		local var_141_0 = {
			zh = 6.4,
			ja = 8
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play926031036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10144"]) and arg_141_1.var_.actorSpriteComps10144 == nil then
				arg_141_1.var_.actorSpriteComps10144 = arg_141_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_0 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10144"]) then
				if arg_141_1.var_.actorSpriteComps10144 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								iter_144_1.color = Color.New(Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor1.r, (arg_141_1.time_ - 0) / var_144_0), Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor1.g, (arg_141_1.time_ - 0) / var_144_0), (Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor1.b, (arg_141_1.time_ - 0) / var_144_0)))
							else
								local var_144_1 = Mathf.Lerp(iter_144_1.color.r, 1, (arg_141_1.time_ - 0) / var_144_0)

								iter_144_1.color = Color.New(var_144_1, var_144_1, var_144_1)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10144"]) and arg_141_1.var_.actorSpriteComps10144 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_144_3 then
						iter_144_3.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps10144 = nil
			end

			local var_144_2 = arg_141_1.actors_["10144"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10144 = var_144_2.localPosition
				var_144_2.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10144", 3)

				for iter_144_4 = 0, var_144_2.childCount - 1 do
					local var_144_3 = var_144_2:GetChild(iter_144_4)

					if var_144_3.name == "split_1" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				var_144_2.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_141_1.time_ - 0) / var_144_4)
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				var_144_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_144_5 = 0
			local var_144_6 = 0.775

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(926031035)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 31 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 31)

				if (31 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 31)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031035", "story_v_out_926031.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031035", "story_v_out_926031.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_926031", "926031035", "story_v_out_926031.awb")

						arg_141_1:RecordAudio("926031035", var_144_12)
						arg_141_1:RecordAudio("926031035", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_926031", "926031035", "story_v_out_926031.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_926031", "926031035", "story_v_out_926031.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_13 = math.max(var_144_6, arg_141_1.talkMaxDuration)

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_13 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_5) / var_144_13

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_5 + var_144_13 and arg_141_1.time_ < var_144_5 + var_144_13 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play926031036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 926031036
		arg_145_1.duration_ = 5.37

		local var_145_0 = {
			zh = 4.1,
			ja = 5.366
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play926031037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.575

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(926031036)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 23 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 23)

				if (23 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 23)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031036", "story_v_out_926031.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_926031", "926031036", "story_v_out_926031.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_926031", "926031036", "story_v_out_926031.awb")

						arg_145_1:RecordAudio("926031036", var_148_6)
						arg_145_1:RecordAudio("926031036", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_926031", "926031036", "story_v_out_926031.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_926031", "926031036", "story_v_out_926031.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play926031037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 926031037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play926031038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10144"]) and arg_149_1.var_.actorSpriteComps10144 == nil then
				arg_149_1.var_.actorSpriteComps10144 = arg_149_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10144"]) then
				if arg_149_1.var_.actorSpriteComps10144 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								iter_152_1.color = Color.New(Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor2.r, (arg_149_1.time_ - 0) / var_152_0), Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor2.g, (arg_149_1.time_ - 0) / var_152_0), (Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor2.b, (arg_149_1.time_ - 0) / var_152_0)))
							else
								local var_152_1 = Mathf.Lerp(iter_152_1.color.r, 0.5, (arg_149_1.time_ - 0) / var_152_0)

								iter_152_1.color = Color.New(var_152_1, var_152_1, var_152_1)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10144"]) and arg_149_1.var_.actorSpriteComps10144 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps10144 = nil
			end

			local var_152_2 = 0
			local var_152_3 = 0.45

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_4 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(926031037).content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_6 = 18 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_4) / 18)

				if (18 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_4) / 18)) > 0 and var_152_3 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_7 and arg_149_1.time_ < var_152_2 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play926031038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 926031038
		arg_153_1.duration_ = 5.57

		local var_153_0 = {
			zh = 5.566,
			ja = 4.766
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play926031039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10144"]) and arg_153_1.var_.actorSpriteComps10144 == nil then
				arg_153_1.var_.actorSpriteComps10144 = arg_153_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10144"]) then
				if arg_153_1.var_.actorSpriteComps10144 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								iter_156_1.color = Color.New(Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_0), Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_0), (Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_0)))
							else
								local var_156_1 = Mathf.Lerp(iter_156_1.color.r, 1, (arg_153_1.time_ - 0) / var_156_0)

								iter_156_1.color = Color.New(var_156_1, var_156_1, var_156_1)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10144"]) and arg_153_1.var_.actorSpriteComps10144 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps10144 = nil
			end

			local var_156_2 = arg_153_1.actors_["10144"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10144 = var_156_2.localPosition
				var_156_2.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10144", 3)

				for iter_156_4 = 0, var_156_2.childCount - 1 do
					local var_156_3 = var_156_2:GetChild(iter_156_4)

					if var_156_3.name == "split_5" or not string.find(var_156_3.name, "split") then
						var_156_3.gameObject:SetActive(true)
					else
						var_156_3.gameObject:SetActive(false)
					end
				end
			end

			local var_156_4 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				var_156_2.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_153_1.time_ - 0) / var_156_4)
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				var_156_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_156_5 = 0
			local var_156_6 = 0.65

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_7 = arg_153_1:GetWordFromCfg(926031038)
				local var_156_8 = arg_153_1:FormatText(var_156_7.content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 26 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 26)

				if (26 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 26)) > 0 and var_156_6 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031038", "story_v_out_926031.awb") ~= 0 then
					local var_156_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031038", "story_v_out_926031.awb") / 1000

					if var_156_11 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_5
					end

					if var_156_7.prefab_name ~= "" and arg_153_1.actors_[var_156_7.prefab_name] ~= nil then
						local var_156_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_7.prefab_name].transform, "story_v_out_926031", "926031038", "story_v_out_926031.awb")

						arg_153_1:RecordAudio("926031038", var_156_12)
						arg_153_1:RecordAudio("926031038", var_156_12)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_926031", "926031038", "story_v_out_926031.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_926031", "926031038", "story_v_out_926031.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_13 = math.max(var_156_6, arg_153_1.talkMaxDuration)

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_13 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_5) / var_156_13

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_5 + var_156_13 and arg_153_1.time_ < var_156_5 + var_156_13 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play926031039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 926031039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play926031040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["10144"]) and arg_157_1.var_.actorSpriteComps10144 == nil then
				arg_157_1.var_.actorSpriteComps10144 = arg_157_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_0 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["10144"]) then
				if arg_157_1.var_.actorSpriteComps10144 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								iter_160_1.color = Color.New(Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_0), Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_0), (Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_0)))
							else
								local var_160_1 = Mathf.Lerp(iter_160_1.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_0)

								iter_160_1.color = Color.New(var_160_1, var_160_1, var_160_1)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["10144"]) and arg_157_1.var_.actorSpriteComps10144 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_160_3 then
						iter_160_3.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps10144 = nil
			end

			local var_160_2 = 0
			local var_160_3 = 0.925

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_4 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(926031039).content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 37 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 37)

				if (37 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 37)) > 0 and var_160_3 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_2
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_3, arg_157_1.talkMaxDuration)

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_2) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_2 + var_160_7 and arg_157_1.time_ < var_160_2 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play926031040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 926031040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play926031041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.75

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(926031040).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 30 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 30)

				if (30 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 30)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play926031041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 926031041
		arg_165_1.duration_ = 2.03

		local var_165_0 = {
			zh = 1.333,
			ja = 2.033
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play926031042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10144"]) and arg_165_1.var_.actorSpriteComps10144 == nil then
				arg_165_1.var_.actorSpriteComps10144 = arg_165_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10144"]) then
				if arg_165_1.var_.actorSpriteComps10144 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								iter_168_1.color = Color.New(Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor1.r, (arg_165_1.time_ - 0) / var_168_0), Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor1.g, (arg_165_1.time_ - 0) / var_168_0), (Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor1.b, (arg_165_1.time_ - 0) / var_168_0)))
							else
								local var_168_1 = Mathf.Lerp(iter_168_1.color.r, 1, (arg_165_1.time_ - 0) / var_168_0)

								iter_168_1.color = Color.New(var_168_1, var_168_1, var_168_1)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10144"]) and arg_165_1.var_.actorSpriteComps10144 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_168_3 then
						iter_168_3.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps10144 = nil
			end

			local var_168_2 = arg_165_1.actors_["10144"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10144 = var_168_2.localPosition
				var_168_2.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10144", 3)

				for iter_168_4 = 0, var_168_2.childCount - 1 do
					local var_168_3 = var_168_2:GetChild(iter_168_4)

					if var_168_3.name == "split_2" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				var_168_2.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_165_1.time_ - 0) / var_168_4)
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				var_168_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_168_5 = 0
			local var_168_6 = 0.075

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_7 = arg_165_1:GetWordFromCfg(926031041)
				local var_168_8 = arg_165_1:FormatText(var_168_7.content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 3 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 3)

				if (3 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 3)) > 0 and var_168_6 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031041", "story_v_out_926031.awb") ~= 0 then
					local var_168_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031041", "story_v_out_926031.awb") / 1000

					if var_168_11 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_5
					end

					if var_168_7.prefab_name ~= "" and arg_165_1.actors_[var_168_7.prefab_name] ~= nil then
						local var_168_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_7.prefab_name].transform, "story_v_out_926031", "926031041", "story_v_out_926031.awb")

						arg_165_1:RecordAudio("926031041", var_168_12)
						arg_165_1:RecordAudio("926031041", var_168_12)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_926031", "926031041", "story_v_out_926031.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_926031", "926031041", "story_v_out_926031.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_6, arg_165_1.talkMaxDuration)

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_5) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_5 + var_168_13 and arg_165_1.time_ < var_168_5 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play926031042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 926031042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play926031043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["10144"]) and arg_169_1.var_.actorSpriteComps10144 == nil then
				arg_169_1.var_.actorSpriteComps10144 = arg_169_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_0 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["10144"]) then
				if arg_169_1.var_.actorSpriteComps10144 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								iter_172_1.color = Color.New(Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor2.r, (arg_169_1.time_ - 0) / var_172_0), Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor2.g, (arg_169_1.time_ - 0) / var_172_0), (Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor2.b, (arg_169_1.time_ - 0) / var_172_0)))
							else
								local var_172_1 = Mathf.Lerp(iter_172_1.color.r, 0.5, (arg_169_1.time_ - 0) / var_172_0)

								iter_172_1.color = Color.New(var_172_1, var_172_1, var_172_1)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["10144"]) and arg_169_1.var_.actorSpriteComps10144 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_172_3 then
						iter_172_3.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps10144 = nil
			end

			local var_172_2 = 0
			local var_172_3 = 0.425

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_4 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(926031042).content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_6 = 17 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_4) / 17)

				if (17 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_4) / 17)) > 0 and var_172_3 < var_172_6 then
					arg_169_1.talkMaxDuration = var_172_6

					if var_172_6 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_7 and arg_169_1.time_ < var_172_2 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play926031043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 926031043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play926031044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.7

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(926031043).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 28 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 28)

				if (28 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 28)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play926031044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 926031044
		arg_177_1.duration_ = 11.9

		local var_177_0 = {
			zh = 8.066,
			ja = 11.9
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play926031045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10144"]) and arg_177_1.var_.actorSpriteComps10144 == nil then
				arg_177_1.var_.actorSpriteComps10144 = arg_177_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_0 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10144"]) then
				if arg_177_1.var_.actorSpriteComps10144 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								iter_180_1.color = Color.New(Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_0), Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_0), (Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_0)))
							else
								local var_180_1 = Mathf.Lerp(iter_180_1.color.r, 1, (arg_177_1.time_ - 0) / var_180_0)

								iter_180_1.color = Color.New(var_180_1, var_180_1, var_180_1)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10144"]) and arg_177_1.var_.actorSpriteComps10144 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps10144 = nil
			end

			local var_180_2 = arg_177_1.actors_["10144"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10144 = var_180_2.localPosition
				var_180_2.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10144", 3)

				for iter_180_4 = 0, var_180_2.childCount - 1 do
					local var_180_3 = var_180_2:GetChild(iter_180_4)

					if var_180_3.name == "" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				var_180_2.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_177_1.time_ - 0) / var_180_4)
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				var_180_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_180_5 = 0
			local var_180_6 = 0.95

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_7 = arg_177_1:GetWordFromCfg(926031044)
				local var_180_8 = arg_177_1:FormatText(var_180_7.content)

				arg_177_1.text_.text = var_180_8

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 38 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 38)

				if (38 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 38)) > 0 and var_180_6 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_8
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031044", "story_v_out_926031.awb") ~= 0 then
					local var_180_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031044", "story_v_out_926031.awb") / 1000

					if var_180_11 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_5
					end

					if var_180_7.prefab_name ~= "" and arg_177_1.actors_[var_180_7.prefab_name] ~= nil then
						local var_180_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_7.prefab_name].transform, "story_v_out_926031", "926031044", "story_v_out_926031.awb")

						arg_177_1:RecordAudio("926031044", var_180_12)
						arg_177_1:RecordAudio("926031044", var_180_12)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_926031", "926031044", "story_v_out_926031.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_926031", "926031044", "story_v_out_926031.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_13 = math.max(var_180_6, arg_177_1.talkMaxDuration)

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_13 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_5) / var_180_13

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_5 + var_180_13 and arg_177_1.time_ < var_180_5 + var_180_13 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play926031045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 926031045
		arg_181_1.duration_ = 13.57

		local var_181_0 = {
			zh = 10.3,
			ja = 13.566
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play926031046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.1

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(926031045)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 44 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 44)

				if (44 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 44)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031045", "story_v_out_926031.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_926031", "926031045", "story_v_out_926031.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_926031", "926031045", "story_v_out_926031.awb")

						arg_181_1:RecordAudio("926031045", var_184_6)
						arg_181_1:RecordAudio("926031045", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_926031", "926031045", "story_v_out_926031.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_926031", "926031045", "story_v_out_926031.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play926031046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 926031046
		arg_185_1.duration_ = 6

		local var_185_0 = {
			zh = 5.533,
			ja = 6
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play926031047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.7

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(926031046)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 28 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 28)

				if (28 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 28)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031046", "story_v_out_926031.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_926031", "926031046", "story_v_out_926031.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_926031", "926031046", "story_v_out_926031.awb")

						arg_185_1:RecordAudio("926031046", var_188_6)
						arg_185_1:RecordAudio("926031046", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_926031", "926031046", "story_v_out_926031.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_926031", "926031046", "story_v_out_926031.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play926031047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 926031047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play926031048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10144"]) and arg_189_1.var_.actorSpriteComps10144 == nil then
				arg_189_1.var_.actorSpriteComps10144 = arg_189_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10144"]) then
				if arg_189_1.var_.actorSpriteComps10144 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								iter_192_1.color = Color.New(Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_0), Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_0), (Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_0)))
							else
								local var_192_1 = Mathf.Lerp(iter_192_1.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_0)

								iter_192_1.color = Color.New(var_192_1, var_192_1, var_192_1)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10144"]) and arg_189_1.var_.actorSpriteComps10144 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps10144 = nil
			end

			local var_192_2 = 0
			local var_192_3 = 0.5

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_4 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(926031047).content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_6 = 20 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_4) / 20)

				if (20 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_4) / 20)) > 0 and var_192_3 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_2
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_3, arg_189_1.talkMaxDuration)

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_2) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_2 + var_192_7 and arg_189_1.time_ < var_192_2 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play926031048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 926031048
		arg_193_1.duration_ = 12.53

		local var_193_0 = {
			zh = 6.7,
			ja = 12.533
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play926031049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["10144"]) and arg_193_1.var_.actorSpriteComps10144 == nil then
				arg_193_1.var_.actorSpriteComps10144 = arg_193_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_0 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["10144"]) then
				if arg_193_1.var_.actorSpriteComps10144 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								iter_196_1.color = Color.New(Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_0), Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_0), (Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_0)))
							else
								local var_196_1 = Mathf.Lerp(iter_196_1.color.r, 1, (arg_193_1.time_ - 0) / var_196_0)

								iter_196_1.color = Color.New(var_196_1, var_196_1, var_196_1)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["10144"]) and arg_193_1.var_.actorSpriteComps10144 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_196_3 then
						iter_196_3.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps10144 = nil
			end

			local var_196_2 = arg_193_1.actors_["10144"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10144 = var_196_2.localPosition
				var_196_2.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10144", 3)

				for iter_196_4 = 0, var_196_2.childCount - 1 do
					local var_196_3 = var_196_2:GetChild(iter_196_4)

					if var_196_3.name == "" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				var_196_2.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_193_1.time_ - 0) / var_196_4)
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				var_196_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_196_5 = 0
			local var_196_6 = 0.75

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_7 = arg_193_1:GetWordFromCfg(926031048)
				local var_196_8 = arg_193_1:FormatText(var_196_7.content)

				arg_193_1.text_.text = var_196_8

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 30 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 30)

				if (30 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 30)) > 0 and var_196_6 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_5
					end
				end

				arg_193_1.text_.text = var_196_8
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031048", "story_v_out_926031.awb") ~= 0 then
					local var_196_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031048", "story_v_out_926031.awb") / 1000

					if var_196_11 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_5
					end

					if var_196_7.prefab_name ~= "" and arg_193_1.actors_[var_196_7.prefab_name] ~= nil then
						local var_196_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_7.prefab_name].transform, "story_v_out_926031", "926031048", "story_v_out_926031.awb")

						arg_193_1:RecordAudio("926031048", var_196_12)
						arg_193_1:RecordAudio("926031048", var_196_12)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_926031", "926031048", "story_v_out_926031.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_926031", "926031048", "story_v_out_926031.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_13 = math.max(var_196_6, arg_193_1.talkMaxDuration)

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_13 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_5) / var_196_13

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_5 + var_196_13 and arg_193_1.time_ < var_196_5 + var_196_13 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play926031049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 926031049
		arg_197_1.duration_ = 5.07

		local var_197_0 = {
			zh = 4.366,
			ja = 5.066
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play926031050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.625

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(926031049)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 25 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 25)

				if (25 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 25)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031049", "story_v_out_926031.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_926031", "926031049", "story_v_out_926031.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_926031", "926031049", "story_v_out_926031.awb")

						arg_197_1:RecordAudio("926031049", var_200_6)
						arg_197_1:RecordAudio("926031049", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_926031", "926031049", "story_v_out_926031.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_926031", "926031049", "story_v_out_926031.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play926031050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 926031050
		arg_201_1.duration_ = 8.53

		local var_201_0 = {
			zh = 5.8,
			ja = 8.533
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
				arg_201_0:Play926031051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["128404"]) and arg_201_1.var_.actorSpriteComps128404 == nil then
				arg_201_1.var_.actorSpriteComps128404 = arg_201_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_0 = 0.2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["128404"]) then
				if arg_201_1.var_.actorSpriteComps128404 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								iter_204_1.color = Color.New(Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor1.r, (arg_201_1.time_ - 0) / var_204_0), Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor1.g, (arg_201_1.time_ - 0) / var_204_0), (Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor1.b, (arg_201_1.time_ - 0) / var_204_0)))
							else
								local var_204_1 = Mathf.Lerp(iter_204_1.color.r, 1, (arg_201_1.time_ - 0) / var_204_0)

								iter_204_1.color = Color.New(var_204_1, var_204_1, var_204_1)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["128404"]) and arg_201_1.var_.actorSpriteComps128404 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_204_3 then
						iter_204_3.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps128404 = nil
			end

			local var_204_2 = arg_201_1.actors_["10144"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps10144 == nil then
				arg_201_1.var_.actorSpriteComps10144 = var_204_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_3 = 0.2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.actorSpriteComps10144 then
					for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_204_5 then
							if arg_201_1.isInRecall_ then
								iter_204_5.color = Color.New(Mathf.Lerp(iter_204_5.color.r, arg_201_1.hightColor2.r, (arg_201_1.time_ - 0) / var_204_3), Mathf.Lerp(iter_204_5.color.g, arg_201_1.hightColor2.g, (arg_201_1.time_ - 0) / var_204_3), (Mathf.Lerp(iter_204_5.color.b, arg_201_1.hightColor2.b, (arg_201_1.time_ - 0) / var_204_3)))
							else
								local var_204_4 = Mathf.Lerp(iter_204_5.color.r, 0.5, (arg_201_1.time_ - 0) / var_204_3)

								iter_204_5.color = Color.New(var_204_4, var_204_4, var_204_4)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps10144 then
				for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_204_7 then
						iter_204_7.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps10144 = nil
			end

			local var_204_5 = arg_201_1.actors_["10144"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10144 = var_204_5.localPosition
				var_204_5.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10144", 4)

				for iter_204_8 = 0, var_204_5.childCount - 1 do
					local var_204_6 = var_204_5:GetChild(iter_204_8)

					if var_204_6.name == "" or not string.find(var_204_6.name, "split") then
						var_204_6.gameObject:SetActive(true)
					else
						var_204_6.gameObject:SetActive(false)
					end
				end
			end

			local var_204_7 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				var_204_5.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_201_1.time_ - 0) / var_204_7)
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				var_204_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_204_8 = arg_201_1.actors_["128404"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos128404 = var_204_8.localPosition
				var_204_8.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("128404", 2)

				for iter_204_9 = 0, var_204_8.childCount - 1 do
					local var_204_9 = var_204_8:GetChild(iter_204_9)

					if var_204_9.name == "" or not string.find(var_204_9.name, "split") then
						var_204_9.gameObject:SetActive(true)
					else
						var_204_9.gameObject:SetActive(false)
					end
				end
			end

			local var_204_10 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_10 then
				var_204_8.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_201_1.time_ - 0) / var_204_10)
			end

			if arg_201_1.time_ >= 0 + var_204_10 and arg_201_1.time_ < 0 + var_204_10 + arg_204_0 then
				var_204_8.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_204_11 = 0
			local var_204_12 = 0.775

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_11 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_13 = arg_201_1:GetWordFromCfg(926031050)
				local var_204_14 = arg_201_1:FormatText(var_204_13.content)

				arg_201_1.text_.text = var_204_14

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_16 = 31 <= 0 and var_204_12 or var_204_12 * (utf8.len(var_204_14) / 31)

				if (31 <= 0 and var_204_12 or var_204_12 * (utf8.len(var_204_14) / 31)) > 0 and var_204_12 < var_204_16 then
					arg_201_1.talkMaxDuration = var_204_16

					if var_204_16 + var_204_11 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_16 + var_204_11
					end
				end

				arg_201_1.text_.text = var_204_14
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031050", "story_v_out_926031.awb") ~= 0 then
					local var_204_17 = manager.audio:GetVoiceLength("story_v_out_926031", "926031050", "story_v_out_926031.awb") / 1000

					if var_204_17 + var_204_11 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_17 + var_204_11
					end

					if var_204_13.prefab_name ~= "" and arg_201_1.actors_[var_204_13.prefab_name] ~= nil then
						local var_204_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_13.prefab_name].transform, "story_v_out_926031", "926031050", "story_v_out_926031.awb")

						arg_201_1:RecordAudio("926031050", var_204_18)
						arg_201_1:RecordAudio("926031050", var_204_18)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_926031", "926031050", "story_v_out_926031.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_926031", "926031050", "story_v_out_926031.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_19 = math.max(var_204_12, arg_201_1.talkMaxDuration)

			if var_204_11 <= arg_201_1.time_ and arg_201_1.time_ < var_204_11 + var_204_19 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_11) / var_204_19

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_11 + var_204_19 and arg_201_1.time_ < var_204_11 + var_204_19 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
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
	Play926031051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 926031051
		arg_205_1.duration_ = 9.4

		local var_205_0 = {
			zh = 7.2,
			ja = 9.4
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play926031052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["10144"]) and arg_205_1.var_.actorSpriteComps10144 == nil then
				arg_205_1.var_.actorSpriteComps10144 = arg_205_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_0 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["10144"]) then
				if arg_205_1.var_.actorSpriteComps10144 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_208_1 then
							if arg_205_1.isInRecall_ then
								iter_208_1.color = Color.New(Mathf.Lerp(iter_208_1.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 0) / var_208_0), Mathf.Lerp(iter_208_1.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 0) / var_208_0), (Mathf.Lerp(iter_208_1.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 0) / var_208_0)))
							else
								local var_208_1 = Mathf.Lerp(iter_208_1.color.r, 1, (arg_205_1.time_ - 0) / var_208_0)

								iter_208_1.color = Color.New(var_208_1, var_208_1, var_208_1)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["10144"]) and arg_205_1.var_.actorSpriteComps10144 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_208_3 then
						iter_208_3.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps10144 = nil
			end

			local var_208_2 = arg_205_1.actors_["128404"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps128404 == nil then
				arg_205_1.var_.actorSpriteComps128404 = var_208_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_3 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.actorSpriteComps128404 then
					for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_208_5 then
							if arg_205_1.isInRecall_ then
								iter_208_5.color = Color.New(Mathf.Lerp(iter_208_5.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 0) / var_208_3), Mathf.Lerp(iter_208_5.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 0) / var_208_3), (Mathf.Lerp(iter_208_5.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 0) / var_208_3)))
							else
								local var_208_4 = Mathf.Lerp(iter_208_5.color.r, 0.5, (arg_205_1.time_ - 0) / var_208_3)

								iter_208_5.color = Color.New(var_208_4, var_208_4, var_208_4)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps128404 then
				for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_208_7 then
						iter_208_7.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps128404 = nil
			end

			local var_208_5 = 0
			local var_208_6 = 0.9

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_7 = arg_205_1:GetWordFromCfg(926031051)
				local var_208_8 = arg_205_1:FormatText(var_208_7.content)

				arg_205_1.text_.text = var_208_8

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_10 = 36 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_8) / 36)

				if (36 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_8) / 36)) > 0 and var_208_6 < var_208_10 then
					arg_205_1.talkMaxDuration = var_208_10

					if var_208_10 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_5
					end
				end

				arg_205_1.text_.text = var_208_8
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031051", "story_v_out_926031.awb") ~= 0 then
					local var_208_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031051", "story_v_out_926031.awb") / 1000

					if var_208_11 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_11 + var_208_5
					end

					if var_208_7.prefab_name ~= "" and arg_205_1.actors_[var_208_7.prefab_name] ~= nil then
						local var_208_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_7.prefab_name].transform, "story_v_out_926031", "926031051", "story_v_out_926031.awb")

						arg_205_1:RecordAudio("926031051", var_208_12)
						arg_205_1:RecordAudio("926031051", var_208_12)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_926031", "926031051", "story_v_out_926031.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_926031", "926031051", "story_v_out_926031.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_13 = math.max(var_208_6, arg_205_1.talkMaxDuration)

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_13 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_5) / var_208_13

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_5 + var_208_13 and arg_205_1.time_ < var_208_5 + var_208_13 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play926031052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 926031052
		arg_209_1.duration_ = 2.67

		local var_209_0 = {
			zh = 1.9,
			ja = 2.666
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
				arg_209_0:Play926031053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["128404"]) and arg_209_1.var_.actorSpriteComps128404 == nil then
				arg_209_1.var_.actorSpriteComps128404 = arg_209_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["128404"]) then
				if arg_209_1.var_.actorSpriteComps128404 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["128404"]) and arg_209_1.var_.actorSpriteComps128404 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps128404 = nil
			end

			local var_212_2 = arg_209_1.actors_["10144"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps10144 == nil then
				arg_209_1.var_.actorSpriteComps10144 = var_212_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_3 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.actorSpriteComps10144 then
					for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_212_5 then
							if arg_209_1.isInRecall_ then
								iter_212_5.color = Color.New(Mathf.Lerp(iter_212_5.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_3), Mathf.Lerp(iter_212_5.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_3), (Mathf.Lerp(iter_212_5.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_3)))
							else
								local var_212_4 = Mathf.Lerp(iter_212_5.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_3)

								iter_212_5.color = Color.New(var_212_4, var_212_4, var_212_4)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps10144 then
				for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_212_7 then
						iter_212_7.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps10144 = nil
			end

			local var_212_5 = arg_209_1.actors_["128404"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos128404 = var_212_5.localPosition
				var_212_5.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("128404", 2)

				for iter_212_8 = 0, var_212_5.childCount - 1 do
					local var_212_6 = var_212_5:GetChild(iter_212_8)

					if var_212_6.name == "split_4" or not string.find(var_212_6.name, "split") then
						var_212_6.gameObject:SetActive(true)
					else
						var_212_6.gameObject:SetActive(false)
					end
				end
			end

			local var_212_7 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				var_212_5.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_209_1.time_ - 0) / var_212_7)
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				var_212_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_212_8 = 0
			local var_212_9 = 0.2

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(926031052)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 8 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 8)

				if (8 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 8)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031052", "story_v_out_926031.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_out_926031", "926031052", "story_v_out_926031.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_out_926031", "926031052", "story_v_out_926031.awb")

						arg_209_1:RecordAudio("926031052", var_212_15)
						arg_209_1:RecordAudio("926031052", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_926031", "926031052", "story_v_out_926031.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_926031", "926031052", "story_v_out_926031.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_16 and arg_209_1.time_ < var_212_8 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926031053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 926031053
		arg_213_1.duration_ = 5.9

		local var_213_0 = {
			zh = 5.9,
			ja = 4.633
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
				arg_213_0:Play926031054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["10144"]) and arg_213_1.var_.actorSpriteComps10144 == nil then
				arg_213_1.var_.actorSpriteComps10144 = arg_213_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_0 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["10144"]) then
				if arg_213_1.var_.actorSpriteComps10144 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								iter_216_1.color = Color.New(Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_0), Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_0), (Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_0)))
							else
								local var_216_1 = Mathf.Lerp(iter_216_1.color.r, 1, (arg_213_1.time_ - 0) / var_216_0)

								iter_216_1.color = Color.New(var_216_1, var_216_1, var_216_1)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["10144"]) and arg_213_1.var_.actorSpriteComps10144 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_216_3 then
						iter_216_3.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps10144 = nil
			end

			local var_216_2 = arg_213_1.actors_["128404"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps128404 == nil then
				arg_213_1.var_.actorSpriteComps128404 = var_216_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_3 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.actorSpriteComps128404 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_216_5 then
							if arg_213_1.isInRecall_ then
								iter_216_5.color = Color.New(Mathf.Lerp(iter_216_5.color.r, arg_213_1.hightColor2.r, (arg_213_1.time_ - 0) / var_216_3), Mathf.Lerp(iter_216_5.color.g, arg_213_1.hightColor2.g, (arg_213_1.time_ - 0) / var_216_3), (Mathf.Lerp(iter_216_5.color.b, arg_213_1.hightColor2.b, (arg_213_1.time_ - 0) / var_216_3)))
							else
								local var_216_4 = Mathf.Lerp(iter_216_5.color.r, 0.5, (arg_213_1.time_ - 0) / var_216_3)

								iter_216_5.color = Color.New(var_216_4, var_216_4, var_216_4)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps128404 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_216_7 then
						iter_216_7.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps128404 = nil
			end

			local var_216_5 = arg_213_1.actors_["10144"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10144 = var_216_5.localPosition
				var_216_5.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10144", 3)

				for iter_216_8 = 0, var_216_5.childCount - 1 do
					local var_216_6 = var_216_5:GetChild(iter_216_8)

					if var_216_6.name == "" or not string.find(var_216_6.name, "split") then
						var_216_6.gameObject:SetActive(true)
					else
						var_216_6.gameObject:SetActive(false)
					end
				end
			end

			local var_216_7 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				var_216_5.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_213_1.time_ - 0) / var_216_7)
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				var_216_5.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_216_8 = arg_213_1.actors_["128404"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos128404 = var_216_8.localPosition
				var_216_8.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("128404", 7)

				for iter_216_9 = 0, var_216_8.childCount - 1 do
					local var_216_9 = var_216_8:GetChild(iter_216_9)

					if var_216_9.name == "" or not string.find(var_216_9.name, "split") then
						var_216_9.gameObject:SetActive(true)
					else
						var_216_9.gameObject:SetActive(false)
					end
				end
			end

			local var_216_10 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_10 then
				var_216_8.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_213_1.time_ - 0) / var_216_10)
			end

			if arg_213_1.time_ >= 0 + var_216_10 and arg_213_1.time_ < 0 + var_216_10 + arg_216_0 then
				var_216_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_216_11 = 0
			local var_216_12 = 0.775

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_11 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_13 = arg_213_1:GetWordFromCfg(926031053)
				local var_216_14 = arg_213_1:FormatText(var_216_13.content)

				arg_213_1.text_.text = var_216_14

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_16 = 31 <= 0 and var_216_12 or var_216_12 * (utf8.len(var_216_14) / 31)

				if (31 <= 0 and var_216_12 or var_216_12 * (utf8.len(var_216_14) / 31)) > 0 and var_216_12 < var_216_16 then
					arg_213_1.talkMaxDuration = var_216_16

					if var_216_16 + var_216_11 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_16 + var_216_11
					end
				end

				arg_213_1.text_.text = var_216_14
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031053", "story_v_out_926031.awb") ~= 0 then
					local var_216_17 = manager.audio:GetVoiceLength("story_v_out_926031", "926031053", "story_v_out_926031.awb") / 1000

					if var_216_17 + var_216_11 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_17 + var_216_11
					end

					if var_216_13.prefab_name ~= "" and arg_213_1.actors_[var_216_13.prefab_name] ~= nil then
						local var_216_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_13.prefab_name].transform, "story_v_out_926031", "926031053", "story_v_out_926031.awb")

						arg_213_1:RecordAudio("926031053", var_216_18)
						arg_213_1:RecordAudio("926031053", var_216_18)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_926031", "926031053", "story_v_out_926031.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_926031", "926031053", "story_v_out_926031.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_19 = math.max(var_216_12, arg_213_1.talkMaxDuration)

			if var_216_11 <= arg_213_1.time_ and arg_213_1.time_ < var_216_11 + var_216_19 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_11) / var_216_19

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_11 + var_216_19 and arg_213_1.time_ < var_216_11 + var_216_19 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
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
	Play926031054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 926031054
		arg_217_1.duration_ = 5.6

		local var_217_0 = {
			zh = 5.6,
			ja = 4.733
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play926031055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos10144 = arg_217_1.actors_["10144"].transform.localPosition
				arg_217_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10144", 3)

				for iter_220_0 = 0, arg_217_1.actors_["10144"].transform.childCount - 1 do
					local var_220_0 = arg_217_1.actors_["10144"].transform:GetChild(iter_220_0)

					if var_220_0.name == "split_2" or not string.find(var_220_0.name, "split") then
						var_220_0.gameObject:SetActive(true)
					else
						var_220_0.gameObject:SetActive(false)
					end
				end
			end

			local var_220_1 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 then
				arg_217_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_217_1.time_ - 0) / var_220_1)
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 then
				arg_217_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_220_2 = 0
			local var_220_3 = 0.6

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_4 = arg_217_1:GetWordFromCfg(926031054)
				local var_220_5 = arg_217_1:FormatText(var_220_4.content)

				arg_217_1.text_.text = var_220_5

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_7 = 24 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 24)

				if (24 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 24)) > 0 and var_220_3 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_2
					end
				end

				arg_217_1.text_.text = var_220_5
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031054", "story_v_out_926031.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031054", "story_v_out_926031.awb") / 1000

					if var_220_8 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_2
					end

					if var_220_4.prefab_name ~= "" and arg_217_1.actors_[var_220_4.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_4.prefab_name].transform, "story_v_out_926031", "926031054", "story_v_out_926031.awb")

						arg_217_1:RecordAudio("926031054", var_220_9)
						arg_217_1:RecordAudio("926031054", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_926031", "926031054", "story_v_out_926031.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_926031", "926031054", "story_v_out_926031.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_3, arg_217_1.talkMaxDuration)

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_2) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_2 + var_220_10 and arg_217_1.time_ < var_220_2 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play926031055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 926031055
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play926031056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["10144"]) and arg_221_1.var_.actorSpriteComps10144 == nil then
				arg_221_1.var_.actorSpriteComps10144 = arg_221_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_0 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["10144"]) then
				if arg_221_1.var_.actorSpriteComps10144 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								iter_224_1.color = Color.New(Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_0), Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_0), (Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_0)))
							else
								local var_224_1 = Mathf.Lerp(iter_224_1.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_0)

								iter_224_1.color = Color.New(var_224_1, var_224_1, var_224_1)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["10144"]) and arg_221_1.var_.actorSpriteComps10144 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_224_3 then
						iter_224_3.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps10144 = nil
			end

			local var_224_2 = 0
			local var_224_3 = 0.55

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_4 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(926031055).content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_6 = 22 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_4) / 22)

				if (22 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_4) / 22)) > 0 and var_224_3 < var_224_6 then
					arg_221_1.talkMaxDuration = var_224_6

					if var_224_6 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_7 and arg_221_1.time_ < var_224_2 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play926031056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 926031056
		arg_225_1.duration_ = 3.7

		local var_225_0 = {
			zh = 3,
			ja = 3.7
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play926031057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["10144"]) and arg_225_1.var_.actorSpriteComps10144 == nil then
				arg_225_1.var_.actorSpriteComps10144 = arg_225_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_0 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["10144"]) then
				if arg_225_1.var_.actorSpriteComps10144 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_228_1 then
							if arg_225_1.isInRecall_ then
								iter_228_1.color = Color.New(Mathf.Lerp(iter_228_1.color.r, arg_225_1.hightColor1.r, (arg_225_1.time_ - 0) / var_228_0), Mathf.Lerp(iter_228_1.color.g, arg_225_1.hightColor1.g, (arg_225_1.time_ - 0) / var_228_0), (Mathf.Lerp(iter_228_1.color.b, arg_225_1.hightColor1.b, (arg_225_1.time_ - 0) / var_228_0)))
							else
								local var_228_1 = Mathf.Lerp(iter_228_1.color.r, 1, (arg_225_1.time_ - 0) / var_228_0)

								iter_228_1.color = Color.New(var_228_1, var_228_1, var_228_1)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["10144"]) and arg_225_1.var_.actorSpriteComps10144 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_228_3 then
						iter_228_3.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_225_1.var_.actorSpriteComps10144 = nil
			end

			local var_228_2 = arg_225_1.actors_["10144"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10144 = var_228_2.localPosition
				var_228_2.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10144", 3)

				for iter_228_4 = 0, var_228_2.childCount - 1 do
					local var_228_3 = var_228_2:GetChild(iter_228_4)

					if var_228_3.name == "" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_2.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_225_1.time_ - 0) / var_228_4)
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_228_5 = 0
			local var_228_6 = 0.375

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_7 = arg_225_1:GetWordFromCfg(926031056)
				local var_228_8 = arg_225_1:FormatText(var_228_7.content)

				arg_225_1.text_.text = var_228_8

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_10 = 15 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_8) / 15)

				if (15 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_8) / 15)) > 0 and var_228_6 < var_228_10 then
					arg_225_1.talkMaxDuration = var_228_10

					if var_228_10 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_5
					end
				end

				arg_225_1.text_.text = var_228_8
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031056", "story_v_out_926031.awb") ~= 0 then
					local var_228_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031056", "story_v_out_926031.awb") / 1000

					if var_228_11 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_5
					end

					if var_228_7.prefab_name ~= "" and arg_225_1.actors_[var_228_7.prefab_name] ~= nil then
						local var_228_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_7.prefab_name].transform, "story_v_out_926031", "926031056", "story_v_out_926031.awb")

						arg_225_1:RecordAudio("926031056", var_228_12)
						arg_225_1:RecordAudio("926031056", var_228_12)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_926031", "926031056", "story_v_out_926031.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_926031", "926031056", "story_v_out_926031.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_13 = math.max(var_228_6, arg_225_1.talkMaxDuration)

			if var_228_5 <= arg_225_1.time_ and arg_225_1.time_ < var_228_5 + var_228_13 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_5) / var_228_13

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_5 + var_228_13 and arg_225_1.time_ < var_228_5 + var_228_13 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play926031057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 926031057
		arg_229_1.duration_ = 8.13

		local var_229_0 = {
			zh = 5.4,
			ja = 8.133
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
				arg_229_0:Play926031058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.7

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(926031057)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 28 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 28)

				if (28 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 28)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031057", "story_v_out_926031.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_926031", "926031057", "story_v_out_926031.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_926031", "926031057", "story_v_out_926031.awb")

						arg_229_1:RecordAudio("926031057", var_232_6)
						arg_229_1:RecordAudio("926031057", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_926031", "926031057", "story_v_out_926031.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_926031", "926031057", "story_v_out_926031.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play926031058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 926031058
		arg_233_1.duration_ = 5

		local var_233_0 = {
			zh = 3.9,
			ja = 5
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
				arg_233_0:Play926031059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10144 = arg_233_1.actors_["10144"].transform.localPosition
				arg_233_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10144", 3)

				for iter_236_0 = 0, arg_233_1.actors_["10144"].transform.childCount - 1 do
					local var_236_0 = arg_233_1.actors_["10144"].transform:GetChild(iter_236_0)

					if var_236_0.name == "split_4" or not string.find(var_236_0.name, "split") then
						var_236_0.gameObject:SetActive(true)
					else
						var_236_0.gameObject:SetActive(false)
					end
				end
			end

			local var_236_1 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_1 then
				arg_233_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_233_1.time_ - 0) / var_236_1)
			end

			if arg_233_1.time_ >= 0 + var_236_1 and arg_233_1.time_ < 0 + var_236_1 + arg_236_0 then
				arg_233_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_236_2 = 0
			local var_236_3 = 0.5

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_4 = arg_233_1:GetWordFromCfg(926031058)
				local var_236_5 = arg_233_1:FormatText(var_236_4.content)

				arg_233_1.text_.text = var_236_5

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_7 = 20 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 20)

				if (20 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 20)) > 0 and var_236_3 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_2
					end
				end

				arg_233_1.text_.text = var_236_5
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031058", "story_v_out_926031.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031058", "story_v_out_926031.awb") / 1000

					if var_236_8 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_2
					end

					if var_236_4.prefab_name ~= "" and arg_233_1.actors_[var_236_4.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_4.prefab_name].transform, "story_v_out_926031", "926031058", "story_v_out_926031.awb")

						arg_233_1:RecordAudio("926031058", var_236_9)
						arg_233_1:RecordAudio("926031058", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_926031", "926031058", "story_v_out_926031.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_926031", "926031058", "story_v_out_926031.awb")
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
				actorName = "10144",
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
	Play926031059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 926031059
		arg_237_1.duration_ = 1.67

		local var_237_0 = {
			zh = 1.533,
			ja = 1.666
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play926031060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["106103"]) and arg_237_1.var_.actorSpriteComps106103 == nil then
				arg_237_1.var_.actorSpriteComps106103 = arg_237_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_0 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["106103"]) then
				if arg_237_1.var_.actorSpriteComps106103 then
					for iter_240_0, iter_240_1 in pairs(arg_237_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_240_1 then
							if arg_237_1.isInRecall_ then
								iter_240_1.color = Color.New(Mathf.Lerp(iter_240_1.color.r, arg_237_1.hightColor1.r, (arg_237_1.time_ - 0) / var_240_0), Mathf.Lerp(iter_240_1.color.g, arg_237_1.hightColor1.g, (arg_237_1.time_ - 0) / var_240_0), (Mathf.Lerp(iter_240_1.color.b, arg_237_1.hightColor1.b, (arg_237_1.time_ - 0) / var_240_0)))
							else
								local var_240_1 = Mathf.Lerp(iter_240_1.color.r, 1, (arg_237_1.time_ - 0) / var_240_0)

								iter_240_1.color = Color.New(var_240_1, var_240_1, var_240_1)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["106103"]) and arg_237_1.var_.actorSpriteComps106103 then
				for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_240_3 then
						iter_240_3.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_237_1.var_.actorSpriteComps106103 = nil
			end

			local var_240_2 = arg_237_1.actors_["10144"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps10144 == nil then
				arg_237_1.var_.actorSpriteComps10144 = var_240_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_3 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 and not isNil(var_240_2) then
				if arg_237_1.var_.actorSpriteComps10144 then
					for iter_240_4, iter_240_5 in pairs(arg_237_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_240_5 then
							if arg_237_1.isInRecall_ then
								iter_240_5.color = Color.New(Mathf.Lerp(iter_240_5.color.r, arg_237_1.hightColor2.r, (arg_237_1.time_ - 0) / var_240_3), Mathf.Lerp(iter_240_5.color.g, arg_237_1.hightColor2.g, (arg_237_1.time_ - 0) / var_240_3), (Mathf.Lerp(iter_240_5.color.b, arg_237_1.hightColor2.b, (arg_237_1.time_ - 0) / var_240_3)))
							else
								local var_240_4 = Mathf.Lerp(iter_240_5.color.r, 0.5, (arg_237_1.time_ - 0) / var_240_3)

								iter_240_5.color = Color.New(var_240_4, var_240_4, var_240_4)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps10144 then
				for iter_240_6, iter_240_7 in pairs(arg_237_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_240_7 then
						iter_240_7.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_237_1.var_.actorSpriteComps10144 = nil
			end

			local var_240_5 = arg_237_1.actors_["106103"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos106103 = var_240_5.localPosition
				var_240_5.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("106103", 3)

				for iter_240_8 = 0, var_240_5.childCount - 1 do
					local var_240_6 = var_240_5:GetChild(iter_240_8)

					if var_240_6.name == "split_2" or not string.find(var_240_6.name, "split") then
						var_240_6.gameObject:SetActive(true)
					else
						var_240_6.gameObject:SetActive(false)
					end
				end
			end

			local var_240_7 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 then
				var_240_5.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_237_1.time_ - 0) / var_240_7)
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 then
				var_240_5.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_240_8 = arg_237_1.actors_["10144"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10144 = var_240_8.localPosition
				var_240_8.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10144", 7)

				for iter_240_9 = 0, var_240_8.childCount - 1 do
					local var_240_9 = var_240_8:GetChild(iter_240_9)

					if var_240_9.name == "" or not string.find(var_240_9.name, "split") then
						var_240_9.gameObject:SetActive(true)
					else
						var_240_9.gameObject:SetActive(false)
					end
				end
			end

			local var_240_10 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_10 then
				var_240_8.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_237_1.time_ - 0) / var_240_10)
			end

			if arg_237_1.time_ >= 0 + var_240_10 and arg_237_1.time_ < 0 + var_240_10 + arg_240_0 then
				var_240_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_240_11 = 0
			local var_240_12 = 0.125

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_11 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_13 = arg_237_1:GetWordFromCfg(926031059)
				local var_240_14 = arg_237_1:FormatText(var_240_13.content)

				arg_237_1.text_.text = var_240_14

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_16 = 5 <= 0 and var_240_12 or var_240_12 * (utf8.len(var_240_14) / 5)

				if (5 <= 0 and var_240_12 or var_240_12 * (utf8.len(var_240_14) / 5)) > 0 and var_240_12 < var_240_16 then
					arg_237_1.talkMaxDuration = var_240_16

					if var_240_16 + var_240_11 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_16 + var_240_11
					end
				end

				arg_237_1.text_.text = var_240_14
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031059", "story_v_out_926031.awb") ~= 0 then
					local var_240_17 = manager.audio:GetVoiceLength("story_v_out_926031", "926031059", "story_v_out_926031.awb") / 1000

					if var_240_17 + var_240_11 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_17 + var_240_11
					end

					if var_240_13.prefab_name ~= "" and arg_237_1.actors_[var_240_13.prefab_name] ~= nil then
						local var_240_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_13.prefab_name].transform, "story_v_out_926031", "926031059", "story_v_out_926031.awb")

						arg_237_1:RecordAudio("926031059", var_240_18)
						arg_237_1:RecordAudio("926031059", var_240_18)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_926031", "926031059", "story_v_out_926031.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_926031", "926031059", "story_v_out_926031.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_19 = math.max(var_240_12, arg_237_1.talkMaxDuration)

			if var_240_11 <= arg_237_1.time_ and arg_237_1.time_ < var_240_11 + var_240_19 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_11) / var_240_19

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_11 + var_240_19 and arg_237_1.time_ < var_240_11 + var_240_19 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play926031060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 926031060
		arg_241_1.duration_ = 3.77

		local var_241_0 = {
			zh = 3.766,
			ja = 3.466
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
				arg_241_0:Play926031061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["104701"]) and arg_241_1.var_.actorSpriteComps104701 == nil then
				arg_241_1.var_.actorSpriteComps104701 = arg_241_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_0 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["104701"]) then
				if arg_241_1.var_.actorSpriteComps104701 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["104701"]) and arg_241_1.var_.actorSpriteComps104701 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_244_3 then
						iter_244_3.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_241_1.var_.actorSpriteComps104701 = nil
			end

			local var_244_2 = arg_241_1.actors_["106103"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps106103 == nil then
				arg_241_1.var_.actorSpriteComps106103 = var_244_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_3 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.actorSpriteComps106103 then
					for iter_244_4, iter_244_5 in pairs(arg_241_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps106103 then
				for iter_244_6, iter_244_7 in pairs(arg_241_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_244_7 then
						iter_244_7.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_241_1.var_.actorSpriteComps106103 = nil
			end

			local var_244_5 = arg_241_1.actors_["104701"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos104701 = var_244_5.localPosition
				var_244_5.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("104701", 3)

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
				var_244_5.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_241_1.time_ - 0) / var_244_7)
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				var_244_5.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_244_8 = arg_241_1.actors_["106103"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos106103 = var_244_8.localPosition
				var_244_8.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("106103", 7)

				for iter_244_9 = 0, var_244_8.childCount - 1 do
					local var_244_9 = var_244_8:GetChild(iter_244_9)

					if var_244_9.name == "split_4" or not string.find(var_244_9.name, "split") then
						var_244_9.gameObject:SetActive(true)
					else
						var_244_9.gameObject:SetActive(false)
					end
				end
			end

			local var_244_10 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_10 then
				var_244_8.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_241_1.time_ - 0) / var_244_10)
			end

			if arg_241_1.time_ >= 0 + var_244_10 and arg_241_1.time_ < 0 + var_244_10 + arg_244_0 then
				var_244_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_244_11 = 0
			local var_244_12 = 0.4

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_11 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_13 = arg_241_1:GetWordFromCfg(926031060)
				local var_244_14 = arg_241_1:FormatText(var_244_13.content)

				arg_241_1.text_.text = var_244_14

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_16 = 16 <= 0 and var_244_12 or var_244_12 * (utf8.len(var_244_14) / 16)

				if (16 <= 0 and var_244_12 or var_244_12 * (utf8.len(var_244_14) / 16)) > 0 and var_244_12 < var_244_16 then
					arg_241_1.talkMaxDuration = var_244_16

					if var_244_16 + var_244_11 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_16 + var_244_11
					end
				end

				arg_241_1.text_.text = var_244_14
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031060", "story_v_out_926031.awb") ~= 0 then
					local var_244_17 = manager.audio:GetVoiceLength("story_v_out_926031", "926031060", "story_v_out_926031.awb") / 1000

					if var_244_17 + var_244_11 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_17 + var_244_11
					end

					if var_244_13.prefab_name ~= "" and arg_241_1.actors_[var_244_13.prefab_name] ~= nil then
						local var_244_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_13.prefab_name].transform, "story_v_out_926031", "926031060", "story_v_out_926031.awb")

						arg_241_1:RecordAudio("926031060", var_244_18)
						arg_241_1:RecordAudio("926031060", var_244_18)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_926031", "926031060", "story_v_out_926031.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_926031", "926031060", "story_v_out_926031.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_19 = math.max(var_244_12, arg_241_1.talkMaxDuration)

			if var_244_11 <= arg_241_1.time_ and arg_241_1.time_ < var_244_11 + var_244_19 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_11) / var_244_19

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_11 + var_244_19 and arg_241_1.time_ < var_244_11 + var_244_19 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
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
	Play926031061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 926031061
		arg_245_1.duration_ = 7.93

		local var_245_0 = {
			zh = 5.266,
			ja = 7.933
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
				arg_245_0:Play926031062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10144"]) and arg_245_1.var_.actorSpriteComps10144 == nil then
				arg_245_1.var_.actorSpriteComps10144 = arg_245_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_0 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10144"]) then
				if arg_245_1.var_.actorSpriteComps10144 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10144"]) and arg_245_1.var_.actorSpriteComps10144 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_248_3 then
						iter_248_3.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_245_1.var_.actorSpriteComps10144 = nil
			end

			local var_248_2 = arg_245_1.actors_["104701"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.actorSpriteComps104701 == nil then
				arg_245_1.var_.actorSpriteComps104701 = var_248_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_3 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_3 and not isNil(var_248_2) then
				if arg_245_1.var_.actorSpriteComps104701 then
					for iter_248_4, iter_248_5 in pairs(arg_245_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_245_1.time_ >= 0 + var_248_3 and arg_245_1.time_ < 0 + var_248_3 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.actorSpriteComps104701 then
				for iter_248_6, iter_248_7 in pairs(arg_245_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_248_7 then
						iter_248_7.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_245_1.var_.actorSpriteComps104701 = nil
			end

			local var_248_5 = arg_245_1.actors_["106103"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos106103 = var_248_5.localPosition
				var_248_5.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("106103", 7)

				for iter_248_8 = 0, var_248_5.childCount - 1 do
					local var_248_6 = var_248_5:GetChild(iter_248_8)

					if var_248_6.name == "" or not string.find(var_248_6.name, "split") then
						var_248_6.gameObject:SetActive(true)
					else
						var_248_6.gameObject:SetActive(false)
					end
				end
			end

			local var_248_7 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				var_248_5.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_245_1.time_ - 0) / var_248_7)
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				var_248_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_248_8 = arg_245_1.actors_["10144"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos10144 = var_248_8.localPosition
				var_248_8.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("10144", 2)

				for iter_248_9 = 0, var_248_8.childCount - 1 do
					local var_248_9 = var_248_8:GetChild(iter_248_9)

					if var_248_9.name == "" or not string.find(var_248_9.name, "split") then
						var_248_9.gameObject:SetActive(true)
					else
						var_248_9.gameObject:SetActive(false)
					end
				end
			end

			local var_248_10 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_10 then
				var_248_8.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_245_1.time_ - 0) / var_248_10)
			end

			if arg_245_1.time_ >= 0 + var_248_10 and arg_245_1.time_ < 0 + var_248_10 + arg_248_0 then
				var_248_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_248_11 = arg_245_1.actors_["104701"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos104701 = var_248_11.localPosition
				var_248_11.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("104701", 4)

				for iter_248_10 = 0, var_248_11.childCount - 1 do
					local var_248_12 = var_248_11:GetChild(iter_248_10)

					if var_248_12.name == "" or not string.find(var_248_12.name, "split") then
						var_248_12.gameObject:SetActive(true)
					else
						var_248_12.gameObject:SetActive(false)
					end
				end
			end

			local var_248_13 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_13 then
				var_248_11.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos104701, Vector3.New(372.4, -386.8, -295), (arg_245_1.time_ - 0) / var_248_13)
			end

			if arg_245_1.time_ >= 0 + var_248_13 and arg_245_1.time_ < 0 + var_248_13 + arg_248_0 then
				var_248_11.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_248_14 = 0
			local var_248_15 = 0.65

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_14 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_16 = arg_245_1:GetWordFromCfg(926031061)
				local var_248_17 = arg_245_1:FormatText(var_248_16.content)

				arg_245_1.text_.text = var_248_17

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_19 = 26 <= 0 and var_248_15 or var_248_15 * (utf8.len(var_248_17) / 26)

				if (26 <= 0 and var_248_15 or var_248_15 * (utf8.len(var_248_17) / 26)) > 0 and var_248_15 < var_248_19 then
					arg_245_1.talkMaxDuration = var_248_19

					if var_248_19 + var_248_14 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_19 + var_248_14
					end
				end

				arg_245_1.text_.text = var_248_17
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031061", "story_v_out_926031.awb") ~= 0 then
					local var_248_20 = manager.audio:GetVoiceLength("story_v_out_926031", "926031061", "story_v_out_926031.awb") / 1000

					if var_248_20 + var_248_14 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_20 + var_248_14
					end

					if var_248_16.prefab_name ~= "" and arg_245_1.actors_[var_248_16.prefab_name] ~= nil then
						local var_248_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_16.prefab_name].transform, "story_v_out_926031", "926031061", "story_v_out_926031.awb")

						arg_245_1:RecordAudio("926031061", var_248_21)
						arg_245_1:RecordAudio("926031061", var_248_21)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_926031", "926031061", "story_v_out_926031.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_926031", "926031061", "story_v_out_926031.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_22 = math.max(var_248_15, arg_245_1.talkMaxDuration)

			if var_248_14 <= arg_245_1.time_ and arg_245_1.time_ < var_248_14 + var_248_22 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_14) / var_248_22

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_14 + var_248_22 and arg_245_1.time_ < var_248_14 + var_248_22 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play926031062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 926031062
		arg_249_1.duration_ = 3.53

		local var_249_0 = {
			zh = 3.533,
			ja = 2.733
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
				arg_249_0:Play926031063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["104701"]) and arg_249_1.var_.actorSpriteComps104701 == nil then
				arg_249_1.var_.actorSpriteComps104701 = arg_249_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["104701"]) then
				if arg_249_1.var_.actorSpriteComps104701 then
					for iter_252_0, iter_252_1 in pairs(arg_249_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["104701"]) and arg_249_1.var_.actorSpriteComps104701 then
				for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_252_3 then
						iter_252_3.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps104701 = nil
			end

			local var_252_2 = arg_249_1.actors_["10144"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps10144 == nil then
				arg_249_1.var_.actorSpriteComps10144 = var_252_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_3 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 and not isNil(var_252_2) then
				if arg_249_1.var_.actorSpriteComps10144 then
					for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps10144 then
				for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_252_7 then
						iter_252_7.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_249_1.var_.actorSpriteComps10144 = nil
			end

			local var_252_5 = arg_249_1.actors_["10144"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10144 = var_252_5.localPosition
				var_252_5.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10144", 2)

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
				var_252_5.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_249_1.time_ - 0) / var_252_7)
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				var_252_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_252_8 = 0
			local var_252_9 = 0.45

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_10 = arg_249_1:GetWordFromCfg(926031062)
				local var_252_11 = arg_249_1:FormatText(var_252_10.content)

				arg_249_1.text_.text = var_252_11

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_13 = 18 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 18)

				if (18 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 18)) > 0 and var_252_9 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_8
					end
				end

				arg_249_1.text_.text = var_252_11
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031062", "story_v_out_926031.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_926031", "926031062", "story_v_out_926031.awb") / 1000

					if var_252_14 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_8
					end

					if var_252_10.prefab_name ~= "" and arg_249_1.actors_[var_252_10.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_10.prefab_name].transform, "story_v_out_926031", "926031062", "story_v_out_926031.awb")

						arg_249_1:RecordAudio("926031062", var_252_15)
						arg_249_1:RecordAudio("926031062", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_926031", "926031062", "story_v_out_926031.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_926031", "926031062", "story_v_out_926031.awb")
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
				actorName = "10144",
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
	Play926031063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 926031063
		arg_253_1.duration_ = 4.2

		local var_253_0 = {
			zh = 3.666,
			ja = 4.2
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
				arg_253_0:Play926031064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["10144"]) and arg_253_1.var_.actorSpriteComps10144 == nil then
				arg_253_1.var_.actorSpriteComps10144 = arg_253_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_0 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["10144"]) then
				if arg_253_1.var_.actorSpriteComps10144 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								iter_256_1.color = Color.New(Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor1.r, (arg_253_1.time_ - 0) / var_256_0), Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor1.g, (arg_253_1.time_ - 0) / var_256_0), (Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor1.b, (arg_253_1.time_ - 0) / var_256_0)))
							else
								local var_256_1 = Mathf.Lerp(iter_256_1.color.r, 1, (arg_253_1.time_ - 0) / var_256_0)

								iter_256_1.color = Color.New(var_256_1, var_256_1, var_256_1)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["10144"]) and arg_253_1.var_.actorSpriteComps10144 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_256_3 then
						iter_256_3.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_253_1.var_.actorSpriteComps10144 = nil
			end

			local var_256_2 = arg_253_1.actors_["104701"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps104701 == nil then
				arg_253_1.var_.actorSpriteComps104701 = var_256_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_3 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.actorSpriteComps104701 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								iter_256_5.color = Color.New(Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor2.r, (arg_253_1.time_ - 0) / var_256_3), Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor2.g, (arg_253_1.time_ - 0) / var_256_3), (Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor2.b, (arg_253_1.time_ - 0) / var_256_3)))
							else
								local var_256_4 = Mathf.Lerp(iter_256_5.color.r, 0.5, (arg_253_1.time_ - 0) / var_256_3)

								iter_256_5.color = Color.New(var_256_4, var_256_4, var_256_4)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps104701 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_256_7 then
						iter_256_7.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_253_1.var_.actorSpriteComps104701 = nil
			end

			local var_256_5 = 0
			local var_256_6 = 0.375

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_7 = arg_253_1:GetWordFromCfg(926031063)
				local var_256_8 = arg_253_1:FormatText(var_256_7.content)

				arg_253_1.text_.text = var_256_8

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_10 = 15 <= 0 and var_256_6 or var_256_6 * (utf8.len(var_256_8) / 15)

				if (15 <= 0 and var_256_6 or var_256_6 * (utf8.len(var_256_8) / 15)) > 0 and var_256_6 < var_256_10 then
					arg_253_1.talkMaxDuration = var_256_10

					if var_256_10 + var_256_5 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_5
					end
				end

				arg_253_1.text_.text = var_256_8
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031063", "story_v_out_926031.awb") ~= 0 then
					local var_256_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031063", "story_v_out_926031.awb") / 1000

					if var_256_11 + var_256_5 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_11 + var_256_5
					end

					if var_256_7.prefab_name ~= "" and arg_253_1.actors_[var_256_7.prefab_name] ~= nil then
						local var_256_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_7.prefab_name].transform, "story_v_out_926031", "926031063", "story_v_out_926031.awb")

						arg_253_1:RecordAudio("926031063", var_256_12)
						arg_253_1:RecordAudio("926031063", var_256_12)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_926031", "926031063", "story_v_out_926031.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_926031", "926031063", "story_v_out_926031.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_13 = math.max(var_256_6, arg_253_1.talkMaxDuration)

			if var_256_5 <= arg_253_1.time_ and arg_253_1.time_ < var_256_5 + var_256_13 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_5) / var_256_13

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_5 + var_256_13 and arg_253_1.time_ < var_256_5 + var_256_13 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play926031064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 926031064
		arg_257_1.duration_ = 9.1

		local var_257_0 = {
			zh = 6.933,
			ja = 9.1
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
				arg_257_0:Play926031065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["104701"]) and arg_257_1.var_.actorSpriteComps104701 == nil then
				arg_257_1.var_.actorSpriteComps104701 = arg_257_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_0 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["104701"]) then
				if arg_257_1.var_.actorSpriteComps104701 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["104701"]) and arg_257_1.var_.actorSpriteComps104701 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_260_3 then
						iter_260_3.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_257_1.var_.actorSpriteComps104701 = nil
			end

			local var_260_2 = arg_257_1.actors_["10144"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps10144 == nil then
				arg_257_1.var_.actorSpriteComps10144 = var_260_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_3 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.actorSpriteComps10144 then
					for iter_260_4, iter_260_5 in pairs(arg_257_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps10144 then
				for iter_260_6, iter_260_7 in pairs(arg_257_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_260_7 then
						iter_260_7.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_257_1.var_.actorSpriteComps10144 = nil
			end

			local var_260_5 = arg_257_1.actors_["104701"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos104701 = var_260_5.localPosition
				var_260_5.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("104701", 4)

				for iter_260_8 = 0, var_260_5.childCount - 1 do
					local var_260_6 = var_260_5:GetChild(iter_260_8)

					if var_260_6.name == "split_6" or not string.find(var_260_6.name, "split") then
						var_260_6.gameObject:SetActive(true)
					else
						var_260_6.gameObject:SetActive(false)
					end
				end
			end

			local var_260_7 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				var_260_5.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos104701, Vector3.New(372.4, -386.8, -295), (arg_257_1.time_ - 0) / var_260_7)
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				var_260_5.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_260_8 = 0
			local var_260_9 = 0.75

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_10 = arg_257_1:GetWordFromCfg(926031064)
				local var_260_11 = arg_257_1:FormatText(var_260_10.content)

				arg_257_1.text_.text = var_260_11

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 30 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 30)

				if (30 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 30)) > 0 and var_260_9 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_11
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031064", "story_v_out_926031.awb") ~= 0 then
					local var_260_14 = manager.audio:GetVoiceLength("story_v_out_926031", "926031064", "story_v_out_926031.awb") / 1000

					if var_260_14 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_8
					end

					if var_260_10.prefab_name ~= "" and arg_257_1.actors_[var_260_10.prefab_name] ~= nil then
						local var_260_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_10.prefab_name].transform, "story_v_out_926031", "926031064", "story_v_out_926031.awb")

						arg_257_1:RecordAudio("926031064", var_260_15)
						arg_257_1:RecordAudio("926031064", var_260_15)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_926031", "926031064", "story_v_out_926031.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_926031", "926031064", "story_v_out_926031.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_16 = math.max(var_260_9, arg_257_1.talkMaxDuration)

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_16 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_8) / var_260_16

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_8 + var_260_16 and arg_257_1.time_ < var_260_8 + var_260_16 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
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
	Play926031065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 926031065
		arg_261_1.duration_ = 7.6

		local var_261_0 = {
			zh = 6.166,
			ja = 7.6
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
				arg_261_0:Play926031066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.85

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:GetWordFromCfg(926031065)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 34 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 34)

				if (34 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 34)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031065", "story_v_out_926031.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_926031", "926031065", "story_v_out_926031.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_926031", "926031065", "story_v_out_926031.awb")

						arg_261_1:RecordAudio("926031065", var_264_6)
						arg_261_1:RecordAudio("926031065", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_926031", "926031065", "story_v_out_926031.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_926031", "926031065", "story_v_out_926031.awb")
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
	Play926031066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 926031066
		arg_265_1.duration_ = 20.43

		local var_265_0 = {
			zh = 14.8,
			ja = 20.433
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
				arg_265_0:Play926031067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos104701 = arg_265_1.actors_["104701"].transform.localPosition
				arg_265_1.actors_["104701"].transform.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("104701", 4)

				for iter_268_0 = 0, arg_265_1.actors_["104701"].transform.childCount - 1 do
					local var_268_0 = arg_265_1.actors_["104701"].transform:GetChild(iter_268_0)

					if var_268_0.name == "" or not string.find(var_268_0.name, "split") then
						var_268_0.gameObject:SetActive(true)
					else
						var_268_0.gameObject:SetActive(false)
					end
				end
			end

			local var_268_1 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				arg_265_1.actors_["104701"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos104701, Vector3.New(372.4, -386.8, -295), (arg_265_1.time_ - 0) / var_268_1)
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				arg_265_1.actors_["104701"].transform.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_268_2 = 0
			local var_268_3 = 1.7

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_4 = arg_265_1:GetWordFromCfg(926031066)
				local var_268_5 = arg_265_1:FormatText(var_268_4.content)

				arg_265_1.text_.text = var_268_5

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_7 = 68 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 68)

				if (68 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 68)) > 0 and var_268_3 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_5
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031066", "story_v_out_926031.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031066", "story_v_out_926031.awb") / 1000

					if var_268_8 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_2
					end

					if var_268_4.prefab_name ~= "" and arg_265_1.actors_[var_268_4.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_4.prefab_name].transform, "story_v_out_926031", "926031066", "story_v_out_926031.awb")

						arg_265_1:RecordAudio("926031066", var_268_9)
						arg_265_1:RecordAudio("926031066", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_926031", "926031066", "story_v_out_926031.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_926031", "926031066", "story_v_out_926031.awb")
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
				actorName = "104701",
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
	Play926031067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 926031067
		arg_269_1.duration_ = 1

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"

			SetActive(arg_269_1.choicesGo_, true)

			for iter_270_0, iter_270_1 in ipairs(arg_269_1.choices_) do
				SetActive(iter_270_1.go, iter_270_0 <= 2)
			end

			arg_269_1.choices_[1].txt.text = arg_269_1:FormatText(StoryChoiceCfg[1318].name)
			arg_269_1.choices_[2].txt.text = arg_269_1:FormatText(StoryChoiceCfg[1319].name)
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play926031068(arg_269_1)
			end

			if arg_271_0 == 2 then
				arg_269_0:Play926031069(arg_269_1)
			end

			arg_269_1:RecordChoiceLog(926031067, 1318, 1319)
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["104701"]) and arg_269_1.var_.actorSpriteComps104701 == nil then
				arg_269_1.var_.actorSpriteComps104701 = arg_269_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["104701"]) then
				if arg_269_1.var_.actorSpriteComps104701 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["104701"]) and arg_269_1.var_.actorSpriteComps104701 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_272_3 then
						iter_272_3.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_269_1.var_.actorSpriteComps104701 = nil
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play926031068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 926031068
		arg_273_1.duration_ = 7.83

		local var_273_0 = {
			zh = 5.033,
			ja = 7.833
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
				arg_273_0:Play926031069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["128404"]) and arg_273_1.var_.actorSpriteComps128404 == nil then
				arg_273_1.var_.actorSpriteComps128404 = arg_273_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_0 = 0.2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["128404"]) then
				if arg_273_1.var_.actorSpriteComps128404 then
					for iter_276_0, iter_276_1 in pairs(arg_273_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_276_1 then
							if arg_273_1.isInRecall_ then
								iter_276_1.color = Color.New(Mathf.Lerp(iter_276_1.color.r, arg_273_1.hightColor1.r, (arg_273_1.time_ - 0) / var_276_0), Mathf.Lerp(iter_276_1.color.g, arg_273_1.hightColor1.g, (arg_273_1.time_ - 0) / var_276_0), (Mathf.Lerp(iter_276_1.color.b, arg_273_1.hightColor1.b, (arg_273_1.time_ - 0) / var_276_0)))
							else
								local var_276_1 = Mathf.Lerp(iter_276_1.color.r, 1, (arg_273_1.time_ - 0) / var_276_0)

								iter_276_1.color = Color.New(var_276_1, var_276_1, var_276_1)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["128404"]) and arg_273_1.var_.actorSpriteComps128404 then
				for iter_276_2, iter_276_3 in pairs(arg_273_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_276_3 then
						iter_276_3.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_273_1.var_.actorSpriteComps128404 = nil
			end

			local var_276_2 = arg_273_1.actors_["104701"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos104701 = var_276_2.localPosition
				var_276_2.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("104701", 7)

				for iter_276_4 = 0, var_276_2.childCount - 1 do
					local var_276_3 = var_276_2:GetChild(iter_276_4)

					if var_276_3.name == "" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				var_276_2.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_273_1.time_ - 0) / var_276_4)
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				var_276_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_276_5 = arg_273_1.actors_["10144"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10144 = var_276_5.localPosition
				var_276_5.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10144", 7)

				for iter_276_5 = 0, var_276_5.childCount - 1 do
					local var_276_6 = var_276_5:GetChild(iter_276_5)

					if var_276_6.name == "" or not string.find(var_276_6.name, "split") then
						var_276_6.gameObject:SetActive(true)
					else
						var_276_6.gameObject:SetActive(false)
					end
				end
			end

			local var_276_7 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				var_276_5.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_273_1.time_ - 0) / var_276_7)
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				var_276_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_276_8 = arg_273_1.actors_["128404"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos128404 = var_276_8.localPosition
				var_276_8.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("128404", 3)

				for iter_276_6 = 0, var_276_8.childCount - 1 do
					local var_276_9 = var_276_8:GetChild(iter_276_6)

					if var_276_9.name == "split_6" or not string.find(var_276_9.name, "split") then
						var_276_9.gameObject:SetActive(true)
					else
						var_276_9.gameObject:SetActive(false)
					end
				end
			end

			local var_276_10 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_10 then
				var_276_8.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_273_1.time_ - 0) / var_276_10)
			end

			if arg_273_1.time_ >= 0 + var_276_10 and arg_273_1.time_ < 0 + var_276_10 + arg_276_0 then
				var_276_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_276_11 = 0
			local var_276_12 = 0.625

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_11 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_13 = arg_273_1:GetWordFromCfg(926031068)
				local var_276_14 = arg_273_1:FormatText(var_276_13.content)

				arg_273_1.text_.text = var_276_14

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_16 = 25 <= 0 and var_276_12 or var_276_12 * (utf8.len(var_276_14) / 25)

				if (25 <= 0 and var_276_12 or var_276_12 * (utf8.len(var_276_14) / 25)) > 0 and var_276_12 < var_276_16 then
					arg_273_1.talkMaxDuration = var_276_16

					if var_276_16 + var_276_11 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_16 + var_276_11
					end
				end

				arg_273_1.text_.text = var_276_14
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031068", "story_v_out_926031.awb") ~= 0 then
					local var_276_17 = manager.audio:GetVoiceLength("story_v_out_926031", "926031068", "story_v_out_926031.awb") / 1000

					if var_276_17 + var_276_11 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_17 + var_276_11
					end

					if var_276_13.prefab_name ~= "" and arg_273_1.actors_[var_276_13.prefab_name] ~= nil then
						local var_276_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_13.prefab_name].transform, "story_v_out_926031", "926031068", "story_v_out_926031.awb")

						arg_273_1:RecordAudio("926031068", var_276_18)
						arg_273_1:RecordAudio("926031068", var_276_18)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_926031", "926031068", "story_v_out_926031.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_926031", "926031068", "story_v_out_926031.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_19 = math.max(var_276_12, arg_273_1.talkMaxDuration)

			if var_276_11 <= arg_273_1.time_ and arg_273_1.time_ < var_276_11 + var_276_19 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_11) / var_276_19

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_11 + var_276_19 and arg_273_1.time_ < var_276_11 + var_276_19 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
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
	Play926031069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 926031069
		arg_277_1.duration_ = 7.07

		local var_277_0 = {
			zh = 4,
			ja = 7.066
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
				arg_277_0:Play926031070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["106103"]) and arg_277_1.var_.actorSpriteComps106103 == nil then
				arg_277_1.var_.actorSpriteComps106103 = arg_277_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_0 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["106103"]) then
				if arg_277_1.var_.actorSpriteComps106103 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_280_1 then
							if arg_277_1.isInRecall_ then
								iter_280_1.color = Color.New(Mathf.Lerp(iter_280_1.color.r, arg_277_1.hightColor1.r, (arg_277_1.time_ - 0) / var_280_0), Mathf.Lerp(iter_280_1.color.g, arg_277_1.hightColor1.g, (arg_277_1.time_ - 0) / var_280_0), (Mathf.Lerp(iter_280_1.color.b, arg_277_1.hightColor1.b, (arg_277_1.time_ - 0) / var_280_0)))
							else
								local var_280_1 = Mathf.Lerp(iter_280_1.color.r, 1, (arg_277_1.time_ - 0) / var_280_0)

								iter_280_1.color = Color.New(var_280_1, var_280_1, var_280_1)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["106103"]) and arg_277_1.var_.actorSpriteComps106103 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_280_3 then
						iter_280_3.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps106103 = nil
			end

			local var_280_2 = arg_277_1.actors_["128404"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps128404 == nil then
				arg_277_1.var_.actorSpriteComps128404 = var_280_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_3 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.actorSpriteComps128404 then
					for iter_280_4, iter_280_5 in pairs(arg_277_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_280_5 then
							if arg_277_1.isInRecall_ then
								iter_280_5.color = Color.New(Mathf.Lerp(iter_280_5.color.r, arg_277_1.hightColor2.r, (arg_277_1.time_ - 0) / var_280_3), Mathf.Lerp(iter_280_5.color.g, arg_277_1.hightColor2.g, (arg_277_1.time_ - 0) / var_280_3), (Mathf.Lerp(iter_280_5.color.b, arg_277_1.hightColor2.b, (arg_277_1.time_ - 0) / var_280_3)))
							else
								local var_280_4 = Mathf.Lerp(iter_280_5.color.r, 0.5, (arg_277_1.time_ - 0) / var_280_3)

								iter_280_5.color = Color.New(var_280_4, var_280_4, var_280_4)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps128404 then
				for iter_280_6, iter_280_7 in pairs(arg_277_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_280_7 then
						iter_280_7.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_277_1.var_.actorSpriteComps128404 = nil
			end

			local var_280_5 = arg_277_1.actors_["128404"].transform

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos128404 = var_280_5.localPosition
				var_280_5.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("128404", 4)

				for iter_280_8 = 0, var_280_5.childCount - 1 do
					local var_280_6 = var_280_5:GetChild(iter_280_8)

					if var_280_6.name == "split_6" or not string.find(var_280_6.name, "split") then
						var_280_6.gameObject:SetActive(true)
					else
						var_280_6.gameObject:SetActive(false)
					end
				end
			end

			local var_280_7 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				var_280_5.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_277_1.time_ - 0) / var_280_7)
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				var_280_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_280_8 = arg_277_1.actors_["106103"].transform

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos106103 = var_280_8.localPosition
				var_280_8.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("106103", 2)

				for iter_280_9 = 0, var_280_8.childCount - 1 do
					local var_280_9 = var_280_8:GetChild(iter_280_9)

					if var_280_9.name == "" or not string.find(var_280_9.name, "split") then
						var_280_9.gameObject:SetActive(true)
					else
						var_280_9.gameObject:SetActive(false)
					end
				end
			end

			local var_280_10 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_10 then
				var_280_8.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos106103, Vector3.New(-428.4, -398.2, -333.7), (arg_277_1.time_ - 0) / var_280_10)
			end

			if arg_277_1.time_ >= 0 + var_280_10 and arg_277_1.time_ < 0 + var_280_10 + arg_280_0 then
				var_280_8.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_280_11 = 0
			local var_280_12 = 0.525

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_11 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_13 = arg_277_1:GetWordFromCfg(926031069)
				local var_280_14 = arg_277_1:FormatText(var_280_13.content)

				arg_277_1.text_.text = var_280_14

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_16 = 21 <= 0 and var_280_12 or var_280_12 * (utf8.len(var_280_14) / 21)

				if (21 <= 0 and var_280_12 or var_280_12 * (utf8.len(var_280_14) / 21)) > 0 and var_280_12 < var_280_16 then
					arg_277_1.talkMaxDuration = var_280_16

					if var_280_16 + var_280_11 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_16 + var_280_11
					end
				end

				arg_277_1.text_.text = var_280_14
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031069", "story_v_out_926031.awb") ~= 0 then
					local var_280_17 = manager.audio:GetVoiceLength("story_v_out_926031", "926031069", "story_v_out_926031.awb") / 1000

					if var_280_17 + var_280_11 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_17 + var_280_11
					end

					if var_280_13.prefab_name ~= "" and arg_277_1.actors_[var_280_13.prefab_name] ~= nil then
						local var_280_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_13.prefab_name].transform, "story_v_out_926031", "926031069", "story_v_out_926031.awb")

						arg_277_1:RecordAudio("926031069", var_280_18)
						arg_277_1:RecordAudio("926031069", var_280_18)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_926031", "926031069", "story_v_out_926031.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_926031", "926031069", "story_v_out_926031.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_19 = math.max(var_280_12, arg_277_1.talkMaxDuration)

			if var_280_11 <= arg_277_1.time_ and arg_277_1.time_ < var_280_11 + var_280_19 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_11) / var_280_19

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_11 + var_280_19 and arg_277_1.time_ < var_280_11 + var_280_19 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
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
	Play926031070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 926031070
		arg_281_1.duration_ = 4.07

		local var_281_0 = {
			zh = 2.433,
			ja = 4.066
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
				arg_281_0:Play926031071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["128404"]) and arg_281_1.var_.actorSpriteComps128404 == nil then
				arg_281_1.var_.actorSpriteComps128404 = arg_281_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_0 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["128404"]) then
				if arg_281_1.var_.actorSpriteComps128404 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_284_1 then
							if arg_281_1.isInRecall_ then
								iter_284_1.color = Color.New(Mathf.Lerp(iter_284_1.color.r, arg_281_1.hightColor1.r, (arg_281_1.time_ - 0) / var_284_0), Mathf.Lerp(iter_284_1.color.g, arg_281_1.hightColor1.g, (arg_281_1.time_ - 0) / var_284_0), (Mathf.Lerp(iter_284_1.color.b, arg_281_1.hightColor1.b, (arg_281_1.time_ - 0) / var_284_0)))
							else
								local var_284_1 = Mathf.Lerp(iter_284_1.color.r, 1, (arg_281_1.time_ - 0) / var_284_0)

								iter_284_1.color = Color.New(var_284_1, var_284_1, var_284_1)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["128404"]) and arg_281_1.var_.actorSpriteComps128404 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_284_3 then
						iter_284_3.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_281_1.var_.actorSpriteComps128404 = nil
			end

			local var_284_2 = arg_281_1.actors_["106103"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps106103 == nil then
				arg_281_1.var_.actorSpriteComps106103 = var_284_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_3 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.actorSpriteComps106103 then
					for iter_284_4, iter_284_5 in pairs(arg_281_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_284_5 then
							if arg_281_1.isInRecall_ then
								iter_284_5.color = Color.New(Mathf.Lerp(iter_284_5.color.r, arg_281_1.hightColor2.r, (arg_281_1.time_ - 0) / var_284_3), Mathf.Lerp(iter_284_5.color.g, arg_281_1.hightColor2.g, (arg_281_1.time_ - 0) / var_284_3), (Mathf.Lerp(iter_284_5.color.b, arg_281_1.hightColor2.b, (arg_281_1.time_ - 0) / var_284_3)))
							else
								local var_284_4 = Mathf.Lerp(iter_284_5.color.r, 0.5, (arg_281_1.time_ - 0) / var_284_3)

								iter_284_5.color = Color.New(var_284_4, var_284_4, var_284_4)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps106103 then
				for iter_284_6, iter_284_7 in pairs(arg_281_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_284_7 then
						iter_284_7.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_281_1.var_.actorSpriteComps106103 = nil
			end

			local var_284_5 = 0
			local var_284_6 = 0.325

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_7 = arg_281_1:GetWordFromCfg(926031070)
				local var_284_8 = arg_281_1:FormatText(var_284_7.content)

				arg_281_1.text_.text = var_284_8

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 13 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 13)

				if (13 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 13)) > 0 and var_284_6 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_5
					end
				end

				arg_281_1.text_.text = var_284_8
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031070", "story_v_out_926031.awb") ~= 0 then
					local var_284_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031070", "story_v_out_926031.awb") / 1000

					if var_284_11 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_5
					end

					if var_284_7.prefab_name ~= "" and arg_281_1.actors_[var_284_7.prefab_name] ~= nil then
						local var_284_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_7.prefab_name].transform, "story_v_out_926031", "926031070", "story_v_out_926031.awb")

						arg_281_1:RecordAudio("926031070", var_284_12)
						arg_281_1:RecordAudio("926031070", var_284_12)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_926031", "926031070", "story_v_out_926031.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_926031", "926031070", "story_v_out_926031.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_13 = math.max(var_284_6, arg_281_1.talkMaxDuration)

			if var_284_5 <= arg_281_1.time_ and arg_281_1.time_ < var_284_5 + var_284_13 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_5) / var_284_13

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_5 + var_284_13 and arg_281_1.time_ < var_284_5 + var_284_13 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play926031071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 926031071
		arg_285_1.duration_ = 10.6

		local var_285_0 = {
			zh = 8.466,
			ja = 10.6
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
				arg_285_0:Play926031072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["106103"]) and arg_285_1.var_.actorSpriteComps106103 == nil then
				arg_285_1.var_.actorSpriteComps106103 = arg_285_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_0 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["106103"]) then
				if arg_285_1.var_.actorSpriteComps106103 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								iter_288_1.color = Color.New(Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor1.r, (arg_285_1.time_ - 0) / var_288_0), Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor1.g, (arg_285_1.time_ - 0) / var_288_0), (Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor1.b, (arg_285_1.time_ - 0) / var_288_0)))
							else
								local var_288_1 = Mathf.Lerp(iter_288_1.color.r, 1, (arg_285_1.time_ - 0) / var_288_0)

								iter_288_1.color = Color.New(var_288_1, var_288_1, var_288_1)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["106103"]) and arg_285_1.var_.actorSpriteComps106103 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps106103 = nil
			end

			local var_288_2 = arg_285_1.actors_["128404"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps128404 == nil then
				arg_285_1.var_.actorSpriteComps128404 = var_288_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_3 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.actorSpriteComps128404 then
					for iter_288_4, iter_288_5 in pairs(arg_285_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_288_5 then
							if arg_285_1.isInRecall_ then
								iter_288_5.color = Color.New(Mathf.Lerp(iter_288_5.color.r, arg_285_1.hightColor2.r, (arg_285_1.time_ - 0) / var_288_3), Mathf.Lerp(iter_288_5.color.g, arg_285_1.hightColor2.g, (arg_285_1.time_ - 0) / var_288_3), (Mathf.Lerp(iter_288_5.color.b, arg_285_1.hightColor2.b, (arg_285_1.time_ - 0) / var_288_3)))
							else
								local var_288_4 = Mathf.Lerp(iter_288_5.color.r, 0.5, (arg_285_1.time_ - 0) / var_288_3)

								iter_288_5.color = Color.New(var_288_4, var_288_4, var_288_4)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps128404 then
				for iter_288_6, iter_288_7 in pairs(arg_285_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_288_7 then
						iter_288_7.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_285_1.var_.actorSpriteComps128404 = nil
			end

			local var_288_5 = arg_285_1.actors_["106103"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos106103 = var_288_5.localPosition
				var_288_5.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("106103", 2)

				for iter_288_8 = 0, var_288_5.childCount - 1 do
					local var_288_6 = var_288_5:GetChild(iter_288_8)

					if var_288_6.name == "split_4" or not string.find(var_288_6.name, "split") then
						var_288_6.gameObject:SetActive(true)
					else
						var_288_6.gameObject:SetActive(false)
					end
				end
			end

			local var_288_7 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				var_288_5.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos106103, Vector3.New(-428.4, -398.2, -333.7), (arg_285_1.time_ - 0) / var_288_7)
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				var_288_5.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_288_8 = 0
			local var_288_9 = 0.8

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_10 = arg_285_1:GetWordFromCfg(926031071)
				local var_288_11 = arg_285_1:FormatText(var_288_10.content)

				arg_285_1.text_.text = var_288_11

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_13 = 32 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 32)

				if (32 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 32)) > 0 and var_288_9 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_8
					end
				end

				arg_285_1.text_.text = var_288_11
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031071", "story_v_out_926031.awb") ~= 0 then
					local var_288_14 = manager.audio:GetVoiceLength("story_v_out_926031", "926031071", "story_v_out_926031.awb") / 1000

					if var_288_14 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_8
					end

					if var_288_10.prefab_name ~= "" and arg_285_1.actors_[var_288_10.prefab_name] ~= nil then
						local var_288_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_10.prefab_name].transform, "story_v_out_926031", "926031071", "story_v_out_926031.awb")

						arg_285_1:RecordAudio("926031071", var_288_15)
						arg_285_1:RecordAudio("926031071", var_288_15)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_926031", "926031071", "story_v_out_926031.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_926031", "926031071", "story_v_out_926031.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_16 = math.max(var_288_9, arg_285_1.talkMaxDuration)

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_16 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_8) / var_288_16

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_8 + var_288_16 and arg_285_1.time_ < var_288_8 + var_288_16 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
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
	Play926031072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 926031072
		arg_289_1.duration_ = 6.1

		local var_289_0 = {
			zh = 5.633,
			ja = 6.1
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
				arg_289_0:Play926031073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.6

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:GetWordFromCfg(926031072)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 24 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 24)

				if (24 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 24)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031072", "story_v_out_926031.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_926031", "926031072", "story_v_out_926031.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_926031", "926031072", "story_v_out_926031.awb")

						arg_289_1:RecordAudio("926031072", var_292_6)
						arg_289_1:RecordAudio("926031072", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_926031", "926031072", "story_v_out_926031.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_926031", "926031072", "story_v_out_926031.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_7 and arg_289_1.time_ < 0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play926031073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 926031073
		arg_293_1.duration_ = 2.57

		local var_293_0 = {
			zh = 2.466,
			ja = 2.566
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
				arg_293_0:Play926031074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["104701"]) and arg_293_1.var_.actorSpriteComps104701 == nil then
				arg_293_1.var_.actorSpriteComps104701 = arg_293_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_0 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["104701"]) then
				if arg_293_1.var_.actorSpriteComps104701 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								iter_296_1.color = Color.New(Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor1.r, (arg_293_1.time_ - 0) / var_296_0), Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor1.g, (arg_293_1.time_ - 0) / var_296_0), (Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor1.b, (arg_293_1.time_ - 0) / var_296_0)))
							else
								local var_296_1 = Mathf.Lerp(iter_296_1.color.r, 1, (arg_293_1.time_ - 0) / var_296_0)

								iter_296_1.color = Color.New(var_296_1, var_296_1, var_296_1)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["104701"]) and arg_293_1.var_.actorSpriteComps104701 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_296_3 then
						iter_296_3.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_293_1.var_.actorSpriteComps104701 = nil
			end

			local var_296_2 = arg_293_1.actors_["106103"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps106103 == nil then
				arg_293_1.var_.actorSpriteComps106103 = var_296_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_3 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 and not isNil(var_296_2) then
				if arg_293_1.var_.actorSpriteComps106103 then
					for iter_296_4, iter_296_5 in pairs(arg_293_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_296_5 then
							if arg_293_1.isInRecall_ then
								iter_296_5.color = Color.New(Mathf.Lerp(iter_296_5.color.r, arg_293_1.hightColor2.r, (arg_293_1.time_ - 0) / var_296_3), Mathf.Lerp(iter_296_5.color.g, arg_293_1.hightColor2.g, (arg_293_1.time_ - 0) / var_296_3), (Mathf.Lerp(iter_296_5.color.b, arg_293_1.hightColor2.b, (arg_293_1.time_ - 0) / var_296_3)))
							else
								local var_296_4 = Mathf.Lerp(iter_296_5.color.r, 0.5, (arg_293_1.time_ - 0) / var_296_3)

								iter_296_5.color = Color.New(var_296_4, var_296_4, var_296_4)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps106103 then
				for iter_296_6, iter_296_7 in pairs(arg_293_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_296_7 then
						iter_296_7.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_293_1.var_.actorSpriteComps106103 = nil
			end

			local var_296_5 = arg_293_1.actors_["106103"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos106103 = var_296_5.localPosition
				var_296_5.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("106103", 7)

				for iter_296_8 = 0, var_296_5.childCount - 1 do
					local var_296_6 = var_296_5:GetChild(iter_296_8)

					if var_296_6.name == "" or not string.find(var_296_6.name, "split") then
						var_296_6.gameObject:SetActive(true)
					else
						var_296_6.gameObject:SetActive(false)
					end
				end
			end

			local var_296_7 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				var_296_5.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_293_1.time_ - 0) / var_296_7)
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				var_296_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_296_8 = arg_293_1.actors_["128404"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos128404 = var_296_8.localPosition
				var_296_8.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("128404", 7)

				for iter_296_9 = 0, var_296_8.childCount - 1 do
					local var_296_9 = var_296_8:GetChild(iter_296_9)

					if var_296_9.name == "" or not string.find(var_296_9.name, "split") then
						var_296_9.gameObject:SetActive(true)
					else
						var_296_9.gameObject:SetActive(false)
					end
				end
			end

			local var_296_10 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_10 then
				var_296_8.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_293_1.time_ - 0) / var_296_10)
			end

			if arg_293_1.time_ >= 0 + var_296_10 and arg_293_1.time_ < 0 + var_296_10 + arg_296_0 then
				var_296_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_296_11 = arg_293_1.actors_["104701"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos104701 = var_296_11.localPosition
				var_296_11.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("104701", 2)

				for iter_296_10 = 0, var_296_11.childCount - 1 do
					local var_296_12 = var_296_11:GetChild(iter_296_10)

					if var_296_12.name == "" or not string.find(var_296_12.name, "split") then
						var_296_12.gameObject:SetActive(true)
					else
						var_296_12.gameObject:SetActive(false)
					end
				end
			end

			local var_296_13 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_13 then
				var_296_11.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos104701, Vector3.New(-528.7, -386.8, -295), (arg_293_1.time_ - 0) / var_296_13)
			end

			if arg_293_1.time_ >= 0 + var_296_13 and arg_293_1.time_ < 0 + var_296_13 + arg_296_0 then
				var_296_11.localPosition = Vector3.New(-528.7, -386.8, -295)
			end

			local var_296_14 = 0
			local var_296_15 = 0.275

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_14 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_16 = arg_293_1:GetWordFromCfg(926031073)
				local var_296_17 = arg_293_1:FormatText(var_296_16.content)

				arg_293_1.text_.text = var_296_17

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_19 = 11 <= 0 and var_296_15 or var_296_15 * (utf8.len(var_296_17) / 11)

				if (11 <= 0 and var_296_15 or var_296_15 * (utf8.len(var_296_17) / 11)) > 0 and var_296_15 < var_296_19 then
					arg_293_1.talkMaxDuration = var_296_19

					if var_296_19 + var_296_14 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_19 + var_296_14
					end
				end

				arg_293_1.text_.text = var_296_17
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031073", "story_v_out_926031.awb") ~= 0 then
					local var_296_20 = manager.audio:GetVoiceLength("story_v_out_926031", "926031073", "story_v_out_926031.awb") / 1000

					if var_296_20 + var_296_14 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_20 + var_296_14
					end

					if var_296_16.prefab_name ~= "" and arg_293_1.actors_[var_296_16.prefab_name] ~= nil then
						local var_296_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_16.prefab_name].transform, "story_v_out_926031", "926031073", "story_v_out_926031.awb")

						arg_293_1:RecordAudio("926031073", var_296_21)
						arg_293_1:RecordAudio("926031073", var_296_21)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_926031", "926031073", "story_v_out_926031.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_926031", "926031073", "story_v_out_926031.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_22 = math.max(var_296_15, arg_293_1.talkMaxDuration)

			if var_296_14 <= arg_293_1.time_ and arg_293_1.time_ < var_296_14 + var_296_22 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_14) / var_296_22

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_14 + var_296_22 and arg_293_1.time_ < var_296_14 + var_296_22 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
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
	Play926031074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 926031074
		arg_297_1.duration_ = 6.4

		local var_297_0 = {
			zh = 4.9,
			ja = 6.4
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
				arg_297_0:Play926031075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["10144"]) and arg_297_1.var_.actorSpriteComps10144 == nil then
				arg_297_1.var_.actorSpriteComps10144 = arg_297_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_0 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["10144"]) then
				if arg_297_1.var_.actorSpriteComps10144 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								iter_300_1.color = Color.New(Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor1.r, (arg_297_1.time_ - 0) / var_300_0), Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor1.g, (arg_297_1.time_ - 0) / var_300_0), (Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor1.b, (arg_297_1.time_ - 0) / var_300_0)))
							else
								local var_300_1 = Mathf.Lerp(iter_300_1.color.r, 1, (arg_297_1.time_ - 0) / var_300_0)

								iter_300_1.color = Color.New(var_300_1, var_300_1, var_300_1)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["10144"]) and arg_297_1.var_.actorSpriteComps10144 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_300_3 then
						iter_300_3.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_297_1.var_.actorSpriteComps10144 = nil
			end

			local var_300_2 = arg_297_1.actors_["104701"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps104701 == nil then
				arg_297_1.var_.actorSpriteComps104701 = var_300_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_3 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 and not isNil(var_300_2) then
				if arg_297_1.var_.actorSpriteComps104701 then
					for iter_300_4, iter_300_5 in pairs(arg_297_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_300_5 then
							if arg_297_1.isInRecall_ then
								iter_300_5.color = Color.New(Mathf.Lerp(iter_300_5.color.r, arg_297_1.hightColor2.r, (arg_297_1.time_ - 0) / var_300_3), Mathf.Lerp(iter_300_5.color.g, arg_297_1.hightColor2.g, (arg_297_1.time_ - 0) / var_300_3), (Mathf.Lerp(iter_300_5.color.b, arg_297_1.hightColor2.b, (arg_297_1.time_ - 0) / var_300_3)))
							else
								local var_300_4 = Mathf.Lerp(iter_300_5.color.r, 0.5, (arg_297_1.time_ - 0) / var_300_3)

								iter_300_5.color = Color.New(var_300_4, var_300_4, var_300_4)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps104701 then
				for iter_300_6, iter_300_7 in pairs(arg_297_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_300_7 then
						iter_300_7.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_297_1.var_.actorSpriteComps104701 = nil
			end

			local var_300_5 = arg_297_1.actors_["10144"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos10144 = var_300_5.localPosition
				var_300_5.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("10144", 4)

				for iter_300_8 = 0, var_300_5.childCount - 1 do
					local var_300_6 = var_300_5:GetChild(iter_300_8)

					if var_300_6.name == "split_7" or not string.find(var_300_6.name, "split") then
						var_300_6.gameObject:SetActive(true)
					else
						var_300_6.gameObject:SetActive(false)
					end
				end
			end

			local var_300_7 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_7 then
				var_300_5.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_297_1.time_ - 0) / var_300_7)
			end

			if arg_297_1.time_ >= 0 + var_300_7 and arg_297_1.time_ < 0 + var_300_7 + arg_300_0 then
				var_300_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_300_8 = 0
			local var_300_9 = 0.55

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_10 = arg_297_1:GetWordFromCfg(926031074)
				local var_300_11 = arg_297_1:FormatText(var_300_10.content)

				arg_297_1.text_.text = var_300_11

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_13 = 22 <= 0 and var_300_9 or var_300_9 * (utf8.len(var_300_11) / 22)

				if (22 <= 0 and var_300_9 or var_300_9 * (utf8.len(var_300_11) / 22)) > 0 and var_300_9 < var_300_13 then
					arg_297_1.talkMaxDuration = var_300_13

					if var_300_13 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_8
					end
				end

				arg_297_1.text_.text = var_300_11
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031074", "story_v_out_926031.awb") ~= 0 then
					local var_300_14 = manager.audio:GetVoiceLength("story_v_out_926031", "926031074", "story_v_out_926031.awb") / 1000

					if var_300_14 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_14 + var_300_8
					end

					if var_300_10.prefab_name ~= "" and arg_297_1.actors_[var_300_10.prefab_name] ~= nil then
						local var_300_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_10.prefab_name].transform, "story_v_out_926031", "926031074", "story_v_out_926031.awb")

						arg_297_1:RecordAudio("926031074", var_300_15)
						arg_297_1:RecordAudio("926031074", var_300_15)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_926031", "926031074", "story_v_out_926031.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_926031", "926031074", "story_v_out_926031.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_16 = math.max(var_300_9, arg_297_1.talkMaxDuration)

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_16 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_8) / var_300_16

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_8 + var_300_16 and arg_297_1.time_ < var_300_8 + var_300_16 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926031075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 926031075
		arg_301_1.duration_ = 6.4

		local var_301_0 = {
			zh = 4.266,
			ja = 6.4
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
				arg_301_0:Play926031076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.55

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:GetWordFromCfg(926031075)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 22 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 22)

				if (22 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 22)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031075", "story_v_out_926031.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_out_926031", "926031075", "story_v_out_926031.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_out_926031", "926031075", "story_v_out_926031.awb")

						arg_301_1:RecordAudio("926031075", var_304_6)
						arg_301_1:RecordAudio("926031075", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_926031", "926031075", "story_v_out_926031.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_926031", "926031075", "story_v_out_926031.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play926031076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 926031076
		arg_305_1.duration_ = 5.03

		local var_305_0 = {
			zh = 3,
			ja = 5.033
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
				arg_305_0:Play926031077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["106103"]) and arg_305_1.var_.actorSpriteComps106103 == nil then
				arg_305_1.var_.actorSpriteComps106103 = arg_305_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_0 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["106103"]) then
				if arg_305_1.var_.actorSpriteComps106103 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["106103"]) and arg_305_1.var_.actorSpriteComps106103 then
				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_308_3 then
						iter_308_3.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_305_1.var_.actorSpriteComps106103 = nil
			end

			local var_308_2 = arg_305_1.actors_["10144"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps10144 == nil then
				arg_305_1.var_.actorSpriteComps10144 = var_308_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_3 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_3 and not isNil(var_308_2) then
				if arg_305_1.var_.actorSpriteComps10144 then
					for iter_308_4, iter_308_5 in pairs(arg_305_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_305_1.time_ >= 0 + var_308_3 and arg_305_1.time_ < 0 + var_308_3 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps10144 then
				for iter_308_6, iter_308_7 in pairs(arg_305_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_308_7 then
						iter_308_7.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_305_1.var_.actorSpriteComps10144 = nil
			end

			local var_308_5 = 0
			local var_308_6 = 0.3

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_5 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_7 = arg_305_1:GetWordFromCfg(926031076)
				local var_308_8 = arg_305_1:FormatText(var_308_7.content)

				arg_305_1.text_.text = var_308_8

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_10 = 12 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 12)

				if (12 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 12)) > 0 and var_308_6 < var_308_10 then
					arg_305_1.talkMaxDuration = var_308_10

					if var_308_10 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_5
					end
				end

				arg_305_1.text_.text = var_308_8
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031076", "story_v_out_926031.awb") ~= 0 then
					local var_308_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031076", "story_v_out_926031.awb") / 1000

					if var_308_11 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_11 + var_308_5
					end

					if var_308_7.prefab_name ~= "" and arg_305_1.actors_[var_308_7.prefab_name] ~= nil then
						local var_308_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_7.prefab_name].transform, "story_v_out_926031", "926031076", "story_v_out_926031.awb")

						arg_305_1:RecordAudio("926031076", var_308_12)
						arg_305_1:RecordAudio("926031076", var_308_12)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_926031", "926031076", "story_v_out_926031.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_926031", "926031076", "story_v_out_926031.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_13 = math.max(var_308_6, arg_305_1.talkMaxDuration)

			if var_308_5 <= arg_305_1.time_ and arg_305_1.time_ < var_308_5 + var_308_13 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_5) / var_308_13

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_5 + var_308_13 and arg_305_1.time_ < var_308_5 + var_308_13 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play926031077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 926031077
		arg_309_1.duration_ = 3.2

		local var_309_0 = {
			zh = 2.3,
			ja = 3.2
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play926031078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["104701"]) and arg_309_1.var_.actorSpriteComps104701 == nil then
				arg_309_1.var_.actorSpriteComps104701 = arg_309_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_0 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["104701"]) then
				if arg_309_1.var_.actorSpriteComps104701 then
					for iter_312_0, iter_312_1 in pairs(arg_309_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_312_1 then
							if arg_309_1.isInRecall_ then
								iter_312_1.color = Color.New(Mathf.Lerp(iter_312_1.color.r, arg_309_1.hightColor1.r, (arg_309_1.time_ - 0) / var_312_0), Mathf.Lerp(iter_312_1.color.g, arg_309_1.hightColor1.g, (arg_309_1.time_ - 0) / var_312_0), (Mathf.Lerp(iter_312_1.color.b, arg_309_1.hightColor1.b, (arg_309_1.time_ - 0) / var_312_0)))
							else
								local var_312_1 = Mathf.Lerp(iter_312_1.color.r, 1, (arg_309_1.time_ - 0) / var_312_0)

								iter_312_1.color = Color.New(var_312_1, var_312_1, var_312_1)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["104701"]) and arg_309_1.var_.actorSpriteComps104701 then
				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_312_3 then
						iter_312_3.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_309_1.var_.actorSpriteComps104701 = nil
			end

			local var_312_2 = arg_309_1.actors_["106103"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.actorSpriteComps106103 == nil then
				arg_309_1.var_.actorSpriteComps106103 = var_312_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_3 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_3 and not isNil(var_312_2) then
				if arg_309_1.var_.actorSpriteComps106103 then
					for iter_312_4, iter_312_5 in pairs(arg_309_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_312_5 then
							if arg_309_1.isInRecall_ then
								iter_312_5.color = Color.New(Mathf.Lerp(iter_312_5.color.r, arg_309_1.hightColor2.r, (arg_309_1.time_ - 0) / var_312_3), Mathf.Lerp(iter_312_5.color.g, arg_309_1.hightColor2.g, (arg_309_1.time_ - 0) / var_312_3), (Mathf.Lerp(iter_312_5.color.b, arg_309_1.hightColor2.b, (arg_309_1.time_ - 0) / var_312_3)))
							else
								local var_312_4 = Mathf.Lerp(iter_312_5.color.r, 0.5, (arg_309_1.time_ - 0) / var_312_3)

								iter_312_5.color = Color.New(var_312_4, var_312_4, var_312_4)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_3 and arg_309_1.time_ < 0 + var_312_3 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.actorSpriteComps106103 then
				for iter_312_6, iter_312_7 in pairs(arg_309_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_312_7 then
						iter_312_7.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_309_1.var_.actorSpriteComps106103 = nil
			end

			local var_312_5 = 0
			local var_312_6 = 0.25

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_7 = arg_309_1:GetWordFromCfg(926031077)
				local var_312_8 = arg_309_1:FormatText(var_312_7.content)

				arg_309_1.text_.text = var_312_8

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_10 = 10 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 10)

				if (10 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 10)) > 0 and var_312_6 < var_312_10 then
					arg_309_1.talkMaxDuration = var_312_10

					if var_312_10 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_5
					end
				end

				arg_309_1.text_.text = var_312_8
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031077", "story_v_out_926031.awb") ~= 0 then
					local var_312_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031077", "story_v_out_926031.awb") / 1000

					if var_312_11 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_11 + var_312_5
					end

					if var_312_7.prefab_name ~= "" and arg_309_1.actors_[var_312_7.prefab_name] ~= nil then
						local var_312_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_7.prefab_name].transform, "story_v_out_926031", "926031077", "story_v_out_926031.awb")

						arg_309_1:RecordAudio("926031077", var_312_12)
						arg_309_1:RecordAudio("926031077", var_312_12)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_926031", "926031077", "story_v_out_926031.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_926031", "926031077", "story_v_out_926031.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_13 = math.max(var_312_6, arg_309_1.talkMaxDuration)

			if var_312_5 <= arg_309_1.time_ and arg_309_1.time_ < var_312_5 + var_312_13 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_5) / var_312_13

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_5 + var_312_13 and arg_309_1.time_ < var_312_5 + var_312_13 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play926031078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 926031078
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play926031079(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["104701"]) and arg_313_1.var_.actorSpriteComps104701 == nil then
				arg_313_1.var_.actorSpriteComps104701 = arg_313_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_0 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["104701"]) then
				if arg_313_1.var_.actorSpriteComps104701 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["104701"]) and arg_313_1.var_.actorSpriteComps104701 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_316_3 then
						iter_316_3.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_313_1.var_.actorSpriteComps104701 = nil
			end

			local var_316_2 = 0
			local var_316_3 = 0.4

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

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_4 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(926031078).content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_6 = 16 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_4) / 16)

				if (16 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_4) / 16)) > 0 and var_316_3 < var_316_6 then
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
	Play926031079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 926031079
		arg_317_1.duration_ = 1

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"

			SetActive(arg_317_1.choicesGo_, true)

			for iter_318_0, iter_318_1 in ipairs(arg_317_1.choices_) do
				SetActive(iter_318_1.go, iter_318_0 <= 3)
			end

			arg_317_1.choices_[1].txt.text = arg_317_1:FormatText(StoryChoiceCfg[1320].name)
			arg_317_1.choices_[2].txt.text = arg_317_1:FormatText(StoryChoiceCfg[1321].name)
			arg_317_1.choices_[3].txt.text = arg_317_1:FormatText(StoryChoiceCfg[1322].name)
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play926031080(arg_317_1)
			end

			if arg_319_0 == 2 then
				arg_317_0:Play926031080(arg_317_1)
			end

			if arg_319_0 == 3 then
				arg_317_0:Play926031080(arg_317_1)
			end

			arg_317_1:RecordChoiceLog(926031079, 1320, 1321, 1322)
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			return
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play926031080 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 926031080
		arg_321_1.duration_ = 2.6

		local var_321_0 = {
			zh = 2.6,
			ja = 2.533
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
				arg_321_0:Play926031081(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["104701"]) and arg_321_1.var_.actorSpriteComps104701 == nil then
				arg_321_1.var_.actorSpriteComps104701 = arg_321_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_0 = 0.2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["104701"]) then
				if arg_321_1.var_.actorSpriteComps104701 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_324_1 then
							if arg_321_1.isInRecall_ then
								iter_324_1.color = Color.New(Mathf.Lerp(iter_324_1.color.r, arg_321_1.hightColor1.r, (arg_321_1.time_ - 0) / var_324_0), Mathf.Lerp(iter_324_1.color.g, arg_321_1.hightColor1.g, (arg_321_1.time_ - 0) / var_324_0), (Mathf.Lerp(iter_324_1.color.b, arg_321_1.hightColor1.b, (arg_321_1.time_ - 0) / var_324_0)))
							else
								local var_324_1 = Mathf.Lerp(iter_324_1.color.r, 1, (arg_321_1.time_ - 0) / var_324_0)

								iter_324_1.color = Color.New(var_324_1, var_324_1, var_324_1)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["104701"]) and arg_321_1.var_.actorSpriteComps104701 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_324_3 then
						iter_324_3.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_321_1.var_.actorSpriteComps104701 = nil
			end

			local var_324_2 = arg_321_1.actors_["104701"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos104701 = var_324_2.localPosition
				var_324_2.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("104701", 2)

				for iter_324_4 = 0, var_324_2.childCount - 1 do
					local var_324_3 = var_324_2:GetChild(iter_324_4)

					if var_324_3.name == "split_2" or not string.find(var_324_3.name, "split") then
						var_324_3.gameObject:SetActive(true)
					else
						var_324_3.gameObject:SetActive(false)
					end
				end
			end

			local var_324_4 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				var_324_2.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos104701, Vector3.New(-528.7, -386.8, -295), (arg_321_1.time_ - 0) / var_324_4)
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				var_324_2.localPosition = Vector3.New(-528.7, -386.8, -295)
			end

			local var_324_5 = 0
			local var_324_6 = 0.25

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_7 = arg_321_1:GetWordFromCfg(926031080)
				local var_324_8 = arg_321_1:FormatText(var_324_7.content)

				arg_321_1.text_.text = var_324_8

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_10 = 10 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 10)

				if (10 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 10)) > 0 and var_324_6 < var_324_10 then
					arg_321_1.talkMaxDuration = var_324_10

					if var_324_10 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_5
					end
				end

				arg_321_1.text_.text = var_324_8
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031080", "story_v_out_926031.awb") ~= 0 then
					local var_324_11 = manager.audio:GetVoiceLength("story_v_out_926031", "926031080", "story_v_out_926031.awb") / 1000

					if var_324_11 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_11 + var_324_5
					end

					if var_324_7.prefab_name ~= "" and arg_321_1.actors_[var_324_7.prefab_name] ~= nil then
						local var_324_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_7.prefab_name].transform, "story_v_out_926031", "926031080", "story_v_out_926031.awb")

						arg_321_1:RecordAudio("926031080", var_324_12)
						arg_321_1:RecordAudio("926031080", var_324_12)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_926031", "926031080", "story_v_out_926031.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_926031", "926031080", "story_v_out_926031.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_13 = math.max(var_324_6, arg_321_1.talkMaxDuration)

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_13 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_5) / var_324_13

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_5 + var_324_13 and arg_321_1.time_ < var_324_5 + var_324_13 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
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
	Play926031081 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 926031081
		arg_325_1.duration_ = 4.13

		local var_325_0 = {
			zh = 3.433,
			ja = 4.133
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
				arg_325_0:Play926031082(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["128404"]) and arg_325_1.var_.actorSpriteComps128404 == nil then
				arg_325_1.var_.actorSpriteComps128404 = arg_325_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_0 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["128404"]) then
				if arg_325_1.var_.actorSpriteComps128404 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["128404"]) and arg_325_1.var_.actorSpriteComps128404 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_328_3 then
						iter_328_3.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_325_1.var_.actorSpriteComps128404 = nil
			end

			local var_328_2 = arg_325_1.actors_["104701"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.actorSpriteComps104701 == nil then
				arg_325_1.var_.actorSpriteComps104701 = var_328_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_3 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_3 and not isNil(var_328_2) then
				if arg_325_1.var_.actorSpriteComps104701 then
					for iter_328_4, iter_328_5 in pairs(arg_325_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_325_1.time_ >= 0 + var_328_3 and arg_325_1.time_ < 0 + var_328_3 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.actorSpriteComps104701 then
				for iter_328_6, iter_328_7 in pairs(arg_325_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_328_7 then
						iter_328_7.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_325_1.var_.actorSpriteComps104701 = nil
			end

			local var_328_5 = arg_325_1.actors_["104701"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos104701 = var_328_5.localPosition
				var_328_5.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("104701", 7)

				for iter_328_8 = 0, var_328_5.childCount - 1 do
					local var_328_6 = var_328_5:GetChild(iter_328_8)

					if var_328_6.name == "" or not string.find(var_328_6.name, "split") then
						var_328_6.gameObject:SetActive(true)
					else
						var_328_6.gameObject:SetActive(false)
					end
				end
			end

			local var_328_7 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				var_328_5.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_325_1.time_ - 0) / var_328_7)
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				var_328_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_328_8 = arg_325_1.actors_["10144"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos10144 = var_328_8.localPosition
				var_328_8.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("10144", 7)

				for iter_328_9 = 0, var_328_8.childCount - 1 do
					local var_328_9 = var_328_8:GetChild(iter_328_9)

					if var_328_9.name == "" or not string.find(var_328_9.name, "split") then
						var_328_9.gameObject:SetActive(true)
					else
						var_328_9.gameObject:SetActive(false)
					end
				end
			end

			local var_328_10 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_10 then
				var_328_8.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_325_1.time_ - 0) / var_328_10)
			end

			if arg_325_1.time_ >= 0 + var_328_10 and arg_325_1.time_ < 0 + var_328_10 + arg_328_0 then
				var_328_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_328_11 = arg_325_1.actors_["128404"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos128404 = var_328_11.localPosition
				var_328_11.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("128404", 3)

				for iter_328_10 = 0, var_328_11.childCount - 1 do
					local var_328_12 = var_328_11:GetChild(iter_328_10)

					if var_328_12.name == "" or not string.find(var_328_12.name, "split") then
						var_328_12.gameObject:SetActive(true)
					else
						var_328_12.gameObject:SetActive(false)
					end
				end
			end

			local var_328_13 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_13 then
				var_328_11.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_325_1.time_ - 0) / var_328_13)
			end

			if arg_325_1.time_ >= 0 + var_328_13 and arg_325_1.time_ < 0 + var_328_13 + arg_328_0 then
				var_328_11.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_328_14 = 0
			local var_328_15 = 0.475

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_14 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_16 = arg_325_1:GetWordFromCfg(926031081)
				local var_328_17 = arg_325_1:FormatText(var_328_16.content)

				arg_325_1.text_.text = var_328_17

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_19 = 19 <= 0 and var_328_15 or var_328_15 * (utf8.len(var_328_17) / 19)

				if (19 <= 0 and var_328_15 or var_328_15 * (utf8.len(var_328_17) / 19)) > 0 and var_328_15 < var_328_19 then
					arg_325_1.talkMaxDuration = var_328_19

					if var_328_19 + var_328_14 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_19 + var_328_14
					end
				end

				arg_325_1.text_.text = var_328_17
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031081", "story_v_out_926031.awb") ~= 0 then
					local var_328_20 = manager.audio:GetVoiceLength("story_v_out_926031", "926031081", "story_v_out_926031.awb") / 1000

					if var_328_20 + var_328_14 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_20 + var_328_14
					end

					if var_328_16.prefab_name ~= "" and arg_325_1.actors_[var_328_16.prefab_name] ~= nil then
						local var_328_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_16.prefab_name].transform, "story_v_out_926031", "926031081", "story_v_out_926031.awb")

						arg_325_1:RecordAudio("926031081", var_328_21)
						arg_325_1:RecordAudio("926031081", var_328_21)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_926031", "926031081", "story_v_out_926031.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_926031", "926031081", "story_v_out_926031.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_22 = math.max(var_328_15, arg_325_1.talkMaxDuration)

			if var_328_14 <= arg_325_1.time_ and arg_325_1.time_ < var_328_14 + var_328_22 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_14) / var_328_22

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_14 + var_328_22 and arg_325_1.time_ < var_328_14 + var_328_22 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
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
	Play926031082 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 926031082
		arg_329_1.duration_ = 7.7

		local var_329_0 = {
			zh = 6.066,
			ja = 7.7
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
				arg_329_0:Play926031083(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["106103"]) and arg_329_1.var_.actorSpriteComps106103 == nil then
				arg_329_1.var_.actorSpriteComps106103 = arg_329_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_0 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["106103"]) then
				if arg_329_1.var_.actorSpriteComps106103 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["106103"]) and arg_329_1.var_.actorSpriteComps106103 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_332_3 then
						iter_332_3.color = arg_329_1.isInRecall_ and (arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_329_1.var_.actorSpriteComps106103 = nil
			end

			local var_332_2 = arg_329_1.actors_["128404"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.actorSpriteComps128404 == nil then
				arg_329_1.var_.actorSpriteComps128404 = var_332_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_3 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_3 and not isNil(var_332_2) then
				if arg_329_1.var_.actorSpriteComps128404 then
					for iter_332_4, iter_332_5 in pairs(arg_329_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_329_1.time_ >= 0 + var_332_3 and arg_329_1.time_ < 0 + var_332_3 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.actorSpriteComps128404 then
				for iter_332_6, iter_332_7 in pairs(arg_329_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_332_7 then
						iter_332_7.color = arg_329_1.isInRecall_ and (arg_329_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_329_1.var_.actorSpriteComps128404 = nil
			end

			local var_332_5 = arg_329_1.actors_["128404"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos128404 = var_332_5.localPosition
				var_332_5.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("128404", 7)

				for iter_332_8 = 0, var_332_5.childCount - 1 do
					local var_332_6 = var_332_5:GetChild(iter_332_8)

					if var_332_6.name == "" or not string.find(var_332_6.name, "split") then
						var_332_6.gameObject:SetActive(true)
					else
						var_332_6.gameObject:SetActive(false)
					end
				end
			end

			local var_332_7 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_7 then
				var_332_5.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_329_1.time_ - 0) / var_332_7)
			end

			if arg_329_1.time_ >= 0 + var_332_7 and arg_329_1.time_ < 0 + var_332_7 + arg_332_0 then
				var_332_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_332_8 = arg_329_1.actors_["106103"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos106103 = var_332_8.localPosition
				var_332_8.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("106103", 3)

				for iter_332_9 = 0, var_332_8.childCount - 1 do
					local var_332_9 = var_332_8:GetChild(iter_332_9)

					if var_332_9.name == "" or not string.find(var_332_9.name, "split") then
						var_332_9.gameObject:SetActive(true)
					else
						var_332_9.gameObject:SetActive(false)
					end
				end
			end

			local var_332_10 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_10 then
				var_332_8.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_329_1.time_ - 0) / var_332_10)
			end

			if arg_329_1.time_ >= 0 + var_332_10 and arg_329_1.time_ < 0 + var_332_10 + arg_332_0 then
				var_332_8.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_332_11 = 0
			local var_332_12 = 0.675

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_11 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_13 = arg_329_1:GetWordFromCfg(926031082)
				local var_332_14 = arg_329_1:FormatText(var_332_13.content)

				arg_329_1.text_.text = var_332_14

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_16 = 27 <= 0 and var_332_12 or var_332_12 * (utf8.len(var_332_14) / 27)

				if (27 <= 0 and var_332_12 or var_332_12 * (utf8.len(var_332_14) / 27)) > 0 and var_332_12 < var_332_16 then
					arg_329_1.talkMaxDuration = var_332_16

					if var_332_16 + var_332_11 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_16 + var_332_11
					end
				end

				arg_329_1.text_.text = var_332_14
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031082", "story_v_out_926031.awb") ~= 0 then
					local var_332_17 = manager.audio:GetVoiceLength("story_v_out_926031", "926031082", "story_v_out_926031.awb") / 1000

					if var_332_17 + var_332_11 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_17 + var_332_11
					end

					if var_332_13.prefab_name ~= "" and arg_329_1.actors_[var_332_13.prefab_name] ~= nil then
						local var_332_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_13.prefab_name].transform, "story_v_out_926031", "926031082", "story_v_out_926031.awb")

						arg_329_1:RecordAudio("926031082", var_332_18)
						arg_329_1:RecordAudio("926031082", var_332_18)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_926031", "926031082", "story_v_out_926031.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_926031", "926031082", "story_v_out_926031.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_19 = math.max(var_332_12, arg_329_1.talkMaxDuration)

			if var_332_11 <= arg_329_1.time_ and arg_329_1.time_ < var_332_11 + var_332_19 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_11) / var_332_19

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_11 + var_332_19 and arg_329_1.time_ < var_332_11 + var_332_19 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
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
	Play926031083 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 926031083
		arg_333_1.duration_ = 5.33

		local var_333_0 = {
			zh = 5.3,
			ja = 5.333
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
			arg_333_1.auto_ = false
		end

		function arg_333_1.playNext_(arg_335_0)
			arg_333_1.onStoryFinished_()
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["10144"]) and arg_333_1.var_.actorSpriteComps10144 == nil then
				arg_333_1.var_.actorSpriteComps10144 = arg_333_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_0 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["10144"]) then
				if arg_333_1.var_.actorSpriteComps10144 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								iter_336_1.color = Color.New(Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor1.r, (arg_333_1.time_ - 0) / var_336_0), Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor1.g, (arg_333_1.time_ - 0) / var_336_0), (Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor1.b, (arg_333_1.time_ - 0) / var_336_0)))
							else
								local var_336_1 = Mathf.Lerp(iter_336_1.color.r, 1, (arg_333_1.time_ - 0) / var_336_0)

								iter_336_1.color = Color.New(var_336_1, var_336_1, var_336_1)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["10144"]) and arg_333_1.var_.actorSpriteComps10144 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_336_3 then
						iter_336_3.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_333_1.var_.actorSpriteComps10144 = nil
			end

			local var_336_2 = arg_333_1.actors_["106103"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.actorSpriteComps106103 == nil then
				arg_333_1.var_.actorSpriteComps106103 = var_336_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_3 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_3 and not isNil(var_336_2) then
				if arg_333_1.var_.actorSpriteComps106103 then
					for iter_336_4, iter_336_5 in pairs(arg_333_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_336_5 then
							if arg_333_1.isInRecall_ then
								iter_336_5.color = Color.New(Mathf.Lerp(iter_336_5.color.r, arg_333_1.hightColor2.r, (arg_333_1.time_ - 0) / var_336_3), Mathf.Lerp(iter_336_5.color.g, arg_333_1.hightColor2.g, (arg_333_1.time_ - 0) / var_336_3), (Mathf.Lerp(iter_336_5.color.b, arg_333_1.hightColor2.b, (arg_333_1.time_ - 0) / var_336_3)))
							else
								local var_336_4 = Mathf.Lerp(iter_336_5.color.r, 0.5, (arg_333_1.time_ - 0) / var_336_3)

								iter_336_5.color = Color.New(var_336_4, var_336_4, var_336_4)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_3 and arg_333_1.time_ < 0 + var_336_3 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.actorSpriteComps106103 then
				for iter_336_6, iter_336_7 in pairs(arg_333_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_336_7 then
						iter_336_7.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_333_1.var_.actorSpriteComps106103 = nil
			end

			local var_336_5 = arg_333_1.actors_["106103"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos106103 = var_336_5.localPosition
				var_336_5.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("106103", 7)

				for iter_336_8 = 0, var_336_5.childCount - 1 do
					local var_336_6 = var_336_5:GetChild(iter_336_8)

					if var_336_6.name == "" or not string.find(var_336_6.name, "split") then
						var_336_6.gameObject:SetActive(true)
					else
						var_336_6.gameObject:SetActive(false)
					end
				end
			end

			local var_336_7 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_7 then
				var_336_5.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_333_1.time_ - 0) / var_336_7)
			end

			if arg_333_1.time_ >= 0 + var_336_7 and arg_333_1.time_ < 0 + var_336_7 + arg_336_0 then
				var_336_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_336_8 = arg_333_1.actors_["10144"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos10144 = var_336_8.localPosition
				var_336_8.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("10144", 3)

				for iter_336_9 = 0, var_336_8.childCount - 1 do
					local var_336_9 = var_336_8:GetChild(iter_336_9)

					if var_336_9.name == "split_1" or not string.find(var_336_9.name, "split") then
						var_336_9.gameObject:SetActive(true)
					else
						var_336_9.gameObject:SetActive(false)
					end
				end
			end

			local var_336_10 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_10 then
				var_336_8.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_333_1.time_ - 0) / var_336_10)
			end

			if arg_333_1.time_ >= 0 + var_336_10 and arg_333_1.time_ < 0 + var_336_10 + arg_336_0 then
				var_336_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_336_11 = 0
			local var_336_12 = 0.6

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_11 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_13 = arg_333_1:GetWordFromCfg(926031083)
				local var_336_14 = arg_333_1:FormatText(var_336_13.content)

				arg_333_1.text_.text = var_336_14

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_16 = 24 <= 0 and var_336_12 or var_336_12 * (utf8.len(var_336_14) / 24)

				if (24 <= 0 and var_336_12 or var_336_12 * (utf8.len(var_336_14) / 24)) > 0 and var_336_12 < var_336_16 then
					arg_333_1.talkMaxDuration = var_336_16

					if var_336_16 + var_336_11 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_16 + var_336_11
					end
				end

				arg_333_1.text_.text = var_336_14
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031083", "story_v_out_926031.awb") ~= 0 then
					local var_336_17 = manager.audio:GetVoiceLength("story_v_out_926031", "926031083", "story_v_out_926031.awb") / 1000

					if var_336_17 + var_336_11 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_17 + var_336_11
					end

					if var_336_13.prefab_name ~= "" and arg_333_1.actors_[var_336_13.prefab_name] ~= nil then
						local var_336_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_13.prefab_name].transform, "story_v_out_926031", "926031083", "story_v_out_926031.awb")

						arg_333_1:RecordAudio("926031083", var_336_18)
						arg_333_1:RecordAudio("926031083", var_336_18)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_926031", "926031083", "story_v_out_926031.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_926031", "926031083", "story_v_out_926031.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_19 = math.max(var_336_12, arg_333_1.talkMaxDuration)

			if var_336_11 <= arg_333_1.time_ and arg_333_1.time_ < var_336_11 + var_336_19 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_11) / var_336_19

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_11 + var_336_19 and arg_333_1.time_ < var_336_11 + var_336_19 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0114"
	},
	voices = {
		"story_v_out_926031.awb"
	}
}
