return {
	Play413141001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413141001
		arg_1_1.duration_ = 5.2

		local var_1_0 = {
			zh = 4.633,
			ja = 5.2
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
				arg_1_0:Play413141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0603a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0603a")
				var_4_0.name = "ST0603a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0603a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0603a

				arg_1_1.bgs_.ST0603a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0603a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "10093"

			if arg_1_1.actors_["10093"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

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

			local var_4_12 = arg_1_1.actors_["10093"].transform

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.73333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos10093 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10093", 3)

				for iter_4_4 = 0, var_4_12.childCount - 1 do
					local var_4_13 = var_4_12:GetChild(iter_4_4)

					if var_4_13.name == "split_4" or not string.find(var_4_13.name, "split") then
						var_4_13.gameObject:SetActive(true)
					else
						var_4_13.gameObject:SetActive(false)
					end
				end
			end

			local var_4_14 = 0.001

			if 1.73333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.73333333333333 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_1_1.time_ - 1.73333333333333) / var_4_14)
			end

			if arg_1_1.time_ >= 1.73333333333333 + var_4_14 and arg_1_1.time_ < 1.73333333333333 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -345, -245)
			end

			local var_4_15 = arg_1_1.actors_["10093"]

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.73333333333333 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10093 == nil then
				arg_1_1.var_.actorSpriteComps10093 = var_4_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_16 = 2

			if 1.73333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.73333333333333 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.actorSpriteComps10093 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.73333333333333) / var_4_16), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.73333333333333) / var_4_16), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.73333333333333) / var_4_16)))
							else
								local var_4_17 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 1.73333333333333) / var_4_16)

								iter_4_6.color = Color.New(var_4_17, var_4_17, var_4_17)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.73333333333333 + var_4_16 and arg_1_1.time_ < 1.73333333333333 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10093 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10093 = nil
			end

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.73333333333333 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue10093 = var_4_18.alpha
					arg_1_1.var_.characterEffect10093 = var_4_18
				end

				arg_1_1.var_.alphaOldValue10093 = 0
			end

			local var_4_19 = 0.232666666666667

			if 1.73333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.73333333333333 + var_4_19 then
				if arg_1_1.var_.characterEffect10093 then
					arg_1_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10093, 1, (arg_1_1.time_ - 1.73333333333333) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.73333333333333 + var_4_19 and arg_1_1.time_ < 1.73333333333333 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect10093 then
				arg_1_1.var_.characterEffect10093.alpha = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			if 1.26666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.26666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_26 = 2
			local var_4_27 = 0.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_28 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_28:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(413141001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 13 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 13)

				if (13 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 13)) > 0 and var_4_27 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32
					var_4_26 = var_4_26 + 0.3

					if var_4_32 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_26
					end
				end

				arg_1_1.text_.text = var_4_30
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141001", "story_v_out_413141.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_413141", "413141001", "story_v_out_413141.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_413141", "413141001", "story_v_out_413141.awb")

						arg_1_1:RecordAudio("413141001", var_4_34)
						arg_1_1:RecordAudio("413141001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413141", "413141001", "story_v_out_413141.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413141", "413141001", "story_v_out_413141.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_35 = var_4_26 + 0.3
			local var_4_36 = math.max(var_4_27, arg_1_1.talkMaxDuration)

			if var_4_26 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_35) / var_4_36

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play413141002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413141002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play413141003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10093 = arg_9_1.actors_["10093"].transform.localPosition
				arg_9_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10093", 7)

				for iter_12_0 = 0, arg_9_1.actors_["10093"].transform.childCount - 1 do
					local var_12_0 = arg_9_1.actors_["10093"].transform:GetChild(iter_12_0)

					if var_12_0.name == "" or not string.find(var_12_0.name, "split") then
						var_12_0.gameObject:SetActive(true)
					else
						var_12_0.gameObject:SetActive(false)
					end
				end
			end

			local var_12_1 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_1 then
				arg_9_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_9_1.time_ - 0) / var_12_1)
			end

			if arg_9_1.time_ >= 0 + var_12_1 and arg_9_1.time_ < 0 + var_12_1 + arg_12_0 then
				arg_9_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_2 = arg_9_1.actors_["10093"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10093 == nil then
				arg_9_1.var_.actorSpriteComps10093 = var_12_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_3 = 2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 and not isNil(var_12_2) then
				if arg_9_1.var_.actorSpriteComps10093 then
					for iter_12_1, iter_12_2 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_12_2 then
							if arg_9_1.isInRecall_ then
								iter_12_2.color = Color.New(Mathf.Lerp(iter_12_2.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_3), Mathf.Lerp(iter_12_2.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_3), (Mathf.Lerp(iter_12_2.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_3)))
							else
								local var_12_4 = Mathf.Lerp(iter_12_2.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_3)

								iter_12_2.color = Color.New(var_12_4, var_12_4, var_12_4)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10093 then
				for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_12_4 then
						iter_12_4.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10093 = nil
			end

			local var_12_5 = 0
			local var_12_6 = 1.25

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_7 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(413141002).content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_9 = 50 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_7) / 50)

				if (50 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_7) / 50)) > 0 and var_12_6 < var_12_9 then
					arg_9_1.talkMaxDuration = var_12_9

					if var_12_9 + var_12_5 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_9 + var_12_5
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_6, arg_9_1.talkMaxDuration)

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_5) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_5 + var_12_10 and arg_9_1.time_ < var_12_5 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413141003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413141003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play413141004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.9

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(413141003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 36 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 36)

				if (36 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 36)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play413141004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413141004
		arg_17_1.duration_ = 11.7

		local var_17_0 = {
			zh = 7.033,
			ja = 11.7
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
				arg_17_0:Play413141005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["10092_1"] == nil then
				local var_20_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092_1")

				if not isNil(var_20_0) then
					local var_20_1 = Object.Instantiate(var_20_0, arg_17_1.canvasGo_.transform)

					var_20_1.transform:SetSiblingIndex(1)

					var_20_1.name = "10092_1"
					var_20_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_["10092_1"] = var_20_1

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs((var_20_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_2 = arg_17_1.actors_["10092_1"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10092_1 = var_20_2.localPosition
				var_20_2.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_20_2 = 0, var_20_2.childCount - 1 do
					local var_20_3 = var_20_2:GetChild(iter_20_2)

					if var_20_3.name == "split_1_1" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_2.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_17_1.time_ - 0) / var_20_4)
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_2.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_20_5 = arg_17_1.actors_["10092_1"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps10092_1 == nil then
				arg_17_1.var_.actorSpriteComps10092_1 = var_20_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.actorSpriteComps10092_1 then
					for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_20_4 then
							if arg_17_1.isInRecall_ then
								iter_20_4.color = Color.New(Mathf.Lerp(iter_20_4.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_6), Mathf.Lerp(iter_20_4.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_6), (Mathf.Lerp(iter_20_4.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_6)))
							else
								local var_20_7 = Mathf.Lerp(iter_20_4.color.r, 1, (arg_17_1.time_ - 0) / var_20_6)

								iter_20_4.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps10092_1 then
				for iter_20_5, iter_20_6 in pairs(arg_17_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_20_6 then
						iter_20_6.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.925

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(413141004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 37 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 37)

				if (37 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 37)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141004", "story_v_out_413141.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141004", "story_v_out_413141.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_413141", "413141004", "story_v_out_413141.awb")

						arg_17_1:RecordAudio("413141004", var_20_15)
						arg_17_1:RecordAudio("413141004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413141", "413141004", "story_v_out_413141.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413141", "413141004", "story_v_out_413141.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413141005
		arg_21_1.duration_ = 4.73

		local var_21_0 = {
			zh = 3.1,
			ja = 4.733
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play413141006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10092_1 = arg_21_1.actors_["10092_1"].transform.localPosition
				arg_21_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_24_0 = 0, arg_21_1.actors_["10092_1"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10092_1"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_24_2 = arg_21_1.actors_["10093"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10093 = var_24_2.localPosition
				var_24_2.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10093", 4)

				for iter_24_1 = 0, var_24_2.childCount - 1 do
					local var_24_3 = var_24_2:GetChild(iter_24_1)

					if var_24_3.name == "split_4" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_2.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_21_1.time_ - 0) / var_24_4)
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_24_5 = arg_21_1.actors_["10092_1"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps10092_1 == nil then
				arg_21_1.var_.actorSpriteComps10092_1 = var_24_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.actorSpriteComps10092_1 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								iter_24_3.color = Color.New(Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_6), Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_6), (Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_6)))
							else
								local var_24_7 = Mathf.Lerp(iter_24_3.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_6)

								iter_24_3.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps10092_1 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_24_5 then
						iter_24_5.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_24_8 = arg_21_1.actors_["10093"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10093 == nil then
				arg_21_1.var_.actorSpriteComps10093 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_9 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 and not isNil(var_24_8) then
				if arg_21_1.var_.actorSpriteComps10093 then
					for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_24_7 then
							if arg_21_1.isInRecall_ then
								iter_24_7.color = Color.New(Mathf.Lerp(iter_24_7.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_9), Mathf.Lerp(iter_24_7.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_9), (Mathf.Lerp(iter_24_7.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_9)))
							else
								local var_24_10 = Mathf.Lerp(iter_24_7.color.r, 1, (arg_21_1.time_ - 0) / var_24_9)

								iter_24_7.color = Color.New(var_24_10, var_24_10, var_24_10)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10093 then
				for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_24_9 then
						iter_24_9.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10093 = nil
			end

			local var_24_11 = 0
			local var_24_12 = 0.325

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_13 = arg_21_1:GetWordFromCfg(413141005)
				local var_24_14 = arg_21_1:FormatText(var_24_13.content)

				arg_21_1.text_.text = var_24_14

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_16 = 13 <= 0 and var_24_12 or var_24_12 * (utf8.len(var_24_14) / 13)

				if (13 <= 0 and var_24_12 or var_24_12 * (utf8.len(var_24_14) / 13)) > 0 and var_24_12 < var_24_16 then
					arg_21_1.talkMaxDuration = var_24_16

					if var_24_16 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_11
					end
				end

				arg_21_1.text_.text = var_24_14
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141005", "story_v_out_413141.awb") ~= 0 then
					local var_24_17 = manager.audio:GetVoiceLength("story_v_out_413141", "413141005", "story_v_out_413141.awb") / 1000

					if var_24_17 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_11
					end

					if var_24_13.prefab_name ~= "" and arg_21_1.actors_[var_24_13.prefab_name] ~= nil then
						local var_24_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_13.prefab_name].transform, "story_v_out_413141", "413141005", "story_v_out_413141.awb")

						arg_21_1:RecordAudio("413141005", var_24_18)
						arg_21_1:RecordAudio("413141005", var_24_18)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413141", "413141005", "story_v_out_413141.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413141", "413141005", "story_v_out_413141.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_19 = math.max(var_24_12, arg_21_1.talkMaxDuration)

			if var_24_11 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_19 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_11) / var_24_19

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_11 + var_24_19 and arg_21_1.time_ < var_24_11 + var_24_19 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play413141006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413141006
		arg_25_1.duration_ = 8.5

		local var_25_0 = {
			zh = 7.466,
			ja = 8.5
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play413141007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10092_1 = arg_25_1.actors_["10092_1"].transform.localPosition
				arg_25_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_28_0 = 0, arg_25_1.actors_["10092_1"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["10092_1"].transform:GetChild(iter_28_0)

					if var_28_0.name == "" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_28_2 = arg_25_1.actors_["10092_1"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10092_1 == nil then
				arg_25_1.var_.actorSpriteComps10092_1 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps10092_1 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								iter_28_2.color = Color.New(Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_2.color.r, 1, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_2.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10092_1 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_28_5 = arg_25_1.actors_["10093"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps10093 == nil then
				arg_25_1.var_.actorSpriteComps10093 = var_28_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_6 = 2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.actorSpriteComps10093 then
					for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_28_6 then
							if arg_25_1.isInRecall_ then
								iter_28_6.color = Color.New(Mathf.Lerp(iter_28_6.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_6), Mathf.Lerp(iter_28_6.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_6), (Mathf.Lerp(iter_28_6.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_6)))
							else
								local var_28_7 = Mathf.Lerp(iter_28_6.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_6)

								iter_28_6.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps10093 then
				for iter_28_7, iter_28_8 in pairs(arg_25_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_28_8 then
						iter_28_8.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10093 = nil
			end

			local var_28_8 = arg_25_1.actors_["10093"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10093 = var_28_8.localPosition
				var_28_8.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10093", 4)

				for iter_28_9 = 0, var_28_8.childCount - 1 do
					local var_28_9 = var_28_8:GetChild(iter_28_9)

					if var_28_9.name == "" or not string.find(var_28_9.name, "split") then
						var_28_9.gameObject:SetActive(true)
					else
						var_28_9.gameObject:SetActive(false)
					end
				end
			end

			local var_28_10 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_10 then
				var_28_8.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_25_1.time_ - 0) / var_28_10)
			end

			if arg_25_1.time_ >= 0 + var_28_10 and arg_25_1.time_ < 0 + var_28_10 + arg_28_0 then
				var_28_8.localPosition = Vector3.New(390, -345, -245)
			end

			local var_28_11 = 0
			local var_28_12 = 1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_13 = arg_25_1:GetWordFromCfg(413141006)
				local var_28_14 = arg_25_1:FormatText(var_28_13.content)

				arg_25_1.text_.text = var_28_14

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_16 = 40 <= 0 and var_28_12 or var_28_12 * (utf8.len(var_28_14) / 40)

				if (40 <= 0 and var_28_12 or var_28_12 * (utf8.len(var_28_14) / 40)) > 0 and var_28_12 < var_28_16 then
					arg_25_1.talkMaxDuration = var_28_16

					if var_28_16 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_11
					end
				end

				arg_25_1.text_.text = var_28_14
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141006", "story_v_out_413141.awb") ~= 0 then
					local var_28_17 = manager.audio:GetVoiceLength("story_v_out_413141", "413141006", "story_v_out_413141.awb") / 1000

					if var_28_17 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_17 + var_28_11
					end

					if var_28_13.prefab_name ~= "" and arg_25_1.actors_[var_28_13.prefab_name] ~= nil then
						local var_28_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_13.prefab_name].transform, "story_v_out_413141", "413141006", "story_v_out_413141.awb")

						arg_25_1:RecordAudio("413141006", var_28_18)
						arg_25_1:RecordAudio("413141006", var_28_18)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413141", "413141006", "story_v_out_413141.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413141", "413141006", "story_v_out_413141.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_19 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_19 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_19

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_19 and arg_25_1.time_ < var_28_11 + var_28_19 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play413141007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413141007
		arg_29_1.duration_ = 6.13

		local var_29_0 = {
			zh = 4.9,
			ja = 6.133
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
				arg_29_0:Play413141008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.675

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(413141007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 27 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 27)

				if (27 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 27)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141007", "story_v_out_413141.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141007", "story_v_out_413141.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_413141", "413141007", "story_v_out_413141.awb")

						arg_29_1:RecordAudio("413141007", var_32_6)
						arg_29_1:RecordAudio("413141007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413141", "413141007", "story_v_out_413141.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413141", "413141007", "story_v_out_413141.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play413141008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413141008
		arg_33_1.duration_ = 18.27

		local var_33_0 = {
			zh = 12.4,
			ja = 18.266
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
				arg_33_0:Play413141009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(413141008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 61 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 61)

				if (61 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 61)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141008", "story_v_out_413141.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141008", "story_v_out_413141.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_413141", "413141008", "story_v_out_413141.awb")

						arg_33_1:RecordAudio("413141008", var_36_6)
						arg_33_1:RecordAudio("413141008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413141", "413141008", "story_v_out_413141.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413141", "413141008", "story_v_out_413141.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play413141009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413141009
		arg_37_1.duration_ = 8.27

		local var_37_0 = {
			zh = 6.066,
			ja = 8.266
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
				arg_37_0:Play413141010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10092_1 = arg_37_1.actors_["10092_1"].transform.localPosition
				arg_37_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_40_0 = 0, arg_37_1.actors_["10092_1"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["10092_1"].transform:GetChild(iter_40_0)

					if var_40_0.name == "split_2" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_40_2 = arg_37_1.actors_["10092_1"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10092_1 == nil then
				arg_37_1.var_.actorSpriteComps10092_1 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps10092_1 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_40_2 then
							if arg_37_1.isInRecall_ then
								iter_40_2.color = Color.New(Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_2.color.r, 1, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_2.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10092_1 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_40_4 then
						iter_40_4.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_40_5 = 0
			local var_40_6 = 0.8

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(413141009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 32 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 32)

				if (32 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 32)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141009", "story_v_out_413141.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141009", "story_v_out_413141.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_413141", "413141009", "story_v_out_413141.awb")

						arg_37_1:RecordAudio("413141009", var_40_12)
						arg_37_1:RecordAudio("413141009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413141", "413141009", "story_v_out_413141.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413141", "413141009", "story_v_out_413141.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_13 and arg_37_1.time_ < var_40_5 + var_40_13 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413141010
		arg_41_1.duration_ = 6.07

		local var_41_0 = {
			zh = 5.5,
			ja = 6.066
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
				arg_41_0:Play413141011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10092_1"]) and arg_41_1.var_.actorSpriteComps10092_1 == nil then
				arg_41_1.var_.actorSpriteComps10092_1 = arg_41_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10092_1"]) then
				if arg_41_1.var_.actorSpriteComps10092_1 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10092_1"]) and arg_41_1.var_.actorSpriteComps10092_1 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_44_2 = arg_41_1.actors_["10093"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10093 == nil then
				arg_41_1.var_.actorSpriteComps10093 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10093 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								iter_44_5.color = Color.New(Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_5.color.r, 1, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_5.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10093 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_44_7 then
						iter_44_7.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10093 = nil
			end

			local var_44_5 = arg_41_1.actors_["10093"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10093 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10093", 4)

				for iter_44_8 = 0, var_44_5.childCount - 1 do
					local var_44_6 = var_44_5:GetChild(iter_44_8)

					if var_44_6.name == "" or not string.find(var_44_6.name, "split") then
						var_44_6.gameObject:SetActive(true)
					else
						var_44_6.gameObject:SetActive(false)
					end
				end
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(390, -345, -245)
			end

			local var_44_8 = 0
			local var_44_9 = 0.75

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(413141010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 30 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 30)

				if (30 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 30)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141010", "story_v_out_413141.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141010", "story_v_out_413141.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_413141", "413141010", "story_v_out_413141.awb")

						arg_41_1:RecordAudio("413141010", var_44_15)
						arg_41_1:RecordAudio("413141010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413141", "413141010", "story_v_out_413141.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413141", "413141010", "story_v_out_413141.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play413141011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413141011
		arg_45_1.duration_ = 2.87

		local var_45_0 = {
			zh = 1.999999999999,
			ja = 2.866
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play413141012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10092_1 = arg_45_1.actors_["10092_1"].transform.localPosition
				arg_45_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_48_0 = 0, arg_45_1.actors_["10092_1"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["10092_1"].transform:GetChild(iter_48_0)

					if var_48_0.name == "" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_48_2 = arg_45_1.actors_["10092_1"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10092_1 == nil then
				arg_45_1.var_.actorSpriteComps10092_1 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps10092_1 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								iter_48_2.color = Color.New(Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_3), Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_3), (Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_3)))
							else
								local var_48_4 = Mathf.Lerp(iter_48_2.color.r, 1, (arg_45_1.time_ - 0) / var_48_3)

								iter_48_2.color = Color.New(var_48_4, var_48_4, var_48_4)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10092_1 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_48_4 then
						iter_48_4.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_48_5 = arg_45_1.actors_["10093"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps10093 == nil then
				arg_45_1.var_.actorSpriteComps10093 = var_48_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_6 = 2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_6 and not isNil(var_48_5) then
				if arg_45_1.var_.actorSpriteComps10093 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_48_6 then
							if arg_45_1.isInRecall_ then
								iter_48_6.color = Color.New(Mathf.Lerp(iter_48_6.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_6), Mathf.Lerp(iter_48_6.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_6), (Mathf.Lerp(iter_48_6.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_6)))
							else
								local var_48_7 = Mathf.Lerp(iter_48_6.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_6)

								iter_48_6.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_6 and arg_45_1.time_ < 0 + var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps10093 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_48_8 then
						iter_48_8.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10093 = nil
			end

			local var_48_8 = arg_45_1.actors_["10093"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10093 = var_48_8.localPosition
				var_48_8.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10093", 4)

				for iter_48_9 = 0, var_48_8.childCount - 1 do
					local var_48_9 = var_48_8:GetChild(iter_48_9)

					if var_48_9.name == "" or not string.find(var_48_9.name, "split") then
						var_48_9.gameObject:SetActive(true)
					else
						var_48_9.gameObject:SetActive(false)
					end
				end
			end

			local var_48_10 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_10 then
				var_48_8.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_45_1.time_ - 0) / var_48_10)
			end

			if arg_45_1.time_ >= 0 + var_48_10 and arg_45_1.time_ < 0 + var_48_10 + arg_48_0 then
				var_48_8.localPosition = Vector3.New(390, -345, -245)
			end

			local var_48_11 = 0
			local var_48_12 = 0.175

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_13 = arg_45_1:GetWordFromCfg(413141011)
				local var_48_14 = arg_45_1:FormatText(var_48_13.content)

				arg_45_1.text_.text = var_48_14

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_16 = 7 <= 0 and var_48_12 or var_48_12 * (utf8.len(var_48_14) / 7)

				if (7 <= 0 and var_48_12 or var_48_12 * (utf8.len(var_48_14) / 7)) > 0 and var_48_12 < var_48_16 then
					arg_45_1.talkMaxDuration = var_48_16

					if var_48_16 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_11
					end
				end

				arg_45_1.text_.text = var_48_14
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141011", "story_v_out_413141.awb") ~= 0 then
					local var_48_17 = manager.audio:GetVoiceLength("story_v_out_413141", "413141011", "story_v_out_413141.awb") / 1000

					if var_48_17 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_11
					end

					if var_48_13.prefab_name ~= "" and arg_45_1.actors_[var_48_13.prefab_name] ~= nil then
						local var_48_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_13.prefab_name].transform, "story_v_out_413141", "413141011", "story_v_out_413141.awb")

						arg_45_1:RecordAudio("413141011", var_48_18)
						arg_45_1:RecordAudio("413141011", var_48_18)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413141", "413141011", "story_v_out_413141.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413141", "413141011", "story_v_out_413141.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_19 = math.max(var_48_12, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_19 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_19

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_19 and arg_45_1.time_ < var_48_11 + var_48_19 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413141012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413141012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play413141013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10092_1 = arg_49_1.actors_["10092_1"].transform.localPosition
				arg_49_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_52_0 = 0, arg_49_1.actors_["10092_1"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["10092_1"].transform:GetChild(iter_52_0)

					if var_52_0.name == "" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_2 = arg_49_1.actors_["10092_1"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10092_1 == nil then
				arg_49_1.var_.actorSpriteComps10092_1 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps10092_1 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								iter_52_2.color = Color.New(Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_2.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_2.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10092_1 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_52_4 then
						iter_52_4.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_52_5 = arg_49_1.actors_["10093"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10093 = var_52_5.localPosition
				var_52_5.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10093", 7)

				for iter_52_5 = 0, var_52_5.childCount - 1 do
					local var_52_6 = var_52_5:GetChild(iter_52_5)

					if var_52_6.name == "split_7" or not string.find(var_52_6.name, "split") then
						var_52_6.gameObject:SetActive(true)
					else
						var_52_6.gameObject:SetActive(false)
					end
				end
			end

			local var_52_7 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				var_52_5.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_49_1.time_ - 0) / var_52_7)
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				var_52_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_8 = 0
			local var_52_9 = 1.25

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(413141012).content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_12 = 50 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_10) / 50)

				if (50 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_10) / 50)) > 0 and var_52_9 < var_52_12 then
					arg_49_1.talkMaxDuration = var_52_12

					if var_52_12 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_13 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_13 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_13

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_13 and arg_49_1.time_ < var_52_8 + var_52_13 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413141013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413141013
		arg_53_1.duration_ = 6.4

		local var_53_0 = {
			zh = 4.566,
			ja = 6.4
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
				arg_53_0:Play413141014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10093 = arg_53_1.actors_["10093"].transform.localPosition
				arg_53_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10093", 4)

				for iter_56_0 = 0, arg_53_1.actors_["10093"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["10093"].transform:GetChild(iter_56_0)

					if var_56_0.name == "split_5" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_56_2 = arg_53_1.actors_["10093"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10093 == nil then
				arg_53_1.var_.actorSpriteComps10093 = var_56_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_3 = 2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.actorSpriteComps10093 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_56_2 then
							if arg_53_1.isInRecall_ then
								iter_56_2.color = Color.New(Mathf.Lerp(iter_56_2.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_3), Mathf.Lerp(iter_56_2.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_3), (Mathf.Lerp(iter_56_2.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_3)))
							else
								local var_56_4 = Mathf.Lerp(iter_56_2.color.r, 1, (arg_53_1.time_ - 0) / var_56_3)

								iter_56_2.color = Color.New(var_56_4, var_56_4, var_56_4)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10093 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_56_4 then
						iter_56_4.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10093 = nil
			end

			local var_56_5 = 0
			local var_56_6 = 0.475

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(413141013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 19 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 19)

				if (19 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 19)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141013", "story_v_out_413141.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141013", "story_v_out_413141.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_413141", "413141013", "story_v_out_413141.awb")

						arg_53_1:RecordAudio("413141013", var_56_12)
						arg_53_1:RecordAudio("413141013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413141", "413141013", "story_v_out_413141.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413141", "413141013", "story_v_out_413141.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_13 = math.max(var_56_6, arg_53_1.talkMaxDuration)

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_13 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_5) / var_56_13

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_5 + var_56_13 and arg_53_1.time_ < var_56_5 + var_56_13 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play413141014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413141014
		arg_57_1.duration_ = 11.1

		local var_57_0 = {
			zh = 7,
			ja = 11.1
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play413141015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10092_1"]) and arg_57_1.var_.actorSpriteComps10092_1 == nil then
				arg_57_1.var_.actorSpriteComps10092_1 = arg_57_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10092_1"]) then
				if arg_57_1.var_.actorSpriteComps10092_1 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								iter_60_1.color = Color.New(Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_0), Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_0), (Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_0)))
							else
								local var_60_1 = Mathf.Lerp(iter_60_1.color.r, 1, (arg_57_1.time_ - 0) / var_60_0)

								iter_60_1.color = Color.New(var_60_1, var_60_1, var_60_1)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10092_1"]) and arg_57_1.var_.actorSpriteComps10092_1 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_60_2 = arg_57_1.actors_["10093"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10093 == nil then
				arg_57_1.var_.actorSpriteComps10093 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps10093 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_60_5 then
							if arg_57_1.isInRecall_ then
								iter_60_5.color = Color.New(Mathf.Lerp(iter_60_5.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_3), Mathf.Lerp(iter_60_5.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_3), (Mathf.Lerp(iter_60_5.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_3)))
							else
								local var_60_4 = Mathf.Lerp(iter_60_5.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_3)

								iter_60_5.color = Color.New(var_60_4, var_60_4, var_60_4)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10093 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_60_7 then
						iter_60_7.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps10093 = nil
			end

			local var_60_5 = arg_57_1.actors_["10092_1"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10092_1 = var_60_5.localPosition
				var_60_5.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_60_8 = 0, var_60_5.childCount - 1 do
					local var_60_6 = var_60_5:GetChild(iter_60_8)

					if var_60_6.name == "" or not string.find(var_60_6.name, "split") then
						var_60_6.gameObject:SetActive(true)
					else
						var_60_6.gameObject:SetActive(false)
					end
				end
			end

			local var_60_7 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				var_60_5.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_57_1.time_ - 0) / var_60_7)
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				var_60_5.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_60_8 = 0
			local var_60_9 = 0.925

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(413141014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 37 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 37)

				if (37 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 37)) > 0 and var_60_9 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141014", "story_v_out_413141.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141014", "story_v_out_413141.awb") / 1000

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_out_413141", "413141014", "story_v_out_413141.awb")

						arg_57_1:RecordAudio("413141014", var_60_15)
						arg_57_1:RecordAudio("413141014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413141", "413141014", "story_v_out_413141.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413141", "413141014", "story_v_out_413141.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413141015
		arg_61_1.duration_ = 2.8

		local var_61_0 = {
			zh = 1.999999999999,
			ja = 2.8
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play413141016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10092_1"]) and arg_61_1.var_.actorSpriteComps10092_1 == nil then
				arg_61_1.var_.actorSpriteComps10092_1 = arg_61_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10092_1"]) then
				if arg_61_1.var_.actorSpriteComps10092_1 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10092_1"]) and arg_61_1.var_.actorSpriteComps10092_1 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_64_2 = arg_61_1.actors_["10093"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10093 == nil then
				arg_61_1.var_.actorSpriteComps10093 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps10093 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								iter_64_5.color = Color.New(Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_3), Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_3), (Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_3)))
							else
								local var_64_4 = Mathf.Lerp(iter_64_5.color.r, 1, (arg_61_1.time_ - 0) / var_64_3)

								iter_64_5.color = Color.New(var_64_4, var_64_4, var_64_4)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10093 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_64_7 then
						iter_64_7.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps10093 = nil
			end

			local var_64_5 = 0
			local var_64_6 = 0.2

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(413141015)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 8 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 8)

				if (8 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 8)) > 0 and var_64_6 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141015", "story_v_out_413141.awb") ~= 0 then
					local var_64_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141015", "story_v_out_413141.awb") / 1000

					if var_64_11 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_5
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_413141", "413141015", "story_v_out_413141.awb")

						arg_61_1:RecordAudio("413141015", var_64_12)
						arg_61_1:RecordAudio("413141015", var_64_12)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413141", "413141015", "story_v_out_413141.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413141", "413141015", "story_v_out_413141.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = math.max(var_64_6, arg_61_1.talkMaxDuration)

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_13 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_5) / var_64_13

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_5 + var_64_13 and arg_61_1.time_ < var_64_5 + var_64_13 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play413141016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413141016
		arg_65_1.duration_ = 13.57

		local var_65_0 = {
			zh = 7.766,
			ja = 13.566
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play413141017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10092_1 = arg_65_1.actors_["10092_1"].transform.localPosition
				arg_65_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_68_0 = 0, arg_65_1.actors_["10092_1"].transform.childCount - 1 do
					local var_68_0 = arg_65_1.actors_["10092_1"].transform:GetChild(iter_68_0)

					if var_68_0.name == "split_1_1" or not string.find(var_68_0.name, "split") then
						var_68_0.gameObject:SetActive(true)
					else
						var_68_0.gameObject:SetActive(false)
					end
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_65_1.time_ - 0) / var_68_1)
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_68_2 = arg_65_1.actors_["10093"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10093 = var_68_2.localPosition
				var_68_2.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10093", 4)

				for iter_68_1 = 0, var_68_2.childCount - 1 do
					local var_68_3 = var_68_2:GetChild(iter_68_1)

					if var_68_3.name == "split_4" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_2.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_65_1.time_ - 0) / var_68_4)
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_68_5 = arg_65_1.actors_["10092_1"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps10092_1 == nil then
				arg_65_1.var_.actorSpriteComps10092_1 = var_68_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_6 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.actorSpriteComps10092_1 then
					for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_68_3 then
							if arg_65_1.isInRecall_ then
								iter_68_3.color = Color.New(Mathf.Lerp(iter_68_3.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_6), Mathf.Lerp(iter_68_3.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_6), (Mathf.Lerp(iter_68_3.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_6)))
							else
								local var_68_7 = Mathf.Lerp(iter_68_3.color.r, 1, (arg_65_1.time_ - 0) / var_68_6)

								iter_68_3.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps10092_1 then
				for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_68_5 then
						iter_68_5.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_68_8 = arg_65_1.actors_["10093"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10093 == nil then
				arg_65_1.var_.actorSpriteComps10093 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_9 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_9 and not isNil(var_68_8) then
				if arg_65_1.var_.actorSpriteComps10093 then
					for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_68_7 then
							if arg_65_1.isInRecall_ then
								iter_68_7.color = Color.New(Mathf.Lerp(iter_68_7.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_9), Mathf.Lerp(iter_68_7.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_9), (Mathf.Lerp(iter_68_7.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_9)))
							else
								local var_68_10 = Mathf.Lerp(iter_68_7.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_9)

								iter_68_7.color = Color.New(var_68_10, var_68_10, var_68_10)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_9 and arg_65_1.time_ < 0 + var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10093 then
				for iter_68_8, iter_68_9 in pairs(arg_65_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_68_9 then
						iter_68_9.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps10093 = nil
			end

			local var_68_11 = 0
			local var_68_12 = 0.825

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_13 = arg_65_1:GetWordFromCfg(413141016)
				local var_68_14 = arg_65_1:FormatText(var_68_13.content)

				arg_65_1.text_.text = var_68_14

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_16 = 33 <= 0 and var_68_12 or var_68_12 * (utf8.len(var_68_14) / 33)

				if (33 <= 0 and var_68_12 or var_68_12 * (utf8.len(var_68_14) / 33)) > 0 and var_68_12 < var_68_16 then
					arg_65_1.talkMaxDuration = var_68_16

					if var_68_16 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_11
					end
				end

				arg_65_1.text_.text = var_68_14
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141016", "story_v_out_413141.awb") ~= 0 then
					local var_68_17 = manager.audio:GetVoiceLength("story_v_out_413141", "413141016", "story_v_out_413141.awb") / 1000

					if var_68_17 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_11
					end

					if var_68_13.prefab_name ~= "" and arg_65_1.actors_[var_68_13.prefab_name] ~= nil then
						local var_68_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_13.prefab_name].transform, "story_v_out_413141", "413141016", "story_v_out_413141.awb")

						arg_65_1:RecordAudio("413141016", var_68_18)
						arg_65_1:RecordAudio("413141016", var_68_18)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413141", "413141016", "story_v_out_413141.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413141", "413141016", "story_v_out_413141.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_19 = math.max(var_68_12, arg_65_1.talkMaxDuration)

			if var_68_11 <= arg_65_1.time_ and arg_65_1.time_ < var_68_11 + var_68_19 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_11) / var_68_19

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_11 + var_68_19 and arg_65_1.time_ < var_68_11 + var_68_19 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play413141017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413141017
		arg_69_1.duration_ = 11.3

		local var_69_0 = {
			zh = 11.3,
			ja = 11.133
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
				arg_69_0:Play413141018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10092_1 = arg_69_1.actors_["10092_1"].transform.localPosition
				arg_69_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_72_0 = 0, arg_69_1.actors_["10092_1"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["10092_1"].transform:GetChild(iter_72_0)

					if var_72_0.name == "" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_72_2 = "10092"

			if arg_69_1.actors_["10092"] == nil then
				local var_72_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_72_3) then
					local var_72_4 = Object.Instantiate(var_72_3, arg_69_1.canvasGo_.transform)

					var_72_4.transform:SetSiblingIndex(1)

					var_72_4.name = var_72_2
					var_72_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_69_1.actors_[var_72_2] = var_72_4

					if arg_69_1.isInRecall_ then
						for iter_72_1, iter_72_2 in ipairs((var_72_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_72_2.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_72_5 = arg_69_1.actors_["10092"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps10092 == nil then
				arg_69_1.var_.actorSpriteComps10092 = var_72_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_6 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.actorSpriteComps10092 then
					for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_72_4 then
							if arg_69_1.isInRecall_ then
								iter_72_4.color = Color.New(Mathf.Lerp(iter_72_4.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_6), Mathf.Lerp(iter_72_4.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_6), (Mathf.Lerp(iter_72_4.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_6)))
							else
								local var_72_7 = Mathf.Lerp(iter_72_4.color.r, 1, (arg_69_1.time_ - 0) / var_72_6)

								iter_72_4.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps10092 then
				for iter_72_5, iter_72_6 in pairs(arg_69_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_72_6 then
						iter_72_6.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps10092 = nil
			end

			local var_72_8 = 0
			local var_72_9 = 1.275

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(413141017)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 51 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 51)

				if (51 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 51)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141017", "story_v_out_413141.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141017", "story_v_out_413141.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_413141", "413141017", "story_v_out_413141.awb")

						arg_69_1:RecordAudio("413141017", var_72_15)
						arg_69_1:RecordAudio("413141017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413141", "413141017", "story_v_out_413141.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413141", "413141017", "story_v_out_413141.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_16 and arg_69_1.time_ < var_72_8 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413141018
		arg_73_1.duration_ = 7.33

		local var_73_0 = {
			zh = 7.333,
			ja = 4.7
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play413141019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10092_1"]) and arg_73_1.var_.actorSpriteComps10092_1 == nil then
				arg_73_1.var_.actorSpriteComps10092_1 = arg_73_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10092_1"]) then
				if arg_73_1.var_.actorSpriteComps10092_1 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10092_1"]) and arg_73_1.var_.actorSpriteComps10092_1 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_76_2 = arg_73_1.actors_["10093"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10093 == nil then
				arg_73_1.var_.actorSpriteComps10093 = var_76_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_3 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.actorSpriteComps10093 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_76_5 then
							if arg_73_1.isInRecall_ then
								iter_76_5.color = Color.New(Mathf.Lerp(iter_76_5.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_3), Mathf.Lerp(iter_76_5.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_3), (Mathf.Lerp(iter_76_5.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_3)))
							else
								local var_76_4 = Mathf.Lerp(iter_76_5.color.r, 1, (arg_73_1.time_ - 0) / var_76_3)

								iter_76_5.color = Color.New(var_76_4, var_76_4, var_76_4)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10093 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_76_7 then
						iter_76_7.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10093 = nil
			end

			local var_76_5 = arg_73_1.actors_["10093"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10093 = var_76_5.localPosition
				var_76_5.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10093", 4)

				for iter_76_8 = 0, var_76_5.childCount - 1 do
					local var_76_6 = var_76_5:GetChild(iter_76_8)

					if var_76_6.name == "split_5" or not string.find(var_76_6.name, "split") then
						var_76_6.gameObject:SetActive(true)
					else
						var_76_6.gameObject:SetActive(false)
					end
				end
			end

			local var_76_7 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				var_76_5.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_73_1.time_ - 0) / var_76_7)
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				var_76_5.localPosition = Vector3.New(390, -345, -245)
			end

			local var_76_8 = 0
			local var_76_9 = 0.775

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(413141018)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 31 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 31)

				if (31 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 31)) > 0 and var_76_9 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141018", "story_v_out_413141.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141018", "story_v_out_413141.awb") / 1000

					if var_76_14 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_8
					end

					if var_76_10.prefab_name ~= "" and arg_73_1.actors_[var_76_10.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_10.prefab_name].transform, "story_v_out_413141", "413141018", "story_v_out_413141.awb")

						arg_73_1:RecordAudio("413141018", var_76_15)
						arg_73_1:RecordAudio("413141018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413141", "413141018", "story_v_out_413141.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413141", "413141018", "story_v_out_413141.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_16 and arg_73_1.time_ < var_76_8 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413141019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413141019
		arg_77_1.duration_ = 9.57

		local var_77_0 = {
			zh = 8.2,
			ja = 9.566
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
				arg_77_0:Play413141020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10092_1 = arg_77_1.actors_["10092_1"].transform.localPosition
				arg_77_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_80_0 = 0, arg_77_1.actors_["10092_1"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["10092_1"].transform:GetChild(iter_80_0)

					if var_80_0.name == "split_2" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_80_2 = arg_77_1.actors_["10092_1"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10092_1 == nil then
				arg_77_1.var_.actorSpriteComps10092_1 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps10092_1 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								iter_80_2.color = Color.New(Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_2.color.r, 1, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_2.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10092_1 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_80_4 then
						iter_80_4.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_80_5 = arg_77_1.actors_["10093"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps10093 == nil then
				arg_77_1.var_.actorSpriteComps10093 = var_80_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_6 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 and not isNil(var_80_5) then
				if arg_77_1.var_.actorSpriteComps10093 then
					for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_80_6 then
							if arg_77_1.isInRecall_ then
								iter_80_6.color = Color.New(Mathf.Lerp(iter_80_6.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_6), Mathf.Lerp(iter_80_6.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_6), (Mathf.Lerp(iter_80_6.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_6)))
							else
								local var_80_7 = Mathf.Lerp(iter_80_6.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_6)

								iter_80_6.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps10093 then
				for iter_80_7, iter_80_8 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_80_8 then
						iter_80_8.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10093 = nil
			end

			local var_80_8 = 0
			local var_80_9 = 0.975

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(413141019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 39 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 39)

				if (39 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 39)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141019", "story_v_out_413141.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141019", "story_v_out_413141.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_413141", "413141019", "story_v_out_413141.awb")

						arg_77_1:RecordAudio("413141019", var_80_15)
						arg_77_1:RecordAudio("413141019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413141", "413141019", "story_v_out_413141.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413141", "413141019", "story_v_out_413141.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_16 and arg_77_1.time_ < var_80_8 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play413141020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413141020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play413141021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10092_1"]) and arg_81_1.var_.actorSpriteComps10092_1 == nil then
				arg_81_1.var_.actorSpriteComps10092_1 = arg_81_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10092_1"]) then
				if arg_81_1.var_.actorSpriteComps10092_1 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								iter_84_1.color = Color.New(Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_0), Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_0), (Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_0)))
							else
								local var_84_1 = Mathf.Lerp(iter_84_1.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_0)

								iter_84_1.color = Color.New(var_84_1, var_84_1, var_84_1)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10092_1"]) and arg_81_1.var_.actorSpriteComps10092_1 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_84_2 = arg_81_1.actors_["10092_1"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10092_1 = var_84_2.localPosition
				var_84_2.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_84_4 = 0, var_84_2.childCount - 1 do
					local var_84_3 = var_84_2:GetChild(iter_84_4)

					if var_84_3.name == "" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_2.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_81_1.time_ - 0) / var_84_4)
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_5 = arg_81_1.actors_["10093"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10093 = var_84_5.localPosition
				var_84_5.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10093", 7)

				for iter_84_5 = 0, var_84_5.childCount - 1 do
					local var_84_6 = var_84_5:GetChild(iter_84_5)

					if var_84_6.name == "" or not string.find(var_84_6.name, "split") then
						var_84_6.gameObject:SetActive(true)
					else
						var_84_6.gameObject:SetActive(false)
					end
				end
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_5.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_81_1.time_ - 0) / var_84_7)
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_8 = 0
			local var_84_9 = 1.025

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(413141020).content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_12 = 41 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_10) / 41)

				if (41 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_10) / 41)) > 0 and var_84_9 < var_84_12 then
					arg_81_1.talkMaxDuration = var_84_12

					if var_84_12 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_13 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_13 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_13

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_13 and arg_81_1.time_ < var_84_8 + var_84_13 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413141021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413141021
		arg_85_1.duration_ = 7.17

		local var_85_0 = {
			zh = 3.833,
			ja = 7.166
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
				arg_85_0:Play413141022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10092_1 = arg_85_1.actors_["10092_1"].transform.localPosition
				arg_85_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_88_0 = 0, arg_85_1.actors_["10092_1"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["10092_1"].transform:GetChild(iter_88_0)

					if var_88_0.name == "" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_88_2 = arg_85_1.actors_["10092_1"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10092_1 == nil then
				arg_85_1.var_.actorSpriteComps10092_1 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps10092_1 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								iter_88_2.color = Color.New(Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_2.color.r, 1, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_2.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10092_1 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_88_4 then
						iter_88_4.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_88_5 = 0
			local var_88_6 = 0.55

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(413141021)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 22 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 22)

				if (22 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 22)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141021", "story_v_out_413141.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141021", "story_v_out_413141.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_413141", "413141021", "story_v_out_413141.awb")

						arg_85_1:RecordAudio("413141021", var_88_12)
						arg_85_1:RecordAudio("413141021", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413141", "413141021", "story_v_out_413141.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413141", "413141021", "story_v_out_413141.awb")
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

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play413141022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413141022
		arg_89_1.duration_ = 13.03

		local var_89_0 = {
			zh = 7.033,
			ja = 13.033
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
				arg_89_0:Play413141023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.075

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(413141022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 43 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 43)

				if (43 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 43)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141022", "story_v_out_413141.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141022", "story_v_out_413141.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_413141", "413141022", "story_v_out_413141.awb")

						arg_89_1:RecordAudio("413141022", var_92_6)
						arg_89_1:RecordAudio("413141022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413141", "413141022", "story_v_out_413141.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413141", "413141022", "story_v_out_413141.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play413141023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413141023
		arg_93_1.duration_ = 10.37

		local var_93_0 = {
			zh = 7.133,
			ja = 10.366
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
				arg_93_0:Play413141024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10092_1 = arg_93_1.actors_["10092_1"].transform.localPosition
				arg_93_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_96_0 = 0, arg_93_1.actors_["10092_1"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["10092_1"].transform:GetChild(iter_96_0)

					if var_96_0.name == "split_2" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_96_2 = arg_93_1.actors_["10092_1"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps10092_1 == nil then
				arg_93_1.var_.actorSpriteComps10092_1 = var_96_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_3 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.actorSpriteComps10092_1 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								iter_96_2.color = Color.New(Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_3), Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_3), (Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_3)))
							else
								local var_96_4 = Mathf.Lerp(iter_96_2.color.r, 1, (arg_93_1.time_ - 0) / var_96_3)

								iter_96_2.color = Color.New(var_96_4, var_96_4, var_96_4)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps10092_1 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_96_4 then
						iter_96_4.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_96_5 = 0
			local var_96_6 = 0.775

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_7 = arg_93_1:GetWordFromCfg(413141023)
				local var_96_8 = arg_93_1:FormatText(var_96_7.content)

				arg_93_1.text_.text = var_96_8

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 31 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 31)

				if (31 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 31)) > 0 and var_96_6 < var_96_10 then
					arg_93_1.talkMaxDuration = var_96_10

					if var_96_10 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_8
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141023", "story_v_out_413141.awb") ~= 0 then
					local var_96_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141023", "story_v_out_413141.awb") / 1000

					if var_96_11 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_5
					end

					if var_96_7.prefab_name ~= "" and arg_93_1.actors_[var_96_7.prefab_name] ~= nil then
						local var_96_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_7.prefab_name].transform, "story_v_out_413141", "413141023", "story_v_out_413141.awb")

						arg_93_1:RecordAudio("413141023", var_96_12)
						arg_93_1:RecordAudio("413141023", var_96_12)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413141", "413141023", "story_v_out_413141.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413141", "413141023", "story_v_out_413141.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_13 = math.max(var_96_6, arg_93_1.talkMaxDuration)

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_13 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_5) / var_96_13

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_5 + var_96_13 and arg_93_1.time_ < var_96_5 + var_96_13 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413141024
		arg_97_1.duration_ = 7.13

		local var_97_0 = {
			zh = 3.9,
			ja = 7.133
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play413141025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10092_1"]) and arg_97_1.var_.actorSpriteComps10092_1 == nil then
				arg_97_1.var_.actorSpriteComps10092_1 = arg_97_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10092_1"]) then
				if arg_97_1.var_.actorSpriteComps10092_1 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10092_1"]) and arg_97_1.var_.actorSpriteComps10092_1 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_100_2 = arg_97_1.actors_["10093"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10093 == nil then
				arg_97_1.var_.actorSpriteComps10093 = var_100_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_3 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.actorSpriteComps10093 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								iter_100_5.color = Color.New(Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_3), Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_3), (Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_3)))
							else
								local var_100_4 = Mathf.Lerp(iter_100_5.color.r, 1, (arg_97_1.time_ - 0) / var_100_3)

								iter_100_5.color = Color.New(var_100_4, var_100_4, var_100_4)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10093 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_100_7 then
						iter_100_7.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps10093 = nil
			end

			local var_100_5 = arg_97_1.actors_["10093"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10093 = var_100_5.localPosition
				var_100_5.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10093", 4)

				for iter_100_8 = 0, var_100_5.childCount - 1 do
					local var_100_6 = var_100_5:GetChild(iter_100_8)

					if var_100_6.name == "split_5" or not string.find(var_100_6.name, "split") then
						var_100_6.gameObject:SetActive(true)
					else
						var_100_6.gameObject:SetActive(false)
					end
				end
			end

			local var_100_7 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				var_100_5.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_97_1.time_ - 0) / var_100_7)
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				var_100_5.localPosition = Vector3.New(390, -345, -245)
			end

			local var_100_8 = arg_97_1.actors_["10092_1"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10092_1 = var_100_8.localPosition
				var_100_8.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_100_9 = 0, var_100_8.childCount - 1 do
					local var_100_9 = var_100_8:GetChild(iter_100_9)

					if var_100_9.name == "split_2" or not string.find(var_100_9.name, "split") then
						var_100_9.gameObject:SetActive(true)
					else
						var_100_9.gameObject:SetActive(false)
					end
				end
			end

			local var_100_10 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_10 then
				var_100_8.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_97_1.time_ - 0) / var_100_10)
			end

			if arg_97_1.time_ >= 0 + var_100_10 and arg_97_1.time_ < 0 + var_100_10 + arg_100_0 then
				var_100_8.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_100_11 = 0
			local var_100_12 = 0.6

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_11 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_13 = arg_97_1:GetWordFromCfg(413141024)
				local var_100_14 = arg_97_1:FormatText(var_100_13.content)

				arg_97_1.text_.text = var_100_14

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_16 = 24 <= 0 and var_100_12 or var_100_12 * (utf8.len(var_100_14) / 24)

				if (24 <= 0 and var_100_12 or var_100_12 * (utf8.len(var_100_14) / 24)) > 0 and var_100_12 < var_100_16 then
					arg_97_1.talkMaxDuration = var_100_16

					if var_100_16 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_16 + var_100_11
					end
				end

				arg_97_1.text_.text = var_100_14
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141024", "story_v_out_413141.awb") ~= 0 then
					local var_100_17 = manager.audio:GetVoiceLength("story_v_out_413141", "413141024", "story_v_out_413141.awb") / 1000

					if var_100_17 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_17 + var_100_11
					end

					if var_100_13.prefab_name ~= "" and arg_97_1.actors_[var_100_13.prefab_name] ~= nil then
						local var_100_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_13.prefab_name].transform, "story_v_out_413141", "413141024", "story_v_out_413141.awb")

						arg_97_1:RecordAudio("413141024", var_100_18)
						arg_97_1:RecordAudio("413141024", var_100_18)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413141", "413141024", "story_v_out_413141.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413141", "413141024", "story_v_out_413141.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_19 = math.max(var_100_12, arg_97_1.talkMaxDuration)

			if var_100_11 <= arg_97_1.time_ and arg_97_1.time_ < var_100_11 + var_100_19 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_11) / var_100_19

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_11 + var_100_19 and arg_97_1.time_ < var_100_11 + var_100_19 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413141025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play413141026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10093 = arg_101_1.actors_["10093"].transform.localPosition
				arg_101_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10093", 7)

				for iter_104_0 = 0, arg_101_1.actors_["10093"].transform.childCount - 1 do
					local var_104_0 = arg_101_1.actors_["10093"].transform:GetChild(iter_104_0)

					if var_104_0.name == "" or not string.find(var_104_0.name, "split") then
						var_104_0.gameObject:SetActive(true)
					else
						var_104_0.gameObject:SetActive(false)
					end
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_101_1.time_ - 0) / var_104_1)
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_104_2 = arg_101_1.actors_["10093"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10093 == nil then
				arg_101_1.var_.actorSpriteComps10093 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps10093 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								iter_104_2.color = Color.New(Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_2.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_2.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10093 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_104_4 then
						iter_104_4.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps10093 = nil
			end

			local var_104_5 = arg_101_1.actors_["10092_1"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10092_1 = var_104_5.localPosition
				var_104_5.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_104_5 = 0, var_104_5.childCount - 1 do
					local var_104_6 = var_104_5:GetChild(iter_104_5)

					if var_104_6.name == "" or not string.find(var_104_6.name, "split") then
						var_104_6.gameObject:SetActive(true)
					else
						var_104_6.gameObject:SetActive(false)
					end
				end
			end

			local var_104_7 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				var_104_5.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_101_1.time_ - 0) / var_104_7)
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				var_104_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_104_8 = 0
			local var_104_9 = 0.675

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(413141025).content)

				arg_101_1.text_.text = var_104_10

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_12 = 27 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_10) / 27)

				if (27 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_10) / 27)) > 0 and var_104_9 < var_104_12 then
					arg_101_1.talkMaxDuration = var_104_12

					if var_104_12 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_10
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_13 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_13 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_13

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_13 and arg_101_1.time_ < var_104_8 + var_104_13 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413141026
		arg_105_1.duration_ = 6.57

		local var_105_0 = {
			zh = 5.466,
			ja = 6.566
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play413141027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10092_1 = arg_105_1.actors_["10092_1"].transform.localPosition
				arg_105_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_108_0 = 0, arg_105_1.actors_["10092_1"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["10092_1"].transform:GetChild(iter_108_0)

					if var_108_0.name == "split_1_1" or not string.find(var_108_0.name, "split") then
						var_108_0.gameObject:SetActive(true)
					else
						var_108_0.gameObject:SetActive(false)
					end
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_105_1.time_ - 0) / var_108_1)
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_108_2 = arg_105_1.actors_["10092_1"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10092_1 == nil then
				arg_105_1.var_.actorSpriteComps10092_1 = var_108_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_3 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.actorSpriteComps10092_1 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_108_2 then
							if arg_105_1.isInRecall_ then
								iter_108_2.color = Color.New(Mathf.Lerp(iter_108_2.color.r, arg_105_1.hightColor1.r, (arg_105_1.time_ - 0) / var_108_3), Mathf.Lerp(iter_108_2.color.g, arg_105_1.hightColor1.g, (arg_105_1.time_ - 0) / var_108_3), (Mathf.Lerp(iter_108_2.color.b, arg_105_1.hightColor1.b, (arg_105_1.time_ - 0) / var_108_3)))
							else
								local var_108_4 = Mathf.Lerp(iter_108_2.color.r, 1, (arg_105_1.time_ - 0) / var_108_3)

								iter_108_2.color = Color.New(var_108_4, var_108_4, var_108_4)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10092_1 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_108_4 then
						iter_108_4.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_108_5 = 0
			local var_108_6 = 0.875

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_7 = arg_105_1:GetWordFromCfg(413141026)
				local var_108_8 = arg_105_1:FormatText(var_108_7.content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 35 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 35)

				if (35 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 35)) > 0 and var_108_6 < var_108_10 then
					arg_105_1.talkMaxDuration = var_108_10

					if var_108_10 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_5
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141026", "story_v_out_413141.awb") ~= 0 then
					local var_108_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141026", "story_v_out_413141.awb") / 1000

					if var_108_11 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_5
					end

					if var_108_7.prefab_name ~= "" and arg_105_1.actors_[var_108_7.prefab_name] ~= nil then
						local var_108_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_7.prefab_name].transform, "story_v_out_413141", "413141026", "story_v_out_413141.awb")

						arg_105_1:RecordAudio("413141026", var_108_12)
						arg_105_1:RecordAudio("413141026", var_108_12)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413141", "413141026", "story_v_out_413141.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413141", "413141026", "story_v_out_413141.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = math.max(var_108_6, arg_105_1.talkMaxDuration)

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_13 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_5) / var_108_13

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_5 + var_108_13 and arg_105_1.time_ < var_108_5 + var_108_13 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play413141027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413141027
		arg_109_1.duration_ = 14.97

		local var_109_0 = {
			zh = 6.5,
			ja = 14.966
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play413141028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10092_1 = arg_109_1.actors_["10092_1"].transform.localPosition
				arg_109_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_112_0 = 0, arg_109_1.actors_["10092_1"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["10092_1"].transform:GetChild(iter_112_0)

					if var_112_0.name == "split_1_1" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_109_1.time_ - 0) / var_112_1)
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_112_2 = arg_109_1.actors_["10092_1"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps10092_1 == nil then
				arg_109_1.var_.actorSpriteComps10092_1 = var_112_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_3 = 2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.actorSpriteComps10092_1 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								iter_112_2.color = Color.New(Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_3), Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_3), (Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_3)))
							else
								local var_112_4 = Mathf.Lerp(iter_112_2.color.r, 1, (arg_109_1.time_ - 0) / var_112_3)

								iter_112_2.color = Color.New(var_112_4, var_112_4, var_112_4)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps10092_1 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_112_4 then
						iter_112_4.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_112_5 = 0
			local var_112_6 = 0.775

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_7 = arg_109_1:GetWordFromCfg(413141027)
				local var_112_8 = arg_109_1:FormatText(var_112_7.content)

				arg_109_1.text_.text = var_112_8

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 31 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 31)

				if (31 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 31)) > 0 and var_112_6 < var_112_10 then
					arg_109_1.talkMaxDuration = var_112_10

					if var_112_10 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_5
					end
				end

				arg_109_1.text_.text = var_112_8
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141027", "story_v_out_413141.awb") ~= 0 then
					local var_112_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141027", "story_v_out_413141.awb") / 1000

					if var_112_11 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_5
					end

					if var_112_7.prefab_name ~= "" and arg_109_1.actors_[var_112_7.prefab_name] ~= nil then
						local var_112_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_7.prefab_name].transform, "story_v_out_413141", "413141027", "story_v_out_413141.awb")

						arg_109_1:RecordAudio("413141027", var_112_12)
						arg_109_1:RecordAudio("413141027", var_112_12)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413141", "413141027", "story_v_out_413141.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413141", "413141027", "story_v_out_413141.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_13 = math.max(var_112_6, arg_109_1.talkMaxDuration)

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_13 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_5) / var_112_13

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_5 + var_112_13 and arg_109_1.time_ < var_112_5 + var_112_13 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play413141028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413141028
		arg_113_1.duration_ = 6.33

		local var_113_0 = {
			zh = 4.733,
			ja = 6.333
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
				arg_113_0:Play413141029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10092_1 = arg_113_1.actors_["10092_1"].transform.localPosition
				arg_113_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_116_0 = 0, arg_113_1.actors_["10092_1"].transform.childCount - 1 do
					local var_116_0 = arg_113_1.actors_["10092_1"].transform:GetChild(iter_116_0)

					if var_116_0.name == "split_1_1" or not string.find(var_116_0.name, "split") then
						var_116_0.gameObject:SetActive(true)
					else
						var_116_0.gameObject:SetActive(false)
					end
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_113_1.time_ - 0) / var_116_1)
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_116_2 = arg_113_1.actors_["10092_1"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10092_1 == nil then
				arg_113_1.var_.actorSpriteComps10092_1 = var_116_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_3 = 2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.actorSpriteComps10092_1 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								iter_116_2.color = Color.New(Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_3), Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_3), (Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_3)))
							else
								local var_116_4 = Mathf.Lerp(iter_116_2.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_3)

								iter_116_2.color = Color.New(var_116_4, var_116_4, var_116_4)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10092_1 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_116_4 then
						iter_116_4.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_116_5 = arg_113_1.actors_["10093"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.actorSpriteComps10093 == nil then
				arg_113_1.var_.actorSpriteComps10093 = var_116_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_6 = 2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 and not isNil(var_116_5) then
				if arg_113_1.var_.actorSpriteComps10093 then
					for iter_116_5, iter_116_6 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_116_6 then
							if arg_113_1.isInRecall_ then
								iter_116_6.color = Color.New(Mathf.Lerp(iter_116_6.color.r, arg_113_1.hightColor1.r, (arg_113_1.time_ - 0) / var_116_6), Mathf.Lerp(iter_116_6.color.g, arg_113_1.hightColor1.g, (arg_113_1.time_ - 0) / var_116_6), (Mathf.Lerp(iter_116_6.color.b, arg_113_1.hightColor1.b, (arg_113_1.time_ - 0) / var_116_6)))
							else
								local var_116_7 = Mathf.Lerp(iter_116_6.color.r, 1, (arg_113_1.time_ - 0) / var_116_6)

								iter_116_6.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.actorSpriteComps10093 then
				for iter_116_7, iter_116_8 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_116_8 then
						iter_116_8.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps10093 = nil
			end

			local var_116_8 = arg_113_1.actors_["10093"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10093 = var_116_8.localPosition
				var_116_8.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10093", 4)

				for iter_116_9 = 0, var_116_8.childCount - 1 do
					local var_116_9 = var_116_8:GetChild(iter_116_9)

					if var_116_9.name == "split_4" or not string.find(var_116_9.name, "split") then
						var_116_9.gameObject:SetActive(true)
					else
						var_116_9.gameObject:SetActive(false)
					end
				end
			end

			local var_116_10 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_10 then
				var_116_8.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_113_1.time_ - 0) / var_116_10)
			end

			if arg_113_1.time_ >= 0 + var_116_10 and arg_113_1.time_ < 0 + var_116_10 + arg_116_0 then
				var_116_8.localPosition = Vector3.New(390, -345, -245)
			end

			local var_116_11 = 0
			local var_116_12 = 0.6

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_11 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_13 = arg_113_1:GetWordFromCfg(413141028)
				local var_116_14 = arg_113_1:FormatText(var_116_13.content)

				arg_113_1.text_.text = var_116_14

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_16 = 24 <= 0 and var_116_12 or var_116_12 * (utf8.len(var_116_14) / 24)

				if (24 <= 0 and var_116_12 or var_116_12 * (utf8.len(var_116_14) / 24)) > 0 and var_116_12 < var_116_16 then
					arg_113_1.talkMaxDuration = var_116_16

					if var_116_16 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_16 + var_116_11
					end
				end

				arg_113_1.text_.text = var_116_14
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141028", "story_v_out_413141.awb") ~= 0 then
					local var_116_17 = manager.audio:GetVoiceLength("story_v_out_413141", "413141028", "story_v_out_413141.awb") / 1000

					if var_116_17 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_17 + var_116_11
					end

					if var_116_13.prefab_name ~= "" and arg_113_1.actors_[var_116_13.prefab_name] ~= nil then
						local var_116_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_13.prefab_name].transform, "story_v_out_413141", "413141028", "story_v_out_413141.awb")

						arg_113_1:RecordAudio("413141028", var_116_18)
						arg_113_1:RecordAudio("413141028", var_116_18)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413141", "413141028", "story_v_out_413141.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413141", "413141028", "story_v_out_413141.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_19 = math.max(var_116_12, arg_113_1.talkMaxDuration)

			if var_116_11 <= arg_113_1.time_ and arg_113_1.time_ < var_116_11 + var_116_19 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_11) / var_116_19

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_11 + var_116_19 and arg_113_1.time_ < var_116_11 + var_116_19 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413141029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413141029
		arg_117_1.duration_ = 7.9

		local var_117_0 = {
			zh = 7.033,
			ja = 7.9
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
				arg_117_0:Play413141030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10092_1 = arg_117_1.actors_["10092_1"].transform.localPosition
				arg_117_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_120_0 = 0, arg_117_1.actors_["10092_1"].transform.childCount - 1 do
					local var_120_0 = arg_117_1.actors_["10092_1"].transform:GetChild(iter_120_0)

					if var_120_0.name == "" or not string.find(var_120_0.name, "split") then
						var_120_0.gameObject:SetActive(true)
					else
						var_120_0.gameObject:SetActive(false)
					end
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_117_1.time_ - 0) / var_120_1)
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_120_2 = arg_117_1.actors_["10092_1"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10092_1 == nil then
				arg_117_1.var_.actorSpriteComps10092_1 = var_120_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_3 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.actorSpriteComps10092_1 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								iter_120_2.color = Color.New(Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_3), Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_3), (Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_3)))
							else
								local var_120_4 = Mathf.Lerp(iter_120_2.color.r, 1, (arg_117_1.time_ - 0) / var_120_3)

								iter_120_2.color = Color.New(var_120_4, var_120_4, var_120_4)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10092_1 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_120_4 then
						iter_120_4.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_120_5 = arg_117_1.actors_["10093"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10093 = var_120_5.localPosition
				var_120_5.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10093", 4)

				for iter_120_5 = 0, var_120_5.childCount - 1 do
					local var_120_6 = var_120_5:GetChild(iter_120_5)

					if var_120_6.name == "" or not string.find(var_120_6.name, "split") then
						var_120_6.gameObject:SetActive(true)
					else
						var_120_6.gameObject:SetActive(false)
					end
				end
			end

			local var_120_7 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				var_120_5.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_117_1.time_ - 0) / var_120_7)
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				var_120_5.localPosition = Vector3.New(390, -345, -245)
			end

			local var_120_8 = arg_117_1.actors_["10093"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps10093 == nil then
				arg_117_1.var_.actorSpriteComps10093 = var_120_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_9 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_9 and not isNil(var_120_8) then
				if arg_117_1.var_.actorSpriteComps10093 then
					for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_120_7 then
							if arg_117_1.isInRecall_ then
								iter_120_7.color = Color.New(Mathf.Lerp(iter_120_7.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_9), Mathf.Lerp(iter_120_7.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_9), (Mathf.Lerp(iter_120_7.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_9)))
							else
								local var_120_10 = Mathf.Lerp(iter_120_7.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_9)

								iter_120_7.color = Color.New(var_120_10, var_120_10, var_120_10)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_9 and arg_117_1.time_ < 0 + var_120_9 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps10093 then
				for iter_120_8, iter_120_9 in pairs(arg_117_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_120_9 then
						iter_120_9.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10093 = nil
			end

			local var_120_11 = 0
			local var_120_12 = 0.875

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_13 = arg_117_1:GetWordFromCfg(413141029)
				local var_120_14 = arg_117_1:FormatText(var_120_13.content)

				arg_117_1.text_.text = var_120_14

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_16 = 35 <= 0 and var_120_12 or var_120_12 * (utf8.len(var_120_14) / 35)

				if (35 <= 0 and var_120_12 or var_120_12 * (utf8.len(var_120_14) / 35)) > 0 and var_120_12 < var_120_16 then
					arg_117_1.talkMaxDuration = var_120_16

					if var_120_16 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_16 + var_120_11
					end
				end

				arg_117_1.text_.text = var_120_14
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141029", "story_v_out_413141.awb") ~= 0 then
					local var_120_17 = manager.audio:GetVoiceLength("story_v_out_413141", "413141029", "story_v_out_413141.awb") / 1000

					if var_120_17 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_17 + var_120_11
					end

					if var_120_13.prefab_name ~= "" and arg_117_1.actors_[var_120_13.prefab_name] ~= nil then
						local var_120_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_13.prefab_name].transform, "story_v_out_413141", "413141029", "story_v_out_413141.awb")

						arg_117_1:RecordAudio("413141029", var_120_18)
						arg_117_1:RecordAudio("413141029", var_120_18)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_413141", "413141029", "story_v_out_413141.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_413141", "413141029", "story_v_out_413141.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_19 = math.max(var_120_12, arg_117_1.talkMaxDuration)

			if var_120_11 <= arg_117_1.time_ and arg_117_1.time_ < var_120_11 + var_120_19 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_11) / var_120_19

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_11 + var_120_19 and arg_117_1.time_ < var_120_11 + var_120_19 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413141030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 413141030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play413141031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10092_1"]) and arg_121_1.var_.actorSpriteComps10092_1 == nil then
				arg_121_1.var_.actorSpriteComps10092_1 = arg_121_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_0 = 2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10092_1"]) then
				if arg_121_1.var_.actorSpriteComps10092_1 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10092_1"]) and arg_121_1.var_.actorSpriteComps10092_1 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_124_2 = arg_121_1.actors_["10092_1"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10092_1 = var_124_2.localPosition
				var_124_2.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_124_4 = 0, var_124_2.childCount - 1 do
					local var_124_3 = var_124_2:GetChild(iter_124_4)

					if var_124_3.name == "split_2" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_121_1.time_ - 0) / var_124_4)
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_5 = arg_121_1.actors_["10093"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10093 = var_124_5.localPosition
				var_124_5.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10093", 7)

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
				var_124_5.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_121_1.time_ - 0) / var_124_7)
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				var_124_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_8 = 0
			local var_124_9 = 1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(413141030).content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_12 = 40 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_10) / 40)

				if (40 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_10) / 40)) > 0 and var_124_9 < var_124_12 then
					arg_121_1.talkMaxDuration = var_124_12

					if var_124_12 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_13 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_13 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_13

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_13 and arg_121_1.time_ < var_124_8 + var_124_13 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413141031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 413141031
		arg_125_1.duration_ = 7.8

		local var_125_0 = {
			zh = 3.9,
			ja = 7.8
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play413141032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10092_1 = arg_125_1.actors_["10092_1"].transform.localPosition
				arg_125_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_128_0 = 0, arg_125_1.actors_["10092_1"].transform.childCount - 1 do
					local var_128_0 = arg_125_1.actors_["10092_1"].transform:GetChild(iter_128_0)

					if var_128_0.name == "" or not string.find(var_128_0.name, "split") then
						var_128_0.gameObject:SetActive(true)
					else
						var_128_0.gameObject:SetActive(false)
					end
				end
			end

			local var_128_1 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 then
				arg_125_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_125_1.time_ - 0) / var_128_1)
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 then
				arg_125_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_128_2 = arg_125_1.actors_["10092_1"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps10092_1 == nil then
				arg_125_1.var_.actorSpriteComps10092_1 = var_128_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_3 = 2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.actorSpriteComps10092_1 then
					for iter_128_1, iter_128_2 in pairs(arg_125_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_128_2 then
							if arg_125_1.isInRecall_ then
								iter_128_2.color = Color.New(Mathf.Lerp(iter_128_2.color.r, arg_125_1.hightColor1.r, (arg_125_1.time_ - 0) / var_128_3), Mathf.Lerp(iter_128_2.color.g, arg_125_1.hightColor1.g, (arg_125_1.time_ - 0) / var_128_3), (Mathf.Lerp(iter_128_2.color.b, arg_125_1.hightColor1.b, (arg_125_1.time_ - 0) / var_128_3)))
							else
								local var_128_4 = Mathf.Lerp(iter_128_2.color.r, 1, (arg_125_1.time_ - 0) / var_128_3)

								iter_128_2.color = Color.New(var_128_4, var_128_4, var_128_4)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.actorSpriteComps10092_1 then
				for iter_128_3, iter_128_4 in pairs(arg_125_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_128_4 then
						iter_128_4.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_125_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_128_5 = 0
			local var_128_6 = 0.55

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_7 = arg_125_1:GetWordFromCfg(413141031)
				local var_128_8 = arg_125_1:FormatText(var_128_7.content)

				arg_125_1.text_.text = var_128_8

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_10 = 22 <= 0 and var_128_6 or var_128_6 * (utf8.len(var_128_8) / 22)

				if (22 <= 0 and var_128_6 or var_128_6 * (utf8.len(var_128_8) / 22)) > 0 and var_128_6 < var_128_10 then
					arg_125_1.talkMaxDuration = var_128_10

					if var_128_10 + var_128_5 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_5
					end
				end

				arg_125_1.text_.text = var_128_8
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141031", "story_v_out_413141.awb") ~= 0 then
					local var_128_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141031", "story_v_out_413141.awb") / 1000

					if var_128_11 + var_128_5 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_5
					end

					if var_128_7.prefab_name ~= "" and arg_125_1.actors_[var_128_7.prefab_name] ~= nil then
						local var_128_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_7.prefab_name].transform, "story_v_out_413141", "413141031", "story_v_out_413141.awb")

						arg_125_1:RecordAudio("413141031", var_128_12)
						arg_125_1:RecordAudio("413141031", var_128_12)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_413141", "413141031", "story_v_out_413141.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_413141", "413141031", "story_v_out_413141.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_13 = math.max(var_128_6, arg_125_1.talkMaxDuration)

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_13 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_5) / var_128_13

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_5 + var_128_13 and arg_125_1.time_ < var_128_5 + var_128_13 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play413141032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413141032
		arg_129_1.duration_ = 7.8

		local var_129_0 = {
			zh = 5.333,
			ja = 7.8
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
				arg_129_0:Play413141033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.625

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(413141032)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 25 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 25)

				if (25 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 25)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141032", "story_v_out_413141.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141032", "story_v_out_413141.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_413141", "413141032", "story_v_out_413141.awb")

						arg_129_1:RecordAudio("413141032", var_132_6)
						arg_129_1:RecordAudio("413141032", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413141", "413141032", "story_v_out_413141.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413141", "413141032", "story_v_out_413141.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play413141033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413141033
		arg_133_1.duration_ = 16.2

		local var_133_0 = {
			zh = 8.233,
			ja = 16.2
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
				arg_133_0:Play413141034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10092_1"]) and arg_133_1.var_.actorSpriteComps10092_1 == nil then
				arg_133_1.var_.actorSpriteComps10092_1 = arg_133_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_0 = 2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10092_1"]) then
				if arg_133_1.var_.actorSpriteComps10092_1 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								iter_136_1.color = Color.New(Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor1.r, (arg_133_1.time_ - 0) / var_136_0), Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor1.g, (arg_133_1.time_ - 0) / var_136_0), (Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor1.b, (arg_133_1.time_ - 0) / var_136_0)))
							else
								local var_136_1 = Mathf.Lerp(iter_136_1.color.r, 1, (arg_133_1.time_ - 0) / var_136_0)

								iter_136_1.color = Color.New(var_136_1, var_136_1, var_136_1)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10092_1"]) and arg_133_1.var_.actorSpriteComps10092_1 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_136_3 then
						iter_136_3.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_133_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_136_2 = 0
			local var_136_3 = 0.975

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:GetWordFromCfg(413141033)
				local var_136_5 = arg_133_1:FormatText(var_136_4.content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 39 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 39)

				if (39 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 39)) > 0 and var_136_3 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141033", "story_v_out_413141.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141033", "story_v_out_413141.awb") / 1000

					if var_136_8 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_2
					end

					if var_136_4.prefab_name ~= "" and arg_133_1.actors_[var_136_4.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_4.prefab_name].transform, "story_v_out_413141", "413141033", "story_v_out_413141.awb")

						arg_133_1:RecordAudio("413141033", var_136_9)
						arg_133_1:RecordAudio("413141033", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_413141", "413141033", "story_v_out_413141.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_413141", "413141033", "story_v_out_413141.awb")
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

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play413141034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413141034
		arg_137_1.duration_ = 2

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play413141035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10092_1 = arg_137_1.actors_["10092_1"].transform.localPosition
				arg_137_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_140_0 = 0, arg_137_1.actors_["10092_1"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["10092_1"].transform:GetChild(iter_140_0)

					if var_140_0.name == "" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_140_2 = arg_137_1.actors_["10093"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10093 = var_140_2.localPosition
				var_140_2.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10093", 4)

				for iter_140_1 = 0, var_140_2.childCount - 1 do
					local var_140_3 = var_140_2:GetChild(iter_140_1)

					if var_140_3.name == "" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				var_140_2.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_137_1.time_ - 0) / var_140_4)
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				var_140_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_140_5 = arg_137_1.actors_["10092_1"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.actorSpriteComps10092_1 == nil then
				arg_137_1.var_.actorSpriteComps10092_1 = var_140_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_6 = 2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_6 and not isNil(var_140_5) then
				if arg_137_1.var_.actorSpriteComps10092_1 then
					for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_140_3 then
							if arg_137_1.isInRecall_ then
								iter_140_3.color = Color.New(Mathf.Lerp(iter_140_3.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 0) / var_140_6), Mathf.Lerp(iter_140_3.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 0) / var_140_6), (Mathf.Lerp(iter_140_3.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 0) / var_140_6)))
							else
								local var_140_7 = Mathf.Lerp(iter_140_3.color.r, 0.5, (arg_137_1.time_ - 0) / var_140_6)

								iter_140_3.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_6 and arg_137_1.time_ < 0 + var_140_6 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.actorSpriteComps10092_1 then
				for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_140_5 then
						iter_140_5.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_140_8 = arg_137_1.actors_["10093"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps10093 == nil then
				arg_137_1.var_.actorSpriteComps10093 = var_140_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_9 = 2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_9 and not isNil(var_140_8) then
				if arg_137_1.var_.actorSpriteComps10093 then
					for iter_140_6, iter_140_7 in pairs(arg_137_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_140_7 then
							if arg_137_1.isInRecall_ then
								iter_140_7.color = Color.New(Mathf.Lerp(iter_140_7.color.r, arg_137_1.hightColor1.r, (arg_137_1.time_ - 0) / var_140_9), Mathf.Lerp(iter_140_7.color.g, arg_137_1.hightColor1.g, (arg_137_1.time_ - 0) / var_140_9), (Mathf.Lerp(iter_140_7.color.b, arg_137_1.hightColor1.b, (arg_137_1.time_ - 0) / var_140_9)))
							else
								local var_140_10 = Mathf.Lerp(iter_140_7.color.r, 1, (arg_137_1.time_ - 0) / var_140_9)

								iter_140_7.color = Color.New(var_140_10, var_140_10, var_140_10)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_9 and arg_137_1.time_ < 0 + var_140_9 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.actorSpriteComps10093 then
				for iter_140_8, iter_140_9 in pairs(arg_137_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_140_9 then
						iter_140_9.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps10093 = nil
			end

			local var_140_11 = 0
			local var_140_12 = 0.1

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_11 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_13 = arg_137_1:GetWordFromCfg(413141034)
				local var_140_14 = arg_137_1:FormatText(var_140_13.content)

				arg_137_1.text_.text = var_140_14

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_16 = 4 <= 0 and var_140_12 or var_140_12 * (utf8.len(var_140_14) / 4)

				if (4 <= 0 and var_140_12 or var_140_12 * (utf8.len(var_140_14) / 4)) > 0 and var_140_12 < var_140_16 then
					arg_137_1.talkMaxDuration = var_140_16

					if var_140_16 + var_140_11 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_16 + var_140_11
					end
				end

				arg_137_1.text_.text = var_140_14
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141034", "story_v_out_413141.awb") ~= 0 then
					local var_140_17 = manager.audio:GetVoiceLength("story_v_out_413141", "413141034", "story_v_out_413141.awb") / 1000

					if var_140_17 + var_140_11 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_17 + var_140_11
					end

					if var_140_13.prefab_name ~= "" and arg_137_1.actors_[var_140_13.prefab_name] ~= nil then
						local var_140_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_13.prefab_name].transform, "story_v_out_413141", "413141034", "story_v_out_413141.awb")

						arg_137_1:RecordAudio("413141034", var_140_18)
						arg_137_1:RecordAudio("413141034", var_140_18)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_413141", "413141034", "story_v_out_413141.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_413141", "413141034", "story_v_out_413141.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_19 = math.max(var_140_12, arg_137_1.talkMaxDuration)

			if var_140_11 <= arg_137_1.time_ and arg_137_1.time_ < var_140_11 + var_140_19 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_11) / var_140_19

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_11 + var_140_19 and arg_137_1.time_ < var_140_11 + var_140_19 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play413141035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413141035
		arg_141_1.duration_ = 8.4

		local var_141_0 = {
			zh = 5.2,
			ja = 8.4
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
				arg_141_0:Play413141036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10092_1"]) and arg_141_1.var_.actorSpriteComps10092_1 == nil then
				arg_141_1.var_.actorSpriteComps10092_1 = arg_141_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_0 = 2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10092_1"]) then
				if arg_141_1.var_.actorSpriteComps10092_1 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10092_1"]) and arg_141_1.var_.actorSpriteComps10092_1 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_144_3 then
						iter_144_3.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_144_2 = arg_141_1.actors_["10093"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps10093 == nil then
				arg_141_1.var_.actorSpriteComps10093 = var_144_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_3 = 2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.actorSpriteComps10093 then
					for iter_144_4, iter_144_5 in pairs(arg_141_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_144_5 then
							if arg_141_1.isInRecall_ then
								iter_144_5.color = Color.New(Mathf.Lerp(iter_144_5.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_3), Mathf.Lerp(iter_144_5.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_3), (Mathf.Lerp(iter_144_5.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_3)))
							else
								local var_144_4 = Mathf.Lerp(iter_144_5.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_3)

								iter_144_5.color = Color.New(var_144_4, var_144_4, var_144_4)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps10093 then
				for iter_144_6, iter_144_7 in pairs(arg_141_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_144_7 then
						iter_144_7.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps10093 = nil
			end

			local var_144_5 = 0
			local var_144_6 = 0.625

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(413141035)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 25 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 25)

				if (25 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 25)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141035", "story_v_out_413141.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141035", "story_v_out_413141.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_413141", "413141035", "story_v_out_413141.awb")

						arg_141_1:RecordAudio("413141035", var_144_12)
						arg_141_1:RecordAudio("413141035", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413141", "413141035", "story_v_out_413141.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413141", "413141035", "story_v_out_413141.awb")
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

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play413141036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413141036
		arg_145_1.duration_ = 6.2

		local var_145_0 = {
			zh = 1.999999999999,
			ja = 6.2
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
				arg_145_0:Play413141037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10093 = arg_145_1.actors_["10093"].transform.localPosition
				arg_145_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10093", 4)

				for iter_148_0 = 0, arg_145_1.actors_["10093"].transform.childCount - 1 do
					local var_148_0 = arg_145_1.actors_["10093"].transform:GetChild(iter_148_0)

					if var_148_0.name == "split_4" or not string.find(var_148_0.name, "split") then
						var_148_0.gameObject:SetActive(true)
					else
						var_148_0.gameObject:SetActive(false)
					end
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_145_1.time_ - 0) / var_148_1)
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_148_2 = arg_145_1.actors_["10092_1"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps10092_1 == nil then
				arg_145_1.var_.actorSpriteComps10092_1 = var_148_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_3 = 2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.actorSpriteComps10092_1 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_148_2 then
							if arg_145_1.isInRecall_ then
								iter_148_2.color = Color.New(Mathf.Lerp(iter_148_2.color.r, arg_145_1.hightColor2.r, (arg_145_1.time_ - 0) / var_148_3), Mathf.Lerp(iter_148_2.color.g, arg_145_1.hightColor2.g, (arg_145_1.time_ - 0) / var_148_3), (Mathf.Lerp(iter_148_2.color.b, arg_145_1.hightColor2.b, (arg_145_1.time_ - 0) / var_148_3)))
							else
								local var_148_4 = Mathf.Lerp(iter_148_2.color.r, 0.5, (arg_145_1.time_ - 0) / var_148_3)

								iter_148_2.color = Color.New(var_148_4, var_148_4, var_148_4)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps10092_1 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_148_4 then
						iter_148_4.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_145_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_148_5 = arg_145_1.actors_["10093"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.actorSpriteComps10093 == nil then
				arg_145_1.var_.actorSpriteComps10093 = var_148_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_6 = 2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 and not isNil(var_148_5) then
				if arg_145_1.var_.actorSpriteComps10093 then
					for iter_148_5, iter_148_6 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_148_6 then
							if arg_145_1.isInRecall_ then
								iter_148_6.color = Color.New(Mathf.Lerp(iter_148_6.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_6), Mathf.Lerp(iter_148_6.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_6), (Mathf.Lerp(iter_148_6.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_6)))
							else
								local var_148_7 = Mathf.Lerp(iter_148_6.color.r, 1, (arg_145_1.time_ - 0) / var_148_6)

								iter_148_6.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.actorSpriteComps10093 then
				for iter_148_7, iter_148_8 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_148_8 then
						iter_148_8.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps10093 = nil
			end

			local var_148_8 = 0
			local var_148_9 = 0.2

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(413141036)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 8 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 8)

				if (8 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 8)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141036", "story_v_out_413141.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141036", "story_v_out_413141.awb") / 1000

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_413141", "413141036", "story_v_out_413141.awb")

						arg_145_1:RecordAudio("413141036", var_148_15)
						arg_145_1:RecordAudio("413141036", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_413141", "413141036", "story_v_out_413141.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_413141", "413141036", "story_v_out_413141.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_16 and arg_145_1.time_ < var_148_8 + var_148_16 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play413141037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 413141037
		arg_149_1.duration_ = 5.27

		local var_149_0 = {
			zh = 4.1,
			ja = 5.266
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play413141038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10092_1 = arg_149_1.actors_["10092_1"].transform.localPosition
				arg_149_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_152_0 = 0, arg_149_1.actors_["10092_1"].transform.childCount - 1 do
					local var_152_0 = arg_149_1.actors_["10092_1"].transform:GetChild(iter_152_0)

					if var_152_0.name == "split_1_1" or not string.find(var_152_0.name, "split") then
						var_152_0.gameObject:SetActive(true)
					else
						var_152_0.gameObject:SetActive(false)
					end
				end
			end

			local var_152_1 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 then
				arg_149_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_149_1.time_ - 0) / var_152_1)
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 then
				arg_149_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_152_2 = arg_149_1.actors_["10092_1"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps10092_1 == nil then
				arg_149_1.var_.actorSpriteComps10092_1 = var_152_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_3 = 2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.actorSpriteComps10092_1 then
					for iter_152_1, iter_152_2 in pairs(arg_149_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_152_2 then
							if arg_149_1.isInRecall_ then
								iter_152_2.color = Color.New(Mathf.Lerp(iter_152_2.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_3), Mathf.Lerp(iter_152_2.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_3), (Mathf.Lerp(iter_152_2.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_3)))
							else
								local var_152_4 = Mathf.Lerp(iter_152_2.color.r, 1, (arg_149_1.time_ - 0) / var_152_3)

								iter_152_2.color = Color.New(var_152_4, var_152_4, var_152_4)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps10092_1 then
				for iter_152_3, iter_152_4 in pairs(arg_149_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_152_4 then
						iter_152_4.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_152_5 = arg_149_1.actors_["10093"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.actorSpriteComps10093 == nil then
				arg_149_1.var_.actorSpriteComps10093 = var_152_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_6 = 2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_6 and not isNil(var_152_5) then
				if arg_149_1.var_.actorSpriteComps10093 then
					for iter_152_5, iter_152_6 in pairs(arg_149_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_152_6 then
							if arg_149_1.isInRecall_ then
								iter_152_6.color = Color.New(Mathf.Lerp(iter_152_6.color.r, arg_149_1.hightColor2.r, (arg_149_1.time_ - 0) / var_152_6), Mathf.Lerp(iter_152_6.color.g, arg_149_1.hightColor2.g, (arg_149_1.time_ - 0) / var_152_6), (Mathf.Lerp(iter_152_6.color.b, arg_149_1.hightColor2.b, (arg_149_1.time_ - 0) / var_152_6)))
							else
								local var_152_7 = Mathf.Lerp(iter_152_6.color.r, 0.5, (arg_149_1.time_ - 0) / var_152_6)

								iter_152_6.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_6 and arg_149_1.time_ < 0 + var_152_6 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.actorSpriteComps10093 then
				for iter_152_7, iter_152_8 in pairs(arg_149_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_152_8 then
						iter_152_8.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps10093 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 0.475

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:GetWordFromCfg(413141037)
				local var_152_11 = arg_149_1:FormatText(var_152_10.content)

				arg_149_1.text_.text = var_152_11

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 19 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 19)

				if (19 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 19)) > 0 and var_152_9 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_11
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141037", "story_v_out_413141.awb") ~= 0 then
					local var_152_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141037", "story_v_out_413141.awb") / 1000

					if var_152_14 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_8
					end

					if var_152_10.prefab_name ~= "" and arg_149_1.actors_[var_152_10.prefab_name] ~= nil then
						local var_152_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_10.prefab_name].transform, "story_v_out_413141", "413141037", "story_v_out_413141.awb")

						arg_149_1:RecordAudio("413141037", var_152_15)
						arg_149_1:RecordAudio("413141037", var_152_15)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_413141", "413141037", "story_v_out_413141.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_413141", "413141037", "story_v_out_413141.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_16 and arg_149_1.time_ < var_152_8 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play413141038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413141038
		arg_153_1.duration_ = 10.03

		local var_153_0 = {
			zh = 7.6,
			ja = 10.033
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
				arg_153_0:Play413141039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(413141038)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 40 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 40)

				if (40 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 40)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141038", "story_v_out_413141.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141038", "story_v_out_413141.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_413141", "413141038", "story_v_out_413141.awb")

						arg_153_1:RecordAudio("413141038", var_156_6)
						arg_153_1:RecordAudio("413141038", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_413141", "413141038", "story_v_out_413141.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_413141", "413141038", "story_v_out_413141.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play413141039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413141039
		arg_157_1.duration_ = 5.87

		local var_157_0 = {
			zh = 4.966,
			ja = 5.866
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play413141040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.675

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:GetWordFromCfg(413141039)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 27 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 27)

				if (27 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 27)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141039", "story_v_out_413141.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141039", "story_v_out_413141.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_413141", "413141039", "story_v_out_413141.awb")

						arg_157_1:RecordAudio("413141039", var_160_6)
						arg_157_1:RecordAudio("413141039", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_413141", "413141039", "story_v_out_413141.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_413141", "413141039", "story_v_out_413141.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play413141040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 413141040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play413141041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10092_1 = arg_161_1.actors_["10092_1"].transform.localPosition
				arg_161_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10092_1", 6)

				for iter_164_0 = 0, arg_161_1.actors_["10092_1"].transform.childCount - 1 do
					local var_164_0 = arg_161_1.actors_["10092_1"].transform:GetChild(iter_164_0)

					if var_164_0.name == "" or not string.find(var_164_0.name, "split") then
						var_164_0.gameObject:SetActive(true)
					else
						var_164_0.gameObject:SetActive(false)
					end
				end
			end

			local var_164_1 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 then
				arg_161_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10092_1, Vector3.New(1500, -300, -295), (arg_161_1.time_ - 0) / var_164_1)
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 then
				arg_161_1.actors_["10092_1"].transform.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_164_2 = arg_161_1.actors_["10093"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10093 = var_164_2.localPosition
				var_164_2.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10093", 7)

				for iter_164_1 = 0, var_164_2.childCount - 1 do
					local var_164_3 = var_164_2:GetChild(iter_164_1)

					if var_164_3.name == "" or not string.find(var_164_3.name, "split") then
						var_164_3.gameObject:SetActive(true)
					else
						var_164_3.gameObject:SetActive(false)
					end
				end
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_2.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_161_1.time_ - 0) / var_164_4)
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_164_5 = arg_161_1.actors_["10092"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.actorSpriteComps10092 == nil then
				arg_161_1.var_.actorSpriteComps10092 = var_164_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_6 = 2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 and not isNil(var_164_5) then
				if arg_161_1.var_.actorSpriteComps10092 then
					for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_164_3 then
							if arg_161_1.isInRecall_ then
								iter_164_3.color = Color.New(Mathf.Lerp(iter_164_3.color.r, arg_161_1.hightColor2.r, (arg_161_1.time_ - 0) / var_164_6), Mathf.Lerp(iter_164_3.color.g, arg_161_1.hightColor2.g, (arg_161_1.time_ - 0) / var_164_6), (Mathf.Lerp(iter_164_3.color.b, arg_161_1.hightColor2.b, (arg_161_1.time_ - 0) / var_164_6)))
							else
								local var_164_7 = Mathf.Lerp(iter_164_3.color.r, 0.5, (arg_161_1.time_ - 0) / var_164_6)

								iter_164_3.color = Color.New(var_164_7, var_164_7, var_164_7)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.actorSpriteComps10092 then
				for iter_164_4, iter_164_5 in pairs(arg_161_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_164_5 then
						iter_164_5.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_161_1.var_.actorSpriteComps10092 = nil
			end

			local var_164_8 = arg_161_1.actors_["10093"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps10093 == nil then
				arg_161_1.var_.actorSpriteComps10093 = var_164_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_9 = 2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_9 and not isNil(var_164_8) then
				if arg_161_1.var_.actorSpriteComps10093 then
					for iter_164_6, iter_164_7 in pairs(arg_161_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_164_7 then
							if arg_161_1.isInRecall_ then
								iter_164_7.color = Color.New(Mathf.Lerp(iter_164_7.color.r, arg_161_1.hightColor2.r, (arg_161_1.time_ - 0) / var_164_9), Mathf.Lerp(iter_164_7.color.g, arg_161_1.hightColor2.g, (arg_161_1.time_ - 0) / var_164_9), (Mathf.Lerp(iter_164_7.color.b, arg_161_1.hightColor2.b, (arg_161_1.time_ - 0) / var_164_9)))
							else
								local var_164_10 = Mathf.Lerp(iter_164_7.color.r, 0.5, (arg_161_1.time_ - 0) / var_164_9)

								iter_164_7.color = Color.New(var_164_10, var_164_10, var_164_10)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_9 and arg_161_1.time_ < 0 + var_164_9 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps10093 then
				for iter_164_8, iter_164_9 in pairs(arg_161_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_164_9 then
						iter_164_9.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_161_1.var_.actorSpriteComps10093 = nil
			end

			local var_164_11 = 0
			local var_164_12 = 0.825

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_13 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(413141040).content)

				arg_161_1.text_.text = var_164_13

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_15 = 33 <= 0 and var_164_12 or var_164_12 * (utf8.len(var_164_13) / 33)

				if (33 <= 0 and var_164_12 or var_164_12 * (utf8.len(var_164_13) / 33)) > 0 and var_164_12 < var_164_15 then
					arg_161_1.talkMaxDuration = var_164_15

					if var_164_15 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_15 + var_164_11
					end
				end

				arg_161_1.text_.text = var_164_13
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_12, arg_161_1.talkMaxDuration)

			if var_164_11 <= arg_161_1.time_ and arg_161_1.time_ < var_164_11 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_11) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_11 + var_164_16 and arg_161_1.time_ < var_164_11 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play413141041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 413141041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play413141042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.875

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(413141041).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 35 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 35)

				if (35 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 35)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play413141042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 413141042
		arg_169_1.duration_ = 7.93

		local var_169_0 = {
			zh = 5.266,
			ja = 7.933
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play413141043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10092_1 = arg_169_1.actors_["10092_1"].transform.localPosition
				arg_169_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_172_0 = 0, arg_169_1.actors_["10092_1"].transform.childCount - 1 do
					local var_172_0 = arg_169_1.actors_["10092_1"].transform:GetChild(iter_172_0)

					if var_172_0.name == "" or not string.find(var_172_0.name, "split") then
						var_172_0.gameObject:SetActive(true)
					else
						var_172_0.gameObject:SetActive(false)
					end
				end
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				arg_169_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_169_1.time_ - 0) / var_172_1)
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_172_2 = arg_169_1.actors_["10092"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps10092 == nil then
				arg_169_1.var_.actorSpriteComps10092 = var_172_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_3 = 2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.actorSpriteComps10092 then
					for iter_172_1, iter_172_2 in pairs(arg_169_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_172_2 then
							if arg_169_1.isInRecall_ then
								iter_172_2.color = Color.New(Mathf.Lerp(iter_172_2.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_3), Mathf.Lerp(iter_172_2.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_3), (Mathf.Lerp(iter_172_2.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_3)))
							else
								local var_172_4 = Mathf.Lerp(iter_172_2.color.r, 1, (arg_169_1.time_ - 0) / var_172_3)

								iter_172_2.color = Color.New(var_172_4, var_172_4, var_172_4)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps10092 then
				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_172_4 then
						iter_172_4.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps10092 = nil
			end

			local var_172_5 = 0
			local var_172_6 = 0.675

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_7 = arg_169_1:GetWordFromCfg(413141042)
				local var_172_8 = arg_169_1:FormatText(var_172_7.content)

				arg_169_1.text_.text = var_172_8

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_10 = 27 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_8) / 27)

				if (27 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_8) / 27)) > 0 and var_172_6 < var_172_10 then
					arg_169_1.talkMaxDuration = var_172_10

					if var_172_10 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_5
					end
				end

				arg_169_1.text_.text = var_172_8
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141042", "story_v_out_413141.awb") ~= 0 then
					local var_172_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141042", "story_v_out_413141.awb") / 1000

					if var_172_11 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_5
					end

					if var_172_7.prefab_name ~= "" and arg_169_1.actors_[var_172_7.prefab_name] ~= nil then
						local var_172_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_7.prefab_name].transform, "story_v_out_413141", "413141042", "story_v_out_413141.awb")

						arg_169_1:RecordAudio("413141042", var_172_12)
						arg_169_1:RecordAudio("413141042", var_172_12)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_413141", "413141042", "story_v_out_413141.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_413141", "413141042", "story_v_out_413141.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_13 = math.max(var_172_6, arg_169_1.talkMaxDuration)

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_13 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_5) / var_172_13

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_5 + var_172_13 and arg_169_1.time_ < var_172_5 + var_172_13 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play413141043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 413141043
		arg_173_1.duration_ = 10.97

		local var_173_0 = {
			zh = 7.833,
			ja = 10.966
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play413141044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.925

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:GetWordFromCfg(413141043)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 37 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 37)

				if (37 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 37)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141043", "story_v_out_413141.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141043", "story_v_out_413141.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_413141", "413141043", "story_v_out_413141.awb")

						arg_173_1:RecordAudio("413141043", var_176_6)
						arg_173_1:RecordAudio("413141043", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_413141", "413141043", "story_v_out_413141.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_413141", "413141043", "story_v_out_413141.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play413141044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 413141044
		arg_177_1.duration_ = 5.77

		local var_177_0 = {
			zh = 4.3,
			ja = 5.766
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
				arg_177_0:Play413141045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.5

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(413141044)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 20 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 20)

				if (20 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 20)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141044", "story_v_out_413141.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141044", "story_v_out_413141.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_413141", "413141044", "story_v_out_413141.awb")

						arg_177_1:RecordAudio("413141044", var_180_6)
						arg_177_1:RecordAudio("413141044", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_413141", "413141044", "story_v_out_413141.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_413141", "413141044", "story_v_out_413141.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play413141045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 413141045
		arg_181_1.duration_ = 2.5

		local var_181_0 = {
			zh = 2.266,
			ja = 2.5
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
				arg_181_0:Play413141046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10092_1 = arg_181_1.actors_["10092_1"].transform.localPosition
				arg_181_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_184_0 = 0, arg_181_1.actors_["10092_1"].transform.childCount - 1 do
					local var_184_0 = arg_181_1.actors_["10092_1"].transform:GetChild(iter_184_0)

					if var_184_0.name == "split_1_1" or not string.find(var_184_0.name, "split") then
						var_184_0.gameObject:SetActive(true)
					else
						var_184_0.gameObject:SetActive(false)
					end
				end
			end

			local var_184_1 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 then
				arg_181_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_181_1.time_ - 0) / var_184_1)
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 then
				arg_181_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_184_2 = arg_181_1.actors_["10093"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10093 = var_184_2.localPosition
				var_184_2.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10093", 4)

				for iter_184_1 = 0, var_184_2.childCount - 1 do
					local var_184_3 = var_184_2:GetChild(iter_184_1)

					if var_184_3.name == "split_4" or not string.find(var_184_3.name, "split") then
						var_184_3.gameObject:SetActive(true)
					else
						var_184_3.gameObject:SetActive(false)
					end
				end
			end

			local var_184_4 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				var_184_2.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_181_1.time_ - 0) / var_184_4)
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				var_184_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_184_5 = arg_181_1.actors_["10092_1"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps10092_1 == nil then
				arg_181_1.var_.actorSpriteComps10092_1 = var_184_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_6 = 2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_6 and not isNil(var_184_5) then
				if arg_181_1.var_.actorSpriteComps10092_1 then
					for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_184_3 then
							if arg_181_1.isInRecall_ then
								iter_184_3.color = Color.New(Mathf.Lerp(iter_184_3.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_6), Mathf.Lerp(iter_184_3.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_6), (Mathf.Lerp(iter_184_3.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_6)))
							else
								local var_184_7 = Mathf.Lerp(iter_184_3.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_6)

								iter_184_3.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_6 and arg_181_1.time_ < 0 + var_184_6 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps10092_1 then
				for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_184_5 then
						iter_184_5.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_184_8 = arg_181_1.actors_["10093"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps10093 == nil then
				arg_181_1.var_.actorSpriteComps10093 = var_184_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_9 = 2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_9 and not isNil(var_184_8) then
				if arg_181_1.var_.actorSpriteComps10093 then
					for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_184_7 then
							if arg_181_1.isInRecall_ then
								iter_184_7.color = Color.New(Mathf.Lerp(iter_184_7.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_9), Mathf.Lerp(iter_184_7.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_9), (Mathf.Lerp(iter_184_7.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_9)))
							else
								local var_184_10 = Mathf.Lerp(iter_184_7.color.r, 1, (arg_181_1.time_ - 0) / var_184_9)

								iter_184_7.color = Color.New(var_184_10, var_184_10, var_184_10)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_9 and arg_181_1.time_ < 0 + var_184_9 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps10093 then
				for iter_184_8, iter_184_9 in pairs(arg_181_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_184_9 then
						iter_184_9.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps10093 = nil
			end

			local var_184_11 = 0
			local var_184_12 = 0.25

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_11 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_13 = arg_181_1:GetWordFromCfg(413141045)
				local var_184_14 = arg_181_1:FormatText(var_184_13.content)

				arg_181_1.text_.text = var_184_14

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_16 = 10 <= 0 and var_184_12 or var_184_12 * (utf8.len(var_184_14) / 10)

				if (10 <= 0 and var_184_12 or var_184_12 * (utf8.len(var_184_14) / 10)) > 0 and var_184_12 < var_184_16 then
					arg_181_1.talkMaxDuration = var_184_16

					if var_184_16 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_16 + var_184_11
					end
				end

				arg_181_1.text_.text = var_184_14
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141045", "story_v_out_413141.awb") ~= 0 then
					local var_184_17 = manager.audio:GetVoiceLength("story_v_out_413141", "413141045", "story_v_out_413141.awb") / 1000

					if var_184_17 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_17 + var_184_11
					end

					if var_184_13.prefab_name ~= "" and arg_181_1.actors_[var_184_13.prefab_name] ~= nil then
						local var_184_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_13.prefab_name].transform, "story_v_out_413141", "413141045", "story_v_out_413141.awb")

						arg_181_1:RecordAudio("413141045", var_184_18)
						arg_181_1:RecordAudio("413141045", var_184_18)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_413141", "413141045", "story_v_out_413141.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_413141", "413141045", "story_v_out_413141.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_19 = math.max(var_184_12, arg_181_1.talkMaxDuration)

			if var_184_11 <= arg_181_1.time_ and arg_181_1.time_ < var_184_11 + var_184_19 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_11) / var_184_19

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_11 + var_184_19 and arg_181_1.time_ < var_184_11 + var_184_19 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play413141046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413141046
		arg_185_1.duration_ = 12.2

		local var_185_0 = {
			zh = 6.266,
			ja = 12.2
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
				arg_185_0:Play413141047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["10092_1"]) and arg_185_1.var_.actorSpriteComps10092_1 == nil then
				arg_185_1.var_.actorSpriteComps10092_1 = arg_185_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_0 = 2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["10092_1"]) then
				if arg_185_1.var_.actorSpriteComps10092_1 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								iter_188_1.color = Color.New(Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor1.r, (arg_185_1.time_ - 0) / var_188_0), Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor1.g, (arg_185_1.time_ - 0) / var_188_0), (Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor1.b, (arg_185_1.time_ - 0) / var_188_0)))
							else
								local var_188_1 = Mathf.Lerp(iter_188_1.color.r, 1, (arg_185_1.time_ - 0) / var_188_0)

								iter_188_1.color = Color.New(var_188_1, var_188_1, var_188_1)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["10092_1"]) and arg_185_1.var_.actorSpriteComps10092_1 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_188_3 then
						iter_188_3.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_188_2 = arg_185_1.actors_["10093"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10093 == nil then
				arg_185_1.var_.actorSpriteComps10093 = var_188_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_3 = 2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.actorSpriteComps10093 then
					for iter_188_4, iter_188_5 in pairs(arg_185_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_188_5 then
							if arg_185_1.isInRecall_ then
								iter_188_5.color = Color.New(Mathf.Lerp(iter_188_5.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_3), Mathf.Lerp(iter_188_5.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_3), (Mathf.Lerp(iter_188_5.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_3)))
							else
								local var_188_4 = Mathf.Lerp(iter_188_5.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_3)

								iter_188_5.color = Color.New(var_188_4, var_188_4, var_188_4)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10093 then
				for iter_188_6, iter_188_7 in pairs(arg_185_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_188_7 then
						iter_188_7.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps10093 = nil
			end

			local var_188_5 = 0
			local var_188_6 = 0.7

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_7 = arg_185_1:GetWordFromCfg(413141046)
				local var_188_8 = arg_185_1:FormatText(var_188_7.content)

				arg_185_1.text_.text = var_188_8

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_10 = 28 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_8) / 28)

				if (28 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_8) / 28)) > 0 and var_188_6 < var_188_10 then
					arg_185_1.talkMaxDuration = var_188_10

					if var_188_10 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_5
					end
				end

				arg_185_1.text_.text = var_188_8
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141046", "story_v_out_413141.awb") ~= 0 then
					local var_188_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141046", "story_v_out_413141.awb") / 1000

					if var_188_11 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_11 + var_188_5
					end

					if var_188_7.prefab_name ~= "" and arg_185_1.actors_[var_188_7.prefab_name] ~= nil then
						local var_188_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_7.prefab_name].transform, "story_v_out_413141", "413141046", "story_v_out_413141.awb")

						arg_185_1:RecordAudio("413141046", var_188_12)
						arg_185_1:RecordAudio("413141046", var_188_12)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_413141", "413141046", "story_v_out_413141.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_413141", "413141046", "story_v_out_413141.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_13 = math.max(var_188_6, arg_185_1.talkMaxDuration)

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_13 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_5) / var_188_13

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_5 + var_188_13 and arg_185_1.time_ < var_188_5 + var_188_13 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play413141047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413141047
		arg_189_1.duration_ = 11.8

		local var_189_0 = {
			zh = 5.4,
			ja = 11.8
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play413141048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10092_1"]) and arg_189_1.var_.actorSpriteComps10092_1 == nil then
				arg_189_1.var_.actorSpriteComps10092_1 = arg_189_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_0 = 2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10092_1"]) then
				if arg_189_1.var_.actorSpriteComps10092_1 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								iter_192_1.color = Color.New(Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_0), Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_0), (Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_0)))
							else
								local var_192_1 = Mathf.Lerp(iter_192_1.color.r, 1, (arg_189_1.time_ - 0) / var_192_0)

								iter_192_1.color = Color.New(var_192_1, var_192_1, var_192_1)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10092_1"]) and arg_189_1.var_.actorSpriteComps10092_1 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_192_2 = 0
			local var_192_3 = 0.625

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_4 = arg_189_1:GetWordFromCfg(413141047)
				local var_192_5 = arg_189_1:FormatText(var_192_4.content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 25 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_5) / 25)

				if (25 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_5) / 25)) > 0 and var_192_3 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_2
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141047", "story_v_out_413141.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141047", "story_v_out_413141.awb") / 1000

					if var_192_8 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_2
					end

					if var_192_4.prefab_name ~= "" and arg_189_1.actors_[var_192_4.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_4.prefab_name].transform, "story_v_out_413141", "413141047", "story_v_out_413141.awb")

						arg_189_1:RecordAudio("413141047", var_192_9)
						arg_189_1:RecordAudio("413141047", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413141", "413141047", "story_v_out_413141.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413141", "413141047", "story_v_out_413141.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_3, arg_189_1.talkMaxDuration)

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_2) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_2 + var_192_10 and arg_189_1.time_ < var_192_2 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play413141048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413141048
		arg_193_1.duration_ = 2.7

		local var_193_0 = {
			zh = 2.566,
			ja = 2.7
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
				arg_193_0:Play413141049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10093 = arg_193_1.actors_["10093"].transform.localPosition
				arg_193_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10093", 4)

				for iter_196_0 = 0, arg_193_1.actors_["10093"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["10093"].transform:GetChild(iter_196_0)

					if var_196_0.name == "split_4" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				arg_193_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_193_1.time_ - 0) / var_196_1)
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_196_2 = arg_193_1.actors_["10092_1"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10092_1 == nil then
				arg_193_1.var_.actorSpriteComps10092_1 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps10092_1 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								iter_196_2.color = Color.New(Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_3), Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_3), (Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_2.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_3)

								iter_196_2.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10092_1 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_196_4 then
						iter_196_4.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_196_5 = arg_193_1.actors_["10093"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps10093 == nil then
				arg_193_1.var_.actorSpriteComps10093 = var_196_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_6 = 2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_6 and not isNil(var_196_5) then
				if arg_193_1.var_.actorSpriteComps10093 then
					for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_196_6 then
							if arg_193_1.isInRecall_ then
								iter_196_6.color = Color.New(Mathf.Lerp(iter_196_6.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_6), Mathf.Lerp(iter_196_6.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_6), (Mathf.Lerp(iter_196_6.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_6)))
							else
								local var_196_7 = Mathf.Lerp(iter_196_6.color.r, 1, (arg_193_1.time_ - 0) / var_196_6)

								iter_196_6.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_6 and arg_193_1.time_ < 0 + var_196_6 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps10093 then
				for iter_196_7, iter_196_8 in pairs(arg_193_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_196_8 then
						iter_196_8.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps10093 = nil
			end

			local var_196_8 = 0
			local var_196_9 = 0.25

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_10 = arg_193_1:GetWordFromCfg(413141048)
				local var_196_11 = arg_193_1:FormatText(var_196_10.content)

				arg_193_1.text_.text = var_196_11

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_13 = 10 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 10)

				if (10 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 10)) > 0 and var_196_9 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_8
					end
				end

				arg_193_1.text_.text = var_196_11
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141048", "story_v_out_413141.awb") ~= 0 then
					local var_196_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141048", "story_v_out_413141.awb") / 1000

					if var_196_14 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_8
					end

					if var_196_10.prefab_name ~= "" and arg_193_1.actors_[var_196_10.prefab_name] ~= nil then
						local var_196_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_10.prefab_name].transform, "story_v_out_413141", "413141048", "story_v_out_413141.awb")

						arg_193_1:RecordAudio("413141048", var_196_15)
						arg_193_1:RecordAudio("413141048", var_196_15)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413141", "413141048", "story_v_out_413141.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413141", "413141048", "story_v_out_413141.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_16 = math.max(var_196_9, arg_193_1.talkMaxDuration)

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_16 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_8) / var_196_16

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_8 + var_196_16 and arg_193_1.time_ < var_196_8 + var_196_16 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413141049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 413141049
		arg_197_1.duration_ = 15.6

		local var_197_0 = {
			zh = 8.233,
			ja = 15.6
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
				arg_197_0:Play413141050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["10092_1"]) and arg_197_1.var_.actorSpriteComps10092_1 == nil then
				arg_197_1.var_.actorSpriteComps10092_1 = arg_197_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_0 = 2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["10092_1"]) then
				if arg_197_1.var_.actorSpriteComps10092_1 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								iter_200_1.color = Color.New(Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor1.r, (arg_197_1.time_ - 0) / var_200_0), Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor1.g, (arg_197_1.time_ - 0) / var_200_0), (Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor1.b, (arg_197_1.time_ - 0) / var_200_0)))
							else
								local var_200_1 = Mathf.Lerp(iter_200_1.color.r, 1, (arg_197_1.time_ - 0) / var_200_0)

								iter_200_1.color = Color.New(var_200_1, var_200_1, var_200_1)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["10092_1"]) and arg_197_1.var_.actorSpriteComps10092_1 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_200_3 then
						iter_200_3.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_197_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_200_2 = arg_197_1.actors_["10093"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10093 == nil then
				arg_197_1.var_.actorSpriteComps10093 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps10093 then
					for iter_200_4, iter_200_5 in pairs(arg_197_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_200_5 then
							if arg_197_1.isInRecall_ then
								iter_200_5.color = Color.New(Mathf.Lerp(iter_200_5.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_3), Mathf.Lerp(iter_200_5.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_3), (Mathf.Lerp(iter_200_5.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_3)))
							else
								local var_200_4 = Mathf.Lerp(iter_200_5.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_3)

								iter_200_5.color = Color.New(var_200_4, var_200_4, var_200_4)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10093 then
				for iter_200_6, iter_200_7 in pairs(arg_197_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_200_7 then
						iter_200_7.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps10093 = nil
			end

			local var_200_5 = 0
			local var_200_6 = 0.675

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_7 = arg_197_1:GetWordFromCfg(413141049)
				local var_200_8 = arg_197_1:FormatText(var_200_7.content)

				arg_197_1.text_.text = var_200_8

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_10 = 27 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 27)

				if (27 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 27)) > 0 and var_200_6 < var_200_10 then
					arg_197_1.talkMaxDuration = var_200_10

					if var_200_10 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_5
					end
				end

				arg_197_1.text_.text = var_200_8
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141049", "story_v_out_413141.awb") ~= 0 then
					local var_200_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141049", "story_v_out_413141.awb") / 1000

					if var_200_11 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_5
					end

					if var_200_7.prefab_name ~= "" and arg_197_1.actors_[var_200_7.prefab_name] ~= nil then
						local var_200_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_7.prefab_name].transform, "story_v_out_413141", "413141049", "story_v_out_413141.awb")

						arg_197_1:RecordAudio("413141049", var_200_12)
						arg_197_1:RecordAudio("413141049", var_200_12)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_413141", "413141049", "story_v_out_413141.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_413141", "413141049", "story_v_out_413141.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_13 = math.max(var_200_6, arg_197_1.talkMaxDuration)

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_13 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_5) / var_200_13

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_5 + var_200_13 and arg_197_1.time_ < var_200_5 + var_200_13 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play413141050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413141050
		arg_201_1.duration_ = 17.97

		local var_201_0 = {
			zh = 9.933,
			ja = 17.966
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
				arg_201_0:Play413141051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10092_1 = arg_201_1.actors_["10092_1"].transform.localPosition
				arg_201_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_204_0 = 0, arg_201_1.actors_["10092_1"].transform.childCount - 1 do
					local var_204_0 = arg_201_1.actors_["10092_1"].transform:GetChild(iter_204_0)

					if var_204_0.name == "split_4" or not string.find(var_204_0.name, "split") then
						var_204_0.gameObject:SetActive(true)
					else
						var_204_0.gameObject:SetActive(false)
					end
				end
			end

			local var_204_1 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_1 then
				arg_201_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_201_1.time_ - 0) / var_204_1)
			end

			if arg_201_1.time_ >= 0 + var_204_1 and arg_201_1.time_ < 0 + var_204_1 + arg_204_0 then
				arg_201_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_204_2 = arg_201_1.actors_["10092_1"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps10092_1 == nil then
				arg_201_1.var_.actorSpriteComps10092_1 = var_204_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_3 = 2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.actorSpriteComps10092_1 then
					for iter_204_1, iter_204_2 in pairs(arg_201_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_204_2 then
							if arg_201_1.isInRecall_ then
								iter_204_2.color = Color.New(Mathf.Lerp(iter_204_2.color.r, arg_201_1.hightColor1.r, (arg_201_1.time_ - 0) / var_204_3), Mathf.Lerp(iter_204_2.color.g, arg_201_1.hightColor1.g, (arg_201_1.time_ - 0) / var_204_3), (Mathf.Lerp(iter_204_2.color.b, arg_201_1.hightColor1.b, (arg_201_1.time_ - 0) / var_204_3)))
							else
								local var_204_4 = Mathf.Lerp(iter_204_2.color.r, 1, (arg_201_1.time_ - 0) / var_204_3)

								iter_204_2.color = Color.New(var_204_4, var_204_4, var_204_4)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps10092_1 then
				for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_204_4 then
						iter_204_4.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_204_5 = 0
			local var_204_6 = 1

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_7 = arg_201_1:GetWordFromCfg(413141050)
				local var_204_8 = arg_201_1:FormatText(var_204_7.content)

				arg_201_1.text_.text = var_204_8

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_10 = 40 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 40)

				if (40 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 40)) > 0 and var_204_6 < var_204_10 then
					arg_201_1.talkMaxDuration = var_204_10

					if var_204_10 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_5
					end
				end

				arg_201_1.text_.text = var_204_8
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141050", "story_v_out_413141.awb") ~= 0 then
					local var_204_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141050", "story_v_out_413141.awb") / 1000

					if var_204_11 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_11 + var_204_5
					end

					if var_204_7.prefab_name ~= "" and arg_201_1.actors_[var_204_7.prefab_name] ~= nil then
						local var_204_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_7.prefab_name].transform, "story_v_out_413141", "413141050", "story_v_out_413141.awb")

						arg_201_1:RecordAudio("413141050", var_204_12)
						arg_201_1:RecordAudio("413141050", var_204_12)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_413141", "413141050", "story_v_out_413141.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_413141", "413141050", "story_v_out_413141.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_13 = math.max(var_204_6, arg_201_1.talkMaxDuration)

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_13 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_5) / var_204_13

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_5 + var_204_13 and arg_201_1.time_ < var_204_5 + var_204_13 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413141051
		arg_205_1.duration_ = 8.4

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play413141052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if arg_205_1.bgs_.F10f == nil then
				local var_208_0 = Object.Instantiate(arg_205_1.paintGo_)

				var_208_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F10f")
				var_208_0.name = "F10f"
				var_208_0.transform.parent = arg_205_1.stage_.transform
				var_208_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.bgs_.F10f = var_208_0
			end

			if 1.4 < arg_205_1.time_ and arg_205_1.time_ <= 1.4 + arg_208_0 then
				local var_208_1 = arg_205_1.bgs_.F10f

				arg_205_1.bgs_.F10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_208_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_208_2 = var_208_1:GetComponent("SpriteRenderer")

				if var_208_2 and var_208_2.sprite then
					local var_208_3 = 2 * (var_208_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_208_1.transform.localScale = Vector3.New(var_208_3 / var_208_2.sprite.bounds.size.y < var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x and var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x or var_208_3 / var_208_2.sprite.bounds.size.y, var_208_3 / var_208_2.sprite.bounds.size.y < var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x and var_208_3 * manager.ui.mainCameraCom_.aspect / var_208_2.sprite.bounds.size.x or var_208_3 / var_208_2.sprite.bounds.size.y, 0)
				end

				for iter_208_0, iter_208_1 in pairs(arg_205_1.bgs_) do
					if iter_208_0 ~= "F10f" then
						iter_208_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_208_4 = 0

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.allBtn_.enabled = false
			end

			if arg_205_1.time_ >= var_208_4 + 0.3 and arg_205_1.time_ < var_208_4 + 0.3 + arg_208_0 then
				arg_205_1.allBtn_.enabled = true
			end

			local var_208_5 = 0

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_6 = 1.4

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_6 then
				local var_208_7 = Color.New(0, 0, 0)

				var_208_7.a = Mathf.Lerp(0, 1, (arg_205_1.time_ - var_208_5) / var_208_6)
				arg_205_1.mask_.color = var_208_7
			end

			if arg_205_1.time_ >= var_208_5 + var_208_6 and arg_205_1.time_ < var_208_5 + var_208_6 + arg_208_0 then
				local var_208_8 = Color.New(0, 0, 0)

				var_208_8.a = 1
				arg_205_1.mask_.color = var_208_8
			end

			local var_208_9 = 1.4

			if 1.4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_9 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_10 = 2

			if var_208_9 <= arg_205_1.time_ and arg_205_1.time_ < var_208_9 + var_208_10 then
				local var_208_11 = Color.New(0, 0, 0)

				var_208_11.a = Mathf.Lerp(1, 0, (arg_205_1.time_ - var_208_9) / var_208_10)
				arg_205_1.mask_.color = var_208_11
			end

			if arg_205_1.time_ >= var_208_9 + var_208_10 and arg_205_1.time_ < var_208_9 + var_208_10 + arg_208_0 then
				local var_208_12 = Color.New(0, 0, 0)

				arg_205_1.mask_.enabled = false
				var_208_12.a = 0
				arg_205_1.mask_.color = var_208_12
			end

			local var_208_13 = arg_205_1.actors_["10092_1"].transform

			if 1.4 < arg_205_1.time_ and arg_205_1.time_ <= 1.4 + arg_208_0 then
				arg_205_1.var_.moveOldPos10092_1 = var_208_13.localPosition
				var_208_13.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10092_1", 6)

				for iter_208_2 = 0, var_208_13.childCount - 1 do
					local var_208_14 = var_208_13:GetChild(iter_208_2)

					if var_208_14.name == "" or not string.find(var_208_14.name, "split") then
						var_208_14.gameObject:SetActive(true)
					else
						var_208_14.gameObject:SetActive(false)
					end
				end
			end

			local var_208_15 = 0.001

			if 1.4 <= arg_205_1.time_ and arg_205_1.time_ < 1.4 + var_208_15 then
				var_208_13.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10092_1, Vector3.New(1500, -300, -295), (arg_205_1.time_ - 1.4) / var_208_15)
			end

			if arg_205_1.time_ >= 1.4 + var_208_15 and arg_205_1.time_ < 1.4 + var_208_15 + arg_208_0 then
				var_208_13.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_208_16 = arg_205_1.actors_["10093"].transform

			if 1.4 < arg_205_1.time_ and arg_205_1.time_ <= 1.4 + arg_208_0 then
				arg_205_1.var_.moveOldPos10093 = var_208_16.localPosition
				var_208_16.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10093", 6)

				for iter_208_3 = 0, var_208_16.childCount - 1 do
					local var_208_17 = var_208_16:GetChild(iter_208_3)

					if var_208_17.name == "" or not string.find(var_208_17.name, "split") then
						var_208_17.gameObject:SetActive(true)
					else
						var_208_17.gameObject:SetActive(false)
					end
				end
			end

			local var_208_18 = 0.001

			if 1.4 <= arg_205_1.time_ and arg_205_1.time_ < 1.4 + var_208_18 then
				var_208_16.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_205_1.time_ - 1.4) / var_208_18)
			end

			if arg_205_1.time_ >= 1.4 + var_208_18 and arg_205_1.time_ < 1.4 + var_208_18 + arg_208_0 then
				var_208_16.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_208_19 = arg_205_1.actors_["10092_1"]

			if 1.4 < arg_205_1.time_ and arg_205_1.time_ <= 1.4 + arg_208_0 and not isNil(var_208_19) and arg_205_1.var_.actorSpriteComps10092_1 == nil then
				arg_205_1.var_.actorSpriteComps10092_1 = var_208_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_20 = 2

			if 1.4 <= arg_205_1.time_ and arg_205_1.time_ < 1.4 + var_208_20 and not isNil(var_208_19) then
				if arg_205_1.var_.actorSpriteComps10092_1 then
					for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_208_5 then
							if arg_205_1.isInRecall_ then
								iter_208_5.color = Color.New(Mathf.Lerp(iter_208_5.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 1.4) / var_208_20), Mathf.Lerp(iter_208_5.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 1.4) / var_208_20), (Mathf.Lerp(iter_208_5.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 1.4) / var_208_20)))
							else
								local var_208_21 = Mathf.Lerp(iter_208_5.color.r, 0.5, (arg_205_1.time_ - 1.4) / var_208_20)

								iter_208_5.color = Color.New(var_208_21, var_208_21, var_208_21)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 1.4 + var_208_20 and arg_205_1.time_ < 1.4 + var_208_20 + arg_208_0 and not isNil(var_208_19) and arg_205_1.var_.actorSpriteComps10092_1 then
				for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_208_7 then
						iter_208_7.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_208_22 = arg_205_1.actors_["10093"]

			if 1.4 < arg_205_1.time_ and arg_205_1.time_ <= 1.4 + arg_208_0 and not isNil(var_208_22) and arg_205_1.var_.actorSpriteComps10093 == nil then
				arg_205_1.var_.actorSpriteComps10093 = var_208_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_23 = 2

			if 1.4 <= arg_205_1.time_ and arg_205_1.time_ < 1.4 + var_208_23 and not isNil(var_208_22) then
				if arg_205_1.var_.actorSpriteComps10093 then
					for iter_208_8, iter_208_9 in pairs(arg_205_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_208_9 then
							if arg_205_1.isInRecall_ then
								iter_208_9.color = Color.New(Mathf.Lerp(iter_208_9.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 1.4) / var_208_23), Mathf.Lerp(iter_208_9.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 1.4) / var_208_23), (Mathf.Lerp(iter_208_9.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 1.4) / var_208_23)))
							else
								local var_208_24 = Mathf.Lerp(iter_208_9.color.r, 0.5, (arg_205_1.time_ - 1.4) / var_208_23)

								iter_208_9.color = Color.New(var_208_24, var_208_24, var_208_24)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 1.4 + var_208_23 and arg_205_1.time_ < 1.4 + var_208_23 + arg_208_0 and not isNil(var_208_22) and arg_205_1.var_.actorSpriteComps10093 then
				for iter_208_10, iter_208_11 in pairs(arg_205_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_208_11 then
						iter_208_11.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps10093 = nil
			end

			local var_208_25 = 1.4

			arg_205_1.isInRecall_ = true

			if var_208_25 < arg_205_1.time_ and arg_205_1.time_ <= var_208_25 + arg_208_0 then
				arg_205_1.screenFilterGo_:SetActive(true)

				arg_205_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_205_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_205_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_208_12, iter_208_13 in pairs(arg_205_1.actors_) do
					for iter_208_14, iter_208_15 in ipairs((iter_208_13:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_208_15.color = iter_208_15.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_208_26 = 0.034

			if var_208_25 <= arg_205_1.time_ and arg_205_1.time_ < var_208_25 + var_208_26 then
				arg_205_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_205_1.time_ - var_208_25) / var_208_26)
			end

			if arg_205_1.time_ >= var_208_25 + var_208_26 and arg_205_1.time_ < var_208_25 + var_208_26 + arg_208_0 then
				arg_205_1.screenFilterEffect_.weight = 1
			end

			if arg_205_1.frameCnt_ <= 1 then
				arg_205_1.dialog_:SetActive(false)
			end

			local var_208_27 = 3.4
			local var_208_28 = 0.825

			if 3.4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_27 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				arg_205_1.dialog_:SetActive(true)

				arg_205_1.dialogCg_.alpha = 0

				local var_208_29 = LeanTween.value(arg_205_1.dialog_, 0, 1, 0.3)

				var_208_29:setOnUpdate(LuaHelper.FloatAction(function(arg_209_0)
					arg_205_1.dialogCg_.alpha = arg_209_0
				end))
				var_208_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_205_1.dialog_)
					var_208_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_205_1.duration_ = arg_205_1.duration_ + 0.3

				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_30 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(413141051).content)

				arg_205_1.text_.text = var_208_30

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_32 = 33 <= 0 and var_208_28 or var_208_28 * (utf8.len(var_208_30) / 33)

				if (33 <= 0 and var_208_28 or var_208_28 * (utf8.len(var_208_30) / 33)) > 0 and var_208_28 < var_208_32 then
					arg_205_1.talkMaxDuration = var_208_32
					var_208_27 = var_208_27 + 0.3

					if var_208_32 + var_208_27 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_32 + var_208_27
					end
				end

				arg_205_1.text_.text = var_208_30
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_33 = var_208_27 + 0.3
			local var_208_34 = math.max(var_208_28, arg_205_1.talkMaxDuration)

			if var_208_27 + 0.3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_33 + var_208_34 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_33) / var_208_34

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_33 + var_208_34 and arg_205_1.time_ < var_208_33 + var_208_34 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play413141052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 413141052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play413141053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 1.025

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(413141052).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 41 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 41)

				if (41 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 41)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play413141053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 413141053
		arg_215_1.duration_ = 1.47

		local var_215_0 = {
			zh = 1.033,
			ja = 1.466
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play413141054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.15

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_3")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_215_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_218_1 = arg_215_1:GetWordFromCfg(413141053)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 6 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 6)

				if (6 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 6)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141053", "story_v_out_413141.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141053", "story_v_out_413141.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_413141", "413141053", "story_v_out_413141.awb")

						arg_215_1:RecordAudio("413141053", var_218_6)
						arg_215_1:RecordAudio("413141053", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_413141", "413141053", "story_v_out_413141.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_413141", "413141053", "story_v_out_413141.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play413141054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 413141054
		arg_219_1.duration_ = 5.9

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play413141055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_0 = 0.633333333333333

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				local var_222_1 = Color.New(1, 1, 1)

				var_222_1.a = Mathf.Lerp(1, 0, (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.mask_.color = var_222_1
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				local var_222_2 = Color.New(1, 1, 1)

				arg_219_1.mask_.enabled = false
				var_222_2.a = 0
				arg_219_1.mask_.color = var_222_2
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_3 = 0.9
			local var_222_4 = 0.95

			if 0.9 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_5 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_5:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(413141054).content)

				arg_219_1.text_.text = var_222_6

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_8 = 38 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_6) / 38)

				if (38 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_6) / 38)) > 0 and var_222_4 < var_222_8 then
					arg_219_1.talkMaxDuration = var_222_8
					var_222_3 = var_222_3 + 0.3

					if var_222_8 + var_222_3 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_3
					end
				end

				arg_219_1.text_.text = var_222_6
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_9 = var_222_3 + 0.3
			local var_222_10 = math.max(var_222_4, arg_219_1.talkMaxDuration)

			if var_222_3 + 0.3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_9 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_9) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_9 + var_222_10 and arg_219_1.time_ < var_222_9 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play413141055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413141055
		arg_225_1.duration_ = 8.97

		local var_225_0 = {
			zh = 5.4,
			ja = 8.966
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
				arg_225_0:Play413141056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.25

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1004].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_225_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_228_1 = arg_225_1:GetWordFromCfg(413141055)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 10 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 10)

				if (10 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 10)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141055", "story_v_out_413141.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141055", "story_v_out_413141.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_413141", "413141055", "story_v_out_413141.awb")

						arg_225_1:RecordAudio("413141055", var_228_6)
						arg_225_1:RecordAudio("413141055", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413141", "413141055", "story_v_out_413141.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413141", "413141055", "story_v_out_413141.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play413141056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 413141056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play413141057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.825

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(413141056).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 33 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 33)

				if (33 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 33)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play413141057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 413141057
		arg_233_1.duration_ = 7.5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play413141058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_0 = 0.3

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				local var_236_1 = Color.New(0, 0, 0)

				var_236_1.a = Mathf.Lerp(0, 1, (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.mask_.color = var_236_1
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				local var_236_2 = Color.New(0, 0, 0)

				var_236_2.a = 1
				arg_233_1.mask_.color = var_236_2
			end

			local var_236_3 = 0.3

			if 0.3 < arg_233_1.time_ and arg_233_1.time_ <= var_236_3 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_4 = 0.7

			if var_236_3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_3 + var_236_4 then
				local var_236_5 = Color.New(0, 0, 0)

				var_236_5.a = Mathf.Lerp(1, 0, (arg_233_1.time_ - var_236_3) / var_236_4)
				arg_233_1.mask_.color = var_236_5
			end

			if arg_233_1.time_ >= var_236_3 + var_236_4 and arg_233_1.time_ < var_236_3 + var_236_4 + arg_236_0 then
				local var_236_6 = Color.New(0, 0, 0)

				arg_233_1.mask_.enabled = false
				var_236_6.a = 0
				arg_233_1.mask_.color = var_236_6
			end

			local var_236_7 = 1.36666666666667

			if 1.36666666666667 < arg_233_1.time_ and arg_233_1.time_ <= var_236_7 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_8 = 0.3

			if var_236_7 <= arg_233_1.time_ and arg_233_1.time_ < var_236_7 + var_236_8 then
				local var_236_9 = Color.New(0, 0, 0)

				var_236_9.a = Mathf.Lerp(0, 1, (arg_233_1.time_ - var_236_7) / var_236_8)
				arg_233_1.mask_.color = var_236_9
			end

			if arg_233_1.time_ >= var_236_7 + var_236_8 and arg_233_1.time_ < var_236_7 + var_236_8 + arg_236_0 then
				local var_236_10 = Color.New(0, 0, 0)

				var_236_10.a = 1
				arg_233_1.mask_.color = var_236_10
			end

			local var_236_11 = 1.66666666666667

			if 1.66666666666667 < arg_233_1.time_ and arg_233_1.time_ <= var_236_11 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_12 = 0.833333333333333

			if var_236_11 <= arg_233_1.time_ and arg_233_1.time_ < var_236_11 + var_236_12 then
				local var_236_13 = Color.New(0, 0, 0)

				var_236_13.a = Mathf.Lerp(1, 0, (arg_233_1.time_ - var_236_11) / var_236_12)
				arg_233_1.mask_.color = var_236_13
			end

			if arg_233_1.time_ >= var_236_11 + var_236_12 and arg_233_1.time_ < var_236_11 + var_236_12 + arg_236_0 then
				local var_236_14 = Color.New(0, 0, 0)

				arg_233_1.mask_.enabled = false
				var_236_14.a = 0
				arg_233_1.mask_.color = var_236_14
			end

			local var_236_15 = 0

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_15 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			if arg_233_1.time_ >= var_236_15 + 2.5 and arg_233_1.time_ < var_236_15 + 2.5 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_16 = 2.5
			local var_236_17 = 1.15

			if 2.5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_18 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_18:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_19 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(413141057).content)

				arg_233_1.text_.text = var_236_19

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_21 = 46 <= 0 and var_236_17 or var_236_17 * (utf8.len(var_236_19) / 46)

				if (46 <= 0 and var_236_17 or var_236_17 * (utf8.len(var_236_19) / 46)) > 0 and var_236_17 < var_236_21 then
					arg_233_1.talkMaxDuration = var_236_21
					var_236_16 = var_236_16 + 0.3

					if var_236_21 + var_236_16 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_21 + var_236_16
					end
				end

				arg_233_1.text_.text = var_236_19
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_22 = var_236_16 + 0.3
			local var_236_23 = math.max(var_236_17, arg_233_1.talkMaxDuration)

			if var_236_16 + 0.3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_22 + var_236_23 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_22) / var_236_23

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_22 + var_236_23 and arg_233_1.time_ < var_236_22 + var_236_23 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play413141058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 413141058
		arg_239_1.duration_ = 8.87

		local var_239_0 = {
			zh = 5.966,
			ja = 8.866
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play413141059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.475

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[1004].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_239_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_242_1 = arg_239_1:GetWordFromCfg(413141058)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 18 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 18)

				if (18 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 18)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141058", "story_v_out_413141.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141058", "story_v_out_413141.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_413141", "413141058", "story_v_out_413141.awb")

						arg_239_1:RecordAudio("413141058", var_242_6)
						arg_239_1:RecordAudio("413141058", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_413141", "413141058", "story_v_out_413141.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_413141", "413141058", "story_v_out_413141.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play413141059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 413141059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play413141060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 1.05

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(413141059).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 42 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 42)

				if (42 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 42)) > 0 and var_246_0 < var_246_3 then
					arg_243_1.talkMaxDuration = var_246_3

					if var_246_3 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_3 + 0
					end
				end

				arg_243_1.text_.text = var_246_1
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_4 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_4

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play413141060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 413141060
		arg_247_1.duration_ = 6.57

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play413141061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if arg_247_1.bgs_.F10f_blur == nil then
				local var_250_0 = Object.Instantiate(arg_247_1.blurPaintGo_)

				var_250_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F10f_blur")
				var_250_0.name = "F10f_blur"
				var_250_0.transform.parent = arg_247_1.stage_.transform
				var_250_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_247_1.bgs_.F10f_blur = var_250_0
			end

			local var_250_1 = 0
			local var_250_2 = arg_247_1.bgs_.F10f_blur

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				var_250_2.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_250_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_3 = var_250_2:GetComponent("SpriteRenderer")

				if var_250_3 and var_250_3.sprite then
					local var_250_4 = 2 * (var_250_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_250_2.transform.localScale = Vector3.New(var_250_4 / var_250_3.sprite.bounds.size.y < var_250_4 * manager.ui.mainCameraCom_.aspect / var_250_3.sprite.bounds.size.x and var_250_4 * manager.ui.mainCameraCom_.aspect / var_250_3.sprite.bounds.size.x or var_250_4 / var_250_3.sprite.bounds.size.y, var_250_4 / var_250_3.sprite.bounds.size.y < var_250_4 * manager.ui.mainCameraCom_.aspect / var_250_3.sprite.bounds.size.x and var_250_4 * manager.ui.mainCameraCom_.aspect / var_250_3.sprite.bounds.size.x or var_250_4 / var_250_3.sprite.bounds.size.y, 0)
				end
			end

			local var_250_5 = 1.86666666666667

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_5 then
				local var_250_6 = Color.New(1, 1, 1)

				var_250_6.a = Mathf.Lerp(0, 1, (arg_247_1.time_ - var_250_1) / var_250_5)

				var_250_2:GetComponent("SpriteRenderer").material:SetColor("_Color", var_250_6)
			end

			local var_250_7 = 0

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_7 + arg_250_0 then
				arg_247_1.allBtn_.enabled = false
			end

			if arg_247_1.time_ >= var_250_7 + 1.56666666666667 and arg_247_1.time_ < var_250_7 + 1.56666666666667 + arg_250_0 then
				arg_247_1.allBtn_.enabled = true
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_8 = 1.56666666666667
			local var_250_9 = 0.975

			if 1.56666666666667 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_10 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_10:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_11 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(413141060).content)

				arg_247_1.text_.text = var_250_11

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_13 = 39 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 39)

				if (39 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 39)) > 0 and var_250_9 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13
					var_250_8 = var_250_8 + 0.3

					if var_250_13 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_8
					end
				end

				arg_247_1.text_.text = var_250_11
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_14 = var_250_8 + 0.3
			local var_250_15 = math.max(var_250_9, arg_247_1.talkMaxDuration)

			if var_250_8 + 0.3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_14 + var_250_15 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_14) / var_250_15

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_14 + var_250_15 and arg_247_1.time_ < var_250_14 + var_250_15 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play413141061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 413141061
		arg_253_1.duration_ = 6.67

		local var_253_0 = {
			zh = 6.666,
			ja = 4.933
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
				arg_253_0:Play413141062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.375

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1004].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_253_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_256_1 = arg_253_1:GetWordFromCfg(413141061)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 15 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 15)

				if (15 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 15)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141061", "story_v_out_413141.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141061", "story_v_out_413141.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_413141", "413141061", "story_v_out_413141.awb")

						arg_253_1:RecordAudio("413141061", var_256_6)
						arg_253_1:RecordAudio("413141061", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_413141", "413141061", "story_v_out_413141.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_413141", "413141061", "story_v_out_413141.awb")
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
	Play413141062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 413141062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play413141063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 1.075

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(413141062).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 43 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 43)

				if (43 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 43)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play413141063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 413141063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play413141064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.725

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_2 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_2:setOnUpdate(LuaHelper.FloatAction(function(arg_265_0)
					arg_261_1.dialogCg_.alpha = arg_265_0
				end))
				var_264_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(413141063).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 29 <= 0 and var_264_1 or var_264_1 * (utf8.len(var_264_3) / 29)

				if (29 <= 0 and var_264_1 or var_264_1 * (utf8.len(var_264_3) / 29)) > 0 and var_264_1 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5
					var_264_0 = var_264_0 + 0.3

					if var_264_5 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_6 = var_264_0 + 0.3
			local var_264_7 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 + 0.3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_7 and arg_261_1.time_ < var_264_6 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play413141064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 413141064
		arg_267_1.duration_ = 16.3

		local var_267_0 = {
			zh = 11.666,
			ja = 16.3
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
				arg_267_0:Play413141065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.65

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[1004].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ilyina")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_267_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_270_1 = arg_267_1:GetWordFromCfg(413141064)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 26 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 26)

				if (26 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 26)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141064", "story_v_out_413141.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141064", "story_v_out_413141.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_413141", "413141064", "story_v_out_413141.awb")

						arg_267_1:RecordAudio("413141064", var_270_6)
						arg_267_1:RecordAudio("413141064", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_413141", "413141064", "story_v_out_413141.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_413141", "413141064", "story_v_out_413141.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play413141065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 413141065
		arg_271_1.duration_ = 5.3

		local var_271_0 = {
			zh = 1.966,
			ja = 5.3
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
				arg_271_0:Play413141066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.15

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_1_split_3")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_271_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_274_1 = arg_271_1:GetWordFromCfg(413141065)
				local var_274_2 = arg_271_1:FormatText(var_274_1.content)

				arg_271_1.text_.text = var_274_2

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 6 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 6)

				if (6 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 6)) > 0 and var_274_0 < var_274_4 then
					arg_271_1.talkMaxDuration = var_274_4

					if var_274_4 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_4 + 0
					end
				end

				arg_271_1.text_.text = var_274_2
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141065", "story_v_out_413141.awb") ~= 0 then
					local var_274_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141065", "story_v_out_413141.awb") / 1000

					if var_274_5 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + 0
					end

					if var_274_1.prefab_name ~= "" and arg_271_1.actors_[var_274_1.prefab_name] ~= nil then
						local var_274_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_1.prefab_name].transform, "story_v_out_413141", "413141065", "story_v_out_413141.awb")

						arg_271_1:RecordAudio("413141065", var_274_6)
						arg_271_1:RecordAudio("413141065", var_274_6)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_413141", "413141065", "story_v_out_413141.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_413141", "413141065", "story_v_out_413141.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play413141066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 413141066
		arg_275_1.duration_ = 8.93

		local var_275_0 = {
			zh = 8.933,
			ja = 8.6
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
				arg_275_0:Play413141067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 1.6 < arg_275_1.time_ and arg_275_1.time_ <= 1.6 + arg_278_0 then
				local var_278_0 = arg_275_1.bgs_.ST0603a

				arg_275_1.bgs_.ST0603a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_278_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_278_1 = var_278_0:GetComponent("SpriteRenderer")

				if var_278_1 and var_278_1.sprite then
					local var_278_2 = 2 * (var_278_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_278_0.transform.localScale = Vector3.New(var_278_2 / var_278_1.sprite.bounds.size.y < var_278_2 * manager.ui.mainCameraCom_.aspect / var_278_1.sprite.bounds.size.x and var_278_2 * manager.ui.mainCameraCom_.aspect / var_278_1.sprite.bounds.size.x or var_278_2 / var_278_1.sprite.bounds.size.y, var_278_2 / var_278_1.sprite.bounds.size.y < var_278_2 * manager.ui.mainCameraCom_.aspect / var_278_1.sprite.bounds.size.x and var_278_2 * manager.ui.mainCameraCom_.aspect / var_278_1.sprite.bounds.size.x or var_278_2 / var_278_1.sprite.bounds.size.y, 0)
				end

				for iter_278_0, iter_278_1 in pairs(arg_275_1.bgs_) do
					if iter_278_0 ~= "ST0603a" then
						iter_278_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_278_3 = 3.2

			if 3.2 < arg_275_1.time_ and arg_275_1.time_ <= var_278_3 + arg_278_0 then
				arg_275_1.allBtn_.enabled = false
			end

			if arg_275_1.time_ >= var_278_3 + 0.3 and arg_275_1.time_ < var_278_3 + 0.3 + arg_278_0 then
				arg_275_1.allBtn_.enabled = true
			end

			local var_278_4 = 0

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_5 = 1.6

			if var_278_4 <= arg_275_1.time_ and arg_275_1.time_ < var_278_4 + var_278_5 then
				local var_278_6 = Color.New(1, 1, 1)

				var_278_6.a = Mathf.Lerp(0, 1, (arg_275_1.time_ - var_278_4) / var_278_5)
				arg_275_1.mask_.color = var_278_6
			end

			if arg_275_1.time_ >= var_278_4 + var_278_5 and arg_275_1.time_ < var_278_4 + var_278_5 + arg_278_0 then
				local var_278_7 = Color.New(1, 1, 1)

				var_278_7.a = 1
				arg_275_1.mask_.color = var_278_7
			end

			local var_278_8 = 1.6

			if 1.6 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_9 = 1.6

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_9 then
				local var_278_10 = Color.New(1, 1, 1)

				var_278_10.a = Mathf.Lerp(1, 0, (arg_275_1.time_ - var_278_8) / var_278_9)
				arg_275_1.mask_.color = var_278_10
			end

			if arg_275_1.time_ >= var_278_8 + var_278_9 and arg_275_1.time_ < var_278_8 + var_278_9 + arg_278_0 then
				local var_278_11 = Color.New(1, 1, 1)

				arg_275_1.mask_.enabled = false
				var_278_11.a = 0
				arg_275_1.mask_.color = var_278_11
			end

			local var_278_12 = arg_275_1.actors_["10092_1"].transform

			if 2.96666666666667 < arg_275_1.time_ and arg_275_1.time_ <= 2.96666666666667 + arg_278_0 then
				arg_275_1.var_.moveOldPos10092_1 = var_278_12.localPosition
				var_278_12.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_278_2 = 0, var_278_12.childCount - 1 do
					local var_278_13 = var_278_12:GetChild(iter_278_2)

					if var_278_13.name == "split_8" or not string.find(var_278_13.name, "split") then
						var_278_13.gameObject:SetActive(true)
					else
						var_278_13.gameObject:SetActive(false)
					end
				end
			end

			local var_278_14 = 0.001

			if 2.96666666666667 <= arg_275_1.time_ and arg_275_1.time_ < 2.96666666666667 + var_278_14 then
				var_278_12.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_275_1.time_ - 2.96666666666667) / var_278_14)
			end

			if arg_275_1.time_ >= 2.96666666666667 + var_278_14 and arg_275_1.time_ < 2.96666666666667 + var_278_14 + arg_278_0 then
				var_278_12.localPosition = Vector3.New(0, -300, -295)
			end

			local var_278_15 = arg_275_1.actors_["10092_1"]

			if 2.96666666666667 < arg_275_1.time_ and arg_275_1.time_ <= 2.96666666666667 + arg_278_0 and not isNil(var_278_15) and arg_275_1.var_.actorSpriteComps10092_1 == nil then
				arg_275_1.var_.actorSpriteComps10092_1 = var_278_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_16 = 2

			if 2.96666666666667 <= arg_275_1.time_ and arg_275_1.time_ < 2.96666666666667 + var_278_16 and not isNil(var_278_15) then
				if arg_275_1.var_.actorSpriteComps10092_1 then
					for iter_278_3, iter_278_4 in pairs(arg_275_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_278_4 then
							if arg_275_1.isInRecall_ then
								iter_278_4.color = Color.New(Mathf.Lerp(iter_278_4.color.r, arg_275_1.hightColor1.r, (arg_275_1.time_ - 2.96666666666667) / var_278_16), Mathf.Lerp(iter_278_4.color.g, arg_275_1.hightColor1.g, (arg_275_1.time_ - 2.96666666666667) / var_278_16), (Mathf.Lerp(iter_278_4.color.b, arg_275_1.hightColor1.b, (arg_275_1.time_ - 2.96666666666667) / var_278_16)))
							else
								local var_278_17 = Mathf.Lerp(iter_278_4.color.r, 1, (arg_275_1.time_ - 2.96666666666667) / var_278_16)

								iter_278_4.color = Color.New(var_278_17, var_278_17, var_278_17)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 2.96666666666667 + var_278_16 and arg_275_1.time_ < 2.96666666666667 + var_278_16 + arg_278_0 and not isNil(var_278_15) and arg_275_1.var_.actorSpriteComps10092_1 then
				for iter_278_5, iter_278_6 in pairs(arg_275_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_278_6 then
						iter_278_6.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_275_1.var_.actorSpriteComps10092_1 = nil
			end

			if 2.96666666666667 < arg_275_1.time_ and arg_275_1.time_ <= 2.96666666666667 + arg_278_0 then
				local var_278_18 = arg_275_1.actors_["10092_1"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_278_18 then
					arg_275_1.var_.alphaOldValue10092_1 = var_278_18.alpha
					arg_275_1.var_.characterEffect10092_1 = var_278_18
				end

				arg_275_1.var_.alphaOldValue10092_1 = 0
			end

			local var_278_19 = 0.3

			if 2.96666666666667 <= arg_275_1.time_ and arg_275_1.time_ < 2.96666666666667 + var_278_19 then
				if arg_275_1.var_.characterEffect10092_1 then
					arg_275_1.var_.characterEffect10092_1.alpha = Mathf.Lerp(arg_275_1.var_.alphaOldValue10092_1, 1, (arg_275_1.time_ - 2.96666666666667) / var_278_19)
				end
			end

			if arg_275_1.time_ >= 2.96666666666667 + var_278_19 and arg_275_1.time_ < 2.96666666666667 + var_278_19 + arg_278_0 and arg_275_1.var_.characterEffect10092_1 then
				arg_275_1.var_.characterEffect10092_1.alpha = 1
			end

			local var_278_20 = 1.6

			arg_275_1.isInRecall_ = false

			if var_278_20 < arg_275_1.time_ and arg_275_1.time_ <= var_278_20 + arg_278_0 then
				arg_275_1.screenFilterGo_:SetActive(false)

				for iter_278_7, iter_278_8 in pairs(arg_275_1.actors_) do
					for iter_278_9, iter_278_10 in ipairs((iter_278_8:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_278_10.color = iter_278_10.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_278_21 = 0.2333333

			if var_278_20 <= arg_275_1.time_ and arg_275_1.time_ < var_278_20 + var_278_21 then
				arg_275_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_275_1.time_ - var_278_20) / var_278_21)
			end

			if arg_275_1.time_ >= var_278_20 + var_278_21 and arg_275_1.time_ < var_278_20 + var_278_21 + arg_278_0 then
				arg_275_1.screenFilterEffect_.weight = 0
			end

			if arg_275_1.frameCnt_ <= 1 then
				arg_275_1.dialog_:SetActive(false)
			end

			local var_278_22 = 3.4
			local var_278_23 = 0.725

			if 3.4 < arg_275_1.time_ and arg_275_1.time_ <= var_278_22 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0

				arg_275_1.dialog_:SetActive(true)

				arg_275_1.dialogCg_.alpha = 0

				local var_278_24 = LeanTween.value(arg_275_1.dialog_, 0, 1, 0.3)

				var_278_24:setOnUpdate(LuaHelper.FloatAction(function(arg_279_0)
					arg_275_1.dialogCg_.alpha = arg_279_0
				end))
				var_278_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_275_1.dialog_)
					var_278_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_275_1.duration_ = arg_275_1.duration_ + 0.3

				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_25 = arg_275_1:GetWordFromCfg(413141066)
				local var_278_26 = arg_275_1:FormatText(var_278_25.content)

				arg_275_1.text_.text = var_278_26

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_28 = 29 <= 0 and var_278_23 or var_278_23 * (utf8.len(var_278_26) / 29)

				if (29 <= 0 and var_278_23 or var_278_23 * (utf8.len(var_278_26) / 29)) > 0 and var_278_23 < var_278_28 then
					arg_275_1.talkMaxDuration = var_278_28
					var_278_22 = var_278_22 + 0.3

					if var_278_28 + var_278_22 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_28 + var_278_22
					end
				end

				arg_275_1.text_.text = var_278_26
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141066", "story_v_out_413141.awb") ~= 0 then
					local var_278_29 = manager.audio:GetVoiceLength("story_v_out_413141", "413141066", "story_v_out_413141.awb") / 1000

					if var_278_29 + var_278_22 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_29 + var_278_22
					end

					if var_278_25.prefab_name ~= "" and arg_275_1.actors_[var_278_25.prefab_name] ~= nil then
						local var_278_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_25.prefab_name].transform, "story_v_out_413141", "413141066", "story_v_out_413141.awb")

						arg_275_1:RecordAudio("413141066", var_278_30)
						arg_275_1:RecordAudio("413141066", var_278_30)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_413141", "413141066", "story_v_out_413141.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_413141", "413141066", "story_v_out_413141.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_31 = var_278_22 + 0.3
			local var_278_32 = math.max(var_278_23, arg_275_1.talkMaxDuration)

			if var_278_22 + 0.3 <= arg_275_1.time_ and arg_275_1.time_ < var_278_31 + var_278_32 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_31) / var_278_32

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_31 + var_278_32 and arg_275_1.time_ < var_278_31 + var_278_32 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play413141067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 413141067
		arg_281_1.duration_ = 7

		local var_281_0 = {
			zh = 6.933,
			ja = 7
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
				arg_281_0:Play413141068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.7

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:GetWordFromCfg(413141067)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 28 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 28)

				if (28 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 28)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141067", "story_v_out_413141.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141067", "story_v_out_413141.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_413141", "413141067", "story_v_out_413141.awb")

						arg_281_1:RecordAudio("413141067", var_284_6)
						arg_281_1:RecordAudio("413141067", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_413141", "413141067", "story_v_out_413141.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_413141", "413141067", "story_v_out_413141.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play413141068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 413141068
		arg_285_1.duration_ = 5.7

		local var_285_0 = {
			zh = 3.9,
			ja = 5.7
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
				arg_285_0:Play413141069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10092_1 = arg_285_1.actors_["10092_1"].transform.localPosition
				arg_285_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_288_0 = 0, arg_285_1.actors_["10092_1"].transform.childCount - 1 do
					local var_288_0 = arg_285_1.actors_["10092_1"].transform:GetChild(iter_288_0)

					if var_288_0.name == "split_8" or not string.find(var_288_0.name, "split") then
						var_288_0.gameObject:SetActive(true)
					else
						var_288_0.gameObject:SetActive(false)
					end
				end
			end

			local var_288_1 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_1 then
				arg_285_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_285_1.time_ - 0) / var_288_1)
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 then
				arg_285_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_288_2 = arg_285_1.actors_["10093"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10093 = var_288_2.localPosition
				var_288_2.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10093", 4)

				for iter_288_1 = 0, var_288_2.childCount - 1 do
					local var_288_3 = var_288_2:GetChild(iter_288_1)

					if var_288_3.name == "split_4" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				var_288_2.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_285_1.time_ - 0) / var_288_4)
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				var_288_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_288_5 = arg_285_1.actors_["10092_1"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.actorSpriteComps10092_1 == nil then
				arg_285_1.var_.actorSpriteComps10092_1 = var_288_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_6 = 2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_6 and not isNil(var_288_5) then
				if arg_285_1.var_.actorSpriteComps10092_1 then
					for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_288_3 then
							if arg_285_1.isInRecall_ then
								iter_288_3.color = Color.New(Mathf.Lerp(iter_288_3.color.r, arg_285_1.hightColor2.r, (arg_285_1.time_ - 0) / var_288_6), Mathf.Lerp(iter_288_3.color.g, arg_285_1.hightColor2.g, (arg_285_1.time_ - 0) / var_288_6), (Mathf.Lerp(iter_288_3.color.b, arg_285_1.hightColor2.b, (arg_285_1.time_ - 0) / var_288_6)))
							else
								local var_288_7 = Mathf.Lerp(iter_288_3.color.r, 0.5, (arg_285_1.time_ - 0) / var_288_6)

								iter_288_3.color = Color.New(var_288_7, var_288_7, var_288_7)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_6 and arg_285_1.time_ < 0 + var_288_6 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.actorSpriteComps10092_1 then
				for iter_288_4, iter_288_5 in pairs(arg_285_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_288_5 then
						iter_288_5.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_285_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_288_8 = arg_285_1.actors_["10093"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.actorSpriteComps10093 == nil then
				arg_285_1.var_.actorSpriteComps10093 = var_288_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_9 = 2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_9 and not isNil(var_288_8) then
				if arg_285_1.var_.actorSpriteComps10093 then
					for iter_288_6, iter_288_7 in pairs(arg_285_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_288_7 then
							if arg_285_1.isInRecall_ then
								iter_288_7.color = Color.New(Mathf.Lerp(iter_288_7.color.r, arg_285_1.hightColor1.r, (arg_285_1.time_ - 0) / var_288_9), Mathf.Lerp(iter_288_7.color.g, arg_285_1.hightColor1.g, (arg_285_1.time_ - 0) / var_288_9), (Mathf.Lerp(iter_288_7.color.b, arg_285_1.hightColor1.b, (arg_285_1.time_ - 0) / var_288_9)))
							else
								local var_288_10 = Mathf.Lerp(iter_288_7.color.r, 1, (arg_285_1.time_ - 0) / var_288_9)

								iter_288_7.color = Color.New(var_288_10, var_288_10, var_288_10)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_9 and arg_285_1.time_ < 0 + var_288_9 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.actorSpriteComps10093 then
				for iter_288_8, iter_288_9 in pairs(arg_285_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_288_9 then
						iter_288_9.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps10093 = nil
			end

			local var_288_11 = 0
			local var_288_12 = 0.475

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_11 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_13 = arg_285_1:GetWordFromCfg(413141068)
				local var_288_14 = arg_285_1:FormatText(var_288_13.content)

				arg_285_1.text_.text = var_288_14

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_16 = 19 <= 0 and var_288_12 or var_288_12 * (utf8.len(var_288_14) / 19)

				if (19 <= 0 and var_288_12 or var_288_12 * (utf8.len(var_288_14) / 19)) > 0 and var_288_12 < var_288_16 then
					arg_285_1.talkMaxDuration = var_288_16

					if var_288_16 + var_288_11 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_16 + var_288_11
					end
				end

				arg_285_1.text_.text = var_288_14
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141068", "story_v_out_413141.awb") ~= 0 then
					local var_288_17 = manager.audio:GetVoiceLength("story_v_out_413141", "413141068", "story_v_out_413141.awb") / 1000

					if var_288_17 + var_288_11 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_17 + var_288_11
					end

					if var_288_13.prefab_name ~= "" and arg_285_1.actors_[var_288_13.prefab_name] ~= nil then
						local var_288_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_13.prefab_name].transform, "story_v_out_413141", "413141068", "story_v_out_413141.awb")

						arg_285_1:RecordAudio("413141068", var_288_18)
						arg_285_1:RecordAudio("413141068", var_288_18)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_413141", "413141068", "story_v_out_413141.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_413141", "413141068", "story_v_out_413141.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_19 = math.max(var_288_12, arg_285_1.talkMaxDuration)

			if var_288_11 <= arg_285_1.time_ and arg_285_1.time_ < var_288_11 + var_288_19 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_11) / var_288_19

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_11 + var_288_19 and arg_285_1.time_ < var_288_11 + var_288_19 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413141069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 413141069
		arg_289_1.duration_ = 8.7

		local var_289_0 = {
			zh = 4.1,
			ja = 8.7
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
				arg_289_0:Play413141070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10092_1 = arg_289_1.actors_["10092_1"].transform.localPosition
				arg_289_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_292_0 = 0, arg_289_1.actors_["10092_1"].transform.childCount - 1 do
					local var_292_0 = arg_289_1.actors_["10092_1"].transform:GetChild(iter_292_0)

					if var_292_0.name == "split_1_1" or not string.find(var_292_0.name, "split") then
						var_292_0.gameObject:SetActive(true)
					else
						var_292_0.gameObject:SetActive(false)
					end
				end
			end

			local var_292_1 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_1 then
				arg_289_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_289_1.time_ - 0) / var_292_1)
			end

			if arg_289_1.time_ >= 0 + var_292_1 and arg_289_1.time_ < 0 + var_292_1 + arg_292_0 then
				arg_289_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_292_2 = arg_289_1.actors_["10092_1"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps10092_1 == nil then
				arg_289_1.var_.actorSpriteComps10092_1 = var_292_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_3 = 2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.actorSpriteComps10092_1 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_292_2 then
							if arg_289_1.isInRecall_ then
								iter_292_2.color = Color.New(Mathf.Lerp(iter_292_2.color.r, arg_289_1.hightColor1.r, (arg_289_1.time_ - 0) / var_292_3), Mathf.Lerp(iter_292_2.color.g, arg_289_1.hightColor1.g, (arg_289_1.time_ - 0) / var_292_3), (Mathf.Lerp(iter_292_2.color.b, arg_289_1.hightColor1.b, (arg_289_1.time_ - 0) / var_292_3)))
							else
								local var_292_4 = Mathf.Lerp(iter_292_2.color.r, 1, (arg_289_1.time_ - 0) / var_292_3)

								iter_292_2.color = Color.New(var_292_4, var_292_4, var_292_4)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps10092_1 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_292_4 then
						iter_292_4.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_289_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_292_5 = arg_289_1.actors_["10093"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.actorSpriteComps10093 == nil then
				arg_289_1.var_.actorSpriteComps10093 = var_292_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_6 = 2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_6 and not isNil(var_292_5) then
				if arg_289_1.var_.actorSpriteComps10093 then
					for iter_292_5, iter_292_6 in pairs(arg_289_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_292_6 then
							if arg_289_1.isInRecall_ then
								iter_292_6.color = Color.New(Mathf.Lerp(iter_292_6.color.r, arg_289_1.hightColor2.r, (arg_289_1.time_ - 0) / var_292_6), Mathf.Lerp(iter_292_6.color.g, arg_289_1.hightColor2.g, (arg_289_1.time_ - 0) / var_292_6), (Mathf.Lerp(iter_292_6.color.b, arg_289_1.hightColor2.b, (arg_289_1.time_ - 0) / var_292_6)))
							else
								local var_292_7 = Mathf.Lerp(iter_292_6.color.r, 0.5, (arg_289_1.time_ - 0) / var_292_6)

								iter_292_6.color = Color.New(var_292_7, var_292_7, var_292_7)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_6 and arg_289_1.time_ < 0 + var_292_6 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.actorSpriteComps10093 then
				for iter_292_7, iter_292_8 in pairs(arg_289_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_292_8 then
						iter_292_8.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_289_1.var_.actorSpriteComps10093 = nil
			end

			local var_292_8 = 0
			local var_292_9 = 0.675

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_10 = arg_289_1:GetWordFromCfg(413141069)
				local var_292_11 = arg_289_1:FormatText(var_292_10.content)

				arg_289_1.text_.text = var_292_11

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_13 = 27 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 27)

				if (27 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 27)) > 0 and var_292_9 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_8
					end
				end

				arg_289_1.text_.text = var_292_11
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141069", "story_v_out_413141.awb") ~= 0 then
					local var_292_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141069", "story_v_out_413141.awb") / 1000

					if var_292_14 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_8
					end

					if var_292_10.prefab_name ~= "" and arg_289_1.actors_[var_292_10.prefab_name] ~= nil then
						local var_292_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_10.prefab_name].transform, "story_v_out_413141", "413141069", "story_v_out_413141.awb")

						arg_289_1:RecordAudio("413141069", var_292_15)
						arg_289_1:RecordAudio("413141069", var_292_15)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_413141", "413141069", "story_v_out_413141.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_413141", "413141069", "story_v_out_413141.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_16 = math.max(var_292_9, arg_289_1.talkMaxDuration)

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_16 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_8) / var_292_16

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_8 + var_292_16 and arg_289_1.time_ < var_292_8 + var_292_16 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play413141070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 413141070
		arg_293_1.duration_ = 5.83

		local var_293_0 = {
			zh = 5.833,
			ja = 4.4
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
				arg_293_0:Play413141071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.6

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:GetWordFromCfg(413141070)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 24 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 24)

				if (24 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 24)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141070", "story_v_out_413141.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141070", "story_v_out_413141.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_out_413141", "413141070", "story_v_out_413141.awb")

						arg_293_1:RecordAudio("413141070", var_296_6)
						arg_293_1:RecordAudio("413141070", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_413141", "413141070", "story_v_out_413141.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_413141", "413141070", "story_v_out_413141.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play413141071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 413141071
		arg_297_1.duration_ = 10.83

		local var_297_0 = {
			zh = 7.9,
			ja = 10.833
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
				arg_297_0:Play413141072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 1.1

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:GetWordFromCfg(413141071)
				local var_300_2 = arg_297_1:FormatText(var_300_1.content)

				arg_297_1.text_.text = var_300_2

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_4 = 44 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 44)

				if (44 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 44)) > 0 and var_300_0 < var_300_4 then
					arg_297_1.talkMaxDuration = var_300_4

					if var_300_4 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_4 + 0
					end
				end

				arg_297_1.text_.text = var_300_2
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141071", "story_v_out_413141.awb") ~= 0 then
					local var_300_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141071", "story_v_out_413141.awb") / 1000

					if var_300_5 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + 0
					end

					if var_300_1.prefab_name ~= "" and arg_297_1.actors_[var_300_1.prefab_name] ~= nil then
						local var_300_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_1.prefab_name].transform, "story_v_out_413141", "413141071", "story_v_out_413141.awb")

						arg_297_1:RecordAudio("413141071", var_300_6)
						arg_297_1:RecordAudio("413141071", var_300_6)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_413141", "413141071", "story_v_out_413141.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_413141", "413141071", "story_v_out_413141.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_7 and arg_297_1.time_ < 0 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play413141072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 413141072
		arg_301_1.duration_ = 9.57

		local var_301_0 = {
			zh = 5.833,
			ja = 9.566
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
				arg_301_0:Play413141073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos10092_1 = arg_301_1.actors_["10092_1"].transform.localPosition
				arg_301_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_304_0 = 0, arg_301_1.actors_["10092_1"].transform.childCount - 1 do
					local var_304_0 = arg_301_1.actors_["10092_1"].transform:GetChild(iter_304_0)

					if var_304_0.name == "split_1_1" or not string.find(var_304_0.name, "split") then
						var_304_0.gameObject:SetActive(true)
					else
						var_304_0.gameObject:SetActive(false)
					end
				end
			end

			local var_304_1 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_1 then
				arg_301_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_301_1.time_ - 0) / var_304_1)
			end

			if arg_301_1.time_ >= 0 + var_304_1 and arg_301_1.time_ < 0 + var_304_1 + arg_304_0 then
				arg_301_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_304_2 = 0
			local var_304_3 = 0.8

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_4 = arg_301_1:GetWordFromCfg(413141072)
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

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141072", "story_v_out_413141.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141072", "story_v_out_413141.awb") / 1000

					if var_304_8 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_2
					end

					if var_304_4.prefab_name ~= "" and arg_301_1.actors_[var_304_4.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_4.prefab_name].transform, "story_v_out_413141", "413141072", "story_v_out_413141.awb")

						arg_301_1:RecordAudio("413141072", var_304_9)
						arg_301_1:RecordAudio("413141072", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_413141", "413141072", "story_v_out_413141.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_413141", "413141072", "story_v_out_413141.awb")
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
				actorName = "10092_1",
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
	Play413141073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 413141073
		arg_305_1.duration_ = 12.7

		local var_305_0 = {
			zh = 11,
			ja = 12.7
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
				arg_305_0:Play413141074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 1.375

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:GetWordFromCfg(413141073)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 55 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 55)

				if (55 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 55)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141073", "story_v_out_413141.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141073", "story_v_out_413141.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_out_413141", "413141073", "story_v_out_413141.awb")

						arg_305_1:RecordAudio("413141073", var_308_6)
						arg_305_1:RecordAudio("413141073", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_413141", "413141073", "story_v_out_413141.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_413141", "413141073", "story_v_out_413141.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play413141074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 413141074
		arg_309_1.duration_ = 8.07

		local var_309_0 = {
			zh = 6.6,
			ja = 8.066
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
				arg_309_0:Play413141075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.775

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:GetWordFromCfg(413141074)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 31 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 31)

				if (31 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 31)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141074", "story_v_out_413141.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141074", "story_v_out_413141.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_out_413141", "413141074", "story_v_out_413141.awb")

						arg_309_1:RecordAudio("413141074", var_312_6)
						arg_309_1:RecordAudio("413141074", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_413141", "413141074", "story_v_out_413141.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_413141", "413141074", "story_v_out_413141.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_7 and arg_309_1.time_ < 0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play413141075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 413141075
		arg_313_1.duration_ = 6.6

		local var_313_0 = {
			zh = 1.999999999999,
			ja = 6.6
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
				arg_313_0:Play413141076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos10092_1 = arg_313_1.actors_["10092_1"].transform.localPosition
				arg_313_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_316_0 = 0, arg_313_1.actors_["10092_1"].transform.childCount - 1 do
					local var_316_0 = arg_313_1.actors_["10092_1"].transform:GetChild(iter_316_0)

					if var_316_0.name == "split_5" or not string.find(var_316_0.name, "split") then
						var_316_0.gameObject:SetActive(true)
					else
						var_316_0.gameObject:SetActive(false)
					end
				end
			end

			local var_316_1 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_1 then
				arg_313_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_313_1.time_ - 0) / var_316_1)
			end

			if arg_313_1.time_ >= 0 + var_316_1 and arg_313_1.time_ < 0 + var_316_1 + arg_316_0 then
				arg_313_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_316_2 = arg_313_1.actors_["10092_1"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.actorSpriteComps10092_1 == nil then
				arg_313_1.var_.actorSpriteComps10092_1 = var_316_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_3 = 2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_3 and not isNil(var_316_2) then
				if arg_313_1.var_.actorSpriteComps10092_1 then
					for iter_316_1, iter_316_2 in pairs(arg_313_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_316_2 then
							if arg_313_1.isInRecall_ then
								iter_316_2.color = Color.New(Mathf.Lerp(iter_316_2.color.r, arg_313_1.hightColor1.r, (arg_313_1.time_ - 0) / var_316_3), Mathf.Lerp(iter_316_2.color.g, arg_313_1.hightColor1.g, (arg_313_1.time_ - 0) / var_316_3), (Mathf.Lerp(iter_316_2.color.b, arg_313_1.hightColor1.b, (arg_313_1.time_ - 0) / var_316_3)))
							else
								local var_316_4 = Mathf.Lerp(iter_316_2.color.r, 1, (arg_313_1.time_ - 0) / var_316_3)

								iter_316_2.color = Color.New(var_316_4, var_316_4, var_316_4)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_3 and arg_313_1.time_ < 0 + var_316_3 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.actorSpriteComps10092_1 then
				for iter_316_3, iter_316_4 in pairs(arg_313_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_316_4 then
						iter_316_4.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_313_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_316_5 = 0
			local var_316_6 = 0.325

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_7 = arg_313_1:GetWordFromCfg(413141075)
				local var_316_8 = arg_313_1:FormatText(var_316_7.content)

				arg_313_1.text_.text = var_316_8

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_10 = 13 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 13)

				if (13 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 13)) > 0 and var_316_6 < var_316_10 then
					arg_313_1.talkMaxDuration = var_316_10

					if var_316_10 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_5
					end
				end

				arg_313_1.text_.text = var_316_8
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141075", "story_v_out_413141.awb") ~= 0 then
					local var_316_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141075", "story_v_out_413141.awb") / 1000

					if var_316_11 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_11 + var_316_5
					end

					if var_316_7.prefab_name ~= "" and arg_313_1.actors_[var_316_7.prefab_name] ~= nil then
						local var_316_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_7.prefab_name].transform, "story_v_out_413141", "413141075", "story_v_out_413141.awb")

						arg_313_1:RecordAudio("413141075", var_316_12)
						arg_313_1:RecordAudio("413141075", var_316_12)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_413141", "413141075", "story_v_out_413141.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_413141", "413141075", "story_v_out_413141.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_13 = math.max(var_316_6, arg_313_1.talkMaxDuration)

			if var_316_5 <= arg_313_1.time_ and arg_313_1.time_ < var_316_5 + var_316_13 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_5) / var_316_13

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_5 + var_316_13 and arg_313_1.time_ < var_316_5 + var_316_13 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 413141076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play413141077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos10092_1 = arg_317_1.actors_["10092_1"].transform.localPosition
				arg_317_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_320_0 = 0, arg_317_1.actors_["10092_1"].transform.childCount - 1 do
					local var_320_0 = arg_317_1.actors_["10092_1"].transform:GetChild(iter_320_0)

					if var_320_0.name == "" or not string.find(var_320_0.name, "split") then
						var_320_0.gameObject:SetActive(true)
					else
						var_320_0.gameObject:SetActive(false)
					end
				end
			end

			local var_320_1 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_1 then
				arg_317_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_317_1.time_ - 0) / var_320_1)
			end

			if arg_317_1.time_ >= 0 + var_320_1 and arg_317_1.time_ < 0 + var_320_1 + arg_320_0 then
				arg_317_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_320_2 = arg_317_1.actors_["10092_1"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.actorSpriteComps10092_1 == nil then
				arg_317_1.var_.actorSpriteComps10092_1 = var_320_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_3 = 2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_3 and not isNil(var_320_2) then
				if arg_317_1.var_.actorSpriteComps10092_1 then
					for iter_320_1, iter_320_2 in pairs(arg_317_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_320_2 then
							if arg_317_1.isInRecall_ then
								iter_320_2.color = Color.New(Mathf.Lerp(iter_320_2.color.r, arg_317_1.hightColor2.r, (arg_317_1.time_ - 0) / var_320_3), Mathf.Lerp(iter_320_2.color.g, arg_317_1.hightColor2.g, (arg_317_1.time_ - 0) / var_320_3), (Mathf.Lerp(iter_320_2.color.b, arg_317_1.hightColor2.b, (arg_317_1.time_ - 0) / var_320_3)))
							else
								local var_320_4 = Mathf.Lerp(iter_320_2.color.r, 0.5, (arg_317_1.time_ - 0) / var_320_3)

								iter_320_2.color = Color.New(var_320_4, var_320_4, var_320_4)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_3 and arg_317_1.time_ < 0 + var_320_3 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.actorSpriteComps10092_1 then
				for iter_320_3, iter_320_4 in pairs(arg_317_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_320_4 then
						iter_320_4.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_317_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_320_5 = arg_317_1.actors_["10093"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos10093 = var_320_5.localPosition
				var_320_5.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("10093", 7)

				for iter_320_5 = 0, var_320_5.childCount - 1 do
					local var_320_6 = var_320_5:GetChild(iter_320_5)

					if var_320_6.name == "" or not string.find(var_320_6.name, "split") then
						var_320_6.gameObject:SetActive(true)
					else
						var_320_6.gameObject:SetActive(false)
					end
				end
			end

			local var_320_7 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_7 then
				var_320_5.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_317_1.time_ - 0) / var_320_7)
			end

			if arg_317_1.time_ >= 0 + var_320_7 and arg_317_1.time_ < 0 + var_320_7 + arg_320_0 then
				var_320_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_320_8 = 0
			local var_320_9 = 0.8

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_10 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(413141076).content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_12 = 32 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_10) / 32)

				if (32 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_10) / 32)) > 0 and var_320_9 < var_320_12 then
					arg_317_1.talkMaxDuration = var_320_12

					if var_320_12 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_12 + var_320_8
					end
				end

				arg_317_1.text_.text = var_320_10
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_13 = math.max(var_320_9, arg_317_1.talkMaxDuration)

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_13 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_8) / var_320_13

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_8 + var_320_13 and arg_317_1.time_ < var_320_8 + var_320_13 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play413141077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 413141077
		arg_321_1.duration_ = 7.7

		local var_321_0 = {
			zh = 5.166,
			ja = 7.7
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
				arg_321_0:Play413141078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos10093 = arg_321_1.actors_["10093"].transform.localPosition
				arg_321_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("10093", 4)

				for iter_324_0 = 0, arg_321_1.actors_["10093"].transform.childCount - 1 do
					local var_324_0 = arg_321_1.actors_["10093"].transform:GetChild(iter_324_0)

					if var_324_0.name == "split_4" or not string.find(var_324_0.name, "split") then
						var_324_0.gameObject:SetActive(true)
					else
						var_324_0.gameObject:SetActive(false)
					end
				end
			end

			local var_324_1 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_1 then
				arg_321_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_321_1.time_ - 0) / var_324_1)
			end

			if arg_321_1.time_ >= 0 + var_324_1 and arg_321_1.time_ < 0 + var_324_1 + arg_324_0 then
				arg_321_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_324_2 = arg_321_1.actors_["10093"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_2) and arg_321_1.var_.actorSpriteComps10093 == nil then
				arg_321_1.var_.actorSpriteComps10093 = var_324_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_3 = 2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_3 and not isNil(var_324_2) then
				if arg_321_1.var_.actorSpriteComps10093 then
					for iter_324_1, iter_324_2 in pairs(arg_321_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_324_2 then
							if arg_321_1.isInRecall_ then
								iter_324_2.color = Color.New(Mathf.Lerp(iter_324_2.color.r, arg_321_1.hightColor1.r, (arg_321_1.time_ - 0) / var_324_3), Mathf.Lerp(iter_324_2.color.g, arg_321_1.hightColor1.g, (arg_321_1.time_ - 0) / var_324_3), (Mathf.Lerp(iter_324_2.color.b, arg_321_1.hightColor1.b, (arg_321_1.time_ - 0) / var_324_3)))
							else
								local var_324_4 = Mathf.Lerp(iter_324_2.color.r, 1, (arg_321_1.time_ - 0) / var_324_3)

								iter_324_2.color = Color.New(var_324_4, var_324_4, var_324_4)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_3 and arg_321_1.time_ < 0 + var_324_3 + arg_324_0 and not isNil(var_324_2) and arg_321_1.var_.actorSpriteComps10093 then
				for iter_324_3, iter_324_4 in pairs(arg_321_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_324_4 then
						iter_324_4.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_321_1.var_.actorSpriteComps10093 = nil
			end

			local var_324_5 = 0
			local var_324_6 = 0.525

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_7 = arg_321_1:GetWordFromCfg(413141077)
				local var_324_8 = arg_321_1:FormatText(var_324_7.content)

				arg_321_1.text_.text = var_324_8

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_10 = 21 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 21)

				if (21 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 21)) > 0 and var_324_6 < var_324_10 then
					arg_321_1.talkMaxDuration = var_324_10

					if var_324_10 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_5
					end
				end

				arg_321_1.text_.text = var_324_8
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141077", "story_v_out_413141.awb") ~= 0 then
					local var_324_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141077", "story_v_out_413141.awb") / 1000

					if var_324_11 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_11 + var_324_5
					end

					if var_324_7.prefab_name ~= "" and arg_321_1.actors_[var_324_7.prefab_name] ~= nil then
						local var_324_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_7.prefab_name].transform, "story_v_out_413141", "413141077", "story_v_out_413141.awb")

						arg_321_1:RecordAudio("413141077", var_324_12)
						arg_321_1:RecordAudio("413141077", var_324_12)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_413141", "413141077", "story_v_out_413141.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_413141", "413141077", "story_v_out_413141.awb")
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
				actorName = "10093",
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
	Play413141078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 413141078
		arg_325_1.duration_ = 13.83

		local var_325_0 = {
			zh = 13.833,
			ja = 7.366
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
				arg_325_0:Play413141079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos10092_1 = arg_325_1.actors_["10092_1"].transform.localPosition
				arg_325_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_328_0 = 0, arg_325_1.actors_["10092_1"].transform.childCount - 1 do
					local var_328_0 = arg_325_1.actors_["10092_1"].transform:GetChild(iter_328_0)

					if var_328_0.name == "split_8" or not string.find(var_328_0.name, "split") then
						var_328_0.gameObject:SetActive(true)
					else
						var_328_0.gameObject:SetActive(false)
					end
				end
			end

			local var_328_1 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_1 then
				arg_325_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_325_1.time_ - 0) / var_328_1)
			end

			if arg_325_1.time_ >= 0 + var_328_1 and arg_325_1.time_ < 0 + var_328_1 + arg_328_0 then
				arg_325_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_328_2 = arg_325_1.actors_["10092_1"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.actorSpriteComps10092_1 == nil then
				arg_325_1.var_.actorSpriteComps10092_1 = var_328_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_3 = 2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_3 and not isNil(var_328_2) then
				if arg_325_1.var_.actorSpriteComps10092_1 then
					for iter_328_1, iter_328_2 in pairs(arg_325_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_328_2 then
							if arg_325_1.isInRecall_ then
								iter_328_2.color = Color.New(Mathf.Lerp(iter_328_2.color.r, arg_325_1.hightColor1.r, (arg_325_1.time_ - 0) / var_328_3), Mathf.Lerp(iter_328_2.color.g, arg_325_1.hightColor1.g, (arg_325_1.time_ - 0) / var_328_3), (Mathf.Lerp(iter_328_2.color.b, arg_325_1.hightColor1.b, (arg_325_1.time_ - 0) / var_328_3)))
							else
								local var_328_4 = Mathf.Lerp(iter_328_2.color.r, 1, (arg_325_1.time_ - 0) / var_328_3)

								iter_328_2.color = Color.New(var_328_4, var_328_4, var_328_4)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= 0 + var_328_3 and arg_325_1.time_ < 0 + var_328_3 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.actorSpriteComps10092_1 then
				for iter_328_3, iter_328_4 in pairs(arg_325_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_328_4 then
						iter_328_4.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_325_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_328_5 = arg_325_1.actors_["10093"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_5) and arg_325_1.var_.actorSpriteComps10093 == nil then
				arg_325_1.var_.actorSpriteComps10093 = var_328_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_6 = 2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_6 and not isNil(var_328_5) then
				if arg_325_1.var_.actorSpriteComps10093 then
					for iter_328_5, iter_328_6 in pairs(arg_325_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_328_6 then
							if arg_325_1.isInRecall_ then
								iter_328_6.color = Color.New(Mathf.Lerp(iter_328_6.color.r, arg_325_1.hightColor2.r, (arg_325_1.time_ - 0) / var_328_6), Mathf.Lerp(iter_328_6.color.g, arg_325_1.hightColor2.g, (arg_325_1.time_ - 0) / var_328_6), (Mathf.Lerp(iter_328_6.color.b, arg_325_1.hightColor2.b, (arg_325_1.time_ - 0) / var_328_6)))
							else
								local var_328_7 = Mathf.Lerp(iter_328_6.color.r, 0.5, (arg_325_1.time_ - 0) / var_328_6)

								iter_328_6.color = Color.New(var_328_7, var_328_7, var_328_7)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= 0 + var_328_6 and arg_325_1.time_ < 0 + var_328_6 + arg_328_0 and not isNil(var_328_5) and arg_325_1.var_.actorSpriteComps10093 then
				for iter_328_7, iter_328_8 in pairs(arg_325_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_328_8 then
						iter_328_8.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_325_1.var_.actorSpriteComps10093 = nil
			end

			local var_328_8 = 0
			local var_328_9 = 1.2

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_10 = arg_325_1:GetWordFromCfg(413141078)
				local var_328_11 = arg_325_1:FormatText(var_328_10.content)

				arg_325_1.text_.text = var_328_11

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_13 = 48 <= 0 and var_328_9 or var_328_9 * (utf8.len(var_328_11) / 48)

				if (48 <= 0 and var_328_9 or var_328_9 * (utf8.len(var_328_11) / 48)) > 0 and var_328_9 < var_328_13 then
					arg_325_1.talkMaxDuration = var_328_13

					if var_328_13 + var_328_8 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_13 + var_328_8
					end
				end

				arg_325_1.text_.text = var_328_11
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141078", "story_v_out_413141.awb") ~= 0 then
					local var_328_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141078", "story_v_out_413141.awb") / 1000

					if var_328_14 + var_328_8 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_14 + var_328_8
					end

					if var_328_10.prefab_name ~= "" and arg_325_1.actors_[var_328_10.prefab_name] ~= nil then
						local var_328_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_10.prefab_name].transform, "story_v_out_413141", "413141078", "story_v_out_413141.awb")

						arg_325_1:RecordAudio("413141078", var_328_15)
						arg_325_1:RecordAudio("413141078", var_328_15)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_413141", "413141078", "story_v_out_413141.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_413141", "413141078", "story_v_out_413141.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_16 = math.max(var_328_9, arg_325_1.talkMaxDuration)

			if var_328_8 <= arg_325_1.time_ and arg_325_1.time_ < var_328_8 + var_328_16 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_8) / var_328_16

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_8 + var_328_16 and arg_325_1.time_ < var_328_8 + var_328_16 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 413141079
		arg_329_1.duration_ = 6.83

		local var_329_0 = {
			zh = 6.833,
			ja = 5.3
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
				arg_329_0:Play413141080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["10092_1"]) and arg_329_1.var_.actorSpriteComps10092_1 == nil then
				arg_329_1.var_.actorSpriteComps10092_1 = arg_329_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_0 = 2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["10092_1"]) then
				if arg_329_1.var_.actorSpriteComps10092_1 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["10092_1"]) and arg_329_1.var_.actorSpriteComps10092_1 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_332_3 then
						iter_332_3.color = arg_329_1.isInRecall_ and (arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_329_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_332_2 = 0
			local var_332_3 = 0.65

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_2 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_4 = arg_329_1:GetWordFromCfg(413141079)
				local var_332_5 = arg_329_1:FormatText(var_332_4.content)

				arg_329_1.text_.text = var_332_5

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_7 = 26 <= 0 and var_332_3 or var_332_3 * (utf8.len(var_332_5) / 26)

				if (26 <= 0 and var_332_3 or var_332_3 * (utf8.len(var_332_5) / 26)) > 0 and var_332_3 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_2
					end
				end

				arg_329_1.text_.text = var_332_5
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141079", "story_v_out_413141.awb") ~= 0 then
					local var_332_8 = manager.audio:GetVoiceLength("story_v_out_413141", "413141079", "story_v_out_413141.awb") / 1000

					if var_332_8 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_2
					end

					if var_332_4.prefab_name ~= "" and arg_329_1.actors_[var_332_4.prefab_name] ~= nil then
						local var_332_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_4.prefab_name].transform, "story_v_out_413141", "413141079", "story_v_out_413141.awb")

						arg_329_1:RecordAudio("413141079", var_332_9)
						arg_329_1:RecordAudio("413141079", var_332_9)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_413141", "413141079", "story_v_out_413141.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_413141", "413141079", "story_v_out_413141.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_10 = math.max(var_332_3, arg_329_1.talkMaxDuration)

			if var_332_2 <= arg_329_1.time_ and arg_329_1.time_ < var_332_2 + var_332_10 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_2) / var_332_10

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_2 + var_332_10 and arg_329_1.time_ < var_332_2 + var_332_10 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play413141080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 413141080
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play413141081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos10092_1 = arg_333_1.actors_["10092_1"].transform.localPosition
				arg_333_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("10092_1", 6)

				for iter_336_0 = 0, arg_333_1.actors_["10092_1"].transform.childCount - 1 do
					local var_336_0 = arg_333_1.actors_["10092_1"].transform:GetChild(iter_336_0)

					if var_336_0.name == "" or not string.find(var_336_0.name, "split") then
						var_336_0.gameObject:SetActive(true)
					else
						var_336_0.gameObject:SetActive(false)
					end
				end
			end

			local var_336_1 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_1 then
				arg_333_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10092_1, Vector3.New(1500, -300, -295), (arg_333_1.time_ - 0) / var_336_1)
			end

			if arg_333_1.time_ >= 0 + var_336_1 and arg_333_1.time_ < 0 + var_336_1 + arg_336_0 then
				arg_333_1.actors_["10092_1"].transform.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_336_2 = arg_333_1.actors_["10093"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos10093 = var_336_2.localPosition
				var_336_2.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("10093", 6)

				for iter_336_1 = 0, var_336_2.childCount - 1 do
					local var_336_3 = var_336_2:GetChild(iter_336_1)

					if var_336_3.name == "" or not string.find(var_336_3.name, "split") then
						var_336_3.gameObject:SetActive(true)
					else
						var_336_3.gameObject:SetActive(false)
					end
				end
			end

			local var_336_4 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 then
				var_336_2.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_333_1.time_ - 0) / var_336_4)
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 then
				var_336_2.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_336_5 = arg_333_1.actors_["10092"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_5) and arg_333_1.var_.actorSpriteComps10092 == nil then
				arg_333_1.var_.actorSpriteComps10092 = var_336_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_6 = 2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_6 and not isNil(var_336_5) then
				if arg_333_1.var_.actorSpriteComps10092 then
					for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_336_3 then
							if arg_333_1.isInRecall_ then
								iter_336_3.color = Color.New(Mathf.Lerp(iter_336_3.color.r, arg_333_1.hightColor2.r, (arg_333_1.time_ - 0) / var_336_6), Mathf.Lerp(iter_336_3.color.g, arg_333_1.hightColor2.g, (arg_333_1.time_ - 0) / var_336_6), (Mathf.Lerp(iter_336_3.color.b, arg_333_1.hightColor2.b, (arg_333_1.time_ - 0) / var_336_6)))
							else
								local var_336_7 = Mathf.Lerp(iter_336_3.color.r, 0.5, (arg_333_1.time_ - 0) / var_336_6)

								iter_336_3.color = Color.New(var_336_7, var_336_7, var_336_7)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_6 and arg_333_1.time_ < 0 + var_336_6 + arg_336_0 and not isNil(var_336_5) and arg_333_1.var_.actorSpriteComps10092 then
				for iter_336_4, iter_336_5 in pairs(arg_333_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_336_5 then
						iter_336_5.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_333_1.var_.actorSpriteComps10092 = nil
			end

			local var_336_8 = arg_333_1.actors_["10093"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps10093 == nil then
				arg_333_1.var_.actorSpriteComps10093 = var_336_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_9 = 2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_9 and not isNil(var_336_8) then
				if arg_333_1.var_.actorSpriteComps10093 then
					for iter_336_6, iter_336_7 in pairs(arg_333_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_336_7 then
							if arg_333_1.isInRecall_ then
								iter_336_7.color = Color.New(Mathf.Lerp(iter_336_7.color.r, arg_333_1.hightColor2.r, (arg_333_1.time_ - 0) / var_336_9), Mathf.Lerp(iter_336_7.color.g, arg_333_1.hightColor2.g, (arg_333_1.time_ - 0) / var_336_9), (Mathf.Lerp(iter_336_7.color.b, arg_333_1.hightColor2.b, (arg_333_1.time_ - 0) / var_336_9)))
							else
								local var_336_10 = Mathf.Lerp(iter_336_7.color.r, 0.5, (arg_333_1.time_ - 0) / var_336_9)

								iter_336_7.color = Color.New(var_336_10, var_336_10, var_336_10)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_9 and arg_333_1.time_ < 0 + var_336_9 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps10093 then
				for iter_336_8, iter_336_9 in pairs(arg_333_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_336_9 then
						iter_336_9.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_333_1.var_.actorSpriteComps10093 = nil
			end

			local var_336_11 = 0
			local var_336_12 = 0.925

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_11 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_13 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(413141080).content)

				arg_333_1.text_.text = var_336_13

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_15 = 37 <= 0 and var_336_12 or var_336_12 * (utf8.len(var_336_13) / 37)

				if (37 <= 0 and var_336_12 or var_336_12 * (utf8.len(var_336_13) / 37)) > 0 and var_336_12 < var_336_15 then
					arg_333_1.talkMaxDuration = var_336_15

					if var_336_15 + var_336_11 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_15 + var_336_11
					end
				end

				arg_333_1.text_.text = var_336_13
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_16 = math.max(var_336_12, arg_333_1.talkMaxDuration)

			if var_336_11 <= arg_333_1.time_ and arg_333_1.time_ < var_336_11 + var_336_16 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_11) / var_336_16

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_11 + var_336_16 and arg_333_1.time_ < var_336_11 + var_336_16 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413141081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 413141081
		arg_337_1.duration_ = 7.63

		local var_337_0 = {
			zh = 6.033,
			ja = 7.633
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
				arg_337_0:Play413141082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos10092_1 = arg_337_1.actors_["10092_1"].transform.localPosition
				arg_337_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_340_0 = 0, arg_337_1.actors_["10092_1"].transform.childCount - 1 do
					local var_340_0 = arg_337_1.actors_["10092_1"].transform:GetChild(iter_340_0)

					if var_340_0.name == "split_8" or not string.find(var_340_0.name, "split") then
						var_340_0.gameObject:SetActive(true)
					else
						var_340_0.gameObject:SetActive(false)
					end
				end
			end

			local var_340_1 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_1 then
				arg_337_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_337_1.time_ - 0) / var_340_1)
			end

			if arg_337_1.time_ >= 0 + var_340_1 and arg_337_1.time_ < 0 + var_340_1 + arg_340_0 then
				arg_337_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_340_2 = arg_337_1.actors_["10092_1"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.actorSpriteComps10092_1 == nil then
				arg_337_1.var_.actorSpriteComps10092_1 = var_340_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_3 = 2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_3 and not isNil(var_340_2) then
				if arg_337_1.var_.actorSpriteComps10092_1 then
					for iter_340_1, iter_340_2 in pairs(arg_337_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_340_2 then
							if arg_337_1.isInRecall_ then
								iter_340_2.color = Color.New(Mathf.Lerp(iter_340_2.color.r, arg_337_1.hightColor1.r, (arg_337_1.time_ - 0) / var_340_3), Mathf.Lerp(iter_340_2.color.g, arg_337_1.hightColor1.g, (arg_337_1.time_ - 0) / var_340_3), (Mathf.Lerp(iter_340_2.color.b, arg_337_1.hightColor1.b, (arg_337_1.time_ - 0) / var_340_3)))
							else
								local var_340_4 = Mathf.Lerp(iter_340_2.color.r, 1, (arg_337_1.time_ - 0) / var_340_3)

								iter_340_2.color = Color.New(var_340_4, var_340_4, var_340_4)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_3 and arg_337_1.time_ < 0 + var_340_3 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.actorSpriteComps10092_1 then
				for iter_340_3, iter_340_4 in pairs(arg_337_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_340_4 then
						iter_340_4.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_337_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_340_5 = 0
			local var_340_6 = 0.55

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_5 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_7 = arg_337_1:GetWordFromCfg(413141081)
				local var_340_8 = arg_337_1:FormatText(var_340_7.content)

				arg_337_1.text_.text = var_340_8

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_10 = 22 <= 0 and var_340_6 or var_340_6 * (utf8.len(var_340_8) / 22)

				if (22 <= 0 and var_340_6 or var_340_6 * (utf8.len(var_340_8) / 22)) > 0 and var_340_6 < var_340_10 then
					arg_337_1.talkMaxDuration = var_340_10

					if var_340_10 + var_340_5 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_5
					end
				end

				arg_337_1.text_.text = var_340_8
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141081", "story_v_out_413141.awb") ~= 0 then
					local var_340_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141081", "story_v_out_413141.awb") / 1000

					if var_340_11 + var_340_5 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_11 + var_340_5
					end

					if var_340_7.prefab_name ~= "" and arg_337_1.actors_[var_340_7.prefab_name] ~= nil then
						local var_340_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_7.prefab_name].transform, "story_v_out_413141", "413141081", "story_v_out_413141.awb")

						arg_337_1:RecordAudio("413141081", var_340_12)
						arg_337_1:RecordAudio("413141081", var_340_12)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_413141", "413141081", "story_v_out_413141.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_413141", "413141081", "story_v_out_413141.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_13 = math.max(var_340_6, arg_337_1.talkMaxDuration)

			if var_340_5 <= arg_337_1.time_ and arg_337_1.time_ < var_340_5 + var_340_13 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_5) / var_340_13

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_5 + var_340_13 and arg_337_1.time_ < var_340_5 + var_340_13 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 413141082
		arg_341_1.duration_ = 8.82

		local var_341_0 = {
			zh = 4.325,
			ja = 8.825
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
				arg_341_0:Play413141083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos10092_1 = arg_341_1.actors_["10092_1"].transform.localPosition
				arg_341_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_344_0 = 0, arg_341_1.actors_["10092_1"].transform.childCount - 1 do
					local var_344_0 = arg_341_1.actors_["10092_1"].transform:GetChild(iter_344_0)

					if var_344_0.name == "" or not string.find(var_344_0.name, "split") then
						var_344_0.gameObject:SetActive(true)
					else
						var_344_0.gameObject:SetActive(false)
					end
				end
			end

			local var_344_1 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_1 then
				arg_341_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_341_1.time_ - 0) / var_344_1)
			end

			if arg_341_1.time_ >= 0 + var_344_1 and arg_341_1.time_ < 0 + var_344_1 + arg_344_0 then
				arg_341_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_344_2 = 0

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 then
				arg_341_1.allBtn_.enabled = false
			end

			if arg_341_1.time_ >= var_344_2 + 0.625 and arg_341_1.time_ < var_344_2 + 0.625 + arg_344_0 then
				arg_341_1.allBtn_.enabled = true
			end

			if arg_341_1.frameCnt_ <= 1 then
				arg_341_1.dialog_:SetActive(false)
			end

			local var_344_3 = 0.625
			local var_344_4 = 0.375

			if 0.625 < arg_341_1.time_ and arg_341_1.time_ <= var_344_3 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0

				arg_341_1.dialog_:SetActive(true)

				arg_341_1.dialogCg_.alpha = 0

				local var_344_5 = LeanTween.value(arg_341_1.dialog_, 0, 1, 0.3)

				var_344_5:setOnUpdate(LuaHelper.FloatAction(function(arg_345_0)
					arg_341_1.dialogCg_.alpha = arg_345_0
				end))
				var_344_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_341_1.dialog_)
					var_344_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_341_1.duration_ = arg_341_1.duration_ + 0.3

				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(413141082)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 15 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_7) / 15)

				if (15 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_7) / 15)) > 0 and var_344_4 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9
					var_344_3 = var_344_3 + 0.3

					if var_344_9 + var_344_3 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_3
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141082", "story_v_out_413141.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_out_413141", "413141082", "story_v_out_413141.awb") / 1000

					if var_344_10 + var_344_3 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_3
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_out_413141", "413141082", "story_v_out_413141.awb")

						arg_341_1:RecordAudio("413141082", var_344_11)
						arg_341_1:RecordAudio("413141082", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_413141", "413141082", "story_v_out_413141.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_413141", "413141082", "story_v_out_413141.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = var_344_3 + 0.3
			local var_344_13 = math.max(var_344_4, arg_341_1.talkMaxDuration)

			if var_344_3 + 0.3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_12 + var_344_13 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_12) / var_344_13

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_12 + var_344_13 and arg_341_1.time_ < var_344_12 + var_344_13 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play413141083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 413141083
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play413141084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["10092_1"]) and arg_347_1.var_.actorSpriteComps10092_1 == nil then
				arg_347_1.var_.actorSpriteComps10092_1 = arg_347_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_0 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["10092_1"]) then
				if arg_347_1.var_.actorSpriteComps10092_1 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								iter_350_1.color = Color.New(Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor2.r, (arg_347_1.time_ - 0) / var_350_0), Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor2.g, (arg_347_1.time_ - 0) / var_350_0), (Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor2.b, (arg_347_1.time_ - 0) / var_350_0)))
							else
								local var_350_1 = Mathf.Lerp(iter_350_1.color.r, 0.5, (arg_347_1.time_ - 0) / var_350_0)

								iter_350_1.color = Color.New(var_350_1, var_350_1, var_350_1)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["10092_1"]) and arg_347_1.var_.actorSpriteComps10092_1 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_350_3 then
						iter_350_3.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_347_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_350_2 = 0
			local var_350_3 = 1.1

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_2 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_4 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(413141083).content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_6 = 44 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_4) / 44)

				if (44 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_4) / 44)) > 0 and var_350_3 < var_350_6 then
					arg_347_1.talkMaxDuration = var_350_6

					if var_350_6 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_6 + var_350_2
					end
				end

				arg_347_1.text_.text = var_350_4
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_3, arg_347_1.talkMaxDuration)

			if var_350_2 <= arg_347_1.time_ and arg_347_1.time_ < var_350_2 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_2) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_2 + var_350_7 and arg_347_1.time_ < var_350_2 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play413141084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 413141084
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play413141085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.625

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(413141084).content)

				arg_351_1.text_.text = var_354_1

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_3 = 25 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 25)

				if (25 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 25)) > 0 and var_354_0 < var_354_3 then
					arg_351_1.talkMaxDuration = var_354_3

					if var_354_3 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_3 + 0
					end
				end

				arg_351_1.text_.text = var_354_1
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_4 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_4

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play413141085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 413141085
		arg_355_1.duration_ = 3.77

		local var_355_0 = {
			zh = 3.766,
			ja = 3.366
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play413141086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos10093 = arg_355_1.actors_["10093"].transform.localPosition
				arg_355_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10093", 3)

				for iter_358_0 = 0, arg_355_1.actors_["10093"].transform.childCount - 1 do
					local var_358_0 = arg_355_1.actors_["10093"].transform:GetChild(iter_358_0)

					if var_358_0.name == "split_3" or not string.find(var_358_0.name, "split") then
						var_358_0.gameObject:SetActive(true)
					else
						var_358_0.gameObject:SetActive(false)
					end
				end
			end

			local var_358_1 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_1 then
				arg_355_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_355_1.time_ - 0) / var_358_1)
			end

			if arg_355_1.time_ >= 0 + var_358_1 and arg_355_1.time_ < 0 + var_358_1 + arg_358_0 then
				arg_355_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_358_2 = arg_355_1.actors_["10093"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.actorSpriteComps10093 == nil then
				arg_355_1.var_.actorSpriteComps10093 = var_358_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_3 = 2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_3 and not isNil(var_358_2) then
				if arg_355_1.var_.actorSpriteComps10093 then
					for iter_358_1, iter_358_2 in pairs(arg_355_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_358_2 then
							if arg_355_1.isInRecall_ then
								iter_358_2.color = Color.New(Mathf.Lerp(iter_358_2.color.r, arg_355_1.hightColor1.r, (arg_355_1.time_ - 0) / var_358_3), Mathf.Lerp(iter_358_2.color.g, arg_355_1.hightColor1.g, (arg_355_1.time_ - 0) / var_358_3), (Mathf.Lerp(iter_358_2.color.b, arg_355_1.hightColor1.b, (arg_355_1.time_ - 0) / var_358_3)))
							else
								local var_358_4 = Mathf.Lerp(iter_358_2.color.r, 1, (arg_355_1.time_ - 0) / var_358_3)

								iter_358_2.color = Color.New(var_358_4, var_358_4, var_358_4)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_3 and arg_355_1.time_ < 0 + var_358_3 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.actorSpriteComps10093 then
				for iter_358_3, iter_358_4 in pairs(arg_355_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_358_4 then
						iter_358_4.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_355_1.var_.actorSpriteComps10093 = nil
			end

			local var_358_5 = 0
			local var_358_6 = 0.475

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_5 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_7 = arg_355_1:GetWordFromCfg(413141085)
				local var_358_8 = arg_355_1:FormatText(var_358_7.content)

				arg_355_1.text_.text = var_358_8

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_10 = 19 <= 0 and var_358_6 or var_358_6 * (utf8.len(var_358_8) / 19)

				if (19 <= 0 and var_358_6 or var_358_6 * (utf8.len(var_358_8) / 19)) > 0 and var_358_6 < var_358_10 then
					arg_355_1.talkMaxDuration = var_358_10

					if var_358_10 + var_358_5 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_5
					end
				end

				arg_355_1.text_.text = var_358_8
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141085", "story_v_out_413141.awb") ~= 0 then
					local var_358_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141085", "story_v_out_413141.awb") / 1000

					if var_358_11 + var_358_5 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_11 + var_358_5
					end

					if var_358_7.prefab_name ~= "" and arg_355_1.actors_[var_358_7.prefab_name] ~= nil then
						local var_358_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_7.prefab_name].transform, "story_v_out_413141", "413141085", "story_v_out_413141.awb")

						arg_355_1:RecordAudio("413141085", var_358_12)
						arg_355_1:RecordAudio("413141085", var_358_12)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_413141", "413141085", "story_v_out_413141.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_413141", "413141085", "story_v_out_413141.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_13 = math.max(var_358_6, arg_355_1.talkMaxDuration)

			if var_358_5 <= arg_355_1.time_ and arg_355_1.time_ < var_358_5 + var_358_13 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_5) / var_358_13

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_5 + var_358_13 and arg_355_1.time_ < var_358_5 + var_358_13 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play413141086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 413141086
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play413141087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos10093 = arg_359_1.actors_["10093"].transform.localPosition
				arg_359_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10093", 6)

				for iter_362_0 = 0, arg_359_1.actors_["10093"].transform.childCount - 1 do
					local var_362_0 = arg_359_1.actors_["10093"].transform:GetChild(iter_362_0)

					if var_362_0.name == "" or not string.find(var_362_0.name, "split") then
						var_362_0.gameObject:SetActive(true)
					else
						var_362_0.gameObject:SetActive(false)
					end
				end
			end

			local var_362_1 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_1 then
				arg_359_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_359_1.time_ - 0) / var_362_1)
			end

			if arg_359_1.time_ >= 0 + var_362_1 and arg_359_1.time_ < 0 + var_362_1 + arg_362_0 then
				arg_359_1.actors_["10093"].transform.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_362_2 = arg_359_1.actors_["10093"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.actorSpriteComps10093 == nil then
				arg_359_1.var_.actorSpriteComps10093 = var_362_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_3 = 2

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_3 and not isNil(var_362_2) then
				if arg_359_1.var_.actorSpriteComps10093 then
					for iter_362_1, iter_362_2 in pairs(arg_359_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_362_2 then
							if arg_359_1.isInRecall_ then
								iter_362_2.color = Color.New(Mathf.Lerp(iter_362_2.color.r, arg_359_1.hightColor2.r, (arg_359_1.time_ - 0) / var_362_3), Mathf.Lerp(iter_362_2.color.g, arg_359_1.hightColor2.g, (arg_359_1.time_ - 0) / var_362_3), (Mathf.Lerp(iter_362_2.color.b, arg_359_1.hightColor2.b, (arg_359_1.time_ - 0) / var_362_3)))
							else
								local var_362_4 = Mathf.Lerp(iter_362_2.color.r, 0.5, (arg_359_1.time_ - 0) / var_362_3)

								iter_362_2.color = Color.New(var_362_4, var_362_4, var_362_4)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= 0 + var_362_3 and arg_359_1.time_ < 0 + var_362_3 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.actorSpriteComps10093 then
				for iter_362_3, iter_362_4 in pairs(arg_359_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_362_4 then
						iter_362_4.color = arg_359_1.isInRecall_ and (arg_359_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_359_1.var_.actorSpriteComps10093 = nil
			end

			local var_362_5 = 0
			local var_362_6 = 0.75

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_5 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_7 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(413141086).content)

				arg_359_1.text_.text = var_362_7

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_9 = 30 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_7) / 30)

				if (30 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_7) / 30)) > 0 and var_362_6 < var_362_9 then
					arg_359_1.talkMaxDuration = var_362_9

					if var_362_9 + var_362_5 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_5
					end
				end

				arg_359_1.text_.text = var_362_7
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_6, arg_359_1.talkMaxDuration)

			if var_362_5 <= arg_359_1.time_ and arg_359_1.time_ < var_362_5 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_5) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_5 + var_362_10 and arg_359_1.time_ < var_362_5 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play413141087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 413141087
		arg_363_1.duration_ = 7

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play413141088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if arg_363_1.actors_["10022"] == nil then
				local var_366_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_366_0) then
					local var_366_1 = Object.Instantiate(var_366_0, arg_363_1.canvasGo_.transform)

					var_366_1.transform:SetSiblingIndex(1)

					var_366_1.name = "10022"
					var_366_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_363_1.actors_["10022"] = var_366_1

					if arg_363_1.isInRecall_ then
						for iter_366_0, iter_366_1 in ipairs((var_366_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_366_1.color = arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_366_2 = arg_363_1.actors_["10022"].transform

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos10022 = var_366_2.localPosition
				var_366_2.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("10022", 3)

				for iter_366_2 = 0, var_366_2.childCount - 1 do
					local var_366_3 = var_366_2:GetChild(iter_366_2)

					if var_366_3.name == "" or not string.find(var_366_3.name, "split") then
						var_366_3.gameObject:SetActive(true)
					else
						var_366_3.gameObject:SetActive(false)
					end
				end
			end

			local var_366_4 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_4 then
				var_366_2.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_363_1.time_ - 0) / var_366_4)
			end

			if arg_363_1.time_ >= 0 + var_366_4 and arg_363_1.time_ < 0 + var_366_4 + arg_366_0 then
				var_366_2.localPosition = Vector3.New(0, -315, -320)
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:SetSpriteNiuquEffect("10022", true)
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				local var_366_6 = arg_363_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_366_6 then
					arg_363_1.var_.alphaOldValue10022 = var_366_6.alpha
					arg_363_1.var_.characterEffect10022 = var_366_6
				end
			end

			local var_366_7 = 0.5

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				if arg_363_1.var_.characterEffect10022 then
					arg_363_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_363_1.var_.alphaOldValue10022, 0.6, (arg_363_1.time_ - 0) / var_366_7)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 and arg_363_1.var_.characterEffect10022 then
				arg_363_1.var_.characterEffect10022.alpha = 0.6
			end

			local var_366_8 = 0
			local var_366_9 = 0.675

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_8 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_10 = arg_363_1:GetWordFromCfg(413141087)
				local var_366_11 = arg_363_1:FormatText(var_366_10.content)

				arg_363_1.text_.text = var_366_11

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_13 = 27 <= 0 and var_366_9 or var_366_9 * (utf8.len(var_366_11) / 27)

				if (27 <= 0 and var_366_9 or var_366_9 * (utf8.len(var_366_11) / 27)) > 0 and var_366_9 < var_366_13 then
					arg_363_1.talkMaxDuration = var_366_13

					if var_366_13 + var_366_8 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_13 + var_366_8
					end
				end

				arg_363_1.text_.text = var_366_11
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141087", "story_v_out_413141.awb") ~= 0 then
					local var_366_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141087", "story_v_out_413141.awb") / 1000

					if var_366_14 + var_366_8 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_14 + var_366_8
					end

					if var_366_10.prefab_name ~= "" and arg_363_1.actors_[var_366_10.prefab_name] ~= nil then
						local var_366_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_10.prefab_name].transform, "story_v_out_413141", "413141087", "story_v_out_413141.awb")

						arg_363_1:RecordAudio("413141087", var_366_15)
						arg_363_1:RecordAudio("413141087", var_366_15)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_413141", "413141087", "story_v_out_413141.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_413141", "413141087", "story_v_out_413141.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_16 = math.max(var_366_9, arg_363_1.talkMaxDuration)

			if var_366_8 <= arg_363_1.time_ and arg_363_1.time_ < var_366_8 + var_366_16 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_8) / var_366_16

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_8 + var_366_16 and arg_363_1.time_ < var_366_8 + var_366_16 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
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

		arg_363_1:InitPlayNodeList()
	end,
	Play413141088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 413141088
		arg_367_1.duration_ = 6.3

		local var_367_0 = {
			zh = 4.333,
			ja = 6.3
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play413141089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos10092_1 = arg_367_1.actors_["10092_1"].transform.localPosition
				arg_367_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_370_0 = 0, arg_367_1.actors_["10092_1"].transform.childCount - 1 do
					local var_370_0 = arg_367_1.actors_["10092_1"].transform:GetChild(iter_370_0)

					if var_370_0.name == "split_1_1" or not string.find(var_370_0.name, "split") then
						var_370_0.gameObject:SetActive(true)
					else
						var_370_0.gameObject:SetActive(false)
					end
				end
			end

			local var_370_1 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_1 then
				arg_367_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_367_1.time_ - 0) / var_370_1)
			end

			if arg_367_1.time_ >= 0 + var_370_1 and arg_367_1.time_ < 0 + var_370_1 + arg_370_0 then
				arg_367_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_370_2 = arg_367_1.actors_["10092_1"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.actorSpriteComps10092_1 == nil then
				arg_367_1.var_.actorSpriteComps10092_1 = var_370_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_3 = 2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_3 and not isNil(var_370_2) then
				if arg_367_1.var_.actorSpriteComps10092_1 then
					for iter_370_1, iter_370_2 in pairs(arg_367_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_370_2 then
							if arg_367_1.isInRecall_ then
								iter_370_2.color = Color.New(Mathf.Lerp(iter_370_2.color.r, arg_367_1.hightColor1.r, (arg_367_1.time_ - 0) / var_370_3), Mathf.Lerp(iter_370_2.color.g, arg_367_1.hightColor1.g, (arg_367_1.time_ - 0) / var_370_3), (Mathf.Lerp(iter_370_2.color.b, arg_367_1.hightColor1.b, (arg_367_1.time_ - 0) / var_370_3)))
							else
								local var_370_4 = Mathf.Lerp(iter_370_2.color.r, 1, (arg_367_1.time_ - 0) / var_370_3)

								iter_370_2.color = Color.New(var_370_4, var_370_4, var_370_4)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= 0 + var_370_3 and arg_367_1.time_ < 0 + var_370_3 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.actorSpriteComps10092_1 then
				for iter_370_3, iter_370_4 in pairs(arg_367_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_370_4 then
						iter_370_4.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_367_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_370_5 = 0
			local var_370_6 = 0.5

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_5 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_7 = arg_367_1:GetWordFromCfg(413141088)
				local var_370_8 = arg_367_1:FormatText(var_370_7.content)

				arg_367_1.text_.text = var_370_8

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_10 = 20 <= 0 and var_370_6 or var_370_6 * (utf8.len(var_370_8) / 20)

				if (20 <= 0 and var_370_6 or var_370_6 * (utf8.len(var_370_8) / 20)) > 0 and var_370_6 < var_370_10 then
					arg_367_1.talkMaxDuration = var_370_10

					if var_370_10 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_5
					end
				end

				arg_367_1.text_.text = var_370_8
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141088", "story_v_out_413141.awb") ~= 0 then
					local var_370_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141088", "story_v_out_413141.awb") / 1000

					if var_370_11 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_11 + var_370_5
					end

					if var_370_7.prefab_name ~= "" and arg_367_1.actors_[var_370_7.prefab_name] ~= nil then
						local var_370_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_7.prefab_name].transform, "story_v_out_413141", "413141088", "story_v_out_413141.awb")

						arg_367_1:RecordAudio("413141088", var_370_12)
						arg_367_1:RecordAudio("413141088", var_370_12)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_413141", "413141088", "story_v_out_413141.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_413141", "413141088", "story_v_out_413141.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_13 = math.max(var_370_6, arg_367_1.talkMaxDuration)

			if var_370_5 <= arg_367_1.time_ and arg_367_1.time_ < var_370_5 + var_370_13 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_5) / var_370_13

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_5 + var_370_13 and arg_367_1.time_ < var_370_5 + var_370_13 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play413141089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 413141089
		arg_371_1.duration_ = 8.23

		local var_371_0 = {
			zh = 4.466,
			ja = 8.233
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play413141090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.625

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:GetWordFromCfg(413141089)
				local var_374_2 = arg_371_1:FormatText(var_374_1.content)

				arg_371_1.text_.text = var_374_2

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 25 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 25)

				if (25 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 25)) > 0 and var_374_0 < var_374_4 then
					arg_371_1.talkMaxDuration = var_374_4

					if var_374_4 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_4 + 0
					end
				end

				arg_371_1.text_.text = var_374_2
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141089", "story_v_out_413141.awb") ~= 0 then
					local var_374_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141089", "story_v_out_413141.awb") / 1000

					if var_374_5 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + 0
					end

					if var_374_1.prefab_name ~= "" and arg_371_1.actors_[var_374_1.prefab_name] ~= nil then
						local var_374_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_1.prefab_name].transform, "story_v_out_413141", "413141089", "story_v_out_413141.awb")

						arg_371_1:RecordAudio("413141089", var_374_6)
						arg_371_1:RecordAudio("413141089", var_374_6)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_413141", "413141089", "story_v_out_413141.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_413141", "413141089", "story_v_out_413141.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_7 and arg_371_1.time_ < 0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play413141090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 413141090
		arg_375_1.duration_ = 2.1

		local var_375_0 = {
			zh = 1.999999999999,
			ja = 2.1
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play413141091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["10092_1"]) and arg_375_1.var_.actorSpriteComps10092_1 == nil then
				arg_375_1.var_.actorSpriteComps10092_1 = arg_375_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_0 = 2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["10092_1"]) then
				if arg_375_1.var_.actorSpriteComps10092_1 then
					for iter_378_0, iter_378_1 in pairs(arg_375_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_378_1 then
							if arg_375_1.isInRecall_ then
								iter_378_1.color = Color.New(Mathf.Lerp(iter_378_1.color.r, arg_375_1.hightColor2.r, (arg_375_1.time_ - 0) / var_378_0), Mathf.Lerp(iter_378_1.color.g, arg_375_1.hightColor2.g, (arg_375_1.time_ - 0) / var_378_0), (Mathf.Lerp(iter_378_1.color.b, arg_375_1.hightColor2.b, (arg_375_1.time_ - 0) / var_378_0)))
							else
								local var_378_1 = Mathf.Lerp(iter_378_1.color.r, 0.5, (arg_375_1.time_ - 0) / var_378_0)

								iter_378_1.color = Color.New(var_378_1, var_378_1, var_378_1)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["10092_1"]) and arg_375_1.var_.actorSpriteComps10092_1 then
				for iter_378_2, iter_378_3 in pairs(arg_375_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_378_3 then
						iter_378_3.color = arg_375_1.isInRecall_ and (arg_375_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_375_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_378_2 = arg_375_1.actors_["10022"].transform

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos10022 = var_378_2.localPosition
				var_378_2.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10022", 3)

				for iter_378_4 = 0, var_378_2.childCount - 1 do
					local var_378_3 = var_378_2:GetChild(iter_378_4)

					if var_378_3.name == "" or not string.find(var_378_3.name, "split") then
						var_378_3.gameObject:SetActive(true)
					else
						var_378_3.gameObject:SetActive(false)
					end
				end
			end

			local var_378_4 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				var_378_2.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_375_1.time_ - 0) / var_378_4)
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				var_378_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_378_5 = 0
			local var_378_6 = 0.075

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_5 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_7 = arg_375_1:GetWordFromCfg(413141090)
				local var_378_8 = arg_375_1:FormatText(var_378_7.content)

				arg_375_1.text_.text = var_378_8

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_10 = 3 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_8) / 3)

				if (3 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_8) / 3)) > 0 and var_378_6 < var_378_10 then
					arg_375_1.talkMaxDuration = var_378_10

					if var_378_10 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_5
					end
				end

				arg_375_1.text_.text = var_378_8
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141090", "story_v_out_413141.awb") ~= 0 then
					local var_378_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141090", "story_v_out_413141.awb") / 1000

					if var_378_11 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_11 + var_378_5
					end

					if var_378_7.prefab_name ~= "" and arg_375_1.actors_[var_378_7.prefab_name] ~= nil then
						local var_378_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_7.prefab_name].transform, "story_v_out_413141", "413141090", "story_v_out_413141.awb")

						arg_375_1:RecordAudio("413141090", var_378_12)
						arg_375_1:RecordAudio("413141090", var_378_12)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_413141", "413141090", "story_v_out_413141.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_413141", "413141090", "story_v_out_413141.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_13 = math.max(var_378_6, arg_375_1.talkMaxDuration)

			if var_378_5 <= arg_375_1.time_ and arg_375_1.time_ < var_378_5 + var_378_13 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_5) / var_378_13

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_5 + var_378_13 and arg_375_1.time_ < var_378_5 + var_378_13 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
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

		arg_375_1:InitPlayNodeList()
	end,
	Play413141091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 413141091
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play413141092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos10022 = arg_379_1.actors_["10022"].transform.localPosition
				arg_379_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("10022", 7)

				for iter_382_0 = 0, arg_379_1.actors_["10022"].transform.childCount - 1 do
					local var_382_0 = arg_379_1.actors_["10022"].transform:GetChild(iter_382_0)

					if var_382_0.name == "split_2" or not string.find(var_382_0.name, "split") then
						var_382_0.gameObject:SetActive(true)
					else
						var_382_0.gameObject:SetActive(false)
					end
				end
			end

			local var_382_1 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_1 then
				arg_379_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_379_1.time_ - 0) / var_382_1)
			end

			if arg_379_1.time_ >= 0 + var_382_1 and arg_379_1.time_ < 0 + var_382_1 + arg_382_0 then
				arg_379_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_382_2 = 0
			local var_382_3 = 0.725

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_2 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_4 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(413141091).content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_6 = 29 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_4) / 29)

				if (29 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_4) / 29)) > 0 and var_382_3 < var_382_6 then
					arg_379_1.talkMaxDuration = var_382_6

					if var_382_6 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_6 + var_382_2
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_7 = math.max(var_382_3, arg_379_1.talkMaxDuration)

			if var_382_2 <= arg_379_1.time_ and arg_379_1.time_ < var_382_2 + var_382_7 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_2) / var_382_7

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_2 + var_382_7 and arg_379_1.time_ < var_382_2 + var_382_7 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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

		arg_379_1:InitPlayNodeList()
	end,
	Play413141092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 413141092
		arg_383_1.duration_ = 12.27

		local var_383_0 = {
			zh = 9.79966666666667,
			ja = 12.2666666666667
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play413141093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.allBtn_.enabled = false
			end

			if arg_383_1.time_ >= 0 + 0.466666666666667 and arg_383_1.time_ < 0 + 0.466666666666667 + arg_386_0 then
				arg_383_1.allBtn_.enabled = true
			end

			local var_386_0 = arg_383_1.actors_["10022"].transform

			if 0.466666666666667 < arg_383_1.time_ and arg_383_1.time_ <= 0.466666666666667 + arg_386_0 then
				arg_383_1.var_.moveOldPos10022 = var_386_0.localPosition
				var_386_0.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10022", 3)

				for iter_386_0 = 0, var_386_0.childCount - 1 do
					local var_386_1 = var_386_0:GetChild(iter_386_0)

					if var_386_1.name == "" or not string.find(var_386_1.name, "split") then
						var_386_1.gameObject:SetActive(true)
					else
						var_386_1.gameObject:SetActive(false)
					end
				end
			end

			local var_386_2 = 0.001

			if 0.466666666666667 <= arg_383_1.time_ and arg_383_1.time_ < 0.466666666666667 + var_386_2 then
				var_386_0.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_383_1.time_ - 0.466666666666667) / var_386_2)
			end

			if arg_383_1.time_ >= 0.466666666666667 + var_386_2 and arg_383_1.time_ < 0.466666666666667 + var_386_2 + arg_386_0 then
				var_386_0.localPosition = Vector3.New(0, -315, -320)
			end

			if 0.466666666666667 < arg_383_1.time_ and arg_383_1.time_ <= 0.466666666666667 + arg_386_0 then
				arg_383_1:SetSpriteNiuquEffect("10022", true)
			end

			if 0.466666666666667 < arg_383_1.time_ and arg_383_1.time_ <= 0.466666666666667 + arg_386_0 then
				local var_386_4 = arg_383_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_386_4 then
					arg_383_1.var_.alphaOldValue10022 = var_386_4.alpha
					arg_383_1.var_.characterEffect10022 = var_386_4
				end
			end

			local var_386_5 = 0.5

			if 0.466666666666667 <= arg_383_1.time_ and arg_383_1.time_ < 0.466666666666667 + var_386_5 then
				if arg_383_1.var_.characterEffect10022 then
					arg_383_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_383_1.var_.alphaOldValue10022, 0.6, (arg_383_1.time_ - 0.466666666666667) / var_386_5)
				end
			end

			if arg_383_1.time_ >= 0.466666666666667 + var_386_5 and arg_383_1.time_ < 0.466666666666667 + var_386_5 + arg_386_0 and arg_383_1.var_.characterEffect10022 then
				arg_383_1.var_.characterEffect10022.alpha = 0.6
			end

			if arg_383_1.frameCnt_ <= 1 then
				arg_383_1.dialog_:SetActive(false)
			end

			local var_386_6 = 0.466666666666667
			local var_386_7 = 0.75

			if 0.466666666666667 < arg_383_1.time_ and arg_383_1.time_ <= var_386_6 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				arg_383_1.dialog_:SetActive(true)

				arg_383_1.dialogCg_.alpha = 0

				local var_386_8 = LeanTween.value(arg_383_1.dialog_, 0, 1, 0.3)

				var_386_8:setOnUpdate(LuaHelper.FloatAction(function(arg_387_0)
					arg_383_1.dialogCg_.alpha = arg_387_0
				end))
				var_386_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_383_1.dialog_)
					var_386_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_383_1.duration_ = arg_383_1.duration_ + 0.3

				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_9 = arg_383_1:GetWordFromCfg(413141092)
				local var_386_10 = arg_383_1:FormatText(var_386_9.content)

				arg_383_1.text_.text = var_386_10

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_12 = 30 <= 0 and var_386_7 or var_386_7 * (utf8.len(var_386_10) / 30)

				if (30 <= 0 and var_386_7 or var_386_7 * (utf8.len(var_386_10) / 30)) > 0 and var_386_7 < var_386_12 then
					arg_383_1.talkMaxDuration = var_386_12
					var_386_6 = var_386_6 + 0.3

					if var_386_12 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_12 + var_386_6
					end
				end

				arg_383_1.text_.text = var_386_10
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141092", "story_v_out_413141.awb") ~= 0 then
					local var_386_13 = manager.audio:GetVoiceLength("story_v_out_413141", "413141092", "story_v_out_413141.awb") / 1000

					if var_386_13 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_6
					end

					if var_386_9.prefab_name ~= "" and arg_383_1.actors_[var_386_9.prefab_name] ~= nil then
						local var_386_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_9.prefab_name].transform, "story_v_out_413141", "413141092", "story_v_out_413141.awb")

						arg_383_1:RecordAudio("413141092", var_386_14)
						arg_383_1:RecordAudio("413141092", var_386_14)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_413141", "413141092", "story_v_out_413141.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_413141", "413141092", "story_v_out_413141.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_15 = var_386_6 + 0.3
			local var_386_16 = math.max(var_386_7, arg_383_1.talkMaxDuration)

			if var_386_6 + 0.3 <= arg_383_1.time_ and arg_383_1.time_ < var_386_15 + var_386_16 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_15) / var_386_16

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_15 + var_386_16 and arg_383_1.time_ < var_386_15 + var_386_16 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play413141093 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 413141093
		arg_389_1.duration_ = 3.3

		local var_389_0 = {
			zh = 2.6,
			ja = 3.3
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play413141094(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos10092_1 = arg_389_1.actors_["10092_1"].transform.localPosition
				arg_389_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_392_0 = 0, arg_389_1.actors_["10092_1"].transform.childCount - 1 do
					local var_392_0 = arg_389_1.actors_["10092_1"].transform:GetChild(iter_392_0)

					if var_392_0.name == "split_1_1" or not string.find(var_392_0.name, "split") then
						var_392_0.gameObject:SetActive(true)
					else
						var_392_0.gameObject:SetActive(false)
					end
				end
			end

			local var_392_1 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_1 then
				arg_389_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_389_1.time_ - 0) / var_392_1)
			end

			if arg_389_1.time_ >= 0 + var_392_1 and arg_389_1.time_ < 0 + var_392_1 + arg_392_0 then
				arg_389_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_392_2 = arg_389_1.actors_["10092_1"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.actorSpriteComps10092_1 == nil then
				arg_389_1.var_.actorSpriteComps10092_1 = var_392_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_3 = 2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_3 and not isNil(var_392_2) then
				if arg_389_1.var_.actorSpriteComps10092_1 then
					for iter_392_1, iter_392_2 in pairs(arg_389_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_392_2 then
							if arg_389_1.isInRecall_ then
								iter_392_2.color = Color.New(Mathf.Lerp(iter_392_2.color.r, arg_389_1.hightColor1.r, (arg_389_1.time_ - 0) / var_392_3), Mathf.Lerp(iter_392_2.color.g, arg_389_1.hightColor1.g, (arg_389_1.time_ - 0) / var_392_3), (Mathf.Lerp(iter_392_2.color.b, arg_389_1.hightColor1.b, (arg_389_1.time_ - 0) / var_392_3)))
							else
								local var_392_4 = Mathf.Lerp(iter_392_2.color.r, 1, (arg_389_1.time_ - 0) / var_392_3)

								iter_392_2.color = Color.New(var_392_4, var_392_4, var_392_4)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_3 and arg_389_1.time_ < 0 + var_392_3 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.actorSpriteComps10092_1 then
				for iter_392_3, iter_392_4 in pairs(arg_389_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_392_4 then
						iter_392_4.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_389_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_392_5 = 0
			local var_392_6 = 0.125

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_5 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_7 = arg_389_1:GetWordFromCfg(413141093)
				local var_392_8 = arg_389_1:FormatText(var_392_7.content)

				arg_389_1.text_.text = var_392_8

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_10 = 5 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_8) / 5)

				if (5 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_8) / 5)) > 0 and var_392_6 < var_392_10 then
					arg_389_1.talkMaxDuration = var_392_10

					if var_392_10 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_10 + var_392_5
					end
				end

				arg_389_1.text_.text = var_392_8
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141093", "story_v_out_413141.awb") ~= 0 then
					local var_392_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141093", "story_v_out_413141.awb") / 1000

					if var_392_11 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_11 + var_392_5
					end

					if var_392_7.prefab_name ~= "" and arg_389_1.actors_[var_392_7.prefab_name] ~= nil then
						local var_392_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_7.prefab_name].transform, "story_v_out_413141", "413141093", "story_v_out_413141.awb")

						arg_389_1:RecordAudio("413141093", var_392_12)
						arg_389_1:RecordAudio("413141093", var_392_12)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_413141", "413141093", "story_v_out_413141.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_413141", "413141093", "story_v_out_413141.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_13 = math.max(var_392_6, arg_389_1.talkMaxDuration)

			if var_392_5 <= arg_389_1.time_ and arg_389_1.time_ < var_392_5 + var_392_13 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_5) / var_392_13

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_5 + var_392_13 and arg_389_1.time_ < var_392_5 + var_392_13 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141094 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 413141094
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play413141095(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos10092_1 = arg_393_1.actors_["10092_1"].transform.localPosition
				arg_393_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_396_0 = 0, arg_393_1.actors_["10092_1"].transform.childCount - 1 do
					local var_396_0 = arg_393_1.actors_["10092_1"].transform:GetChild(iter_396_0)

					if var_396_0.name == "split_1_1" or not string.find(var_396_0.name, "split") then
						var_396_0.gameObject:SetActive(true)
					else
						var_396_0.gameObject:SetActive(false)
					end
				end
			end

			local var_396_1 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_1 then
				arg_393_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_393_1.time_ - 0) / var_396_1)
			end

			if arg_393_1.time_ >= 0 + var_396_1 and arg_393_1.time_ < 0 + var_396_1 + arg_396_0 then
				arg_393_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_396_2 = 0
			local var_396_3 = 0.7

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_2 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_4 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(413141094).content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_6 = 28 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_4) / 28)

				if (28 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_4) / 28)) > 0 and var_396_3 < var_396_6 then
					arg_393_1.talkMaxDuration = var_396_6

					if var_396_6 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_6 + var_396_2
					end
				end

				arg_393_1.text_.text = var_396_4
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_3, arg_393_1.talkMaxDuration)

			if var_396_2 <= arg_393_1.time_ and arg_393_1.time_ < var_396_2 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_2) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_2 + var_396_7 and arg_393_1.time_ < var_396_2 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141095 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 413141095
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play413141096(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.75

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(413141095).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 30 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 30)

				if (30 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 30)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play413141096 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 413141096
		arg_401_1.duration_ = 8.6

		local var_401_0 = {
			zh = 8.1,
			ja = 8.6
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play413141097(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 1.8 < arg_401_1.time_ and arg_401_1.time_ <= 1.8 + arg_404_0 then
				arg_401_1.var_.moveOldPos10092_1 = arg_401_1.actors_["10092_1"].transform.localPosition
				arg_401_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_404_0 = 0, arg_401_1.actors_["10092_1"].transform.childCount - 1 do
					local var_404_0 = arg_401_1.actors_["10092_1"].transform:GetChild(iter_404_0)

					if var_404_0.name == "" or not string.find(var_404_0.name, "split") then
						var_404_0.gameObject:SetActive(true)
					else
						var_404_0.gameObject:SetActive(false)
					end
				end
			end

			local var_404_1 = 0.001

			if 1.8 <= arg_401_1.time_ and arg_401_1.time_ < 1.8 + var_404_1 then
				arg_401_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_401_1.time_ - 1.8) / var_404_1)
			end

			if arg_401_1.time_ >= 1.8 + var_404_1 and arg_401_1.time_ < 1.8 + var_404_1 + arg_404_0 then
				arg_401_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_404_2 = arg_401_1.actors_["10092_1"]

			if 1.8 < arg_401_1.time_ and arg_401_1.time_ <= 1.8 + arg_404_0 and not isNil(var_404_2) and arg_401_1.var_.actorSpriteComps10092_1 == nil then
				arg_401_1.var_.actorSpriteComps10092_1 = var_404_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_3 = 2

			if 1.8 <= arg_401_1.time_ and arg_401_1.time_ < 1.8 + var_404_3 and not isNil(var_404_2) then
				if arg_401_1.var_.actorSpriteComps10092_1 then
					for iter_404_1, iter_404_2 in pairs(arg_401_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_404_2 then
							if arg_401_1.isInRecall_ then
								iter_404_2.color = Color.New(Mathf.Lerp(iter_404_2.color.r, arg_401_1.hightColor1.r, (arg_401_1.time_ - 1.8) / var_404_3), Mathf.Lerp(iter_404_2.color.g, arg_401_1.hightColor1.g, (arg_401_1.time_ - 1.8) / var_404_3), (Mathf.Lerp(iter_404_2.color.b, arg_401_1.hightColor1.b, (arg_401_1.time_ - 1.8) / var_404_3)))
							else
								local var_404_4 = Mathf.Lerp(iter_404_2.color.r, 1, (arg_401_1.time_ - 1.8) / var_404_3)

								iter_404_2.color = Color.New(var_404_4, var_404_4, var_404_4)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 1.8 + var_404_3 and arg_401_1.time_ < 1.8 + var_404_3 + arg_404_0 and not isNil(var_404_2) and arg_401_1.var_.actorSpriteComps10092_1 then
				for iter_404_3, iter_404_4 in pairs(arg_401_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_404_4 then
						iter_404_4.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_401_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_404_5 = 0

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_5 + arg_404_0 then
				arg_401_1.mask_.enabled = true
				arg_401_1.mask_.raycastTarget = true

				arg_401_1:SetGaussion(false)
			end

			local var_404_6 = 1

			if var_404_5 <= arg_401_1.time_ and arg_401_1.time_ < var_404_5 + var_404_6 then
				local var_404_7 = Color.New(0, 0, 0)

				var_404_7.a = Mathf.Lerp(0, 1, (arg_401_1.time_ - var_404_5) / var_404_6)
				arg_401_1.mask_.color = var_404_7
			end

			if arg_401_1.time_ >= var_404_5 + var_404_6 and arg_401_1.time_ < var_404_5 + var_404_6 + arg_404_0 then
				local var_404_8 = Color.New(0, 0, 0)

				var_404_8.a = 1
				arg_401_1.mask_.color = var_404_8
			end

			local var_404_9 = 1

			if 1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_9 + arg_404_0 then
				arg_401_1.mask_.enabled = true
				arg_401_1.mask_.raycastTarget = true

				arg_401_1:SetGaussion(false)
			end

			local var_404_10 = 1

			if var_404_9 <= arg_401_1.time_ and arg_401_1.time_ < var_404_9 + var_404_10 then
				local var_404_11 = Color.New(0, 0, 0)

				var_404_11.a = Mathf.Lerp(1, 0, (arg_401_1.time_ - var_404_9) / var_404_10)
				arg_401_1.mask_.color = var_404_11
			end

			if arg_401_1.time_ >= var_404_9 + var_404_10 and arg_401_1.time_ < var_404_9 + var_404_10 + arg_404_0 then
				local var_404_12 = Color.New(0, 0, 0)

				arg_401_1.mask_.enabled = false
				var_404_12.a = 0
				arg_401_1.mask_.color = var_404_12
			end

			if 1.8 < arg_401_1.time_ and arg_401_1.time_ <= 1.8 + arg_404_0 then
				local var_404_13 = arg_401_1.actors_["10092_1"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_404_13 then
					arg_401_1.var_.alphaOldValue10092_1 = var_404_13.alpha
					arg_401_1.var_.characterEffect10092_1 = var_404_13
				end

				arg_401_1.var_.alphaOldValue10092_1 = 0
			end

			local var_404_14 = 0.2

			if 1.8 <= arg_401_1.time_ and arg_401_1.time_ < 1.8 + var_404_14 then
				if arg_401_1.var_.characterEffect10092_1 then
					arg_401_1.var_.characterEffect10092_1.alpha = Mathf.Lerp(arg_401_1.var_.alphaOldValue10092_1, 1, (arg_401_1.time_ - 1.8) / var_404_14)
				end
			end

			if arg_401_1.time_ >= 1.8 + var_404_14 and arg_401_1.time_ < 1.8 + var_404_14 + arg_404_0 and arg_401_1.var_.characterEffect10092_1 then
				arg_401_1.var_.characterEffect10092_1.alpha = 1
			end

			if arg_401_1.frameCnt_ <= 1 then
				arg_401_1.dialog_:SetActive(false)
			end

			local var_404_15 = 2.2
			local var_404_16 = 0.775

			if 2.2 < arg_401_1.time_ and arg_401_1.time_ <= var_404_15 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0

				arg_401_1.dialog_:SetActive(true)

				arg_401_1.dialogCg_.alpha = 0

				local var_404_17 = LeanTween.value(arg_401_1.dialog_, 0, 1, 0.3)

				var_404_17:setOnUpdate(LuaHelper.FloatAction(function(arg_405_0)
					arg_401_1.dialogCg_.alpha = arg_405_0
				end))
				var_404_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_401_1.dialog_)
					var_404_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_401_1.duration_ = arg_401_1.duration_ + 0.3

				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_18 = arg_401_1:GetWordFromCfg(413141096)
				local var_404_19 = arg_401_1:FormatText(var_404_18.content)

				arg_401_1.text_.text = var_404_19

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_21 = 31 <= 0 and var_404_16 or var_404_16 * (utf8.len(var_404_19) / 31)

				if (31 <= 0 and var_404_16 or var_404_16 * (utf8.len(var_404_19) / 31)) > 0 and var_404_16 < var_404_21 then
					arg_401_1.talkMaxDuration = var_404_21
					var_404_15 = var_404_15 + 0.3

					if var_404_21 + var_404_15 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_21 + var_404_15
					end
				end

				arg_401_1.text_.text = var_404_19
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141096", "story_v_out_413141.awb") ~= 0 then
					local var_404_22 = manager.audio:GetVoiceLength("story_v_out_413141", "413141096", "story_v_out_413141.awb") / 1000

					if var_404_22 + var_404_15 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_22 + var_404_15
					end

					if var_404_18.prefab_name ~= "" and arg_401_1.actors_[var_404_18.prefab_name] ~= nil then
						local var_404_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_18.prefab_name].transform, "story_v_out_413141", "413141096", "story_v_out_413141.awb")

						arg_401_1:RecordAudio("413141096", var_404_23)
						arg_401_1:RecordAudio("413141096", var_404_23)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_413141", "413141096", "story_v_out_413141.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_413141", "413141096", "story_v_out_413141.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_24 = var_404_15 + 0.3
			local var_404_25 = math.max(var_404_16, arg_401_1.talkMaxDuration)

			if var_404_15 + 0.3 <= arg_401_1.time_ and arg_401_1.time_ < var_404_24 + var_404_25 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_24) / var_404_25

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_24 + var_404_25 and arg_401_1.time_ < var_404_24 + var_404_25 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play413141097 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 413141097
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play413141098(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos10092_1 = arg_407_1.actors_["10092_1"].transform.localPosition
				arg_407_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_410_0 = 0, arg_407_1.actors_["10092_1"].transform.childCount - 1 do
					local var_410_0 = arg_407_1.actors_["10092_1"].transform:GetChild(iter_410_0)

					if var_410_0.name == "" or not string.find(var_410_0.name, "split") then
						var_410_0.gameObject:SetActive(true)
					else
						var_410_0.gameObject:SetActive(false)
					end
				end
			end

			local var_410_1 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_1 then
				arg_407_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_407_1.time_ - 0) / var_410_1)
			end

			if arg_407_1.time_ >= 0 + var_410_1 and arg_407_1.time_ < 0 + var_410_1 + arg_410_0 then
				arg_407_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_410_2 = arg_407_1.actors_["10092_1"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_2) and arg_407_1.var_.actorSpriteComps10092_1 == nil then
				arg_407_1.var_.actorSpriteComps10092_1 = var_410_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_3 = 2

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_3 and not isNil(var_410_2) then
				if arg_407_1.var_.actorSpriteComps10092_1 then
					for iter_410_1, iter_410_2 in pairs(arg_407_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_410_2 then
							if arg_407_1.isInRecall_ then
								iter_410_2.color = Color.New(Mathf.Lerp(iter_410_2.color.r, arg_407_1.hightColor2.r, (arg_407_1.time_ - 0) / var_410_3), Mathf.Lerp(iter_410_2.color.g, arg_407_1.hightColor2.g, (arg_407_1.time_ - 0) / var_410_3), (Mathf.Lerp(iter_410_2.color.b, arg_407_1.hightColor2.b, (arg_407_1.time_ - 0) / var_410_3)))
							else
								local var_410_4 = Mathf.Lerp(iter_410_2.color.r, 0.5, (arg_407_1.time_ - 0) / var_410_3)

								iter_410_2.color = Color.New(var_410_4, var_410_4, var_410_4)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= 0 + var_410_3 and arg_407_1.time_ < 0 + var_410_3 + arg_410_0 and not isNil(var_410_2) and arg_407_1.var_.actorSpriteComps10092_1 then
				for iter_410_3, iter_410_4 in pairs(arg_407_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_410_4 then
						iter_410_4.color = arg_407_1.isInRecall_ and (arg_407_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_407_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_410_5 = 0
			local var_410_6 = 0.95

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_5 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_7 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(413141097).content)

				arg_407_1.text_.text = var_410_7

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_9 = 38 <= 0 and var_410_6 or var_410_6 * (utf8.len(var_410_7) / 38)

				if (38 <= 0 and var_410_6 or var_410_6 * (utf8.len(var_410_7) / 38)) > 0 and var_410_6 < var_410_9 then
					arg_407_1.talkMaxDuration = var_410_9

					if var_410_9 + var_410_5 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_9 + var_410_5
					end
				end

				arg_407_1.text_.text = var_410_7
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_10 = math.max(var_410_6, arg_407_1.talkMaxDuration)

			if var_410_5 <= arg_407_1.time_ and arg_407_1.time_ < var_410_5 + var_410_10 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_5) / var_410_10

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_5 + var_410_10 and arg_407_1.time_ < var_410_5 + var_410_10 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play413141098 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 413141098
		arg_411_1.duration_ = 3

		local var_411_0 = {
			zh = 3,
			ja = 2.133
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play413141099(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos10093 = arg_411_1.actors_["10093"].transform.localPosition
				arg_411_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10093", 3)

				for iter_414_0 = 0, arg_411_1.actors_["10093"].transform.childCount - 1 do
					local var_414_0 = arg_411_1.actors_["10093"].transform:GetChild(iter_414_0)

					if var_414_0.name == "split_4" or not string.find(var_414_0.name, "split") then
						var_414_0.gameObject:SetActive(true)
					else
						var_414_0.gameObject:SetActive(false)
					end
				end
			end

			local var_414_1 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_1 then
				arg_411_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_411_1.time_ - 0) / var_414_1)
			end

			if arg_411_1.time_ >= 0 + var_414_1 and arg_411_1.time_ < 0 + var_414_1 + arg_414_0 then
				arg_411_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_414_2 = arg_411_1.actors_["10092_1"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_2) and arg_411_1.var_.actorSpriteComps10092_1 == nil then
				arg_411_1.var_.actorSpriteComps10092_1 = var_414_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_3 = 2

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_3 and not isNil(var_414_2) then
				if arg_411_1.var_.actorSpriteComps10092_1 then
					for iter_414_1, iter_414_2 in pairs(arg_411_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_414_2 then
							if arg_411_1.isInRecall_ then
								iter_414_2.color = Color.New(Mathf.Lerp(iter_414_2.color.r, arg_411_1.hightColor2.r, (arg_411_1.time_ - 0) / var_414_3), Mathf.Lerp(iter_414_2.color.g, arg_411_1.hightColor2.g, (arg_411_1.time_ - 0) / var_414_3), (Mathf.Lerp(iter_414_2.color.b, arg_411_1.hightColor2.b, (arg_411_1.time_ - 0) / var_414_3)))
							else
								local var_414_4 = Mathf.Lerp(iter_414_2.color.r, 0.5, (arg_411_1.time_ - 0) / var_414_3)

								iter_414_2.color = Color.New(var_414_4, var_414_4, var_414_4)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= 0 + var_414_3 and arg_411_1.time_ < 0 + var_414_3 + arg_414_0 and not isNil(var_414_2) and arg_411_1.var_.actorSpriteComps10092_1 then
				for iter_414_3, iter_414_4 in pairs(arg_411_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_414_4 then
						iter_414_4.color = arg_411_1.isInRecall_ and (arg_411_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_411_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_414_5 = arg_411_1.actors_["10093"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_5) and arg_411_1.var_.actorSpriteComps10093 == nil then
				arg_411_1.var_.actorSpriteComps10093 = var_414_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_6 = 2

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_6 and not isNil(var_414_5) then
				if arg_411_1.var_.actorSpriteComps10093 then
					for iter_414_5, iter_414_6 in pairs(arg_411_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_414_6 then
							if arg_411_1.isInRecall_ then
								iter_414_6.color = Color.New(Mathf.Lerp(iter_414_6.color.r, arg_411_1.hightColor1.r, (arg_411_1.time_ - 0) / var_414_6), Mathf.Lerp(iter_414_6.color.g, arg_411_1.hightColor1.g, (arg_411_1.time_ - 0) / var_414_6), (Mathf.Lerp(iter_414_6.color.b, arg_411_1.hightColor1.b, (arg_411_1.time_ - 0) / var_414_6)))
							else
								local var_414_7 = Mathf.Lerp(iter_414_6.color.r, 1, (arg_411_1.time_ - 0) / var_414_6)

								iter_414_6.color = Color.New(var_414_7, var_414_7, var_414_7)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= 0 + var_414_6 and arg_411_1.time_ < 0 + var_414_6 + arg_414_0 and not isNil(var_414_5) and arg_411_1.var_.actorSpriteComps10093 then
				for iter_414_7, iter_414_8 in pairs(arg_411_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_414_8 then
						iter_414_8.color = arg_411_1.isInRecall_ and (arg_411_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_411_1.var_.actorSpriteComps10093 = nil
			end

			local var_414_8 = 0
			local var_414_9 = 0.325

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_10 = arg_411_1:GetWordFromCfg(413141098)
				local var_414_11 = arg_411_1:FormatText(var_414_10.content)

				arg_411_1.text_.text = var_414_11

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_13 = 13 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 13)

				if (13 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 13)) > 0 and var_414_9 < var_414_13 then
					arg_411_1.talkMaxDuration = var_414_13

					if var_414_13 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_8
					end
				end

				arg_411_1.text_.text = var_414_11
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141098", "story_v_out_413141.awb") ~= 0 then
					local var_414_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141098", "story_v_out_413141.awb") / 1000

					if var_414_14 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_14 + var_414_8
					end

					if var_414_10.prefab_name ~= "" and arg_411_1.actors_[var_414_10.prefab_name] ~= nil then
						local var_414_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_10.prefab_name].transform, "story_v_out_413141", "413141098", "story_v_out_413141.awb")

						arg_411_1:RecordAudio("413141098", var_414_15)
						arg_411_1:RecordAudio("413141098", var_414_15)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_413141", "413141098", "story_v_out_413141.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_413141", "413141098", "story_v_out_413141.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_16 = math.max(var_414_9, arg_411_1.talkMaxDuration)

			if var_414_8 <= arg_411_1.time_ and arg_411_1.time_ < var_414_8 + var_414_16 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_8) / var_414_16

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_8 + var_414_16 and arg_411_1.time_ < var_414_8 + var_414_16 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413141099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 413141099
		arg_415_1.duration_ = 8.3

		local var_415_0 = {
			zh = 5.6,
			ja = 8.3
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play413141100(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos10092_1 = arg_415_1.actors_["10092_1"].transform.localPosition
				arg_415_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_415_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_418_0 = 0, arg_415_1.actors_["10092_1"].transform.childCount - 1 do
					local var_418_0 = arg_415_1.actors_["10092_1"].transform:GetChild(iter_418_0)

					if var_418_0.name == "" or not string.find(var_418_0.name, "split") then
						var_418_0.gameObject:SetActive(true)
					else
						var_418_0.gameObject:SetActive(false)
					end
				end
			end

			local var_418_1 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_1 then
				arg_415_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_415_1.time_ - 0) / var_418_1)
			end

			if arg_415_1.time_ >= 0 + var_418_1 and arg_415_1.time_ < 0 + var_418_1 + arg_418_0 then
				arg_415_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_418_2 = arg_415_1.actors_["10092_1"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_2) and arg_415_1.var_.actorSpriteComps10092_1 == nil then
				arg_415_1.var_.actorSpriteComps10092_1 = var_418_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_3 = 2

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_3 and not isNil(var_418_2) then
				if arg_415_1.var_.actorSpriteComps10092_1 then
					for iter_418_1, iter_418_2 in pairs(arg_415_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_418_2 then
							if arg_415_1.isInRecall_ then
								iter_418_2.color = Color.New(Mathf.Lerp(iter_418_2.color.r, arg_415_1.hightColor1.r, (arg_415_1.time_ - 0) / var_418_3), Mathf.Lerp(iter_418_2.color.g, arg_415_1.hightColor1.g, (arg_415_1.time_ - 0) / var_418_3), (Mathf.Lerp(iter_418_2.color.b, arg_415_1.hightColor1.b, (arg_415_1.time_ - 0) / var_418_3)))
							else
								local var_418_4 = Mathf.Lerp(iter_418_2.color.r, 1, (arg_415_1.time_ - 0) / var_418_3)

								iter_418_2.color = Color.New(var_418_4, var_418_4, var_418_4)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= 0 + var_418_3 and arg_415_1.time_ < 0 + var_418_3 + arg_418_0 and not isNil(var_418_2) and arg_415_1.var_.actorSpriteComps10092_1 then
				for iter_418_3, iter_418_4 in pairs(arg_415_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_418_4 then
						iter_418_4.color = arg_415_1.isInRecall_ and (arg_415_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_415_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_418_5 = arg_415_1.actors_["10093"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_5) and arg_415_1.var_.actorSpriteComps10093 == nil then
				arg_415_1.var_.actorSpriteComps10093 = var_418_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_6 = 2

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_6 and not isNil(var_418_5) then
				if arg_415_1.var_.actorSpriteComps10093 then
					for iter_418_5, iter_418_6 in pairs(arg_415_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_418_6 then
							if arg_415_1.isInRecall_ then
								iter_418_6.color = Color.New(Mathf.Lerp(iter_418_6.color.r, arg_415_1.hightColor2.r, (arg_415_1.time_ - 0) / var_418_6), Mathf.Lerp(iter_418_6.color.g, arg_415_1.hightColor2.g, (arg_415_1.time_ - 0) / var_418_6), (Mathf.Lerp(iter_418_6.color.b, arg_415_1.hightColor2.b, (arg_415_1.time_ - 0) / var_418_6)))
							else
								local var_418_7 = Mathf.Lerp(iter_418_6.color.r, 0.5, (arg_415_1.time_ - 0) / var_418_6)

								iter_418_6.color = Color.New(var_418_7, var_418_7, var_418_7)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= 0 + var_418_6 and arg_415_1.time_ < 0 + var_418_6 + arg_418_0 and not isNil(var_418_5) and arg_415_1.var_.actorSpriteComps10093 then
				for iter_418_7, iter_418_8 in pairs(arg_415_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_418_8 then
						iter_418_8.color = arg_415_1.isInRecall_ and (arg_415_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_415_1.var_.actorSpriteComps10093 = nil
			end

			local var_418_8 = 0
			local var_418_9 = 0.8

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_8 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_10 = arg_415_1:GetWordFromCfg(413141099)
				local var_418_11 = arg_415_1:FormatText(var_418_10.content)

				arg_415_1.text_.text = var_418_11

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_13 = 32 <= 0 and var_418_9 or var_418_9 * (utf8.len(var_418_11) / 32)

				if (32 <= 0 and var_418_9 or var_418_9 * (utf8.len(var_418_11) / 32)) > 0 and var_418_9 < var_418_13 then
					arg_415_1.talkMaxDuration = var_418_13

					if var_418_13 + var_418_8 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_13 + var_418_8
					end
				end

				arg_415_1.text_.text = var_418_11
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141099", "story_v_out_413141.awb") ~= 0 then
					local var_418_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141099", "story_v_out_413141.awb") / 1000

					if var_418_14 + var_418_8 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_14 + var_418_8
					end

					if var_418_10.prefab_name ~= "" and arg_415_1.actors_[var_418_10.prefab_name] ~= nil then
						local var_418_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_10.prefab_name].transform, "story_v_out_413141", "413141099", "story_v_out_413141.awb")

						arg_415_1:RecordAudio("413141099", var_418_15)
						arg_415_1:RecordAudio("413141099", var_418_15)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_413141", "413141099", "story_v_out_413141.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_413141", "413141099", "story_v_out_413141.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_16 = math.max(var_418_9, arg_415_1.talkMaxDuration)

			if var_418_8 <= arg_415_1.time_ and arg_415_1.time_ < var_418_8 + var_418_16 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_8) / var_418_16

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_8 + var_418_16 and arg_415_1.time_ < var_418_8 + var_418_16 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play413141100 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 413141100
		arg_419_1.duration_ = 10.53

		local var_419_0 = {
			zh = 5.466,
			ja = 10.533
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play413141101(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.775

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_1 = arg_419_1:GetWordFromCfg(413141100)
				local var_422_2 = arg_419_1:FormatText(var_422_1.content)

				arg_419_1.text_.text = var_422_2

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 31 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 31)

				if (31 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 31)) > 0 and var_422_0 < var_422_4 then
					arg_419_1.talkMaxDuration = var_422_4

					if var_422_4 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_4 + 0
					end
				end

				arg_419_1.text_.text = var_422_2
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141100", "story_v_out_413141.awb") ~= 0 then
					local var_422_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141100", "story_v_out_413141.awb") / 1000

					if var_422_5 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + 0
					end

					if var_422_1.prefab_name ~= "" and arg_419_1.actors_[var_422_1.prefab_name] ~= nil then
						local var_422_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_1.prefab_name].transform, "story_v_out_413141", "413141100", "story_v_out_413141.awb")

						arg_419_1:RecordAudio("413141100", var_422_6)
						arg_419_1:RecordAudio("413141100", var_422_6)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_413141", "413141100", "story_v_out_413141.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_413141", "413141100", "story_v_out_413141.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_7 and arg_419_1.time_ < 0 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play413141101 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 413141101
		arg_423_1.duration_ = 7.6

		local var_423_0 = {
			zh = 3.966,
			ja = 7.6
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play413141102(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos10092_1 = arg_423_1.actors_["10092_1"].transform.localPosition
				arg_423_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_423_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_426_0 = 0, arg_423_1.actors_["10092_1"].transform.childCount - 1 do
					local var_426_0 = arg_423_1.actors_["10092_1"].transform:GetChild(iter_426_0)

					if var_426_0.name == "" or not string.find(var_426_0.name, "split") then
						var_426_0.gameObject:SetActive(true)
					else
						var_426_0.gameObject:SetActive(false)
					end
				end
			end

			local var_426_1 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_1 then
				arg_423_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_423_1.time_ - 0) / var_426_1)
			end

			if arg_423_1.time_ >= 0 + var_426_1 and arg_423_1.time_ < 0 + var_426_1 + arg_426_0 then
				arg_423_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_426_2 = arg_423_1.actors_["10092"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_2) and arg_423_1.var_.actorSpriteComps10092 == nil then
				arg_423_1.var_.actorSpriteComps10092 = var_426_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_3 = 2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_3 and not isNil(var_426_2) then
				if arg_423_1.var_.actorSpriteComps10092 then
					for iter_426_1, iter_426_2 in pairs(arg_423_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_426_2 then
							if arg_423_1.isInRecall_ then
								iter_426_2.color = Color.New(Mathf.Lerp(iter_426_2.color.r, arg_423_1.hightColor1.r, (arg_423_1.time_ - 0) / var_426_3), Mathf.Lerp(iter_426_2.color.g, arg_423_1.hightColor1.g, (arg_423_1.time_ - 0) / var_426_3), (Mathf.Lerp(iter_426_2.color.b, arg_423_1.hightColor1.b, (arg_423_1.time_ - 0) / var_426_3)))
							else
								local var_426_4 = Mathf.Lerp(iter_426_2.color.r, 1, (arg_423_1.time_ - 0) / var_426_3)

								iter_426_2.color = Color.New(var_426_4, var_426_4, var_426_4)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= 0 + var_426_3 and arg_423_1.time_ < 0 + var_426_3 + arg_426_0 and not isNil(var_426_2) and arg_423_1.var_.actorSpriteComps10092 then
				for iter_426_3, iter_426_4 in pairs(arg_423_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_426_4 then
						iter_426_4.color = arg_423_1.isInRecall_ and (arg_423_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_423_1.var_.actorSpriteComps10092 = nil
			end

			local var_426_5 = 0
			local var_426_6 = 0.475

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_5 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_7 = arg_423_1:GetWordFromCfg(413141101)
				local var_426_8 = arg_423_1:FormatText(var_426_7.content)

				arg_423_1.text_.text = var_426_8

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_10 = 19 <= 0 and var_426_6 or var_426_6 * (utf8.len(var_426_8) / 19)

				if (19 <= 0 and var_426_6 or var_426_6 * (utf8.len(var_426_8) / 19)) > 0 and var_426_6 < var_426_10 then
					arg_423_1.talkMaxDuration = var_426_10

					if var_426_10 + var_426_5 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_5
					end
				end

				arg_423_1.text_.text = var_426_8
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141101", "story_v_out_413141.awb") ~= 0 then
					local var_426_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141101", "story_v_out_413141.awb") / 1000

					if var_426_11 + var_426_5 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_11 + var_426_5
					end

					if var_426_7.prefab_name ~= "" and arg_423_1.actors_[var_426_7.prefab_name] ~= nil then
						local var_426_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_7.prefab_name].transform, "story_v_out_413141", "413141101", "story_v_out_413141.awb")

						arg_423_1:RecordAudio("413141101", var_426_12)
						arg_423_1:RecordAudio("413141101", var_426_12)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_413141", "413141101", "story_v_out_413141.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_413141", "413141101", "story_v_out_413141.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_13 = math.max(var_426_6, arg_423_1.talkMaxDuration)

			if var_426_5 <= arg_423_1.time_ and arg_423_1.time_ < var_426_5 + var_426_13 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_5) / var_426_13

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_5 + var_426_13 and arg_423_1.time_ < var_426_5 + var_426_13 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play413141102 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 413141102
		arg_427_1.duration_ = 5.03

		local var_427_0 = {
			zh = 4.166,
			ja = 5.033
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play413141103(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos10092_1 = arg_427_1.actors_["10092_1"].transform.localPosition
				arg_427_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_427_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_430_0 = 0, arg_427_1.actors_["10092_1"].transform.childCount - 1 do
					local var_430_0 = arg_427_1.actors_["10092_1"].transform:GetChild(iter_430_0)

					if var_430_0.name == "" or not string.find(var_430_0.name, "split") then
						var_430_0.gameObject:SetActive(true)
					else
						var_430_0.gameObject:SetActive(false)
					end
				end
			end

			local var_430_1 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_1 then
				arg_427_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_427_1.time_ - 0) / var_430_1)
			end

			if arg_427_1.time_ >= 0 + var_430_1 and arg_427_1.time_ < 0 + var_430_1 + arg_430_0 then
				arg_427_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_430_2 = arg_427_1.actors_["10093"].transform

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos10093 = var_430_2.localPosition
				var_430_2.localScale = Vector3.New(1, 1, 1)

				arg_427_1:CheckSpriteTmpPos("10093", 4)

				for iter_430_1 = 0, var_430_2.childCount - 1 do
					local var_430_3 = var_430_2:GetChild(iter_430_1)

					if var_430_3.name == "split_5" or not string.find(var_430_3.name, "split") then
						var_430_3.gameObject:SetActive(true)
					else
						var_430_3.gameObject:SetActive(false)
					end
				end
			end

			local var_430_4 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				var_430_2.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_427_1.time_ - 0) / var_430_4)
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				var_430_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_430_5 = arg_427_1.actors_["10092_1"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_5) and arg_427_1.var_.actorSpriteComps10092_1 == nil then
				arg_427_1.var_.actorSpriteComps10092_1 = var_430_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_430_6 = 2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_6 and not isNil(var_430_5) then
				if arg_427_1.var_.actorSpriteComps10092_1 then
					for iter_430_2, iter_430_3 in pairs(arg_427_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_430_3 then
							if arg_427_1.isInRecall_ then
								iter_430_3.color = Color.New(Mathf.Lerp(iter_430_3.color.r, arg_427_1.hightColor2.r, (arg_427_1.time_ - 0) / var_430_6), Mathf.Lerp(iter_430_3.color.g, arg_427_1.hightColor2.g, (arg_427_1.time_ - 0) / var_430_6), (Mathf.Lerp(iter_430_3.color.b, arg_427_1.hightColor2.b, (arg_427_1.time_ - 0) / var_430_6)))
							else
								local var_430_7 = Mathf.Lerp(iter_430_3.color.r, 0.5, (arg_427_1.time_ - 0) / var_430_6)

								iter_430_3.color = Color.New(var_430_7, var_430_7, var_430_7)
							end
						end
					end
				end
			end

			if arg_427_1.time_ >= 0 + var_430_6 and arg_427_1.time_ < 0 + var_430_6 + arg_430_0 and not isNil(var_430_5) and arg_427_1.var_.actorSpriteComps10092_1 then
				for iter_430_4, iter_430_5 in pairs(arg_427_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_430_5 then
						iter_430_5.color = arg_427_1.isInRecall_ and (arg_427_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_427_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_430_8 = arg_427_1.actors_["10093"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_8) and arg_427_1.var_.actorSpriteComps10093 == nil then
				arg_427_1.var_.actorSpriteComps10093 = var_430_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_430_9 = 2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_9 and not isNil(var_430_8) then
				if arg_427_1.var_.actorSpriteComps10093 then
					for iter_430_6, iter_430_7 in pairs(arg_427_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_430_7 then
							if arg_427_1.isInRecall_ then
								iter_430_7.color = Color.New(Mathf.Lerp(iter_430_7.color.r, arg_427_1.hightColor1.r, (arg_427_1.time_ - 0) / var_430_9), Mathf.Lerp(iter_430_7.color.g, arg_427_1.hightColor1.g, (arg_427_1.time_ - 0) / var_430_9), (Mathf.Lerp(iter_430_7.color.b, arg_427_1.hightColor1.b, (arg_427_1.time_ - 0) / var_430_9)))
							else
								local var_430_10 = Mathf.Lerp(iter_430_7.color.r, 1, (arg_427_1.time_ - 0) / var_430_9)

								iter_430_7.color = Color.New(var_430_10, var_430_10, var_430_10)
							end
						end
					end
				end
			end

			if arg_427_1.time_ >= 0 + var_430_9 and arg_427_1.time_ < 0 + var_430_9 + arg_430_0 and not isNil(var_430_8) and arg_427_1.var_.actorSpriteComps10093 then
				for iter_430_8, iter_430_9 in pairs(arg_427_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_430_9 then
						iter_430_9.color = arg_427_1.isInRecall_ and (arg_427_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_427_1.var_.actorSpriteComps10093 = nil
			end

			local var_430_11 = 0
			local var_430_12 = 0.375

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_11 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_13 = arg_427_1:GetWordFromCfg(413141102)
				local var_430_14 = arg_427_1:FormatText(var_430_13.content)

				arg_427_1.text_.text = var_430_14

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_16 = 15 <= 0 and var_430_12 or var_430_12 * (utf8.len(var_430_14) / 15)

				if (15 <= 0 and var_430_12 or var_430_12 * (utf8.len(var_430_14) / 15)) > 0 and var_430_12 < var_430_16 then
					arg_427_1.talkMaxDuration = var_430_16

					if var_430_16 + var_430_11 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_16 + var_430_11
					end
				end

				arg_427_1.text_.text = var_430_14
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141102", "story_v_out_413141.awb") ~= 0 then
					local var_430_17 = manager.audio:GetVoiceLength("story_v_out_413141", "413141102", "story_v_out_413141.awb") / 1000

					if var_430_17 + var_430_11 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_17 + var_430_11
					end

					if var_430_13.prefab_name ~= "" and arg_427_1.actors_[var_430_13.prefab_name] ~= nil then
						local var_430_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_13.prefab_name].transform, "story_v_out_413141", "413141102", "story_v_out_413141.awb")

						arg_427_1:RecordAudio("413141102", var_430_18)
						arg_427_1:RecordAudio("413141102", var_430_18)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_413141", "413141102", "story_v_out_413141.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_413141", "413141102", "story_v_out_413141.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_19 = math.max(var_430_12, arg_427_1.talkMaxDuration)

			if var_430_11 <= arg_427_1.time_ and arg_427_1.time_ < var_430_11 + var_430_19 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_11) / var_430_19

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_11 + var_430_19 and arg_427_1.time_ < var_430_11 + var_430_19 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play413141103 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 413141103
		arg_431_1.duration_ = 6.1

		local var_431_0 = {
			zh = 4.666,
			ja = 6.1
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
				arg_431_0:Play413141104(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.var_.moveOldPos10092_1 = arg_431_1.actors_["10092_1"].transform.localPosition
				arg_431_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_431_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_434_0 = 0, arg_431_1.actors_["10092_1"].transform.childCount - 1 do
					local var_434_0 = arg_431_1.actors_["10092_1"].transform:GetChild(iter_434_0)

					if var_434_0.name == "split_1_1" or not string.find(var_434_0.name, "split") then
						var_434_0.gameObject:SetActive(true)
					else
						var_434_0.gameObject:SetActive(false)
					end
				end
			end

			local var_434_1 = 0.001

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_1 then
				arg_431_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_431_1.time_ - 0) / var_434_1)
			end

			if arg_431_1.time_ >= 0 + var_434_1 and arg_431_1.time_ < 0 + var_434_1 + arg_434_0 then
				arg_431_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_434_2 = arg_431_1.actors_["10092_1"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(var_434_2) and arg_431_1.var_.actorSpriteComps10092_1 == nil then
				arg_431_1.var_.actorSpriteComps10092_1 = var_434_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_3 = 2

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_3 and not isNil(var_434_2) then
				if arg_431_1.var_.actorSpriteComps10092_1 then
					for iter_434_1, iter_434_2 in pairs(arg_431_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_434_2 then
							if arg_431_1.isInRecall_ then
								iter_434_2.color = Color.New(Mathf.Lerp(iter_434_2.color.r, arg_431_1.hightColor1.r, (arg_431_1.time_ - 0) / var_434_3), Mathf.Lerp(iter_434_2.color.g, arg_431_1.hightColor1.g, (arg_431_1.time_ - 0) / var_434_3), (Mathf.Lerp(iter_434_2.color.b, arg_431_1.hightColor1.b, (arg_431_1.time_ - 0) / var_434_3)))
							else
								local var_434_4 = Mathf.Lerp(iter_434_2.color.r, 1, (arg_431_1.time_ - 0) / var_434_3)

								iter_434_2.color = Color.New(var_434_4, var_434_4, var_434_4)
							end
						end
					end
				end
			end

			if arg_431_1.time_ >= 0 + var_434_3 and arg_431_1.time_ < 0 + var_434_3 + arg_434_0 and not isNil(var_434_2) and arg_431_1.var_.actorSpriteComps10092_1 then
				for iter_434_3, iter_434_4 in pairs(arg_431_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_434_4 then
						iter_434_4.color = arg_431_1.isInRecall_ and (arg_431_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_431_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_434_5 = arg_431_1.actors_["10093"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(var_434_5) and arg_431_1.var_.actorSpriteComps10093 == nil then
				arg_431_1.var_.actorSpriteComps10093 = var_434_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_6 = 2

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_6 and not isNil(var_434_5) then
				if arg_431_1.var_.actorSpriteComps10093 then
					for iter_434_5, iter_434_6 in pairs(arg_431_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_434_6 then
							if arg_431_1.isInRecall_ then
								iter_434_6.color = Color.New(Mathf.Lerp(iter_434_6.color.r, arg_431_1.hightColor2.r, (arg_431_1.time_ - 0) / var_434_6), Mathf.Lerp(iter_434_6.color.g, arg_431_1.hightColor2.g, (arg_431_1.time_ - 0) / var_434_6), (Mathf.Lerp(iter_434_6.color.b, arg_431_1.hightColor2.b, (arg_431_1.time_ - 0) / var_434_6)))
							else
								local var_434_7 = Mathf.Lerp(iter_434_6.color.r, 0.5, (arg_431_1.time_ - 0) / var_434_6)

								iter_434_6.color = Color.New(var_434_7, var_434_7, var_434_7)
							end
						end
					end
				end
			end

			if arg_431_1.time_ >= 0 + var_434_6 and arg_431_1.time_ < 0 + var_434_6 + arg_434_0 and not isNil(var_434_5) and arg_431_1.var_.actorSpriteComps10093 then
				for iter_434_7, iter_434_8 in pairs(arg_431_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_434_8 then
						iter_434_8.color = arg_431_1.isInRecall_ and (arg_431_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_431_1.var_.actorSpriteComps10093 = nil
			end

			local var_434_8 = 0
			local var_434_9 = 0.5

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_8 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_10 = arg_431_1:GetWordFromCfg(413141103)
				local var_434_11 = arg_431_1:FormatText(var_434_10.content)

				arg_431_1.text_.text = var_434_11

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_13 = 20 <= 0 and var_434_9 or var_434_9 * (utf8.len(var_434_11) / 20)

				if (20 <= 0 and var_434_9 or var_434_9 * (utf8.len(var_434_11) / 20)) > 0 and var_434_9 < var_434_13 then
					arg_431_1.talkMaxDuration = var_434_13

					if var_434_13 + var_434_8 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_13 + var_434_8
					end
				end

				arg_431_1.text_.text = var_434_11
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141103", "story_v_out_413141.awb") ~= 0 then
					local var_434_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141103", "story_v_out_413141.awb") / 1000

					if var_434_14 + var_434_8 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_14 + var_434_8
					end

					if var_434_10.prefab_name ~= "" and arg_431_1.actors_[var_434_10.prefab_name] ~= nil then
						local var_434_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_10.prefab_name].transform, "story_v_out_413141", "413141103", "story_v_out_413141.awb")

						arg_431_1:RecordAudio("413141103", var_434_15)
						arg_431_1:RecordAudio("413141103", var_434_15)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_413141", "413141103", "story_v_out_413141.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_413141", "413141103", "story_v_out_413141.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_16 = math.max(var_434_9, arg_431_1.talkMaxDuration)

			if var_434_8 <= arg_431_1.time_ and arg_431_1.time_ < var_434_8 + var_434_16 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_8) / var_434_16

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_8 + var_434_16 and arg_431_1.time_ < var_434_8 + var_434_16 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413141104 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 413141104
		arg_435_1.duration_ = 2

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play413141105(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos10093 = arg_435_1.actors_["10093"].transform.localPosition
				arg_435_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_435_1:CheckSpriteTmpPos("10093", 4)

				for iter_438_0 = 0, arg_435_1.actors_["10093"].transform.childCount - 1 do
					local var_438_0 = arg_435_1.actors_["10093"].transform:GetChild(iter_438_0)

					if var_438_0.name == "split_4" or not string.find(var_438_0.name, "split") then
						var_438_0.gameObject:SetActive(true)
					else
						var_438_0.gameObject:SetActive(false)
					end
				end
			end

			local var_438_1 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_1 then
				arg_435_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_435_1.time_ - 0) / var_438_1)
			end

			if arg_435_1.time_ >= 0 + var_438_1 and arg_435_1.time_ < 0 + var_438_1 + arg_438_0 then
				arg_435_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_438_2 = arg_435_1.actors_["10092_1"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_2) and arg_435_1.var_.actorSpriteComps10092_1 == nil then
				arg_435_1.var_.actorSpriteComps10092_1 = var_438_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_3 = 2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_3 and not isNil(var_438_2) then
				if arg_435_1.var_.actorSpriteComps10092_1 then
					for iter_438_1, iter_438_2 in pairs(arg_435_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_438_2 then
							if arg_435_1.isInRecall_ then
								iter_438_2.color = Color.New(Mathf.Lerp(iter_438_2.color.r, arg_435_1.hightColor2.r, (arg_435_1.time_ - 0) / var_438_3), Mathf.Lerp(iter_438_2.color.g, arg_435_1.hightColor2.g, (arg_435_1.time_ - 0) / var_438_3), (Mathf.Lerp(iter_438_2.color.b, arg_435_1.hightColor2.b, (arg_435_1.time_ - 0) / var_438_3)))
							else
								local var_438_4 = Mathf.Lerp(iter_438_2.color.r, 0.5, (arg_435_1.time_ - 0) / var_438_3)

								iter_438_2.color = Color.New(var_438_4, var_438_4, var_438_4)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= 0 + var_438_3 and arg_435_1.time_ < 0 + var_438_3 + arg_438_0 and not isNil(var_438_2) and arg_435_1.var_.actorSpriteComps10092_1 then
				for iter_438_3, iter_438_4 in pairs(arg_435_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_438_4 then
						iter_438_4.color = arg_435_1.isInRecall_ and (arg_435_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_435_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_438_5 = arg_435_1.actors_["10093"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_5) and arg_435_1.var_.actorSpriteComps10093 == nil then
				arg_435_1.var_.actorSpriteComps10093 = var_438_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_6 = 2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_6 and not isNil(var_438_5) then
				if arg_435_1.var_.actorSpriteComps10093 then
					for iter_438_5, iter_438_6 in pairs(arg_435_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_438_6 then
							if arg_435_1.isInRecall_ then
								iter_438_6.color = Color.New(Mathf.Lerp(iter_438_6.color.r, arg_435_1.hightColor1.r, (arg_435_1.time_ - 0) / var_438_6), Mathf.Lerp(iter_438_6.color.g, arg_435_1.hightColor1.g, (arg_435_1.time_ - 0) / var_438_6), (Mathf.Lerp(iter_438_6.color.b, arg_435_1.hightColor1.b, (arg_435_1.time_ - 0) / var_438_6)))
							else
								local var_438_7 = Mathf.Lerp(iter_438_6.color.r, 1, (arg_435_1.time_ - 0) / var_438_6)

								iter_438_6.color = Color.New(var_438_7, var_438_7, var_438_7)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= 0 + var_438_6 and arg_435_1.time_ < 0 + var_438_6 + arg_438_0 and not isNil(var_438_5) and arg_435_1.var_.actorSpriteComps10093 then
				for iter_438_7, iter_438_8 in pairs(arg_435_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_438_8 then
						iter_438_8.color = arg_435_1.isInRecall_ and (arg_435_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_435_1.var_.actorSpriteComps10093 = nil
			end

			local var_438_8 = 0
			local var_438_9 = 0.075

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_8 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_10 = arg_435_1:GetWordFromCfg(413141104)
				local var_438_11 = arg_435_1:FormatText(var_438_10.content)

				arg_435_1.text_.text = var_438_11

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_13 = 3 <= 0 and var_438_9 or var_438_9 * (utf8.len(var_438_11) / 3)

				if (3 <= 0 and var_438_9 or var_438_9 * (utf8.len(var_438_11) / 3)) > 0 and var_438_9 < var_438_13 then
					arg_435_1.talkMaxDuration = var_438_13

					if var_438_13 + var_438_8 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_13 + var_438_8
					end
				end

				arg_435_1.text_.text = var_438_11
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141104", "story_v_out_413141.awb") ~= 0 then
					local var_438_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141104", "story_v_out_413141.awb") / 1000

					if var_438_14 + var_438_8 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_14 + var_438_8
					end

					if var_438_10.prefab_name ~= "" and arg_435_1.actors_[var_438_10.prefab_name] ~= nil then
						local var_438_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_10.prefab_name].transform, "story_v_out_413141", "413141104", "story_v_out_413141.awb")

						arg_435_1:RecordAudio("413141104", var_438_15)
						arg_435_1:RecordAudio("413141104", var_438_15)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_413141", "413141104", "story_v_out_413141.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_413141", "413141104", "story_v_out_413141.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_16 = math.max(var_438_9, arg_435_1.talkMaxDuration)

			if var_438_8 <= arg_435_1.time_ and arg_435_1.time_ < var_438_8 + var_438_16 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_8) / var_438_16

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_8 + var_438_16 and arg_435_1.time_ < var_438_8 + var_438_16 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play413141105 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 413141105
		arg_439_1.duration_ = 12.23

		local var_439_0 = {
			zh = 7.1,
			ja = 12.233
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
				arg_439_0:Play413141106(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos10092_1 = arg_439_1.actors_["10092_1"].transform.localPosition
				arg_439_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_439_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_442_0 = 0, arg_439_1.actors_["10092_1"].transform.childCount - 1 do
					local var_442_0 = arg_439_1.actors_["10092_1"].transform:GetChild(iter_442_0)

					if var_442_0.name == "split_2" or not string.find(var_442_0.name, "split") then
						var_442_0.gameObject:SetActive(true)
					else
						var_442_0.gameObject:SetActive(false)
					end
				end
			end

			local var_442_1 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_1 then
				arg_439_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_439_1.time_ - 0) / var_442_1)
			end

			if arg_439_1.time_ >= 0 + var_442_1 and arg_439_1.time_ < 0 + var_442_1 + arg_442_0 then
				arg_439_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_442_2 = arg_439_1.actors_["10092_1"]

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(var_442_2) and arg_439_1.var_.actorSpriteComps10092_1 == nil then
				arg_439_1.var_.actorSpriteComps10092_1 = var_442_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_442_3 = 2

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_3 and not isNil(var_442_2) then
				if arg_439_1.var_.actorSpriteComps10092_1 then
					for iter_442_1, iter_442_2 in pairs(arg_439_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_442_2 then
							if arg_439_1.isInRecall_ then
								iter_442_2.color = Color.New(Mathf.Lerp(iter_442_2.color.r, arg_439_1.hightColor1.r, (arg_439_1.time_ - 0) / var_442_3), Mathf.Lerp(iter_442_2.color.g, arg_439_1.hightColor1.g, (arg_439_1.time_ - 0) / var_442_3), (Mathf.Lerp(iter_442_2.color.b, arg_439_1.hightColor1.b, (arg_439_1.time_ - 0) / var_442_3)))
							else
								local var_442_4 = Mathf.Lerp(iter_442_2.color.r, 1, (arg_439_1.time_ - 0) / var_442_3)

								iter_442_2.color = Color.New(var_442_4, var_442_4, var_442_4)
							end
						end
					end
				end
			end

			if arg_439_1.time_ >= 0 + var_442_3 and arg_439_1.time_ < 0 + var_442_3 + arg_442_0 and not isNil(var_442_2) and arg_439_1.var_.actorSpriteComps10092_1 then
				for iter_442_3, iter_442_4 in pairs(arg_439_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_442_4 then
						iter_442_4.color = arg_439_1.isInRecall_ and (arg_439_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_439_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_442_5 = arg_439_1.actors_["10093"]

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(var_442_5) and arg_439_1.var_.actorSpriteComps10093 == nil then
				arg_439_1.var_.actorSpriteComps10093 = var_442_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_442_6 = 2

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_6 and not isNil(var_442_5) then
				if arg_439_1.var_.actorSpriteComps10093 then
					for iter_442_5, iter_442_6 in pairs(arg_439_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_442_6 then
							if arg_439_1.isInRecall_ then
								iter_442_6.color = Color.New(Mathf.Lerp(iter_442_6.color.r, arg_439_1.hightColor2.r, (arg_439_1.time_ - 0) / var_442_6), Mathf.Lerp(iter_442_6.color.g, arg_439_1.hightColor2.g, (arg_439_1.time_ - 0) / var_442_6), (Mathf.Lerp(iter_442_6.color.b, arg_439_1.hightColor2.b, (arg_439_1.time_ - 0) / var_442_6)))
							else
								local var_442_7 = Mathf.Lerp(iter_442_6.color.r, 0.5, (arg_439_1.time_ - 0) / var_442_6)

								iter_442_6.color = Color.New(var_442_7, var_442_7, var_442_7)
							end
						end
					end
				end
			end

			if arg_439_1.time_ >= 0 + var_442_6 and arg_439_1.time_ < 0 + var_442_6 + arg_442_0 and not isNil(var_442_5) and arg_439_1.var_.actorSpriteComps10093 then
				for iter_442_7, iter_442_8 in pairs(arg_439_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_442_8 then
						iter_442_8.color = arg_439_1.isInRecall_ and (arg_439_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_439_1.var_.actorSpriteComps10093 = nil
			end

			local var_442_8 = 0
			local var_442_9 = 0.95

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_8 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_10 = arg_439_1:GetWordFromCfg(413141105)
				local var_442_11 = arg_439_1:FormatText(var_442_10.content)

				arg_439_1.text_.text = var_442_11

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_13 = 38 <= 0 and var_442_9 or var_442_9 * (utf8.len(var_442_11) / 38)

				if (38 <= 0 and var_442_9 or var_442_9 * (utf8.len(var_442_11) / 38)) > 0 and var_442_9 < var_442_13 then
					arg_439_1.talkMaxDuration = var_442_13

					if var_442_13 + var_442_8 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_13 + var_442_8
					end
				end

				arg_439_1.text_.text = var_442_11
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141105", "story_v_out_413141.awb") ~= 0 then
					local var_442_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141105", "story_v_out_413141.awb") / 1000

					if var_442_14 + var_442_8 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_14 + var_442_8
					end

					if var_442_10.prefab_name ~= "" and arg_439_1.actors_[var_442_10.prefab_name] ~= nil then
						local var_442_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_10.prefab_name].transform, "story_v_out_413141", "413141105", "story_v_out_413141.awb")

						arg_439_1:RecordAudio("413141105", var_442_15)
						arg_439_1:RecordAudio("413141105", var_442_15)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_413141", "413141105", "story_v_out_413141.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_413141", "413141105", "story_v_out_413141.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_16 = math.max(var_442_9, arg_439_1.talkMaxDuration)

			if var_442_8 <= arg_439_1.time_ and arg_439_1.time_ < var_442_8 + var_442_16 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_8) / var_442_16

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_8 + var_442_16 and arg_439_1.time_ < var_442_8 + var_442_16 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play413141106 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 413141106
		arg_443_1.duration_ = 4.57

		local var_443_0 = {
			zh = 4.566,
			ja = 4.233
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
				arg_443_0:Play413141107(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos10093 = arg_443_1.actors_["10093"].transform.localPosition
				arg_443_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_443_1:CheckSpriteTmpPos("10093", 4)

				for iter_446_0 = 0, arg_443_1.actors_["10093"].transform.childCount - 1 do
					local var_446_0 = arg_443_1.actors_["10093"].transform:GetChild(iter_446_0)

					if var_446_0.name == "split_4" or not string.find(var_446_0.name, "split") then
						var_446_0.gameObject:SetActive(true)
					else
						var_446_0.gameObject:SetActive(false)
					end
				end
			end

			local var_446_1 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_1 then
				arg_443_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_443_1.time_ - 0) / var_446_1)
			end

			if arg_443_1.time_ >= 0 + var_446_1 and arg_443_1.time_ < 0 + var_446_1 + arg_446_0 then
				arg_443_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_446_2 = arg_443_1.actors_["10092_1"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_2) and arg_443_1.var_.actorSpriteComps10092_1 == nil then
				arg_443_1.var_.actorSpriteComps10092_1 = var_446_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_3 = 2

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_3 and not isNil(var_446_2) then
				if arg_443_1.var_.actorSpriteComps10092_1 then
					for iter_446_1, iter_446_2 in pairs(arg_443_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_446_2 then
							if arg_443_1.isInRecall_ then
								iter_446_2.color = Color.New(Mathf.Lerp(iter_446_2.color.r, arg_443_1.hightColor2.r, (arg_443_1.time_ - 0) / var_446_3), Mathf.Lerp(iter_446_2.color.g, arg_443_1.hightColor2.g, (arg_443_1.time_ - 0) / var_446_3), (Mathf.Lerp(iter_446_2.color.b, arg_443_1.hightColor2.b, (arg_443_1.time_ - 0) / var_446_3)))
							else
								local var_446_4 = Mathf.Lerp(iter_446_2.color.r, 0.5, (arg_443_1.time_ - 0) / var_446_3)

								iter_446_2.color = Color.New(var_446_4, var_446_4, var_446_4)
							end
						end
					end
				end
			end

			if arg_443_1.time_ >= 0 + var_446_3 and arg_443_1.time_ < 0 + var_446_3 + arg_446_0 and not isNil(var_446_2) and arg_443_1.var_.actorSpriteComps10092_1 then
				for iter_446_3, iter_446_4 in pairs(arg_443_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_446_4 then
						iter_446_4.color = arg_443_1.isInRecall_ and (arg_443_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_443_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_446_5 = arg_443_1.actors_["10093"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_5) and arg_443_1.var_.actorSpriteComps10093 == nil then
				arg_443_1.var_.actorSpriteComps10093 = var_446_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_6 = 2

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_6 and not isNil(var_446_5) then
				if arg_443_1.var_.actorSpriteComps10093 then
					for iter_446_5, iter_446_6 in pairs(arg_443_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_446_6 then
							if arg_443_1.isInRecall_ then
								iter_446_6.color = Color.New(Mathf.Lerp(iter_446_6.color.r, arg_443_1.hightColor1.r, (arg_443_1.time_ - 0) / var_446_6), Mathf.Lerp(iter_446_6.color.g, arg_443_1.hightColor1.g, (arg_443_1.time_ - 0) / var_446_6), (Mathf.Lerp(iter_446_6.color.b, arg_443_1.hightColor1.b, (arg_443_1.time_ - 0) / var_446_6)))
							else
								local var_446_7 = Mathf.Lerp(iter_446_6.color.r, 1, (arg_443_1.time_ - 0) / var_446_6)

								iter_446_6.color = Color.New(var_446_7, var_446_7, var_446_7)
							end
						end
					end
				end
			end

			if arg_443_1.time_ >= 0 + var_446_6 and arg_443_1.time_ < 0 + var_446_6 + arg_446_0 and not isNil(var_446_5) and arg_443_1.var_.actorSpriteComps10093 then
				for iter_446_7, iter_446_8 in pairs(arg_443_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_446_8 then
						iter_446_8.color = arg_443_1.isInRecall_ and (arg_443_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_443_1.var_.actorSpriteComps10093 = nil
			end

			local var_446_8 = 0
			local var_446_9 = 0.425

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_8 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_10 = arg_443_1:GetWordFromCfg(413141106)
				local var_446_11 = arg_443_1:FormatText(var_446_10.content)

				arg_443_1.text_.text = var_446_11

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_13 = 17 <= 0 and var_446_9 or var_446_9 * (utf8.len(var_446_11) / 17)

				if (17 <= 0 and var_446_9 or var_446_9 * (utf8.len(var_446_11) / 17)) > 0 and var_446_9 < var_446_13 then
					arg_443_1.talkMaxDuration = var_446_13

					if var_446_13 + var_446_8 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_13 + var_446_8
					end
				end

				arg_443_1.text_.text = var_446_11
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141106", "story_v_out_413141.awb") ~= 0 then
					local var_446_14 = manager.audio:GetVoiceLength("story_v_out_413141", "413141106", "story_v_out_413141.awb") / 1000

					if var_446_14 + var_446_8 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_14 + var_446_8
					end

					if var_446_10.prefab_name ~= "" and arg_443_1.actors_[var_446_10.prefab_name] ~= nil then
						local var_446_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_10.prefab_name].transform, "story_v_out_413141", "413141106", "story_v_out_413141.awb")

						arg_443_1:RecordAudio("413141106", var_446_15)
						arg_443_1:RecordAudio("413141106", var_446_15)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_413141", "413141106", "story_v_out_413141.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_413141", "413141106", "story_v_out_413141.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_16 = math.max(var_446_9, arg_443_1.talkMaxDuration)

			if var_446_8 <= arg_443_1.time_ and arg_443_1.time_ < var_446_8 + var_446_16 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_8) / var_446_16

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_8 + var_446_16 and arg_443_1.time_ < var_446_8 + var_446_16 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play413141107 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 413141107
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play413141108(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos10093 = arg_447_1.actors_["10093"].transform.localPosition
				arg_447_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_447_1:CheckSpriteTmpPos("10093", 7)

				for iter_450_0 = 0, arg_447_1.actors_["10093"].transform.childCount - 1 do
					local var_450_0 = arg_447_1.actors_["10093"].transform:GetChild(iter_450_0)

					if var_450_0.name == "" or not string.find(var_450_0.name, "split") then
						var_450_0.gameObject:SetActive(true)
					else
						var_450_0.gameObject:SetActive(false)
					end
				end
			end

			local var_450_1 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_1 then
				arg_447_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_447_1.time_ - 0) / var_450_1)
			end

			if arg_447_1.time_ >= 0 + var_450_1 and arg_447_1.time_ < 0 + var_450_1 + arg_450_0 then
				arg_447_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_450_2 = arg_447_1.actors_["10092_1"].transform

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos10092_1 = var_450_2.localPosition
				var_450_2.localScale = Vector3.New(1, 1, 1)

				arg_447_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_450_1 = 0, var_450_2.childCount - 1 do
					local var_450_3 = var_450_2:GetChild(iter_450_1)

					if var_450_3.name == "split_2" or not string.find(var_450_3.name, "split") then
						var_450_3.gameObject:SetActive(true)
					else
						var_450_3.gameObject:SetActive(false)
					end
				end
			end

			local var_450_4 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_4 then
				var_450_2.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_447_1.time_ - 0) / var_450_4)
			end

			if arg_447_1.time_ >= 0 + var_450_4 and arg_447_1.time_ < 0 + var_450_4 + arg_450_0 then
				var_450_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_450_5 = 0
			local var_450_6 = 1.05

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_5 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_7 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(413141107).content)

				arg_447_1.text_.text = var_450_7

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_9 = 42 <= 0 and var_450_6 or var_450_6 * (utf8.len(var_450_7) / 42)

				if (42 <= 0 and var_450_6 or var_450_6 * (utf8.len(var_450_7) / 42)) > 0 and var_450_6 < var_450_9 then
					arg_447_1.talkMaxDuration = var_450_9

					if var_450_9 + var_450_5 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_9 + var_450_5
					end
				end

				arg_447_1.text_.text = var_450_7
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_10 = math.max(var_450_6, arg_447_1.talkMaxDuration)

			if var_450_5 <= arg_447_1.time_ and arg_447_1.time_ < var_450_5 + var_450_10 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_5) / var_450_10

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_5 + var_450_10 and arg_447_1.time_ < var_450_5 + var_450_10 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play413141108 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 413141108
		arg_451_1.duration_ = 7.8

		local var_451_0 = {
			zh = 5.333,
			ja = 7.8
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
				arg_451_0:Play413141109(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos10092_1 = arg_451_1.actors_["10092_1"].transform.localPosition
				arg_451_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_451_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_454_0 = 0, arg_451_1.actors_["10092_1"].transform.childCount - 1 do
					local var_454_0 = arg_451_1.actors_["10092_1"].transform:GetChild(iter_454_0)

					if var_454_0.name == "split_1_1" or not string.find(var_454_0.name, "split") then
						var_454_0.gameObject:SetActive(true)
					else
						var_454_0.gameObject:SetActive(false)
					end
				end
			end

			local var_454_1 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_1 then
				arg_451_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_451_1.time_ - 0) / var_454_1)
			end

			if arg_451_1.time_ >= 0 + var_454_1 and arg_451_1.time_ < 0 + var_454_1 + arg_454_0 then
				arg_451_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_454_2 = arg_451_1.actors_["10092_1"]

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(var_454_2) and arg_451_1.var_.actorSpriteComps10092_1 == nil then
				arg_451_1.var_.actorSpriteComps10092_1 = var_454_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_454_3 = 2

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_3 and not isNil(var_454_2) then
				if arg_451_1.var_.actorSpriteComps10092_1 then
					for iter_454_1, iter_454_2 in pairs(arg_451_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_454_2 then
							if arg_451_1.isInRecall_ then
								iter_454_2.color = Color.New(Mathf.Lerp(iter_454_2.color.r, arg_451_1.hightColor1.r, (arg_451_1.time_ - 0) / var_454_3), Mathf.Lerp(iter_454_2.color.g, arg_451_1.hightColor1.g, (arg_451_1.time_ - 0) / var_454_3), (Mathf.Lerp(iter_454_2.color.b, arg_451_1.hightColor1.b, (arg_451_1.time_ - 0) / var_454_3)))
							else
								local var_454_4 = Mathf.Lerp(iter_454_2.color.r, 1, (arg_451_1.time_ - 0) / var_454_3)

								iter_454_2.color = Color.New(var_454_4, var_454_4, var_454_4)
							end
						end
					end
				end
			end

			if arg_451_1.time_ >= 0 + var_454_3 and arg_451_1.time_ < 0 + var_454_3 + arg_454_0 and not isNil(var_454_2) and arg_451_1.var_.actorSpriteComps10092_1 then
				for iter_454_3, iter_454_4 in pairs(arg_451_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_454_4 then
						iter_454_4.color = arg_451_1.isInRecall_ and (arg_451_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_451_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_454_5 = 0
			local var_454_6 = 0.7

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_5 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_7 = arg_451_1:GetWordFromCfg(413141108)
				local var_454_8 = arg_451_1:FormatText(var_454_7.content)

				arg_451_1.text_.text = var_454_8

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_10 = 28 <= 0 and var_454_6 or var_454_6 * (utf8.len(var_454_8) / 28)

				if (28 <= 0 and var_454_6 or var_454_6 * (utf8.len(var_454_8) / 28)) > 0 and var_454_6 < var_454_10 then
					arg_451_1.talkMaxDuration = var_454_10

					if var_454_10 + var_454_5 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_10 + var_454_5
					end
				end

				arg_451_1.text_.text = var_454_8
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141108", "story_v_out_413141.awb") ~= 0 then
					local var_454_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141108", "story_v_out_413141.awb") / 1000

					if var_454_11 + var_454_5 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_11 + var_454_5
					end

					if var_454_7.prefab_name ~= "" and arg_451_1.actors_[var_454_7.prefab_name] ~= nil then
						local var_454_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_7.prefab_name].transform, "story_v_out_413141", "413141108", "story_v_out_413141.awb")

						arg_451_1:RecordAudio("413141108", var_454_12)
						arg_451_1:RecordAudio("413141108", var_454_12)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_413141", "413141108", "story_v_out_413141.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_413141", "413141108", "story_v_out_413141.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_13 = math.max(var_454_6, arg_451_1.talkMaxDuration)

			if var_454_5 <= arg_451_1.time_ and arg_451_1.time_ < var_454_5 + var_454_13 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_5) / var_454_13

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_5 + var_454_13 and arg_451_1.time_ < var_454_5 + var_454_13 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play413141109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 413141109
		arg_455_1.duration_ = 5.53

		local var_455_0 = {
			zh = 3.266,
			ja = 5.533
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
				arg_455_0:Play413141110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPos10092_1 = arg_455_1.actors_["10092_1"].transform.localPosition
				arg_455_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_455_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_458_0 = 0, arg_455_1.actors_["10092_1"].transform.childCount - 1 do
					local var_458_0 = arg_455_1.actors_["10092_1"].transform:GetChild(iter_458_0)

					if var_458_0.name == "" or not string.find(var_458_0.name, "split") then
						var_458_0.gameObject:SetActive(true)
					else
						var_458_0.gameObject:SetActive(false)
					end
				end
			end

			local var_458_1 = 0.001

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_1 then
				arg_455_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_455_1.time_ - 0) / var_458_1)
			end

			if arg_455_1.time_ >= 0 + var_458_1 and arg_455_1.time_ < 0 + var_458_1 + arg_458_0 then
				arg_455_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_458_2 = arg_455_1.actors_["10093"].transform

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPos10093 = var_458_2.localPosition
				var_458_2.localScale = Vector3.New(1, 1, 1)

				arg_455_1:CheckSpriteTmpPos("10093", 4)

				for iter_458_1 = 0, var_458_2.childCount - 1 do
					local var_458_3 = var_458_2:GetChild(iter_458_1)

					if var_458_3.name == "split_3" or not string.find(var_458_3.name, "split") then
						var_458_3.gameObject:SetActive(true)
					else
						var_458_3.gameObject:SetActive(false)
					end
				end
			end

			local var_458_4 = 0.001

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_4 then
				var_458_2.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_455_1.time_ - 0) / var_458_4)
			end

			if arg_455_1.time_ >= 0 + var_458_4 and arg_455_1.time_ < 0 + var_458_4 + arg_458_0 then
				var_458_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_458_5 = arg_455_1.actors_["10092_1"]

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(var_458_5) and arg_455_1.var_.actorSpriteComps10092_1 == nil then
				arg_455_1.var_.actorSpriteComps10092_1 = var_458_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_458_6 = 2

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_6 and not isNil(var_458_5) then
				if arg_455_1.var_.actorSpriteComps10092_1 then
					for iter_458_2, iter_458_3 in pairs(arg_455_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_458_3 then
							if arg_455_1.isInRecall_ then
								iter_458_3.color = Color.New(Mathf.Lerp(iter_458_3.color.r, arg_455_1.hightColor2.r, (arg_455_1.time_ - 0) / var_458_6), Mathf.Lerp(iter_458_3.color.g, arg_455_1.hightColor2.g, (arg_455_1.time_ - 0) / var_458_6), (Mathf.Lerp(iter_458_3.color.b, arg_455_1.hightColor2.b, (arg_455_1.time_ - 0) / var_458_6)))
							else
								local var_458_7 = Mathf.Lerp(iter_458_3.color.r, 0.5, (arg_455_1.time_ - 0) / var_458_6)

								iter_458_3.color = Color.New(var_458_7, var_458_7, var_458_7)
							end
						end
					end
				end
			end

			if arg_455_1.time_ >= 0 + var_458_6 and arg_455_1.time_ < 0 + var_458_6 + arg_458_0 and not isNil(var_458_5) and arg_455_1.var_.actorSpriteComps10092_1 then
				for iter_458_4, iter_458_5 in pairs(arg_455_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_458_5 then
						iter_458_5.color = arg_455_1.isInRecall_ and (arg_455_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_455_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_458_8 = arg_455_1.actors_["10093"]

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(var_458_8) and arg_455_1.var_.actorSpriteComps10093 == nil then
				arg_455_1.var_.actorSpriteComps10093 = var_458_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_458_9 = 2

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_9 and not isNil(var_458_8) then
				if arg_455_1.var_.actorSpriteComps10093 then
					for iter_458_6, iter_458_7 in pairs(arg_455_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_458_7 then
							if arg_455_1.isInRecall_ then
								iter_458_7.color = Color.New(Mathf.Lerp(iter_458_7.color.r, arg_455_1.hightColor1.r, (arg_455_1.time_ - 0) / var_458_9), Mathf.Lerp(iter_458_7.color.g, arg_455_1.hightColor1.g, (arg_455_1.time_ - 0) / var_458_9), (Mathf.Lerp(iter_458_7.color.b, arg_455_1.hightColor1.b, (arg_455_1.time_ - 0) / var_458_9)))
							else
								local var_458_10 = Mathf.Lerp(iter_458_7.color.r, 1, (arg_455_1.time_ - 0) / var_458_9)

								iter_458_7.color = Color.New(var_458_10, var_458_10, var_458_10)
							end
						end
					end
				end
			end

			if arg_455_1.time_ >= 0 + var_458_9 and arg_455_1.time_ < 0 + var_458_9 + arg_458_0 and not isNil(var_458_8) and arg_455_1.var_.actorSpriteComps10093 then
				for iter_458_8, iter_458_9 in pairs(arg_455_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_458_9 then
						iter_458_9.color = arg_455_1.isInRecall_ and (arg_455_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_455_1.var_.actorSpriteComps10093 = nil
			end

			local var_458_11 = 0
			local var_458_12 = 0.35

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_11 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_13 = arg_455_1:GetWordFromCfg(413141109)
				local var_458_14 = arg_455_1:FormatText(var_458_13.content)

				arg_455_1.text_.text = var_458_14

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_16 = 14 <= 0 and var_458_12 or var_458_12 * (utf8.len(var_458_14) / 14)

				if (14 <= 0 and var_458_12 or var_458_12 * (utf8.len(var_458_14) / 14)) > 0 and var_458_12 < var_458_16 then
					arg_455_1.talkMaxDuration = var_458_16

					if var_458_16 + var_458_11 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_16 + var_458_11
					end
				end

				arg_455_1.text_.text = var_458_14
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141109", "story_v_out_413141.awb") ~= 0 then
					local var_458_17 = manager.audio:GetVoiceLength("story_v_out_413141", "413141109", "story_v_out_413141.awb") / 1000

					if var_458_17 + var_458_11 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_17 + var_458_11
					end

					if var_458_13.prefab_name ~= "" and arg_455_1.actors_[var_458_13.prefab_name] ~= nil then
						local var_458_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_13.prefab_name].transform, "story_v_out_413141", "413141109", "story_v_out_413141.awb")

						arg_455_1:RecordAudio("413141109", var_458_18)
						arg_455_1:RecordAudio("413141109", var_458_18)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_413141", "413141109", "story_v_out_413141.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_413141", "413141109", "story_v_out_413141.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_19 = math.max(var_458_12, arg_455_1.talkMaxDuration)

			if var_458_11 <= arg_455_1.time_ and arg_455_1.time_ < var_458_11 + var_458_19 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_11) / var_458_19

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_11 + var_458_19 and arg_455_1.time_ < var_458_11 + var_458_19 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play413141110 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 413141110
		arg_459_1.duration_ = 8.8

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play413141111(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 2 < arg_459_1.time_ and arg_459_1.time_ <= 2 + arg_462_0 then
				local var_462_0 = arg_459_1.bgs_.ST0603a

				arg_459_1.bgs_.ST0603a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_462_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_462_1 = var_462_0:GetComponent("SpriteRenderer")

				if var_462_1 and var_462_1.sprite then
					local var_462_2 = 2 * (var_462_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_462_0.transform.localScale = Vector3.New(var_462_2 / var_462_1.sprite.bounds.size.y < var_462_2 * manager.ui.mainCameraCom_.aspect / var_462_1.sprite.bounds.size.x and var_462_2 * manager.ui.mainCameraCom_.aspect / var_462_1.sprite.bounds.size.x or var_462_2 / var_462_1.sprite.bounds.size.y, var_462_2 / var_462_1.sprite.bounds.size.y < var_462_2 * manager.ui.mainCameraCom_.aspect / var_462_1.sprite.bounds.size.x and var_462_2 * manager.ui.mainCameraCom_.aspect / var_462_1.sprite.bounds.size.x or var_462_2 / var_462_1.sprite.bounds.size.y, 0)
				end

				for iter_462_0, iter_462_1 in pairs(arg_459_1.bgs_) do
					if iter_462_0 ~= "ST0603a" then
						iter_462_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_462_3 = 3.8

			if 3.8 < arg_459_1.time_ and arg_459_1.time_ <= var_462_3 + arg_462_0 then
				arg_459_1.allBtn_.enabled = false
			end

			if arg_459_1.time_ >= var_462_3 + 0.3 and arg_459_1.time_ < var_462_3 + 0.3 + arg_462_0 then
				arg_459_1.allBtn_.enabled = true
			end

			local var_462_4 = 0

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_4 + arg_462_0 then
				arg_459_1.mask_.enabled = true
				arg_459_1.mask_.raycastTarget = true

				arg_459_1:SetGaussion(false)
			end

			local var_462_5 = 2

			if var_462_4 <= arg_459_1.time_ and arg_459_1.time_ < var_462_4 + var_462_5 then
				local var_462_6 = Color.New(0, 0, 0)

				var_462_6.a = Mathf.Lerp(0, 1, (arg_459_1.time_ - var_462_4) / var_462_5)
				arg_459_1.mask_.color = var_462_6
			end

			if arg_459_1.time_ >= var_462_4 + var_462_5 and arg_459_1.time_ < var_462_4 + var_462_5 + arg_462_0 then
				local var_462_7 = Color.New(0, 0, 0)

				var_462_7.a = 1
				arg_459_1.mask_.color = var_462_7
			end

			local var_462_8 = 2

			if 2 < arg_459_1.time_ and arg_459_1.time_ <= var_462_8 + arg_462_0 then
				arg_459_1.mask_.enabled = true
				arg_459_1.mask_.raycastTarget = true

				arg_459_1:SetGaussion(false)
			end

			local var_462_9 = 2

			if var_462_8 <= arg_459_1.time_ and arg_459_1.time_ < var_462_8 + var_462_9 then
				local var_462_10 = Color.New(0, 0, 0)

				var_462_10.a = Mathf.Lerp(1, 0, (arg_459_1.time_ - var_462_8) / var_462_9)
				arg_459_1.mask_.color = var_462_10
			end

			if arg_459_1.time_ >= var_462_8 + var_462_9 and arg_459_1.time_ < var_462_8 + var_462_9 + arg_462_0 then
				local var_462_11 = Color.New(0, 0, 0)

				arg_459_1.mask_.enabled = false
				var_462_11.a = 0
				arg_459_1.mask_.color = var_462_11
			end

			local var_462_12 = arg_459_1.actors_["10092_1"].transform

			if 2 < arg_459_1.time_ and arg_459_1.time_ <= 2 + arg_462_0 then
				arg_459_1.var_.moveOldPos10092_1 = var_462_12.localPosition
				var_462_12.localScale = Vector3.New(1, 1, 1)

				arg_459_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_462_2 = 0, var_462_12.childCount - 1 do
					local var_462_13 = var_462_12:GetChild(iter_462_2)

					if var_462_13.name == "" or not string.find(var_462_13.name, "split") then
						var_462_13.gameObject:SetActive(true)
					else
						var_462_13.gameObject:SetActive(false)
					end
				end
			end

			local var_462_14 = 0.001

			if 2 <= arg_459_1.time_ and arg_459_1.time_ < 2 + var_462_14 then
				var_462_12.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_459_1.time_ - 2) / var_462_14)
			end

			if arg_459_1.time_ >= 2 + var_462_14 and arg_459_1.time_ < 2 + var_462_14 + arg_462_0 then
				var_462_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_462_15 = arg_459_1.actors_["10093"].transform

			if 2 < arg_459_1.time_ and arg_459_1.time_ <= 2 + arg_462_0 then
				arg_459_1.var_.moveOldPos10093 = var_462_15.localPosition
				var_462_15.localScale = Vector3.New(1, 1, 1)

				arg_459_1:CheckSpriteTmpPos("10093", 7)

				for iter_462_3 = 0, var_462_15.childCount - 1 do
					local var_462_16 = var_462_15:GetChild(iter_462_3)

					if var_462_16.name == "" or not string.find(var_462_16.name, "split") then
						var_462_16.gameObject:SetActive(true)
					else
						var_462_16.gameObject:SetActive(false)
					end
				end
			end

			local var_462_17 = 0.001

			if 2 <= arg_459_1.time_ and arg_459_1.time_ < 2 + var_462_17 then
				var_462_15.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_459_1.time_ - 2) / var_462_17)
			end

			if arg_459_1.time_ >= 2 + var_462_17 and arg_459_1.time_ < 2 + var_462_17 + arg_462_0 then
				var_462_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_459_1.frameCnt_ <= 1 then
				arg_459_1.dialog_:SetActive(false)
			end

			local var_462_18 = 3.8
			local var_462_19 = 0.65

			if 3.8 < arg_459_1.time_ and arg_459_1.time_ <= var_462_18 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0

				arg_459_1.dialog_:SetActive(true)

				arg_459_1.dialogCg_.alpha = 0

				local var_462_20 = LeanTween.value(arg_459_1.dialog_, 0, 1, 0.3)

				var_462_20:setOnUpdate(LuaHelper.FloatAction(function(arg_463_0)
					arg_459_1.dialogCg_.alpha = arg_463_0
				end))
				var_462_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_459_1.dialog_)
					var_462_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_459_1.duration_ = arg_459_1.duration_ + 0.3

				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_21 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(413141110).content)

				arg_459_1.text_.text = var_462_21

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_23 = 26 <= 0 and var_462_19 or var_462_19 * (utf8.len(var_462_21) / 26)

				if (26 <= 0 and var_462_19 or var_462_19 * (utf8.len(var_462_21) / 26)) > 0 and var_462_19 < var_462_23 then
					arg_459_1.talkMaxDuration = var_462_23
					var_462_18 = var_462_18 + 0.3

					if var_462_23 + var_462_18 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_23 + var_462_18
					end
				end

				arg_459_1.text_.text = var_462_21
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_24 = var_462_18 + 0.3
			local var_462_25 = math.max(var_462_19, arg_459_1.talkMaxDuration)

			if var_462_18 + 0.3 <= arg_459_1.time_ and arg_459_1.time_ < var_462_24 + var_462_25 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_24) / var_462_25

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_24 + var_462_25 and arg_459_1.time_ < var_462_24 + var_462_25 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play413141111 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 413141111
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play413141112(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 1.475

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_1 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(413141111).content)

				arg_465_1.text_.text = var_468_1

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_3 = 59 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 59)

				if (59 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 59)) > 0 and var_468_0 < var_468_3 then
					arg_465_1.talkMaxDuration = var_468_3

					if var_468_3 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_3 + 0
					end
				end

				arg_465_1.text_.text = var_468_1
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_4 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_4

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play413141112 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 413141112
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play413141113(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 1.125

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_1 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(413141112).content)

				arg_469_1.text_.text = var_472_1

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_3 = 45 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 45)

				if (45 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 45)) > 0 and var_472_0 < var_472_3 then
					arg_469_1.talkMaxDuration = var_472_3

					if var_472_3 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_3 + 0
					end
				end

				arg_469_1.text_.text = var_472_1
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_4 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_4

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_4 and arg_469_1.time_ < 0 + var_472_4 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play413141113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 413141113
		arg_473_1.duration_ = 16

		local var_473_0 = {
			zh = 8.466,
			ja = 16
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play413141114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos10092_1 = arg_473_1.actors_["10092_1"].transform.localPosition
				arg_473_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_473_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_476_0 = 0, arg_473_1.actors_["10092_1"].transform.childCount - 1 do
					local var_476_0 = arg_473_1.actors_["10092_1"].transform:GetChild(iter_476_0)

					if var_476_0.name == "" or not string.find(var_476_0.name, "split") then
						var_476_0.gameObject:SetActive(true)
					else
						var_476_0.gameObject:SetActive(false)
					end
				end
			end

			local var_476_1 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_1 then
				arg_473_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_473_1.time_ - 0) / var_476_1)
			end

			if arg_473_1.time_ >= 0 + var_476_1 and arg_473_1.time_ < 0 + var_476_1 + arg_476_0 then
				arg_473_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_476_2 = arg_473_1.actors_["10092_1"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_2) and arg_473_1.var_.actorSpriteComps10092_1 == nil then
				arg_473_1.var_.actorSpriteComps10092_1 = var_476_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_476_3 = 2

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_3 and not isNil(var_476_2) then
				if arg_473_1.var_.actorSpriteComps10092_1 then
					for iter_476_1, iter_476_2 in pairs(arg_473_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_476_2 then
							if arg_473_1.isInRecall_ then
								iter_476_2.color = Color.New(Mathf.Lerp(iter_476_2.color.r, arg_473_1.hightColor1.r, (arg_473_1.time_ - 0) / var_476_3), Mathf.Lerp(iter_476_2.color.g, arg_473_1.hightColor1.g, (arg_473_1.time_ - 0) / var_476_3), (Mathf.Lerp(iter_476_2.color.b, arg_473_1.hightColor1.b, (arg_473_1.time_ - 0) / var_476_3)))
							else
								local var_476_4 = Mathf.Lerp(iter_476_2.color.r, 1, (arg_473_1.time_ - 0) / var_476_3)

								iter_476_2.color = Color.New(var_476_4, var_476_4, var_476_4)
							end
						end
					end
				end
			end

			if arg_473_1.time_ >= 0 + var_476_3 and arg_473_1.time_ < 0 + var_476_3 + arg_476_0 and not isNil(var_476_2) and arg_473_1.var_.actorSpriteComps10092_1 then
				for iter_476_3, iter_476_4 in pairs(arg_473_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_476_4 then
						iter_476_4.color = arg_473_1.isInRecall_ and (arg_473_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_473_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_476_5 = 0
			local var_476_6 = 0.975

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_5 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0

				arg_473_1.dialog_:SetActive(true)

				arg_473_1.dialogCg_.alpha = 0

				local var_476_7 = LeanTween.value(arg_473_1.dialog_, 0, 1, 0.3)

				var_476_7:setOnUpdate(LuaHelper.FloatAction(function(arg_477_0)
					arg_473_1.dialogCg_.alpha = arg_477_0
				end))
				var_476_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_473_1.dialog_)
					var_476_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_473_1.duration_ = arg_473_1.duration_ + 0.3

				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_8 = arg_473_1:GetWordFromCfg(413141113)
				local var_476_9 = arg_473_1:FormatText(var_476_8.content)

				arg_473_1.text_.text = var_476_9

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_11 = 39 <= 0 and var_476_6 or var_476_6 * (utf8.len(var_476_9) / 39)

				if (39 <= 0 and var_476_6 or var_476_6 * (utf8.len(var_476_9) / 39)) > 0 and var_476_6 < var_476_11 then
					arg_473_1.talkMaxDuration = var_476_11
					var_476_5 = var_476_5 + 0.3

					if var_476_11 + var_476_5 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_11 + var_476_5
					end
				end

				arg_473_1.text_.text = var_476_9
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141113", "story_v_out_413141.awb") ~= 0 then
					local var_476_12 = manager.audio:GetVoiceLength("story_v_out_413141", "413141113", "story_v_out_413141.awb") / 1000

					if var_476_12 + var_476_5 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_12 + var_476_5
					end

					if var_476_8.prefab_name ~= "" and arg_473_1.actors_[var_476_8.prefab_name] ~= nil then
						local var_476_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_8.prefab_name].transform, "story_v_out_413141", "413141113", "story_v_out_413141.awb")

						arg_473_1:RecordAudio("413141113", var_476_13)
						arg_473_1:RecordAudio("413141113", var_476_13)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_413141", "413141113", "story_v_out_413141.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_413141", "413141113", "story_v_out_413141.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_14 = var_476_5 + 0.3
			local var_476_15 = math.max(var_476_6, arg_473_1.talkMaxDuration)

			if var_476_5 + 0.3 <= arg_473_1.time_ and arg_473_1.time_ < var_476_14 + var_476_15 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_14) / var_476_15

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_14 + var_476_15 and arg_473_1.time_ < var_476_14 + var_476_15 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play413141114 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 413141114
		arg_479_1.duration_ = 6.4

		local var_479_0 = {
			zh = 4.3,
			ja = 6.4
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
				arg_479_0:Play413141115(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.var_.moveOldPos10092_1 = arg_479_1.actors_["10092_1"].transform.localPosition
				arg_479_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_479_1:CheckSpriteTmpPos("10092_1", 3)

				for iter_482_0 = 0, arg_479_1.actors_["10092_1"].transform.childCount - 1 do
					local var_482_0 = arg_479_1.actors_["10092_1"].transform:GetChild(iter_482_0)

					if var_482_0.name == "split_2" or not string.find(var_482_0.name, "split") then
						var_482_0.gameObject:SetActive(true)
					else
						var_482_0.gameObject:SetActive(false)
					end
				end
			end

			local var_482_1 = 0.001

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_1 then
				arg_479_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos10092_1, Vector3.New(0, -300, -295), (arg_479_1.time_ - 0) / var_482_1)
			end

			if arg_479_1.time_ >= 0 + var_482_1 and arg_479_1.time_ < 0 + var_482_1 + arg_482_0 then
				arg_479_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_482_2 = arg_479_1.actors_["10092_1"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_2) and arg_479_1.var_.actorSpriteComps10092_1 == nil then
				arg_479_1.var_.actorSpriteComps10092_1 = var_482_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_3 = 2

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_3 and not isNil(var_482_2) then
				if arg_479_1.var_.actorSpriteComps10092_1 then
					for iter_482_1, iter_482_2 in pairs(arg_479_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_482_2 then
							if arg_479_1.isInRecall_ then
								iter_482_2.color = Color.New(Mathf.Lerp(iter_482_2.color.r, arg_479_1.hightColor1.r, (arg_479_1.time_ - 0) / var_482_3), Mathf.Lerp(iter_482_2.color.g, arg_479_1.hightColor1.g, (arg_479_1.time_ - 0) / var_482_3), (Mathf.Lerp(iter_482_2.color.b, arg_479_1.hightColor1.b, (arg_479_1.time_ - 0) / var_482_3)))
							else
								local var_482_4 = Mathf.Lerp(iter_482_2.color.r, 1, (arg_479_1.time_ - 0) / var_482_3)

								iter_482_2.color = Color.New(var_482_4, var_482_4, var_482_4)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= 0 + var_482_3 and arg_479_1.time_ < 0 + var_482_3 + arg_482_0 and not isNil(var_482_2) and arg_479_1.var_.actorSpriteComps10092_1 then
				for iter_482_3, iter_482_4 in pairs(arg_479_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_482_4 then
						iter_482_4.color = arg_479_1.isInRecall_ and (arg_479_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_479_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_482_5 = 0
			local var_482_6 = 0.475

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_5 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_7 = arg_479_1:GetWordFromCfg(413141114)
				local var_482_8 = arg_479_1:FormatText(var_482_7.content)

				arg_479_1.text_.text = var_482_8

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_10 = 19 <= 0 and var_482_6 or var_482_6 * (utf8.len(var_482_8) / 19)

				if (19 <= 0 and var_482_6 or var_482_6 * (utf8.len(var_482_8) / 19)) > 0 and var_482_6 < var_482_10 then
					arg_479_1.talkMaxDuration = var_482_10

					if var_482_10 + var_482_5 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_10 + var_482_5
					end
				end

				arg_479_1.text_.text = var_482_8
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141114", "story_v_out_413141.awb") ~= 0 then
					local var_482_11 = manager.audio:GetVoiceLength("story_v_out_413141", "413141114", "story_v_out_413141.awb") / 1000

					if var_482_11 + var_482_5 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_11 + var_482_5
					end

					if var_482_7.prefab_name ~= "" and arg_479_1.actors_[var_482_7.prefab_name] ~= nil then
						local var_482_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_7.prefab_name].transform, "story_v_out_413141", "413141114", "story_v_out_413141.awb")

						arg_479_1:RecordAudio("413141114", var_482_12)
						arg_479_1:RecordAudio("413141114", var_482_12)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_413141", "413141114", "story_v_out_413141.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_413141", "413141114", "story_v_out_413141.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_13 = math.max(var_482_6, arg_479_1.talkMaxDuration)

			if var_482_5 <= arg_479_1.time_ and arg_479_1.time_ < var_482_5 + var_482_13 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_5) / var_482_13

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_5 + var_482_13 and arg_479_1.time_ < var_482_5 + var_482_13 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play413141115 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 413141115
		arg_483_1.duration_ = 9

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play413141116(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if arg_483_1.bgs_.F08m == nil then
				local var_486_0 = Object.Instantiate(arg_483_1.paintGo_)

				var_486_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08m")
				var_486_0.name = "F08m"
				var_486_0.transform.parent = arg_483_1.stage_.transform
				var_486_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_483_1.bgs_.F08m = var_486_0
			end

			if 2 < arg_483_1.time_ and arg_483_1.time_ <= 2 + arg_486_0 then
				local var_486_1 = arg_483_1.bgs_.F08m

				arg_483_1.bgs_.F08m.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_486_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_486_2 = var_486_1:GetComponent("SpriteRenderer")

				if var_486_2 and var_486_2.sprite then
					local var_486_3 = 2 * (var_486_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_486_1.transform.localScale = Vector3.New(var_486_3 / var_486_2.sprite.bounds.size.y < var_486_3 * manager.ui.mainCameraCom_.aspect / var_486_2.sprite.bounds.size.x and var_486_3 * manager.ui.mainCameraCom_.aspect / var_486_2.sprite.bounds.size.x or var_486_3 / var_486_2.sprite.bounds.size.y, var_486_3 / var_486_2.sprite.bounds.size.y < var_486_3 * manager.ui.mainCameraCom_.aspect / var_486_2.sprite.bounds.size.x and var_486_3 * manager.ui.mainCameraCom_.aspect / var_486_2.sprite.bounds.size.x or var_486_3 / var_486_2.sprite.bounds.size.y, 0)
				end

				for iter_486_0, iter_486_1 in pairs(arg_483_1.bgs_) do
					if iter_486_0 ~= "F08m" then
						iter_486_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_486_4 = 4

			if 4 < arg_483_1.time_ and arg_483_1.time_ <= var_486_4 + arg_486_0 then
				arg_483_1.allBtn_.enabled = false
			end

			if arg_483_1.time_ >= var_486_4 + 0.3 and arg_483_1.time_ < var_486_4 + 0.3 + arg_486_0 then
				arg_483_1.allBtn_.enabled = true
			end

			local var_486_5 = 0

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_5 + arg_486_0 then
				arg_483_1.mask_.enabled = true
				arg_483_1.mask_.raycastTarget = true

				arg_483_1:SetGaussion(false)
			end

			local var_486_6 = 2

			if var_486_5 <= arg_483_1.time_ and arg_483_1.time_ < var_486_5 + var_486_6 then
				local var_486_7 = Color.New(0, 0, 0)

				var_486_7.a = Mathf.Lerp(0, 1, (arg_483_1.time_ - var_486_5) / var_486_6)
				arg_483_1.mask_.color = var_486_7
			end

			if arg_483_1.time_ >= var_486_5 + var_486_6 and arg_483_1.time_ < var_486_5 + var_486_6 + arg_486_0 then
				local var_486_8 = Color.New(0, 0, 0)

				var_486_8.a = 1
				arg_483_1.mask_.color = var_486_8
			end

			local var_486_9 = 2

			if 2 < arg_483_1.time_ and arg_483_1.time_ <= var_486_9 + arg_486_0 then
				arg_483_1.mask_.enabled = true
				arg_483_1.mask_.raycastTarget = true

				arg_483_1:SetGaussion(false)
			end

			local var_486_10 = 2

			if var_486_9 <= arg_483_1.time_ and arg_483_1.time_ < var_486_9 + var_486_10 then
				local var_486_11 = Color.New(0, 0, 0)

				var_486_11.a = Mathf.Lerp(1, 0, (arg_483_1.time_ - var_486_9) / var_486_10)
				arg_483_1.mask_.color = var_486_11
			end

			if arg_483_1.time_ >= var_486_9 + var_486_10 and arg_483_1.time_ < var_486_9 + var_486_10 + arg_486_0 then
				local var_486_12 = Color.New(0, 0, 0)

				arg_483_1.mask_.enabled = false
				var_486_12.a = 0
				arg_483_1.mask_.color = var_486_12
			end

			local var_486_13 = arg_483_1.actors_["10092_1"].transform

			if 2 < arg_483_1.time_ and arg_483_1.time_ <= 2 + arg_486_0 then
				arg_483_1.var_.moveOldPos10092_1 = var_486_13.localPosition
				var_486_13.localScale = Vector3.New(1, 1, 1)

				arg_483_1:CheckSpriteTmpPos("10092_1", 6)

				for iter_486_2 = 0, var_486_13.childCount - 1 do
					local var_486_14 = var_486_13:GetChild(iter_486_2)

					if var_486_14.name == "" or not string.find(var_486_14.name, "split") then
						var_486_14.gameObject:SetActive(true)
					else
						var_486_14.gameObject:SetActive(false)
					end
				end
			end

			local var_486_15 = 0.001

			if 2 <= arg_483_1.time_ and arg_483_1.time_ < 2 + var_486_15 then
				var_486_13.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos10092_1, Vector3.New(1500, -300, -295), (arg_483_1.time_ - 2) / var_486_15)
			end

			if arg_483_1.time_ >= 2 + var_486_15 and arg_483_1.time_ < 2 + var_486_15 + arg_486_0 then
				var_486_13.localPosition = Vector3.New(1500, -300, -295)
			end

			if arg_483_1.frameCnt_ <= 1 then
				arg_483_1.dialog_:SetActive(false)
			end

			local var_486_16 = 4
			local var_486_17 = 1.175

			if 4 < arg_483_1.time_ and arg_483_1.time_ <= var_486_16 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0

				arg_483_1.dialog_:SetActive(true)

				arg_483_1.dialogCg_.alpha = 0

				local var_486_18 = LeanTween.value(arg_483_1.dialog_, 0, 1, 0.3)

				var_486_18:setOnUpdate(LuaHelper.FloatAction(function(arg_487_0)
					arg_483_1.dialogCg_.alpha = arg_487_0
				end))
				var_486_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_483_1.dialog_)
					var_486_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_483_1.duration_ = arg_483_1.duration_ + 0.3

				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_19 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(413141115).content)

				arg_483_1.text_.text = var_486_19

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_21 = 47 <= 0 and var_486_17 or var_486_17 * (utf8.len(var_486_19) / 47)

				if (47 <= 0 and var_486_17 or var_486_17 * (utf8.len(var_486_19) / 47)) > 0 and var_486_17 < var_486_21 then
					arg_483_1.talkMaxDuration = var_486_21
					var_486_16 = var_486_16 + 0.3

					if var_486_21 + var_486_16 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_21 + var_486_16
					end
				end

				arg_483_1.text_.text = var_486_19
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_22 = var_486_16 + 0.3
			local var_486_23 = math.max(var_486_17, arg_483_1.talkMaxDuration)

			if var_486_16 + 0.3 <= arg_483_1.time_ and arg_483_1.time_ < var_486_22 + var_486_23 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_22) / var_486_23

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_22 + var_486_23 and arg_483_1.time_ < var_486_22 + var_486_23 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play413141116 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 413141116
		arg_489_1.duration_ = 5

		local var_489_0 = {
			zh = 3.466,
			ja = 5
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play413141117(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.35

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_1 = arg_489_1:GetWordFromCfg(413141116)
				local var_492_2 = arg_489_1:FormatText(var_492_1.content)

				arg_489_1.text_.text = var_492_2

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_4 = 14 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 14)

				if (14 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 14)) > 0 and var_492_0 < var_492_4 then
					arg_489_1.talkMaxDuration = var_492_4

					if var_492_4 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_4 + 0
					end
				end

				arg_489_1.text_.text = var_492_2
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141116", "story_v_out_413141.awb") ~= 0 then
					local var_492_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141116", "story_v_out_413141.awb") / 1000

					if var_492_5 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + 0
					end

					if var_492_1.prefab_name ~= "" and arg_489_1.actors_[var_492_1.prefab_name] ~= nil then
						local var_492_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_1.prefab_name].transform, "story_v_out_413141", "413141116", "story_v_out_413141.awb")

						arg_489_1:RecordAudio("413141116", var_492_6)
						arg_489_1:RecordAudio("413141116", var_492_6)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_413141", "413141116", "story_v_out_413141.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_413141", "413141116", "story_v_out_413141.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_7 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_7

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play413141117 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 413141117
		arg_493_1.duration_ = 3.83

		local var_493_0 = {
			zh = 3,
			ja = 3.833
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play413141118(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.175

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_1 = arg_493_1:GetWordFromCfg(413141117)
				local var_496_2 = arg_493_1:FormatText(var_496_1.content)

				arg_493_1.text_.text = var_496_2

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_4 = 7 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 7)

				if (7 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_2) / 7)) > 0 and var_496_0 < var_496_4 then
					arg_493_1.talkMaxDuration = var_496_4

					if var_496_4 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_4 + 0
					end
				end

				arg_493_1.text_.text = var_496_2
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141117", "story_v_out_413141.awb") ~= 0 then
					local var_496_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141117", "story_v_out_413141.awb") / 1000

					if var_496_5 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_5 + 0
					end

					if var_496_1.prefab_name ~= "" and arg_493_1.actors_[var_496_1.prefab_name] ~= nil then
						local var_496_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_1.prefab_name].transform, "story_v_out_413141", "413141117", "story_v_out_413141.awb")

						arg_493_1:RecordAudio("413141117", var_496_6)
						arg_493_1:RecordAudio("413141117", var_496_6)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_413141", "413141117", "story_v_out_413141.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_413141", "413141117", "story_v_out_413141.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_7 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_7 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_7

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_7 and arg_493_1.time_ < 0 + var_496_7 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play413141118 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 413141118
		arg_497_1.duration_ = 6.2

		local var_497_0 = {
			zh = 3.766,
			ja = 6.2
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play413141119(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_500_0 = 0.6

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 then
				local var_500_1, var_500_2 = math.modf((arg_497_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_500_2 * 0.13, var_500_2 * 0.13, var_500_2 * 0.13) + arg_497_1.var_.shakeOldPos
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 then
				manager.ui.mainCamera.transform.localPosition = arg_497_1.var_.shakeOldPos
			end

			local var_500_3 = 0

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_3 + arg_500_0 then
				arg_497_1.allBtn_.enabled = false
			end

			if arg_497_1.time_ >= var_500_3 + 0.6 and arg_497_1.time_ < var_500_3 + 0.6 + arg_500_0 then
				arg_497_1.allBtn_.enabled = true
			end

			local var_500_4 = 0
			local var_500_5 = 0.325

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_4 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_6 = arg_497_1:GetWordFromCfg(413141118)
				local var_500_7 = arg_497_1:FormatText(var_500_6.content)

				arg_497_1.text_.text = var_500_7

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_9 = 13 <= 0 and var_500_5 or var_500_5 * (utf8.len(var_500_7) / 13)

				if (13 <= 0 and var_500_5 or var_500_5 * (utf8.len(var_500_7) / 13)) > 0 and var_500_5 < var_500_9 then
					arg_497_1.talkMaxDuration = var_500_9

					if var_500_9 + var_500_4 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_9 + var_500_4
					end
				end

				arg_497_1.text_.text = var_500_7
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141118", "story_v_out_413141.awb") ~= 0 then
					local var_500_10 = manager.audio:GetVoiceLength("story_v_out_413141", "413141118", "story_v_out_413141.awb") / 1000

					if var_500_10 + var_500_4 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_10 + var_500_4
					end

					if var_500_6.prefab_name ~= "" and arg_497_1.actors_[var_500_6.prefab_name] ~= nil then
						local var_500_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_6.prefab_name].transform, "story_v_out_413141", "413141118", "story_v_out_413141.awb")

						arg_497_1:RecordAudio("413141118", var_500_11)
						arg_497_1:RecordAudio("413141118", var_500_11)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_413141", "413141118", "story_v_out_413141.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_413141", "413141118", "story_v_out_413141.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_12 = math.max(var_500_5, arg_497_1.talkMaxDuration)

			if var_500_4 <= arg_497_1.time_ and arg_497_1.time_ < var_500_4 + var_500_12 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_4) / var_500_12

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_4 + var_500_12 and arg_497_1.time_ < var_500_4 + var_500_12 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play413141119 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 413141119
		arg_501_1.duration_ = 8.03

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play413141120(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if arg_501_1.bgs_.F10g == nil then
				local var_504_0 = Object.Instantiate(arg_501_1.paintGo_)

				var_504_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F10g")
				var_504_0.name = "F10g"
				var_504_0.transform.parent = arg_501_1.stage_.transform
				var_504_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_501_1.bgs_.F10g = var_504_0
			end

			if 1.26666666666667 < arg_501_1.time_ and arg_501_1.time_ <= 1.26666666666667 + arg_504_0 then
				local var_504_1 = arg_501_1.bgs_.F10g

				arg_501_1.bgs_.F10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_504_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_504_2 = var_504_1:GetComponent("SpriteRenderer")

				if var_504_2 and var_504_2.sprite then
					local var_504_3 = 2 * (var_504_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_504_1.transform.localScale = Vector3.New(var_504_3 / var_504_2.sprite.bounds.size.y < var_504_3 * manager.ui.mainCameraCom_.aspect / var_504_2.sprite.bounds.size.x and var_504_3 * manager.ui.mainCameraCom_.aspect / var_504_2.sprite.bounds.size.x or var_504_3 / var_504_2.sprite.bounds.size.y, var_504_3 / var_504_2.sprite.bounds.size.y < var_504_3 * manager.ui.mainCameraCom_.aspect / var_504_2.sprite.bounds.size.x and var_504_3 * manager.ui.mainCameraCom_.aspect / var_504_2.sprite.bounds.size.x or var_504_3 / var_504_2.sprite.bounds.size.y, 0)
				end

				for iter_504_0, iter_504_1 in pairs(arg_501_1.bgs_) do
					if iter_504_0 ~= "F10g" then
						iter_504_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_504_4 = 2.86666666666667

			if 2.86666666666667 < arg_501_1.time_ and arg_501_1.time_ <= var_504_4 + arg_504_0 then
				arg_501_1.allBtn_.enabled = false
			end

			if arg_501_1.time_ >= var_504_4 + 0.3 and arg_501_1.time_ < var_504_4 + 0.3 + arg_504_0 then
				arg_501_1.allBtn_.enabled = true
			end

			local var_504_5 = 0

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_5 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_6 = 1.26666666666667

			if var_504_5 <= arg_501_1.time_ and arg_501_1.time_ < var_504_5 + var_504_6 then
				local var_504_7 = Color.New(1, 1, 1)

				var_504_7.a = Mathf.Lerp(0, 1, (arg_501_1.time_ - var_504_5) / var_504_6)
				arg_501_1.mask_.color = var_504_7
			end

			if arg_501_1.time_ >= var_504_5 + var_504_6 and arg_501_1.time_ < var_504_5 + var_504_6 + arg_504_0 then
				local var_504_8 = Color.New(1, 1, 1)

				var_504_8.a = 1
				arg_501_1.mask_.color = var_504_8
			end

			local var_504_9 = 1.26666666666667

			if 1.26666666666667 < arg_501_1.time_ and arg_501_1.time_ <= var_504_9 + arg_504_0 then
				arg_501_1.mask_.enabled = true
				arg_501_1.mask_.raycastTarget = true

				arg_501_1:SetGaussion(false)
			end

			local var_504_10 = 1.6

			if var_504_9 <= arg_501_1.time_ and arg_501_1.time_ < var_504_9 + var_504_10 then
				local var_504_11 = Color.New(1, 1, 1)

				var_504_11.a = Mathf.Lerp(1, 0, (arg_501_1.time_ - var_504_9) / var_504_10)
				arg_501_1.mask_.color = var_504_11
			end

			if arg_501_1.time_ >= var_504_9 + var_504_10 and arg_501_1.time_ < var_504_9 + var_504_10 + arg_504_0 then
				local var_504_12 = Color.New(1, 1, 1)

				arg_501_1.mask_.enabled = false
				var_504_12.a = 0
				arg_501_1.mask_.color = var_504_12
			end

			if arg_501_1.frameCnt_ <= 1 then
				arg_501_1.dialog_:SetActive(false)
			end

			local var_504_13 = 3.03333333333333
			local var_504_14 = 0.7

			if 3.03333333333333 < arg_501_1.time_ and arg_501_1.time_ <= var_504_13 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0

				arg_501_1.dialog_:SetActive(true)

				arg_501_1.dialogCg_.alpha = 0

				local var_504_15 = LeanTween.value(arg_501_1.dialog_, 0, 1, 0.3)

				var_504_15:setOnUpdate(LuaHelper.FloatAction(function(arg_505_0)
					arg_501_1.dialogCg_.alpha = arg_505_0
				end))
				var_504_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_501_1.dialog_)
					var_504_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_501_1.duration_ = arg_501_1.duration_ + 0.3

				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_16 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(413141119).content)

				arg_501_1.text_.text = var_504_16

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_18 = 28 <= 0 and var_504_14 or var_504_14 * (utf8.len(var_504_16) / 28)

				if (28 <= 0 and var_504_14 or var_504_14 * (utf8.len(var_504_16) / 28)) > 0 and var_504_14 < var_504_18 then
					arg_501_1.talkMaxDuration = var_504_18
					var_504_13 = var_504_13 + 0.3

					if var_504_18 + var_504_13 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_18 + var_504_13
					end
				end

				arg_501_1.text_.text = var_504_16
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_19 = var_504_13 + 0.3
			local var_504_20 = math.max(var_504_14, arg_501_1.talkMaxDuration)

			if var_504_13 + 0.3 <= arg_501_1.time_ and arg_501_1.time_ < var_504_19 + var_504_20 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_19) / var_504_20

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_19 + var_504_20 and arg_501_1.time_ < var_504_19 + var_504_20 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play413141120 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 413141120
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play413141121(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 1.15

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_1 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(413141120).content)

				arg_507_1.text_.text = var_510_1

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_3 = 46 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 46)

				if (46 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 46)) > 0 and var_510_0 < var_510_3 then
					arg_507_1.talkMaxDuration = var_510_3

					if var_510_3 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_3 + 0
					end
				end

				arg_507_1.text_.text = var_510_1
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_4 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_4 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_4

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_4 and arg_507_1.time_ < 0 + var_510_4 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play413141121 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 413141121
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play413141122(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0.875

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_1 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(413141121).content)

				arg_511_1.text_.text = var_514_1

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_3 = 35 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 35)

				if (35 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 35)) > 0 and var_514_0 < var_514_3 then
					arg_511_1.talkMaxDuration = var_514_3

					if var_514_3 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_3 + 0
					end
				end

				arg_511_1.text_.text = var_514_1
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_4 = math.max(var_514_0, arg_511_1.talkMaxDuration)

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_4 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - 0) / var_514_4

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= 0 + var_514_4 and arg_511_1.time_ < 0 + var_514_4 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play413141122 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 413141122
		arg_515_1.duration_ = 13.17

		local var_515_0 = {
			zh = 8.533,
			ja = 13.166
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
				arg_515_0:Play413141123(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_9000

			if arg_515_1.bgs_.SS1309 == nil then
				local var_518_0 = Object.Instantiate(arg_515_1.paintGo_)

				var_518_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1309")
				var_518_0.name = "SS1309"
				var_518_0.transform.parent = arg_515_1.stage_.transform
				var_518_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_515_1.bgs_.SS1309 = var_518_0
			end

			if 1.31666666666667 < arg_515_1.time_ and arg_515_1.time_ <= 1.31666666666667 + arg_518_0 then
				local var_518_1 = arg_515_1.bgs_.SS1309

				arg_515_1.bgs_.SS1309.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_518_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_518_2 = var_518_1:GetComponent("SpriteRenderer")

				if var_518_2 and var_518_2.sprite then
					local var_518_3 = 2 * (var_518_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_518_1.transform.localScale = Vector3.New(var_518_3 / var_518_2.sprite.bounds.size.y < var_518_3 * manager.ui.mainCameraCom_.aspect / var_518_2.sprite.bounds.size.x and var_518_3 * manager.ui.mainCameraCom_.aspect / var_518_2.sprite.bounds.size.x or var_518_3 / var_518_2.sprite.bounds.size.y, var_518_3 / var_518_2.sprite.bounds.size.y < var_518_3 * manager.ui.mainCameraCom_.aspect / var_518_2.sprite.bounds.size.x and var_518_3 * manager.ui.mainCameraCom_.aspect / var_518_2.sprite.bounds.size.x or var_518_3 / var_518_2.sprite.bounds.size.y, 0)
				end

				for iter_518_0, iter_518_1 in pairs(arg_515_1.bgs_) do
					if iter_518_0 ~= "SS1309" then
						iter_518_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_518_4 = 0

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_4 + arg_518_0 then
				arg_515_1.allBtn_.enabled = false
			end

			if arg_515_1.time_ >= var_518_4 + 0.3 and arg_515_1.time_ < var_518_4 + 0.3 + arg_518_0 then
				arg_515_1.allBtn_.enabled = true
			end

			local var_518_5 = 0

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_5 + arg_518_0 then
				arg_515_1.mask_.enabled = true
				arg_515_1.mask_.raycastTarget = true

				arg_515_1:SetGaussion(false)
			end

			local var_518_6 = 1.33333333333333

			if var_518_5 <= arg_515_1.time_ and arg_515_1.time_ < var_518_5 + var_518_6 then
				local var_518_7 = Color.New(0, 0, 0)

				var_518_7.a = Mathf.Lerp(0, 1, (arg_515_1.time_ - var_518_5) / var_518_6)
				arg_515_1.mask_.color = var_518_7
			end

			if arg_515_1.time_ >= var_518_5 + var_518_6 and arg_515_1.time_ < var_518_5 + var_518_6 + arg_518_0 then
				local var_518_8 = Color.New(0, 0, 0)

				var_518_8.a = 1
				arg_515_1.mask_.color = var_518_8
			end

			local var_518_9 = 1.33333333333333

			if 1.33333333333333 < arg_515_1.time_ and arg_515_1.time_ <= var_518_9 + arg_518_0 then
				arg_515_1.mask_.enabled = true
				arg_515_1.mask_.raycastTarget = true

				arg_515_1:SetGaussion(false)
			end

			local var_518_10 = 2

			if var_518_9 <= arg_515_1.time_ and arg_515_1.time_ < var_518_9 + var_518_10 then
				local var_518_11 = Color.New(0, 0, 0)

				var_518_11.a = Mathf.Lerp(1, 0, (arg_515_1.time_ - var_518_9) / var_518_10)
				arg_515_1.mask_.color = var_518_11
			end

			if arg_515_1.time_ >= var_518_9 + var_518_10 and arg_515_1.time_ < var_518_9 + var_518_10 + arg_518_0 then
				local var_518_12 = Color.New(0, 0, 0)

				arg_515_1.mask_.enabled = false
				var_518_12.a = 0
				arg_515_1.mask_.color = var_518_12
			end

			local var_518_13 = arg_515_1.bgs_.SS1309.transform

			if 1.33333333333333 < arg_515_1.time_ and arg_515_1.time_ <= 1.33333333333333 + arg_518_0 then
				arg_515_1.var_.moveOldPosSS1309 = var_518_13.localPosition
			end

			local var_518_14 = 0.001

			if 1.33333333333333 <= arg_515_1.time_ and arg_515_1.time_ < 1.33333333333333 + var_518_14 then
				var_518_13.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPosSS1309, Vector3.New(0, 1, 10), (arg_515_1.time_ - 1.33333333333333) / var_518_14)
			end

			if arg_515_1.time_ >= 1.33333333333333 + var_518_14 and arg_515_1.time_ < 1.33333333333333 + var_518_14 + arg_518_0 then
				var_518_13.localPosition = Vector3.New(0, 1, 10)
			end

			local var_518_15 = arg_515_1.bgs_.SS1309.transform

			if 1.35 < arg_515_1.time_ and arg_515_1.time_ <= 1.35 + arg_518_0 then
				arg_515_1.var_.moveOldPosSS1309 = var_518_15.localPosition
			end

			local var_518_16 = 2.15

			if 1.35 <= arg_515_1.time_ and arg_515_1.time_ < 1.35 + var_518_16 then
				var_518_15.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPosSS1309, Vector3.New(0, 1, 9), (arg_515_1.time_ - 1.35) / var_518_16)
			end

			if arg_515_1.time_ >= 1.35 + var_518_16 and arg_515_1.time_ < 1.35 + var_518_16 + arg_518_0 then
				var_518_15.localPosition = Vector3.New(0, 1, 9)
			end

			if 1.33333333333333 < arg_515_1.time_ and arg_515_1.time_ <= 1.33333333333333 + arg_518_0 then
				local var_518_17 = arg_515_1.var_.effectheliesihuoyan1

				if not arg_515_1.var_.effectheliesihuoyan1 then
					var_518_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), manager.ui.mainCamera.transform)
					var_518_17.name = "heliesihuoyan1"
					arg_515_1.var_.effectheliesihuoyan1 = var_518_17
				else
					var_518_17.transform:SetParent(var_518_9000)
				end

				var_518_17.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_518_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:AudioAction("play", "effect", "se_story_8", "se_story_8_fire", "")
			end

			if arg_515_1.frameCnt_ <= 1 then
				arg_515_1.dialog_:SetActive(false)
			end

			local var_518_20 = 3.5
			local var_518_21 = 0.6

			if 3.5 < arg_515_1.time_ and arg_515_1.time_ <= var_518_20 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0

				arg_515_1.dialog_:SetActive(true)

				arg_515_1.dialogCg_.alpha = 0

				local var_518_22 = LeanTween.value(arg_515_1.dialog_, 0, 1, 0.3)

				var_518_22:setOnUpdate(LuaHelper.FloatAction(function(arg_519_0)
					arg_515_1.dialogCg_.alpha = arg_519_0
				end))
				var_518_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_515_1.dialog_)
					var_518_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_515_1.duration_ = arg_515_1.duration_ + 0.3

				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_23 = arg_515_1:GetWordFromCfg(413141122)
				local var_518_24 = arg_515_1:FormatText(var_518_23.content)

				arg_515_1.text_.text = var_518_24

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_26 = 24 <= 0 and var_518_21 or var_518_21 * (utf8.len(var_518_24) / 24)

				if (24 <= 0 and var_518_21 or var_518_21 * (utf8.len(var_518_24) / 24)) > 0 and var_518_21 < var_518_26 then
					arg_515_1.talkMaxDuration = var_518_26
					var_518_20 = var_518_20 + 0.3

					if var_518_26 + var_518_20 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_26 + var_518_20
					end
				end

				arg_515_1.text_.text = var_518_24
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141122", "story_v_out_413141.awb") ~= 0 then
					local var_518_27 = manager.audio:GetVoiceLength("story_v_out_413141", "413141122", "story_v_out_413141.awb") / 1000

					if var_518_27 + var_518_20 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_27 + var_518_20
					end

					if var_518_23.prefab_name ~= "" and arg_515_1.actors_[var_518_23.prefab_name] ~= nil then
						local var_518_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_23.prefab_name].transform, "story_v_out_413141", "413141122", "story_v_out_413141.awb")

						arg_515_1:RecordAudio("413141122", var_518_28)
						arg_515_1:RecordAudio("413141122", var_518_28)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_413141", "413141122", "story_v_out_413141.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_413141", "413141122", "story_v_out_413141.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_29 = var_518_20 + 0.3
			local var_518_30 = math.max(var_518_21, arg_515_1.talkMaxDuration)

			if var_518_20 + 0.3 <= arg_515_1.time_ and arg_515_1.time_ < var_518_29 + var_518_30 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_29) / var_518_30

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_29 + var_518_30 and arg_515_1.time_ < var_518_29 + var_518_30 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1309",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1309",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.15,
				className = "StoryMoveNode",
				startTime = 1.35,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play413141123 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 413141123
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play413141124(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0.133333333333333 < arg_521_1.time_ and arg_521_1.time_ <= 0.133333333333333 + arg_524_0 then
				arg_521_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_arrow1", "")
			end

			local var_524_1 = 0
			local var_524_2 = 0.525

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_3 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(413141123).content)

				arg_521_1.text_.text = var_524_3

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_5 = 21 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_3) / 21)

				if (21 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_3) / 21)) > 0 and var_524_2 < var_524_5 then
					arg_521_1.talkMaxDuration = var_524_5

					if var_524_5 + var_524_1 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + var_524_1
					end
				end

				arg_521_1.text_.text = var_524_3
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_6 = math.max(var_524_2, arg_521_1.talkMaxDuration)

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_6 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_1) / var_524_6

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_1 + var_524_6 and arg_521_1.time_ < var_524_1 + var_524_6 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play413141124 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 413141124
		arg_525_1.duration_ = 4.43

		local var_525_0 = {
			zh = 4.433,
			ja = 3.8
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play413141125(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0.275

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_1 = arg_525_1:GetWordFromCfg(413141124)
				local var_528_2 = arg_525_1:FormatText(var_528_1.content)

				arg_525_1.text_.text = var_528_2

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_4 = 11 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 11)

				if (11 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 11)) > 0 and var_528_0 < var_528_4 then
					arg_525_1.talkMaxDuration = var_528_4

					if var_528_4 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_4 + 0
					end
				end

				arg_525_1.text_.text = var_528_2
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141124", "story_v_out_413141.awb") ~= 0 then
					local var_528_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141124", "story_v_out_413141.awb") / 1000

					if var_528_5 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_5 + 0
					end

					if var_528_1.prefab_name ~= "" and arg_525_1.actors_[var_528_1.prefab_name] ~= nil then
						local var_528_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_1.prefab_name].transform, "story_v_out_413141", "413141124", "story_v_out_413141.awb")

						arg_525_1:RecordAudio("413141124", var_528_6)
						arg_525_1:RecordAudio("413141124", var_528_6)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_413141", "413141124", "story_v_out_413141.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_413141", "413141124", "story_v_out_413141.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_7 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_7 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_7

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_7 and arg_525_1.time_ < 0 + var_528_7 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play413141125 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 413141125
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play413141126(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 0.725

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_1 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(413141125).content)

				arg_529_1.text_.text = var_532_1

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_3 = 29 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_1) / 29)

				if (29 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_1) / 29)) > 0 and var_532_0 < var_532_3 then
					arg_529_1.talkMaxDuration = var_532_3

					if var_532_3 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_3 + 0
					end
				end

				arg_529_1.text_.text = var_532_1
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_4 = math.max(var_532_0, arg_529_1.talkMaxDuration)

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_4 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - 0) / var_532_4

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= 0 + var_532_4 and arg_529_1.time_ < 0 + var_532_4 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play413141126 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 413141126
		arg_533_1.duration_ = 9.5

		local var_533_0 = {
			zh = 7.133,
			ja = 9.5
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play413141127(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0.525

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_1 = arg_533_1:GetWordFromCfg(413141126)
				local var_536_2 = arg_533_1:FormatText(var_536_1.content)

				arg_533_1.text_.text = var_536_2

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_4 = 21 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 21)

				if (21 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 21)) > 0 and var_536_0 < var_536_4 then
					arg_533_1.talkMaxDuration = var_536_4

					if var_536_4 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_4 + 0
					end
				end

				arg_533_1.text_.text = var_536_2
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141126", "story_v_out_413141.awb") ~= 0 then
					local var_536_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141126", "story_v_out_413141.awb") / 1000

					if var_536_5 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_5 + 0
					end

					if var_536_1.prefab_name ~= "" and arg_533_1.actors_[var_536_1.prefab_name] ~= nil then
						local var_536_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_1.prefab_name].transform, "story_v_out_413141", "413141126", "story_v_out_413141.awb")

						arg_533_1:RecordAudio("413141126", var_536_6)
						arg_533_1:RecordAudio("413141126", var_536_6)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_413141", "413141126", "story_v_out_413141.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_413141", "413141126", "story_v_out_413141.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_7 = math.max(var_536_0, arg_533_1.talkMaxDuration)

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_7 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - 0) / var_536_7

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= 0 + var_536_7 and arg_533_1.time_ < 0 + var_536_7 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play413141127 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 413141127
		arg_537_1.duration_ = 2.57

		local var_537_0 = {
			zh = 2.566,
			ja = 2.2
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play413141128(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0.2

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_5")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_1 = arg_537_1:GetWordFromCfg(413141127)
				local var_540_2 = arg_537_1:FormatText(var_540_1.content)

				arg_537_1.text_.text = var_540_2

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_4 = 8 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_2) / 8)

				if (8 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_2) / 8)) > 0 and var_540_0 < var_540_4 then
					arg_537_1.talkMaxDuration = var_540_4

					if var_540_4 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_4 + 0
					end
				end

				arg_537_1.text_.text = var_540_2
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141127", "story_v_out_413141.awb") ~= 0 then
					local var_540_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141127", "story_v_out_413141.awb") / 1000

					if var_540_5 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_5 + 0
					end

					if var_540_1.prefab_name ~= "" and arg_537_1.actors_[var_540_1.prefab_name] ~= nil then
						local var_540_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_1.prefab_name].transform, "story_v_out_413141", "413141127", "story_v_out_413141.awb")

						arg_537_1:RecordAudio("413141127", var_540_6)
						arg_537_1:RecordAudio("413141127", var_540_6)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_413141", "413141127", "story_v_out_413141.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_413141", "413141127", "story_v_out_413141.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_7 = math.max(var_540_0, arg_537_1.talkMaxDuration)

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_7 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - 0) / var_540_7

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= 0 + var_540_7 and arg_537_1.time_ < 0 + var_540_7 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play413141128 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 413141128
		arg_541_1.duration_ = 2.87

		local var_541_0 = {
			zh = 2.866,
			ja = 2.833
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play413141129(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0.175

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_1 = arg_541_1:GetWordFromCfg(413141128)
				local var_544_2 = arg_541_1:FormatText(var_544_1.content)

				arg_541_1.text_.text = var_544_2

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_4 = 7 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 7)

				if (7 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 7)) > 0 and var_544_0 < var_544_4 then
					arg_541_1.talkMaxDuration = var_544_4

					if var_544_4 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_4 + 0
					end
				end

				arg_541_1.text_.text = var_544_2
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141128", "story_v_out_413141.awb") ~= 0 then
					local var_544_5 = manager.audio:GetVoiceLength("story_v_out_413141", "413141128", "story_v_out_413141.awb") / 1000

					if var_544_5 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + 0
					end

					if var_544_1.prefab_name ~= "" and arg_541_1.actors_[var_544_1.prefab_name] ~= nil then
						local var_544_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_1.prefab_name].transform, "story_v_out_413141", "413141128", "story_v_out_413141.awb")

						arg_541_1:RecordAudio("413141128", var_544_6)
						arg_541_1:RecordAudio("413141128", var_544_6)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_413141", "413141128", "story_v_out_413141.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_413141", "413141128", "story_v_out_413141.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_7 = math.max(var_544_0, arg_541_1.talkMaxDuration)

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_7 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - 0) / var_544_7

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= 0 + var_544_7 and arg_541_1.time_ < 0 + var_544_7 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play413141129 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 413141129
		arg_545_1.duration_ = 6.47

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play413141130(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPosSS1309 = arg_545_1.bgs_.SS1309.transform.localPosition
			end

			local var_548_0 = 0.001

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 then
				arg_545_1.bgs_.SS1309.transform.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPosSS1309, Vector3.New(0, 1, 9), (arg_545_1.time_ - 0) / var_548_0)
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 then
				arg_545_1.bgs_.SS1309.transform.localPosition = Vector3.New(0, 1, 9)
			end

			local var_548_1 = arg_545_1.bgs_.SS1309.transform

			if 0.0166666666666667 < arg_545_1.time_ and arg_545_1.time_ <= 0.0166666666666667 + arg_548_0 then
				arg_545_1.var_.moveOldPosSS1309 = var_548_1.localPosition
			end

			local var_548_2 = 1.51666666666667

			if 0.0166666666666667 <= arg_545_1.time_ and arg_545_1.time_ < 0.0166666666666667 + var_548_2 then
				var_548_1.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPosSS1309, Vector3.New(0, 1, 10), (arg_545_1.time_ - 0.0166666666666667) / var_548_2)
			end

			if arg_545_1.time_ >= 0.0166666666666667 + var_548_2 and arg_545_1.time_ < 0.0166666666666667 + var_548_2 + arg_548_0 then
				var_548_1.localPosition = Vector3.New(0, 1, 10)
			end

			local var_548_3 = manager.ui.mainCamera.transform

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.shakeOldPos = var_548_3.localPosition
			end

			local var_548_4 = 0.6

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_4 then
				local var_548_5, var_548_6 = math.modf((arg_545_1.time_ - 0) / 0.066)

				var_548_3.localPosition = Vector3.New(var_548_6 * 0.13, var_548_6 * 0.13, var_548_6 * 0.13) + arg_545_1.var_.shakeOldPos
			end

			if arg_545_1.time_ >= 0 + var_548_4 and arg_545_1.time_ < 0 + var_548_4 + arg_548_0 then
				var_548_3.localPosition = arg_545_1.var_.shakeOldPos
			end

			local var_548_7 = 0

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_7 + arg_548_0 then
				arg_545_1.allBtn_.enabled = false
			end

			if arg_545_1.time_ >= var_548_7 + 1.53333333333333 and arg_545_1.time_ < var_548_7 + 1.53333333333333 + arg_548_0 then
				arg_545_1.allBtn_.enabled = true
			end

			if arg_545_1.frameCnt_ <= 1 then
				arg_545_1.dialog_:SetActive(false)
			end

			local var_548_8 = 1.46666666666667
			local var_548_9 = 0.8

			if 1.46666666666667 < arg_545_1.time_ and arg_545_1.time_ <= var_548_8 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0

				arg_545_1.dialog_:SetActive(true)

				arg_545_1.dialogCg_.alpha = 0

				local var_548_10 = LeanTween.value(arg_545_1.dialog_, 0, 1, 0.3)

				var_548_10:setOnUpdate(LuaHelper.FloatAction(function(arg_549_0)
					arg_545_1.dialogCg_.alpha = arg_549_0
				end))
				var_548_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_545_1.dialog_)
					var_548_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_545_1.duration_ = arg_545_1.duration_ + 0.3

				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_11 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(413141129).content)

				arg_545_1.text_.text = var_548_11

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_13 = 32 <= 0 and var_548_9 or var_548_9 * (utf8.len(var_548_11) / 32)

				if (32 <= 0 and var_548_9 or var_548_9 * (utf8.len(var_548_11) / 32)) > 0 and var_548_9 < var_548_13 then
					arg_545_1.talkMaxDuration = var_548_13
					var_548_8 = var_548_8 + 0.3

					if var_548_13 + var_548_8 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_13 + var_548_8
					end
				end

				arg_545_1.text_.text = var_548_11
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_14 = var_548_8 + 0.3
			local var_548_15 = math.max(var_548_9, arg_545_1.talkMaxDuration)

			if var_548_8 + 0.3 <= arg_545_1.time_ and arg_545_1.time_ < var_548_14 + var_548_15 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_14) / var_548_15

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_14 + var_548_15 and arg_545_1.time_ < var_548_14 + var_548_15 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1309",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1309",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.51666666666667,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play413141130 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 413141130
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play413141131(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 1.075

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, false)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_1 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(413141130).content)

				arg_551_1.text_.text = var_554_1

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_3 = 43 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 43)

				if (43 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 43)) > 0 and var_554_0 < var_554_3 then
					arg_551_1.talkMaxDuration = var_554_3

					if var_554_3 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_3 + 0
					end
				end

				arg_551_1.text_.text = var_554_1
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_4 = math.max(var_554_0, arg_551_1.talkMaxDuration)

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_4 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - 0) / var_554_4

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= 0 + var_554_4 and arg_551_1.time_ < 0 + var_554_4 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play413141131 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 413141131
		arg_555_1.duration_ = 6.6

		local var_555_0 = {
			zh = 6.6,
			ja = 4.9
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
				arg_555_0:Play413141132(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if arg_555_1.bgs_.STblack == nil then
				local var_558_0 = Object.Instantiate(arg_555_1.paintGo_)

				var_558_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_558_0.name = "STblack"
				var_558_0.transform.parent = arg_555_1.stage_.transform
				var_558_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_555_1.bgs_.STblack = var_558_0
			end

			if 1.66666666666667 < arg_555_1.time_ and arg_555_1.time_ <= 1.66666666666667 + arg_558_0 then
				local var_558_1 = arg_555_1.bgs_.STblack

				arg_555_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_558_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_558_2 = var_558_1:GetComponent("SpriteRenderer")

				if var_558_2 and var_558_2.sprite then
					local var_558_3 = 2 * (var_558_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_558_1.transform.localScale = Vector3.New(var_558_3 / var_558_2.sprite.bounds.size.y < var_558_3 * manager.ui.mainCameraCom_.aspect / var_558_2.sprite.bounds.size.x and var_558_3 * manager.ui.mainCameraCom_.aspect / var_558_2.sprite.bounds.size.x or var_558_3 / var_558_2.sprite.bounds.size.y, var_558_3 / var_558_2.sprite.bounds.size.y < var_558_3 * manager.ui.mainCameraCom_.aspect / var_558_2.sprite.bounds.size.x and var_558_3 * manager.ui.mainCameraCom_.aspect / var_558_2.sprite.bounds.size.x or var_558_3 / var_558_2.sprite.bounds.size.y, 0)
				end

				for iter_558_0, iter_558_1 in pairs(arg_555_1.bgs_) do
					if iter_558_0 ~= "STblack" then
						iter_558_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_558_4 = 0

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_4 + arg_558_0 then
				arg_555_1.mask_.enabled = true
				arg_555_1.mask_.raycastTarget = true

				arg_555_1:SetGaussion(false)
			end

			local var_558_5 = 1.66666666666667

			if var_558_4 <= arg_555_1.time_ and arg_555_1.time_ < var_558_4 + var_558_5 then
				local var_558_6 = Color.New(0, 0, 0)

				var_558_6.a = Mathf.Lerp(0, 1, (arg_555_1.time_ - var_558_4) / var_558_5)
				arg_555_1.mask_.color = var_558_6
			end

			if arg_555_1.time_ >= var_558_4 + var_558_5 and arg_555_1.time_ < var_558_4 + var_558_5 + arg_558_0 then
				local var_558_7 = Color.New(0, 0, 0)

				var_558_7.a = 1
				arg_555_1.mask_.color = var_558_7
			end

			local var_558_8 = 1.66666666666667

			if 1.66666666666667 < arg_555_1.time_ and arg_555_1.time_ <= var_558_8 + arg_558_0 then
				arg_555_1.mask_.enabled = true
				arg_555_1.mask_.raycastTarget = true

				arg_555_1:SetGaussion(false)
			end

			local var_558_9 = 0.733333333333333

			if var_558_8 <= arg_555_1.time_ and arg_555_1.time_ < var_558_8 + var_558_9 then
				local var_558_10 = Color.New(0, 0, 0)

				var_558_10.a = Mathf.Lerp(1, 0, (arg_555_1.time_ - var_558_8) / var_558_9)
				arg_555_1.mask_.color = var_558_10
			end

			if arg_555_1.time_ >= var_558_8 + var_558_9 and arg_555_1.time_ < var_558_8 + var_558_9 + arg_558_0 then
				local var_558_11 = Color.New(0, 0, 0)

				arg_555_1.mask_.enabled = false
				var_558_11.a = 0
				arg_555_1.mask_.color = var_558_11
			end

			if 1.66666666666667 < arg_555_1.time_ and arg_555_1.time_ <= 1.66666666666667 + arg_558_0 then
				if arg_555_1.var_.effectheliesihuoyan1 then
					Object.Destroy(arg_555_1.var_.effectheliesihuoyan1)

					arg_555_1.var_.effectheliesihuoyan1 = nil
				end
			end

			if arg_555_1.frameCnt_ <= 1 then
				arg_555_1.dialog_:SetActive(false)
			end

			local var_558_13 = 2.3
			local var_558_14 = 0.275

			if 2.3 < arg_555_1.time_ and arg_555_1.time_ <= var_558_13 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0

				arg_555_1.dialog_:SetActive(true)

				arg_555_1.dialogCg_.alpha = 0

				local var_558_15 = LeanTween.value(arg_555_1.dialog_, 0, 1, 0.3)

				var_558_15:setOnUpdate(LuaHelper.FloatAction(function(arg_559_0)
					arg_555_1.dialogCg_.alpha = arg_559_0
				end))
				var_558_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_555_1.dialog_)
					var_558_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_555_1.duration_ = arg_555_1.duration_ + 0.3

				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_16 = arg_555_1:GetWordFromCfg(413141131)
				local var_558_17 = arg_555_1:FormatText(var_558_16.content)

				arg_555_1.text_.text = var_558_17

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_19 = 11 <= 0 and var_558_14 or var_558_14 * (utf8.len(var_558_17) / 11)

				if (11 <= 0 and var_558_14 or var_558_14 * (utf8.len(var_558_17) / 11)) > 0 and var_558_14 < var_558_19 then
					arg_555_1.talkMaxDuration = var_558_19
					var_558_13 = var_558_13 + 0.3

					if var_558_19 + var_558_13 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_19 + var_558_13
					end
				end

				arg_555_1.text_.text = var_558_17
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413141", "413141131", "story_v_out_413141.awb") ~= 0 then
					local var_558_20 = manager.audio:GetVoiceLength("story_v_out_413141", "413141131", "story_v_out_413141.awb") / 1000

					if var_558_20 + var_558_13 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_20 + var_558_13
					end

					if var_558_16.prefab_name ~= "" and arg_555_1.actors_[var_558_16.prefab_name] ~= nil then
						local var_558_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_16.prefab_name].transform, "story_v_out_413141", "413141131", "story_v_out_413141.awb")

						arg_555_1:RecordAudio("413141131", var_558_21)
						arg_555_1:RecordAudio("413141131", var_558_21)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_out_413141", "413141131", "story_v_out_413141.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_out_413141", "413141131", "story_v_out_413141.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_22 = var_558_13 + 0.3
			local var_558_23 = math.max(var_558_14, arg_555_1.talkMaxDuration)

			if var_558_13 + 0.3 <= arg_555_1.time_ and arg_555_1.time_ < var_558_22 + var_558_23 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_22) / var_558_23

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_22 + var_558_23 and arg_555_1.time_ < var_558_22 + var_558_23 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play413141132 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 413141132
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
			arg_561_1.auto_ = false
		end

		function arg_561_1.playNext_(arg_563_0)
			arg_561_1.onStoryFinished_()
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0.7

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, false)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_1 = arg_561_1:FormatText(arg_561_1:GetWordFromCfg(413141132).content)

				arg_561_1.text_.text = var_564_1

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_3 = 28 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_1) / 28)

				if (28 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_1) / 28)) > 0 and var_564_0 < var_564_3 then
					arg_561_1.talkMaxDuration = var_564_3

					if var_564_3 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_3 + 0
					end
				end

				arg_561_1.text_.text = var_564_1
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_4 = math.max(var_564_0, arg_561_1.talkMaxDuration)

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_4 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - 0) / var_564_4

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= 0 + var_564_4 and arg_561_1.time_ < 0 + var_564_4 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0603a",
		"TextureConfig/Background/F10f",
		"TextureConfig/Background/F08m",
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/SS1309",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_413141.awb"
	}
}
