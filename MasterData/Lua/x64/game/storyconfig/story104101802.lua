return {
	Play410182001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410182001
		arg_1_1.duration_ = 9.17

		local var_1_0 = {
			ja = 9.166,
			CriLanguages = 8.566,
			zh = 8.566
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
				arg_1_0:Play410182002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L04g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L04g")
				var_4_0.name = "L04g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L04g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L04g

				arg_1_1.bgs_.L04g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L04g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

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

			local var_4_8 = "10061"

			if arg_1_1.actors_["10061"] == nil then
				local var_4_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10061")

				if not isNil(var_4_9) then
					local var_4_10 = Object.Instantiate(var_4_9, arg_1_1.canvasGo_.transform)

					var_4_10.transform:SetSiblingIndex(1)

					var_4_10.name = var_4_8
					var_4_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_8] = var_4_10

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs((var_4_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_11 = arg_1_1.actors_["10061"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10061 = var_4_11.localPosition
				var_4_11.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10061", 3)

				for iter_4_4 = 0, var_4_11.childCount - 1 do
					local var_4_12 = var_4_11:GetChild(iter_4_4)

					if var_4_12.name == "split_5" or not string.find(var_4_12.name, "split") then
						var_4_12.gameObject:SetActive(true)
					else
						var_4_12.gameObject:SetActive(false)
					end
				end
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10061, Vector3.New(0, -517.5, -100), (arg_1_1.time_ - 2) / var_4_13)
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, -517.5, -100)
			end

			local var_4_14 = arg_1_1.actors_["10061"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps10061 == nil then
				arg_1_1.var_.actorSpriteComps10061 = var_4_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_15 = 0.034

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.actorSpriteComps10061 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 2) / var_4_15), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 2) / var_4_15), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 2) / var_4_15)))
							else
								local var_4_16 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 2) / var_4_15)

								iter_4_6.color = Color.New(var_4_16, var_4_16, var_4_16)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps10061 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10061 = nil
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 2
			local var_4_24 = 0.475

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(410182001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 19 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 19)

				if (19 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 19)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182001", "story_v_out_410182.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_410182", "410182001", "story_v_out_410182.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_410182", "410182001", "story_v_out_410182.awb")

						arg_1_1:RecordAudio("410182001", var_4_31)
						arg_1_1:RecordAudio("410182001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410182", "410182001", "story_v_out_410182.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410182", "410182001", "story_v_out_410182.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play410182002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410182002
		arg_9_1.duration_ = 7.57

		local var_9_0 = {
			ja = 3.933,
			CriLanguages = 7.566,
			zh = 7.566
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
				arg_9_0:Play410182003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["10061"]) and arg_9_1.var_.actorSpriteComps10061 == nil then
				arg_9_1.var_.actorSpriteComps10061 = arg_9_1.actors_["10061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_0 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["10061"]) then
				if arg_9_1.var_.actorSpriteComps10061 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_12_1 then
							if arg_9_1.isInRecall_ then
								iter_12_1.color = Color.New(Mathf.Lerp(iter_12_1.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_0), Mathf.Lerp(iter_12_1.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_0), (Mathf.Lerp(iter_12_1.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_0)))
							else
								local var_12_1 = Mathf.Lerp(iter_12_1.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_0)

								iter_12_1.color = Color.New(var_12_1, var_12_1, var_12_1)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["10061"]) and arg_9_1.var_.actorSpriteComps10061 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_12_3 then
						iter_12_3.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10061 = nil
			end

			local var_12_2 = 0
			local var_12_3 = 0.325

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[608].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_a")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_4 = arg_9_1:GetWordFromCfg(410182002)
				local var_12_5 = arg_9_1:FormatText(var_12_4.content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 13 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_5) / 13)

				if (13 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_5) / 13)) > 0 and var_12_3 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_2
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182002", "story_v_out_410182.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_410182", "410182002", "story_v_out_410182.awb") / 1000

					if var_12_8 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_2
					end

					if var_12_4.prefab_name ~= "" and arg_9_1.actors_[var_12_4.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_4.prefab_name].transform, "story_v_out_410182", "410182002", "story_v_out_410182.awb")

						arg_9_1:RecordAudio("410182002", var_12_9)
						arg_9_1:RecordAudio("410182002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410182", "410182002", "story_v_out_410182.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410182", "410182002", "story_v_out_410182.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_3, arg_9_1.talkMaxDuration)

			if var_12_2 <= arg_9_1.time_ and arg_9_1.time_ < var_12_2 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_2) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_2 + var_12_10 and arg_9_1.time_ < var_12_2 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play410182003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410182003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play410182004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10061 = arg_13_1.actors_["10061"].transform.localPosition
				arg_13_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10061", 7)

				for iter_16_0 = 0, arg_13_1.actors_["10061"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["10061"].transform:GetChild(iter_16_0)

					if var_16_0.name == "" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10061, Vector3.New(0, -2000, -100), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["10061"].transform.localPosition = Vector3.New(0, -2000, -100)
			end

			local var_16_2 = 0
			local var_16_3 = 1.4

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(410182003).content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 56 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_4) / 56)

				if (56 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_4) / 56)) > 0 and var_16_3 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_7 and arg_13_1.time_ < var_16_2 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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
	Play410182004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410182004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play410182005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.925

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(410182004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 37 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 37)

				if (37 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 37)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play410182005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410182005
		arg_21_1.duration_ = 5.23

		local var_21_0 = {
			ja = 5.233,
			CriLanguages = 3,
			zh = 2.033
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
				arg_21_0:Play410182006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10061 = arg_21_1.actors_["10061"].transform.localPosition
				arg_21_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10061", 7)

				for iter_24_0 = 0, arg_21_1.actors_["10061"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10061"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10061, Vector3.New(0, -2000, -100), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10061"].transform.localPosition = Vector3.New(0, -2000, -100)
			end

			local var_24_2 = "10059"

			if arg_21_1.actors_["10059"] == nil then
				local var_24_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10059")

				if not isNil(var_24_3) then
					local var_24_4 = Object.Instantiate(var_24_3, arg_21_1.canvasGo_.transform)

					var_24_4.transform:SetSiblingIndex(1)

					var_24_4.name = var_24_2
					var_24_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_[var_24_2] = var_24_4

					if arg_21_1.isInRecall_ then
						for iter_24_1, iter_24_2 in ipairs((var_24_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_24_2.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_5 = arg_21_1.actors_["10059"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10059 = var_24_5.localPosition
				var_24_5.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10059", 2)

				for iter_24_3 = 0, var_24_5.childCount - 1 do
					local var_24_6 = var_24_5:GetChild(iter_24_3)

					if var_24_6.name == "split_3" or not string.find(var_24_6.name, "split") then
						var_24_6.gameObject:SetActive(true)
					else
						var_24_6.gameObject:SetActive(false)
					end
				end
			end

			local var_24_7 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_21_1.time_ - 0) / var_24_7)
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_24_8 = "1061"

			if arg_21_1.actors_["1061"] == nil then
				local var_24_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

				if not isNil(var_24_9) then
					local var_24_10 = Object.Instantiate(var_24_9, arg_21_1.canvasGo_.transform)

					var_24_10.transform:SetSiblingIndex(1)

					var_24_10.name = var_24_8
					var_24_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_[var_24_8] = var_24_10

					if arg_21_1.isInRecall_ then
						for iter_24_4, iter_24_5 in ipairs((var_24_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_24_5.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_11 = arg_21_1.actors_["1061"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1061 = var_24_11.localPosition
				var_24_11.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1061", 4)

				for iter_24_6 = 0, var_24_11.childCount - 1 do
					local var_24_12 = var_24_11:GetChild(iter_24_6)

					if var_24_12.name == "" or not string.find(var_24_12.name, "split") then
						var_24_12.gameObject:SetActive(true)
					else
						var_24_12.gameObject:SetActive(false)
					end
				end
			end

			local var_24_13 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_13 then
				var_24_11.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_21_1.time_ - 0) / var_24_13)
			end

			if arg_21_1.time_ >= 0 + var_24_13 and arg_21_1.time_ < 0 + var_24_13 + arg_24_0 then
				var_24_11.localPosition = Vector3.New(390, -490, 18)
			end

			local var_24_14 = arg_21_1.actors_["10061"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.actorSpriteComps10061 == nil then
				arg_21_1.var_.actorSpriteComps10061 = var_24_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_15 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_15 and not isNil(var_24_14) then
				if arg_21_1.var_.actorSpriteComps10061 then
					for iter_24_7, iter_24_8 in pairs(arg_21_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_24_8 then
							if arg_21_1.isInRecall_ then
								iter_24_8.color = Color.New(Mathf.Lerp(iter_24_8.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_15), Mathf.Lerp(iter_24_8.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_15), (Mathf.Lerp(iter_24_8.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_15)))
							else
								local var_24_16 = Mathf.Lerp(iter_24_8.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_15)

								iter_24_8.color = Color.New(var_24_16, var_24_16, var_24_16)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_15 and arg_21_1.time_ < 0 + var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.actorSpriteComps10061 then
				for iter_24_9, iter_24_10 in pairs(arg_21_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_24_10 then
						iter_24_10.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10061 = nil
			end

			local var_24_17 = arg_21_1.actors_["10059"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_17) and arg_21_1.var_.actorSpriteComps10059 == nil then
				arg_21_1.var_.actorSpriteComps10059 = var_24_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_18 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_18 and not isNil(var_24_17) then
				if arg_21_1.var_.actorSpriteComps10059 then
					for iter_24_11, iter_24_12 in pairs(arg_21_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_24_12 then
							if arg_21_1.isInRecall_ then
								iter_24_12.color = Color.New(Mathf.Lerp(iter_24_12.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_18), Mathf.Lerp(iter_24_12.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_18), (Mathf.Lerp(iter_24_12.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_18)))
							else
								local var_24_19 = Mathf.Lerp(iter_24_12.color.r, 1, (arg_21_1.time_ - 0) / var_24_18)

								iter_24_12.color = Color.New(var_24_19, var_24_19, var_24_19)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_18 and arg_21_1.time_ < 0 + var_24_18 + arg_24_0 and not isNil(var_24_17) and arg_21_1.var_.actorSpriteComps10059 then
				for iter_24_13, iter_24_14 in pairs(arg_21_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_24_14 then
						iter_24_14.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10059 = nil
			end

			local var_24_20 = arg_21_1.actors_["1061"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_20) and arg_21_1.var_.actorSpriteComps1061 == nil then
				arg_21_1.var_.actorSpriteComps1061 = var_24_20:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_21 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_21 and not isNil(var_24_20) then
				if arg_21_1.var_.actorSpriteComps1061 then
					for iter_24_15, iter_24_16 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_24_16 then
							if arg_21_1.isInRecall_ then
								iter_24_16.color = Color.New(Mathf.Lerp(iter_24_16.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_21), Mathf.Lerp(iter_24_16.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_21), (Mathf.Lerp(iter_24_16.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_21)))
							else
								local var_24_22 = Mathf.Lerp(iter_24_16.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_21)

								iter_24_16.color = Color.New(var_24_22, var_24_22, var_24_22)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_21 and arg_21_1.time_ < 0 + var_24_21 + arg_24_0 and not isNil(var_24_20) and arg_21_1.var_.actorSpriteComps1061 then
				for iter_24_17, iter_24_18 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_24_18 then
						iter_24_18.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps1061 = nil
			end

			local var_24_23 = 0
			local var_24_24 = 0.275

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_25 = arg_21_1:GetWordFromCfg(410182005)
				local var_24_26 = arg_21_1:FormatText(var_24_25.content)

				arg_21_1.text_.text = var_24_26

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_28 = 11 <= 0 and var_24_24 or var_24_24 * (utf8.len(var_24_26) / 11)

				if (11 <= 0 and var_24_24 or var_24_24 * (utf8.len(var_24_26) / 11)) > 0 and var_24_24 < var_24_28 then
					arg_21_1.talkMaxDuration = var_24_28

					if var_24_28 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_28 + var_24_23
					end
				end

				arg_21_1.text_.text = var_24_26
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182005", "story_v_out_410182.awb") ~= 0 then
					local var_24_29 = manager.audio:GetVoiceLength("story_v_out_410182", "410182005", "story_v_out_410182.awb") / 1000

					if var_24_29 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_29 + var_24_23
					end

					if var_24_25.prefab_name ~= "" and arg_21_1.actors_[var_24_25.prefab_name] ~= nil then
						local var_24_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_25.prefab_name].transform, "story_v_out_410182", "410182005", "story_v_out_410182.awb")

						arg_21_1:RecordAudio("410182005", var_24_30)
						arg_21_1:RecordAudio("410182005", var_24_30)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410182", "410182005", "story_v_out_410182.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410182", "410182005", "story_v_out_410182.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_31 = math.max(var_24_24, arg_21_1.talkMaxDuration)

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_31 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_23) / var_24_31

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_23 + var_24_31 and arg_21_1.time_ < var_24_23 + var_24_31 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410182006
		arg_25_1.duration_ = 10.93

		local var_25_0 = {
			ja = 10.933,
			CriLanguages = 6.133,
			zh = 6.133
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
				arg_25_0:Play410182007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1061 = arg_25_1.actors_["1061"].transform.localPosition
				arg_25_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1061", 4)

				for iter_28_0 = 0, arg_25_1.actors_["1061"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["1061"].transform:GetChild(iter_28_0)

					if var_28_0.name == "" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_28_2 = arg_25_1.actors_["1061"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1061 == nil then
				arg_25_1.var_.actorSpriteComps1061 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps1061 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1061 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps1061 = nil
			end

			local var_28_5 = arg_25_1.actors_["10059"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps10059 == nil then
				arg_25_1.var_.actorSpriteComps10059 = var_28_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_6 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.actorSpriteComps10059 then
					for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps10059 then
				for iter_28_7, iter_28_8 in pairs(arg_25_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_28_8 then
						iter_28_8.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10059 = nil
			end

			local var_28_8 = 0
			local var_28_9 = 0.8

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(410182006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 32 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 32)

				if (32 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 32)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182006", "story_v_out_410182.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182006", "story_v_out_410182.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_410182", "410182006", "story_v_out_410182.awb")

						arg_25_1:RecordAudio("410182006", var_28_15)
						arg_25_1:RecordAudio("410182006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410182", "410182006", "story_v_out_410182.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410182", "410182006", "story_v_out_410182.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410182007
		arg_29_1.duration_ = 6.63

		local var_29_0 = {
			ja = 6.633,
			CriLanguages = 3.2,
			zh = 3.2
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
				arg_29_0:Play410182008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1061 = arg_29_1.actors_["1061"].transform.localPosition
				arg_29_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1061", 4)

				for iter_32_0 = 0, arg_29_1.actors_["1061"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["1061"].transform:GetChild(iter_32_0)

					if var_32_0.name == "" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_32_2 = arg_29_1.actors_["1061"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps1061 == nil then
				arg_29_1.var_.actorSpriteComps1061 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps1061 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_32_2 then
							if arg_29_1.isInRecall_ then
								iter_32_2.color = Color.New(Mathf.Lerp(iter_32_2.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_2.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_2.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_2.color.r, 1, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_2.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps1061 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps1061 = nil
			end

			local var_32_5 = 0
			local var_32_6 = 0.45

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
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

				local var_32_7 = arg_29_1:GetWordFromCfg(410182007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 18 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 18)

				if (18 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 18)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182007", "story_v_out_410182.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182007", "story_v_out_410182.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_410182", "410182007", "story_v_out_410182.awb")

						arg_29_1:RecordAudio("410182007", var_32_12)
						arg_29_1:RecordAudio("410182007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410182", "410182007", "story_v_out_410182.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410182", "410182007", "story_v_out_410182.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_13 = math.max(var_32_6, arg_29_1.talkMaxDuration)

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_5) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_5 + var_32_13 and arg_29_1.time_ < var_32_5 + var_32_13 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410182008
		arg_33_1.duration_ = 5.13

		local var_33_0 = {
			ja = 5.133,
			CriLanguages = 2.6,
			zh = 2.6
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
				arg_33_0:Play410182009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1061 = arg_33_1.actors_["1061"].transform.localPosition
				arg_33_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1061", 4)

				for iter_36_0 = 0, arg_33_1.actors_["1061"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["1061"].transform:GetChild(iter_36_0)

					if var_36_0.name == "" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_36_2 = arg_33_1.actors_["1061"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1061 == nil then
				arg_33_1.var_.actorSpriteComps1061 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps1061 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								iter_36_2.color = Color.New(Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_2.color.r, 1, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_2.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1061 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_36_4 then
						iter_36_4.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1061 = nil
			end

			local var_36_5 = 0
			local var_36_6 = 0.35

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(410182008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 14 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 14)

				if (14 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 14)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182008", "story_v_out_410182.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182008", "story_v_out_410182.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_410182", "410182008", "story_v_out_410182.awb")

						arg_33_1:RecordAudio("410182008", var_36_12)
						arg_33_1:RecordAudio("410182008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410182", "410182008", "story_v_out_410182.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410182", "410182008", "story_v_out_410182.awb")
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

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play410182009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410182009
		arg_37_1.duration_ = 7.37

		local var_37_0 = {
			ja = 7.366,
			CriLanguages = 2.033,
			zh = 7.066
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
				arg_37_0:Play410182010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10059 = arg_37_1.actors_["10059"].transform.localPosition
				arg_37_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10059", 2)

				for iter_40_0 = 0, arg_37_1.actors_["10059"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["10059"].transform:GetChild(iter_40_0)

					if var_40_0.name == "split_3" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_40_2 = arg_37_1.actors_["10059"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10059 == nil then
				arg_37_1.var_.actorSpriteComps10059 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps10059 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10059 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_40_4 then
						iter_40_4.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10059 = nil
			end

			local var_40_5 = arg_37_1.actors_["1061"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.actorSpriteComps1061 == nil then
				arg_37_1.var_.actorSpriteComps1061 = var_40_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_6 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.actorSpriteComps1061 then
					for iter_40_5, iter_40_6 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_40_6 then
							if arg_37_1.isInRecall_ then
								iter_40_6.color = Color.New(Mathf.Lerp(iter_40_6.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_6), Mathf.Lerp(iter_40_6.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_6), (Mathf.Lerp(iter_40_6.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_6)))
							else
								local var_40_7 = Mathf.Lerp(iter_40_6.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_6)

								iter_40_6.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.actorSpriteComps1061 then
				for iter_40_7, iter_40_8 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_40_8 then
						iter_40_8.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1061 = nil
			end

			local var_40_8 = 0
			local var_40_9 = 0.775

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(410182009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 31 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 31)

				if (31 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 31)) > 0 and var_40_9 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182009", "story_v_out_410182.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182009", "story_v_out_410182.awb") / 1000

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_410182", "410182009", "story_v_out_410182.awb")

						arg_37_1:RecordAudio("410182009", var_40_15)
						arg_37_1:RecordAudio("410182009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410182", "410182009", "story_v_out_410182.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410182", "410182009", "story_v_out_410182.awb")
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
				actorName = "10059",
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
	Play410182010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410182010
		arg_41_1.duration_ = 4.07

		local var_41_0 = {
			ja = 4.066,
			CriLanguages = 1.766,
			zh = 1.766
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
				arg_41_0:Play410182011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1061 = arg_41_1.actors_["1061"].transform.localPosition
				arg_41_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1061", 4)

				for iter_44_0 = 0, arg_41_1.actors_["1061"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["1061"].transform:GetChild(iter_44_0)

					if var_44_0.name == "split_2" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_44_2 = arg_41_1.actors_["1061"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps1061 == nil then
				arg_41_1.var_.actorSpriteComps1061 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps1061 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								iter_44_2.color = Color.New(Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_2.color.r, 1, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_2.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps1061 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_44_4 then
						iter_44_4.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1061 = nil
			end

			local var_44_5 = arg_41_1.actors_["10059"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.actorSpriteComps10059 == nil then
				arg_41_1.var_.actorSpriteComps10059 = var_44_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_6 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.actorSpriteComps10059 then
					for iter_44_5, iter_44_6 in pairs(arg_41_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_44_6 then
							if arg_41_1.isInRecall_ then
								iter_44_6.color = Color.New(Mathf.Lerp(iter_44_6.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_6), Mathf.Lerp(iter_44_6.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_6), (Mathf.Lerp(iter_44_6.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_6)))
							else
								local var_44_7 = Mathf.Lerp(iter_44_6.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_6)

								iter_44_6.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.actorSpriteComps10059 then
				for iter_44_7, iter_44_8 in pairs(arg_41_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_44_8 then
						iter_44_8.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10059 = nil
			end

			local var_44_8 = 0
			local var_44_9 = 0.125

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(410182010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 5 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 5)

				if (5 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 5)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182010", "story_v_out_410182.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182010", "story_v_out_410182.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_410182", "410182010", "story_v_out_410182.awb")

						arg_41_1:RecordAudio("410182010", var_44_15)
						arg_41_1:RecordAudio("410182010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410182", "410182010", "story_v_out_410182.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410182", "410182010", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410182011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play410182012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1061"]) and arg_45_1.var_.actorSpriteComps1061 == nil then
				arg_45_1.var_.actorSpriteComps1061 = arg_45_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1061"]) then
				if arg_45_1.var_.actorSpriteComps1061 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1061"]) and arg_45_1.var_.actorSpriteComps1061 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1061 = nil
			end

			local var_48_2 = 0
			local var_48_3 = 0.9

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(410182011).content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 36 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 36)

				if (36 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 36)) > 0 and var_48_3 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_7 and arg_45_1.time_ < var_48_2 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play410182012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410182012
		arg_49_1.duration_ = 8.77

		local var_49_0 = {
			ja = 8.766,
			CriLanguages = 6.366,
			zh = 6.366
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
				arg_49_0:Play410182013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1061 = arg_49_1.actors_["1061"].transform.localPosition
				arg_49_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1061", 4)

				for iter_52_0 = 0, arg_49_1.actors_["1061"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["1061"].transform:GetChild(iter_52_0)

					if var_52_0.name == "split_5" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_52_2 = arg_49_1.actors_["1061"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1061 == nil then
				arg_49_1.var_.actorSpriteComps1061 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps1061 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								iter_52_2.color = Color.New(Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_2.color.r, 1, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_2.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1061 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_52_4 then
						iter_52_4.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps1061 = nil
			end

			local var_52_5 = 0
			local var_52_6 = 0.725

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(410182012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 29 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 29)

				if (29 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 29)) > 0 and var_52_6 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182012", "story_v_out_410182.awb") ~= 0 then
					local var_52_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182012", "story_v_out_410182.awb") / 1000

					if var_52_11 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_5
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_410182", "410182012", "story_v_out_410182.awb")

						arg_49_1:RecordAudio("410182012", var_52_12)
						arg_49_1:RecordAudio("410182012", var_52_12)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410182", "410182012", "story_v_out_410182.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410182", "410182012", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410182013
		arg_53_1.duration_ = 13.1

		local var_53_0 = {
			ja = 13.1,
			CriLanguages = 7.333,
			zh = 7.333
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
				arg_53_0:Play410182014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1061 = arg_53_1.actors_["1061"].transform.localPosition
				arg_53_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1061", 4)

				for iter_56_0 = 0, arg_53_1.actors_["1061"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["1061"].transform:GetChild(iter_56_0)

					if var_56_0.name == "split_5" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_56_2 = arg_53_1.actors_["1061"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps1061 == nil then
				arg_53_1.var_.actorSpriteComps1061 = var_56_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_3 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.actorSpriteComps1061 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps1061 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_56_4 then
						iter_56_4.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps1061 = nil
			end

			local var_56_5 = 0
			local var_56_6 = 0.975

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(410182013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 39 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 39)

				if (39 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 39)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182013", "story_v_out_410182.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182013", "story_v_out_410182.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_410182", "410182013", "story_v_out_410182.awb")

						arg_53_1:RecordAudio("410182013", var_56_12)
						arg_53_1:RecordAudio("410182013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410182", "410182013", "story_v_out_410182.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410182", "410182013", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410182014
		arg_57_1.duration_ = 12.93

		local var_57_0 = {
			ja = 12.933,
			CriLanguages = 7.433,
			zh = 7.433
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
				arg_57_0:Play410182015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1061 = arg_57_1.actors_["1061"].transform.localPosition
				arg_57_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1061", 4)

				for iter_60_0 = 0, arg_57_1.actors_["1061"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["1061"].transform:GetChild(iter_60_0)

					if var_60_0.name == "split_5" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_60_2 = arg_57_1.actors_["1061"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1061 == nil then
				arg_57_1.var_.actorSpriteComps1061 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 0.034

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps1061 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_60_2 then
							if arg_57_1.isInRecall_ then
								iter_60_2.color = Color.New(Mathf.Lerp(iter_60_2.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_3), Mathf.Lerp(iter_60_2.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_3), (Mathf.Lerp(iter_60_2.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_3)))
							else
								local var_60_4 = Mathf.Lerp(iter_60_2.color.r, 1, (arg_57_1.time_ - 0) / var_60_3)

								iter_60_2.color = Color.New(var_60_4, var_60_4, var_60_4)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1061 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_60_4 then
						iter_60_4.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps1061 = nil
			end

			local var_60_5 = 0
			local var_60_6 = 1.1

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(410182014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 44 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 44)

				if (44 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 44)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182014", "story_v_out_410182.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182014", "story_v_out_410182.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_410182", "410182014", "story_v_out_410182.awb")

						arg_57_1:RecordAudio("410182014", var_60_12)
						arg_57_1:RecordAudio("410182014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_410182", "410182014", "story_v_out_410182.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_410182", "410182014", "story_v_out_410182.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_13 and arg_57_1.time_ < var_60_5 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410182015
		arg_61_1.duration_ = 15.67

		local var_61_0 = {
			ja = 15.666,
			CriLanguages = 9.433,
			zh = 9.433
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
				arg_61_0:Play410182016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1061 = arg_61_1.actors_["1061"].transform.localPosition
				arg_61_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1061", 4)

				for iter_64_0 = 0, arg_61_1.actors_["1061"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["1061"].transform:GetChild(iter_64_0)

					if var_64_0.name == "split_5" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_64_2 = arg_61_1.actors_["1061"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps1061 == nil then
				arg_61_1.var_.actorSpriteComps1061 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 0.034

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps1061 then
					for iter_64_1, iter_64_2 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_64_2 then
							if arg_61_1.isInRecall_ then
								iter_64_2.color = Color.New(Mathf.Lerp(iter_64_2.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_3), Mathf.Lerp(iter_64_2.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_3), (Mathf.Lerp(iter_64_2.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_3)))
							else
								local var_64_4 = Mathf.Lerp(iter_64_2.color.r, 1, (arg_61_1.time_ - 0) / var_64_3)

								iter_64_2.color = Color.New(var_64_4, var_64_4, var_64_4)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps1061 then
				for iter_64_3, iter_64_4 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_64_4 then
						iter_64_4.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps1061 = nil
			end

			local var_64_5 = 0
			local var_64_6 = 1.275

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(410182015)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 51 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 51)

				if (51 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 51)) > 0 and var_64_6 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182015", "story_v_out_410182.awb") ~= 0 then
					local var_64_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182015", "story_v_out_410182.awb") / 1000

					if var_64_11 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_5
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_410182", "410182015", "story_v_out_410182.awb")

						arg_61_1:RecordAudio("410182015", var_64_12)
						arg_61_1:RecordAudio("410182015", var_64_12)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410182", "410182015", "story_v_out_410182.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410182", "410182015", "story_v_out_410182.awb")
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

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play410182016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410182016
		arg_65_1.duration_ = 7.03

		local var_65_0 = {
			ja = 1.433,
			CriLanguages = 7.033,
			zh = 1.266
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
				arg_65_0:Play410182017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10059 = arg_65_1.actors_["10059"].transform.localPosition
				arg_65_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10059", 2)

				for iter_68_0 = 0, arg_65_1.actors_["10059"].transform.childCount - 1 do
					local var_68_0 = arg_65_1.actors_["10059"].transform:GetChild(iter_68_0)

					if var_68_0.name == "split_3" or not string.find(var_68_0.name, "split") then
						var_68_0.gameObject:SetActive(true)
					else
						var_68_0.gameObject:SetActive(false)
					end
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_65_1.time_ - 0) / var_68_1)
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_68_2 = arg_65_1.actors_["10059"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10059 == nil then
				arg_65_1.var_.actorSpriteComps10059 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.034

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps10059 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								iter_68_2.color = Color.New(Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_2.color.r, 1, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_2.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10059 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_68_4 then
						iter_68_4.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10059 = nil
			end

			local var_68_5 = arg_65_1.actors_["1061"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps1061 == nil then
				arg_65_1.var_.actorSpriteComps1061 = var_68_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_6 = 0.034

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.actorSpriteComps1061 then
					for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_68_6 then
							if arg_65_1.isInRecall_ then
								iter_68_6.color = Color.New(Mathf.Lerp(iter_68_6.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_6), Mathf.Lerp(iter_68_6.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_6), (Mathf.Lerp(iter_68_6.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_6)))
							else
								local var_68_7 = Mathf.Lerp(iter_68_6.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_6)

								iter_68_6.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps1061 then
				for iter_68_7, iter_68_8 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_68_8 then
						iter_68_8.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps1061 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 0.075

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(410182016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 3 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 3)

				if (3 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 3)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182016", "story_v_out_410182.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182016", "story_v_out_410182.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_410182", "410182016", "story_v_out_410182.awb")

						arg_65_1:RecordAudio("410182016", var_68_15)
						arg_65_1:RecordAudio("410182016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410182", "410182016", "story_v_out_410182.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410182", "410182016", "story_v_out_410182.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410182017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410182017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play410182018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10059"]) and arg_69_1.var_.actorSpriteComps10059 == nil then
				arg_69_1.var_.actorSpriteComps10059 = arg_69_1.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.034

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10059"]) then
				if arg_69_1.var_.actorSpriteComps10059 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								iter_72_1.color = Color.New(Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_0), Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_0), (Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_0)))
							else
								local var_72_1 = Mathf.Lerp(iter_72_1.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_0)

								iter_72_1.color = Color.New(var_72_1, var_72_1, var_72_1)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10059"]) and arg_69_1.var_.actorSpriteComps10059 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps10059 = nil
			end

			local var_72_2 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			if arg_69_1.time_ >= var_72_2 + 2 and arg_69_1.time_ < var_72_2 + 2 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_3 = arg_69_1.actors_["10059"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10059 = var_72_3.localPosition
				var_72_3.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10059", 7)

				for iter_72_4 = 0, var_72_3.childCount - 1 do
					local var_72_4 = var_72_3:GetChild(iter_72_4)

					if var_72_4.name == "split_3" or not string.find(var_72_4.name, "split") then
						var_72_4.gameObject:SetActive(true)
					else
						var_72_4.gameObject:SetActive(false)
					end
				end
			end

			local var_72_5 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 then
				var_72_3.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_69_1.time_ - 0) / var_72_5)
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 then
				var_72_3.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_72_6 = arg_69_1.actors_["1061"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1061 = var_72_6.localPosition
				var_72_6.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1061", 7)

				for iter_72_5 = 0, var_72_6.childCount - 1 do
					local var_72_7 = var_72_6:GetChild(iter_72_5)

					if var_72_7.name == "split_3" or not string.find(var_72_7.name, "split") then
						var_72_7.gameObject:SetActive(true)
					else
						var_72_7.gameObject:SetActive(false)
					end
				end
			end

			local var_72_8 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_8 then
				var_72_6.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_69_1.time_ - 0) / var_72_8)
			end

			if arg_69_1.time_ >= 0 + var_72_8 and arg_69_1.time_ < 0 + var_72_8 + arg_72_0 then
				var_72_6.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_72_9 = 0
			local var_72_10 = 1.1

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_11 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(410182017).content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 44 <= 0 and var_72_10 or var_72_10 * (utf8.len(var_72_11) / 44)

				if (44 <= 0 and var_72_10 or var_72_10 * (utf8.len(var_72_11) / 44)) > 0 and var_72_10 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_9 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_9
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_10, arg_69_1.talkMaxDuration)

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_9) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_9 + var_72_14 and arg_69_1.time_ < var_72_9 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410182018
		arg_73_1.duration_ = 5.93

		local var_73_0 = {
			ja = 5.933,
			CriLanguages = 5.233,
			zh = 5.366
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
				arg_73_0:Play410182019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if arg_73_1.bgs_.ST63 == nil then
				local var_76_0 = Object.Instantiate(arg_73_1.paintGo_)

				var_76_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST63")
				var_76_0.name = "ST63"
				var_76_0.transform.parent = arg_73_1.stage_.transform
				var_76_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.bgs_.ST63 = var_76_0
			end

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 then
				local var_76_1 = arg_73_1.bgs_.ST63

				arg_73_1.bgs_.ST63.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_76_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_76_2 = var_76_1:GetComponent("SpriteRenderer")

				if var_76_2 and var_76_2.sprite then
					local var_76_3 = 2 * (var_76_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_76_1.transform.localScale = Vector3.New(var_76_3 / var_76_2.sprite.bounds.size.y < var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x and var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x or var_76_3 / var_76_2.sprite.bounds.size.y, var_76_3 / var_76_2.sprite.bounds.size.y < var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x and var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x or var_76_3 / var_76_2.sprite.bounds.size.y, 0)
				end

				for iter_76_0, iter_76_1 in pairs(arg_73_1.bgs_) do
					if iter_76_0 ~= "ST63" then
						iter_76_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_76_4 = 0

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_5 = 2

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_5 then
				local var_76_6 = Color.New(0, 0, 0)

				var_76_6.a = Mathf.Lerp(0, 1, (arg_73_1.time_ - var_76_4) / var_76_5)
				arg_73_1.mask_.color = var_76_6
			end

			if arg_73_1.time_ >= var_76_4 + var_76_5 and arg_73_1.time_ < var_76_4 + var_76_5 + arg_76_0 then
				local var_76_7 = Color.New(0, 0, 0)

				var_76_7.a = 1
				arg_73_1.mask_.color = var_76_7
			end

			local var_76_8 = 2

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_9 = 2

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 then
				local var_76_10 = Color.New(0, 0, 0)

				var_76_10.a = Mathf.Lerp(1, 0, (arg_73_1.time_ - var_76_8) / var_76_9)
				arg_73_1.mask_.color = var_76_10
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 then
				local var_76_11 = Color.New(0, 0, 0)

				arg_73_1.mask_.enabled = false
				var_76_11.a = 0
				arg_73_1.mask_.color = var_76_11
			end

			local var_76_12 = arg_73_1.actors_["10059"]

			if 4 < arg_73_1.time_ and arg_73_1.time_ <= 4 + arg_76_0 and not isNil(var_76_12) and arg_73_1.var_.actorSpriteComps10059 == nil then
				arg_73_1.var_.actorSpriteComps10059 = var_76_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_13 = 0.034

			if 4 <= arg_73_1.time_ and arg_73_1.time_ < 4 + var_76_13 and not isNil(var_76_12) then
				if arg_73_1.var_.actorSpriteComps10059 then
					for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_76_3 then
							if arg_73_1.isInRecall_ then
								iter_76_3.color = Color.New(Mathf.Lerp(iter_76_3.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 4) / var_76_13), Mathf.Lerp(iter_76_3.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 4) / var_76_13), (Mathf.Lerp(iter_76_3.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 4) / var_76_13)))
							else
								local var_76_14 = Mathf.Lerp(iter_76_3.color.r, 1, (arg_73_1.time_ - 4) / var_76_13)

								iter_76_3.color = Color.New(var_76_14, var_76_14, var_76_14)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 4 + var_76_13 and arg_73_1.time_ < 4 + var_76_13 + arg_76_0 and not isNil(var_76_12) and arg_73_1.var_.actorSpriteComps10059 then
				for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_76_5 then
						iter_76_5.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10059 = nil
			end

			local var_76_15 = arg_73_1.actors_["10059"].transform

			if 4 < arg_73_1.time_ and arg_73_1.time_ <= 4 + arg_76_0 then
				arg_73_1.var_.moveOldPos10059 = var_76_15.localPosition
				var_76_15.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10059", 2)

				for iter_76_6 = 0, var_76_15.childCount - 1 do
					local var_76_16 = var_76_15:GetChild(iter_76_6)

					if var_76_16.name == "split_3" or not string.find(var_76_16.name, "split") then
						var_76_16.gameObject:SetActive(true)
					else
						var_76_16.gameObject:SetActive(false)
					end
				end
			end

			local var_76_17 = 0.001

			if 4 <= arg_73_1.time_ and arg_73_1.time_ < 4 + var_76_17 then
				var_76_15.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_73_1.time_ - 4) / var_76_17)
			end

			if arg_73_1.time_ >= 4 + var_76_17 and arg_73_1.time_ < 4 + var_76_17 + arg_76_0 then
				var_76_15.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_76_18 = arg_73_1.actors_["1061"].transform

			if 4 < arg_73_1.time_ and arg_73_1.time_ <= 4 + arg_76_0 then
				arg_73_1.var_.moveOldPos1061 = var_76_18.localPosition
				var_76_18.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1061", 4)

				for iter_76_7 = 0, var_76_18.childCount - 1 do
					local var_76_19 = var_76_18:GetChild(iter_76_7)

					if var_76_19.name == "split_3" or not string.find(var_76_19.name, "split") then
						var_76_19.gameObject:SetActive(true)
					else
						var_76_19.gameObject:SetActive(false)
					end
				end
			end

			local var_76_20 = 0.001

			if 4 <= arg_73_1.time_ and arg_73_1.time_ < 4 + var_76_20 then
				var_76_18.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_73_1.time_ - 4) / var_76_20)
			end

			if arg_73_1.time_ >= 4 + var_76_20 and arg_73_1.time_ < 4 + var_76_20 + arg_76_0 then
				var_76_18.localPosition = Vector3.New(390, -490, 18)
			end

			local var_76_21 = arg_73_1.actors_["1061"]

			if 4 < arg_73_1.time_ and arg_73_1.time_ <= 4 + arg_76_0 and not isNil(var_76_21) and arg_73_1.var_.actorSpriteComps1061 == nil then
				arg_73_1.var_.actorSpriteComps1061 = var_76_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_22 = 0.034

			if 4 <= arg_73_1.time_ and arg_73_1.time_ < 4 + var_76_22 and not isNil(var_76_21) then
				if arg_73_1.var_.actorSpriteComps1061 then
					for iter_76_8, iter_76_9 in pairs(arg_73_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_76_9 then
							if arg_73_1.isInRecall_ then
								iter_76_9.color = Color.New(Mathf.Lerp(iter_76_9.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 4) / var_76_22), Mathf.Lerp(iter_76_9.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 4) / var_76_22), (Mathf.Lerp(iter_76_9.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 4) / var_76_22)))
							else
								local var_76_23 = Mathf.Lerp(iter_76_9.color.r, 0.5, (arg_73_1.time_ - 4) / var_76_22)

								iter_76_9.color = Color.New(var_76_23, var_76_23, var_76_23)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 4 + var_76_22 and arg_73_1.time_ < 4 + var_76_22 + arg_76_0 and not isNil(var_76_21) and arg_73_1.var_.actorSpriteComps1061 then
				for iter_76_10, iter_76_11 in pairs(arg_73_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_76_11 then
						iter_76_11.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps1061 = nil
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_24 = 4
			local var_76_25 = 0.225

			if 4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_24 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_26 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_26:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_27 = arg_73_1:GetWordFromCfg(410182018)
				local var_76_28 = arg_73_1:FormatText(var_76_27.content)

				arg_73_1.text_.text = var_76_28

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_30 = 9 <= 0 and var_76_25 or var_76_25 * (utf8.len(var_76_28) / 9)

				if (9 <= 0 and var_76_25 or var_76_25 * (utf8.len(var_76_28) / 9)) > 0 and var_76_25 < var_76_30 then
					arg_73_1.talkMaxDuration = var_76_30
					var_76_24 = var_76_24 + 0.3

					if var_76_30 + var_76_24 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_30 + var_76_24
					end
				end

				arg_73_1.text_.text = var_76_28
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182018", "story_v_out_410182.awb") ~= 0 then
					local var_76_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182018", "story_v_out_410182.awb") / 1000

					if var_76_31 + var_76_24 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_31 + var_76_24
					end

					if var_76_27.prefab_name ~= "" and arg_73_1.actors_[var_76_27.prefab_name] ~= nil then
						local var_76_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_27.prefab_name].transform, "story_v_out_410182", "410182018", "story_v_out_410182.awb")

						arg_73_1:RecordAudio("410182018", var_76_32)
						arg_73_1:RecordAudio("410182018", var_76_32)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410182", "410182018", "story_v_out_410182.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410182", "410182018", "story_v_out_410182.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_33 = var_76_24 + 0.3
			local var_76_34 = math.max(var_76_25, arg_73_1.talkMaxDuration)

			if var_76_24 + 0.3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_33 + var_76_34 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_33) / var_76_34

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_33 + var_76_34 and arg_73_1.time_ < var_76_33 + var_76_34 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play410182019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 410182019
		arg_79_1.duration_ = 12.97

		local var_79_0 = {
			ja = 12.966,
			CriLanguages = 6.4,
			zh = 6.4
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play410182020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1061 = arg_79_1.actors_["1061"].transform.localPosition
				arg_79_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1061", 4)

				for iter_82_0 = 0, arg_79_1.actors_["1061"].transform.childCount - 1 do
					local var_82_0 = arg_79_1.actors_["1061"].transform:GetChild(iter_82_0)

					if var_82_0.name == "" or not string.find(var_82_0.name, "split") then
						var_82_0.gameObject:SetActive(true)
					else
						var_82_0.gameObject:SetActive(false)
					end
				end
			end

			local var_82_1 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 then
				arg_79_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_79_1.time_ - 0) / var_82_1)
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 then
				arg_79_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_82_2 = arg_79_1.actors_["1061"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps1061 == nil then
				arg_79_1.var_.actorSpriteComps1061 = var_82_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_3 = 0.034

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.actorSpriteComps1061 then
					for iter_82_1, iter_82_2 in pairs(arg_79_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_82_2 then
							if arg_79_1.isInRecall_ then
								iter_82_2.color = Color.New(Mathf.Lerp(iter_82_2.color.r, arg_79_1.hightColor1.r, (arg_79_1.time_ - 0) / var_82_3), Mathf.Lerp(iter_82_2.color.g, arg_79_1.hightColor1.g, (arg_79_1.time_ - 0) / var_82_3), (Mathf.Lerp(iter_82_2.color.b, arg_79_1.hightColor1.b, (arg_79_1.time_ - 0) / var_82_3)))
							else
								local var_82_4 = Mathf.Lerp(iter_82_2.color.r, 1, (arg_79_1.time_ - 0) / var_82_3)

								iter_82_2.color = Color.New(var_82_4, var_82_4, var_82_4)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps1061 then
				for iter_82_3, iter_82_4 in pairs(arg_79_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_82_4 then
						iter_82_4.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_79_1.var_.actorSpriteComps1061 = nil
			end

			local var_82_5 = arg_79_1.actors_["10059"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_5) and arg_79_1.var_.actorSpriteComps10059 == nil then
				arg_79_1.var_.actorSpriteComps10059 = var_82_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_6 = 0.034

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_6 and not isNil(var_82_5) then
				if arg_79_1.var_.actorSpriteComps10059 then
					for iter_82_5, iter_82_6 in pairs(arg_79_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_82_6 then
							if arg_79_1.isInRecall_ then
								iter_82_6.color = Color.New(Mathf.Lerp(iter_82_6.color.r, arg_79_1.hightColor2.r, (arg_79_1.time_ - 0) / var_82_6), Mathf.Lerp(iter_82_6.color.g, arg_79_1.hightColor2.g, (arg_79_1.time_ - 0) / var_82_6), (Mathf.Lerp(iter_82_6.color.b, arg_79_1.hightColor2.b, (arg_79_1.time_ - 0) / var_82_6)))
							else
								local var_82_7 = Mathf.Lerp(iter_82_6.color.r, 0.5, (arg_79_1.time_ - 0) / var_82_6)

								iter_82_6.color = Color.New(var_82_7, var_82_7, var_82_7)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_6 and arg_79_1.time_ < 0 + var_82_6 + arg_82_0 and not isNil(var_82_5) and arg_79_1.var_.actorSpriteComps10059 then
				for iter_82_7, iter_82_8 in pairs(arg_79_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_82_8 then
						iter_82_8.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps10059 = nil
			end

			local var_82_8 = 0
			local var_82_9 = 0.75

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_10 = arg_79_1:GetWordFromCfg(410182019)
				local var_82_11 = arg_79_1:FormatText(var_82_10.content)

				arg_79_1.text_.text = var_82_11

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 30 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 30)

				if (30 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 30)) > 0 and var_82_9 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_8
					end
				end

				arg_79_1.text_.text = var_82_11
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182019", "story_v_out_410182.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182019", "story_v_out_410182.awb") / 1000

					if var_82_14 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_8
					end

					if var_82_10.prefab_name ~= "" and arg_79_1.actors_[var_82_10.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_10.prefab_name].transform, "story_v_out_410182", "410182019", "story_v_out_410182.awb")

						arg_79_1:RecordAudio("410182019", var_82_15)
						arg_79_1:RecordAudio("410182019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_410182", "410182019", "story_v_out_410182.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_410182", "410182019", "story_v_out_410182.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_9, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_16 and arg_79_1.time_ < var_82_8 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play410182020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410182020
		arg_83_1.duration_ = 8.9

		local var_83_0 = {
			ja = 8.533,
			CriLanguages = 1.366,
			zh = 8.9
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play410182021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10059 = arg_83_1.actors_["10059"].transform.localPosition
				arg_83_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10059", 2)

				for iter_86_0 = 0, arg_83_1.actors_["10059"].transform.childCount - 1 do
					local var_86_0 = arg_83_1.actors_["10059"].transform:GetChild(iter_86_0)

					if var_86_0.name == "" or not string.find(var_86_0.name, "split") then
						var_86_0.gameObject:SetActive(true)
					else
						var_86_0.gameObject:SetActive(false)
					end
				end
			end

			local var_86_1 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 then
				arg_83_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_83_1.time_ - 0) / var_86_1)
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 then
				arg_83_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_86_2 = arg_83_1.actors_["10059"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10059 == nil then
				arg_83_1.var_.actorSpriteComps10059 = var_86_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_3 = 0.034

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.actorSpriteComps10059 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_86_2 then
							if arg_83_1.isInRecall_ then
								iter_86_2.color = Color.New(Mathf.Lerp(iter_86_2.color.r, arg_83_1.hightColor1.r, (arg_83_1.time_ - 0) / var_86_3), Mathf.Lerp(iter_86_2.color.g, arg_83_1.hightColor1.g, (arg_83_1.time_ - 0) / var_86_3), (Mathf.Lerp(iter_86_2.color.b, arg_83_1.hightColor1.b, (arg_83_1.time_ - 0) / var_86_3)))
							else
								local var_86_4 = Mathf.Lerp(iter_86_2.color.r, 1, (arg_83_1.time_ - 0) / var_86_3)

								iter_86_2.color = Color.New(var_86_4, var_86_4, var_86_4)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10059 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_86_4 then
						iter_86_4.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_83_1.var_.actorSpriteComps10059 = nil
			end

			local var_86_5 = arg_83_1.actors_["1061"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.actorSpriteComps1061 == nil then
				arg_83_1.var_.actorSpriteComps1061 = var_86_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_6 = 0.034

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_6 and not isNil(var_86_5) then
				if arg_83_1.var_.actorSpriteComps1061 then
					for iter_86_5, iter_86_6 in pairs(arg_83_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_86_6 then
							if arg_83_1.isInRecall_ then
								iter_86_6.color = Color.New(Mathf.Lerp(iter_86_6.color.r, arg_83_1.hightColor2.r, (arg_83_1.time_ - 0) / var_86_6), Mathf.Lerp(iter_86_6.color.g, arg_83_1.hightColor2.g, (arg_83_1.time_ - 0) / var_86_6), (Mathf.Lerp(iter_86_6.color.b, arg_83_1.hightColor2.b, (arg_83_1.time_ - 0) / var_86_6)))
							else
								local var_86_7 = Mathf.Lerp(iter_86_6.color.r, 0.5, (arg_83_1.time_ - 0) / var_86_6)

								iter_86_6.color = Color.New(var_86_7, var_86_7, var_86_7)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_6 and arg_83_1.time_ < 0 + var_86_6 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.actorSpriteComps1061 then
				for iter_86_7, iter_86_8 in pairs(arg_83_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_86_8 then
						iter_86_8.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_83_1.var_.actorSpriteComps1061 = nil
			end

			local var_86_8 = 0
			local var_86_9 = 0.7

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_10 = arg_83_1:GetWordFromCfg(410182020)
				local var_86_11 = arg_83_1:FormatText(var_86_10.content)

				arg_83_1.text_.text = var_86_11

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_13 = 28 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_11) / 28)

				if (28 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_11) / 28)) > 0 and var_86_9 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_8
					end
				end

				arg_83_1.text_.text = var_86_11
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182020", "story_v_out_410182.awb") ~= 0 then
					local var_86_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182020", "story_v_out_410182.awb") / 1000

					if var_86_14 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_14 + var_86_8
					end

					if var_86_10.prefab_name ~= "" and arg_83_1.actors_[var_86_10.prefab_name] ~= nil then
						local var_86_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_10.prefab_name].transform, "story_v_out_410182", "410182020", "story_v_out_410182.awb")

						arg_83_1:RecordAudio("410182020", var_86_15)
						arg_83_1:RecordAudio("410182020", var_86_15)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_410182", "410182020", "story_v_out_410182.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_410182", "410182020", "story_v_out_410182.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_9, arg_83_1.talkMaxDuration)

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_8) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_8 + var_86_16 and arg_83_1.time_ < var_86_8 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play410182021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 410182021
		arg_87_1.duration_ = 4.83

		local var_87_0 = {
			ja = 4.833,
			CriLanguages = 2.366,
			zh = 2.366
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
				arg_87_0:Play410182022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1061 = arg_87_1.actors_["1061"].transform.localPosition
				arg_87_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1061", 4)

				for iter_90_0 = 0, arg_87_1.actors_["1061"].transform.childCount - 1 do
					local var_90_0 = arg_87_1.actors_["1061"].transform:GetChild(iter_90_0)

					if var_90_0.name == "" or not string.find(var_90_0.name, "split") then
						var_90_0.gameObject:SetActive(true)
					else
						var_90_0.gameObject:SetActive(false)
					end
				end
			end

			local var_90_1 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 then
				arg_87_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_87_1.time_ - 0) / var_90_1)
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 then
				arg_87_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_90_2 = arg_87_1.actors_["10059"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps10059 == nil then
				arg_87_1.var_.actorSpriteComps10059 = var_90_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_3 = 0.034

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_2) then
				if arg_87_1.var_.actorSpriteComps10059 then
					for iter_90_1, iter_90_2 in pairs(arg_87_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_90_2 then
							if arg_87_1.isInRecall_ then
								iter_90_2.color = Color.New(Mathf.Lerp(iter_90_2.color.r, arg_87_1.hightColor2.r, (arg_87_1.time_ - 0) / var_90_3), Mathf.Lerp(iter_90_2.color.g, arg_87_1.hightColor2.g, (arg_87_1.time_ - 0) / var_90_3), (Mathf.Lerp(iter_90_2.color.b, arg_87_1.hightColor2.b, (arg_87_1.time_ - 0) / var_90_3)))
							else
								local var_90_4 = Mathf.Lerp(iter_90_2.color.r, 0.5, (arg_87_1.time_ - 0) / var_90_3)

								iter_90_2.color = Color.New(var_90_4, var_90_4, var_90_4)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps10059 then
				for iter_90_3, iter_90_4 in pairs(arg_87_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_90_4 then
						iter_90_4.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_87_1.var_.actorSpriteComps10059 = nil
			end

			local var_90_5 = arg_87_1.actors_["1061"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.actorSpriteComps1061 == nil then
				arg_87_1.var_.actorSpriteComps1061 = var_90_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_6 = 0.034

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_6 and not isNil(var_90_5) then
				if arg_87_1.var_.actorSpriteComps1061 then
					for iter_90_5, iter_90_6 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_90_6 then
							if arg_87_1.isInRecall_ then
								iter_90_6.color = Color.New(Mathf.Lerp(iter_90_6.color.r, arg_87_1.hightColor1.r, (arg_87_1.time_ - 0) / var_90_6), Mathf.Lerp(iter_90_6.color.g, arg_87_1.hightColor1.g, (arg_87_1.time_ - 0) / var_90_6), (Mathf.Lerp(iter_90_6.color.b, arg_87_1.hightColor1.b, (arg_87_1.time_ - 0) / var_90_6)))
							else
								local var_90_7 = Mathf.Lerp(iter_90_6.color.r, 1, (arg_87_1.time_ - 0) / var_90_6)

								iter_90_6.color = Color.New(var_90_7, var_90_7, var_90_7)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_6 and arg_87_1.time_ < 0 + var_90_6 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.actorSpriteComps1061 then
				for iter_90_7, iter_90_8 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_90_8 then
						iter_90_8.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_87_1.var_.actorSpriteComps1061 = nil
			end

			local var_90_8 = 0
			local var_90_9 = 0.325

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_10 = arg_87_1:GetWordFromCfg(410182021)
				local var_90_11 = arg_87_1:FormatText(var_90_10.content)

				arg_87_1.text_.text = var_90_11

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 13 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 13)

				if (13 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 13)) > 0 and var_90_9 < var_90_13 then
					arg_87_1.talkMaxDuration = var_90_13

					if var_90_13 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_8
					end
				end

				arg_87_1.text_.text = var_90_11
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182021", "story_v_out_410182.awb") ~= 0 then
					local var_90_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182021", "story_v_out_410182.awb") / 1000

					if var_90_14 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_14 + var_90_8
					end

					if var_90_10.prefab_name ~= "" and arg_87_1.actors_[var_90_10.prefab_name] ~= nil then
						local var_90_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_10.prefab_name].transform, "story_v_out_410182", "410182021", "story_v_out_410182.awb")

						arg_87_1:RecordAudio("410182021", var_90_15)
						arg_87_1:RecordAudio("410182021", var_90_15)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_410182", "410182021", "story_v_out_410182.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_410182", "410182021", "story_v_out_410182.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_16 = math.max(var_90_9, arg_87_1.talkMaxDuration)

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_16 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_8) / var_90_16

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_8 + var_90_16 and arg_87_1.time_ < var_90_8 + var_90_16 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play410182022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 410182022
		arg_91_1.duration_ = 8.9

		local var_91_0 = {
			ja = 3.766,
			CriLanguages = 8.9,
			zh = 2.6
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play410182023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10059 = arg_91_1.actors_["10059"].transform.localPosition
				arg_91_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10059", 2)

				for iter_94_0 = 0, arg_91_1.actors_["10059"].transform.childCount - 1 do
					local var_94_0 = arg_91_1.actors_["10059"].transform:GetChild(iter_94_0)

					if var_94_0.name == "" or not string.find(var_94_0.name, "split") then
						var_94_0.gameObject:SetActive(true)
					else
						var_94_0.gameObject:SetActive(false)
					end
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_91_1.time_ - 0) / var_94_1)
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_94_2 = arg_91_1.actors_["10059"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps10059 == nil then
				arg_91_1.var_.actorSpriteComps10059 = var_94_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_3 = 0.034

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 and not isNil(var_94_2) then
				if arg_91_1.var_.actorSpriteComps10059 then
					for iter_94_1, iter_94_2 in pairs(arg_91_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_94_2 then
							if arg_91_1.isInRecall_ then
								iter_94_2.color = Color.New(Mathf.Lerp(iter_94_2.color.r, arg_91_1.hightColor1.r, (arg_91_1.time_ - 0) / var_94_3), Mathf.Lerp(iter_94_2.color.g, arg_91_1.hightColor1.g, (arg_91_1.time_ - 0) / var_94_3), (Mathf.Lerp(iter_94_2.color.b, arg_91_1.hightColor1.b, (arg_91_1.time_ - 0) / var_94_3)))
							else
								local var_94_4 = Mathf.Lerp(iter_94_2.color.r, 1, (arg_91_1.time_ - 0) / var_94_3)

								iter_94_2.color = Color.New(var_94_4, var_94_4, var_94_4)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps10059 then
				for iter_94_3, iter_94_4 in pairs(arg_91_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_94_4 then
						iter_94_4.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps10059 = nil
			end

			local var_94_5 = arg_91_1.actors_["1061"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.actorSpriteComps1061 == nil then
				arg_91_1.var_.actorSpriteComps1061 = var_94_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_6 = 0.034

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_6 and not isNil(var_94_5) then
				if arg_91_1.var_.actorSpriteComps1061 then
					for iter_94_5, iter_94_6 in pairs(arg_91_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_94_6 then
							if arg_91_1.isInRecall_ then
								iter_94_6.color = Color.New(Mathf.Lerp(iter_94_6.color.r, arg_91_1.hightColor2.r, (arg_91_1.time_ - 0) / var_94_6), Mathf.Lerp(iter_94_6.color.g, arg_91_1.hightColor2.g, (arg_91_1.time_ - 0) / var_94_6), (Mathf.Lerp(iter_94_6.color.b, arg_91_1.hightColor2.b, (arg_91_1.time_ - 0) / var_94_6)))
							else
								local var_94_7 = Mathf.Lerp(iter_94_6.color.r, 0.5, (arg_91_1.time_ - 0) / var_94_6)

								iter_94_6.color = Color.New(var_94_7, var_94_7, var_94_7)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_6 and arg_91_1.time_ < 0 + var_94_6 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.actorSpriteComps1061 then
				for iter_94_7, iter_94_8 in pairs(arg_91_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_94_8 then
						iter_94_8.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_91_1.var_.actorSpriteComps1061 = nil
			end

			local var_94_8 = 0
			local var_94_9 = 0.2

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_10 = arg_91_1:GetWordFromCfg(410182022)
				local var_94_11 = arg_91_1:FormatText(var_94_10.content)

				arg_91_1.text_.text = var_94_11

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_13 = 8 <= 0 and var_94_9 or var_94_9 * (utf8.len(var_94_11) / 8)

				if (8 <= 0 and var_94_9 or var_94_9 * (utf8.len(var_94_11) / 8)) > 0 and var_94_9 < var_94_13 then
					arg_91_1.talkMaxDuration = var_94_13

					if var_94_13 + var_94_8 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_8
					end
				end

				arg_91_1.text_.text = var_94_11
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182022", "story_v_out_410182.awb") ~= 0 then
					local var_94_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182022", "story_v_out_410182.awb") / 1000

					if var_94_14 + var_94_8 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_14 + var_94_8
					end

					if var_94_10.prefab_name ~= "" and arg_91_1.actors_[var_94_10.prefab_name] ~= nil then
						local var_94_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_10.prefab_name].transform, "story_v_out_410182", "410182022", "story_v_out_410182.awb")

						arg_91_1:RecordAudio("410182022", var_94_15)
						arg_91_1:RecordAudio("410182022", var_94_15)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_410182", "410182022", "story_v_out_410182.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_410182", "410182022", "story_v_out_410182.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_16 = math.max(var_94_9, arg_91_1.talkMaxDuration)

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_16 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_8) / var_94_16

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_8 + var_94_16 and arg_91_1.time_ < var_94_8 + var_94_16 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play410182023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 410182023
		arg_95_1.duration_ = 8.87

		local var_95_0 = {
			ja = 8.866,
			CriLanguages = 6.466,
			zh = 6.466
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play410182024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1061 = arg_95_1.actors_["1061"].transform.localPosition
				arg_95_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1061", 4)

				for iter_98_0 = 0, arg_95_1.actors_["1061"].transform.childCount - 1 do
					local var_98_0 = arg_95_1.actors_["1061"].transform:GetChild(iter_98_0)

					if var_98_0.name == "" or not string.find(var_98_0.name, "split") then
						var_98_0.gameObject:SetActive(true)
					else
						var_98_0.gameObject:SetActive(false)
					end
				end
			end

			local var_98_1 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 then
				arg_95_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_95_1.time_ - 0) / var_98_1)
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 then
				arg_95_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_98_2 = arg_95_1.actors_["10059"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.actorSpriteComps10059 == nil then
				arg_95_1.var_.actorSpriteComps10059 = var_98_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_3 = 0.034

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_3 and not isNil(var_98_2) then
				if arg_95_1.var_.actorSpriteComps10059 then
					for iter_98_1, iter_98_2 in pairs(arg_95_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_98_2 then
							if arg_95_1.isInRecall_ then
								iter_98_2.color = Color.New(Mathf.Lerp(iter_98_2.color.r, arg_95_1.hightColor2.r, (arg_95_1.time_ - 0) / var_98_3), Mathf.Lerp(iter_98_2.color.g, arg_95_1.hightColor2.g, (arg_95_1.time_ - 0) / var_98_3), (Mathf.Lerp(iter_98_2.color.b, arg_95_1.hightColor2.b, (arg_95_1.time_ - 0) / var_98_3)))
							else
								local var_98_4 = Mathf.Lerp(iter_98_2.color.r, 0.5, (arg_95_1.time_ - 0) / var_98_3)

								iter_98_2.color = Color.New(var_98_4, var_98_4, var_98_4)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_3 and arg_95_1.time_ < 0 + var_98_3 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.actorSpriteComps10059 then
				for iter_98_3, iter_98_4 in pairs(arg_95_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_98_4 then
						iter_98_4.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_95_1.var_.actorSpriteComps10059 = nil
			end

			local var_98_5 = arg_95_1.actors_["1061"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.actorSpriteComps1061 == nil then
				arg_95_1.var_.actorSpriteComps1061 = var_98_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_6 = 0.034

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_6 and not isNil(var_98_5) then
				if arg_95_1.var_.actorSpriteComps1061 then
					for iter_98_5, iter_98_6 in pairs(arg_95_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_98_6 then
							if arg_95_1.isInRecall_ then
								iter_98_6.color = Color.New(Mathf.Lerp(iter_98_6.color.r, arg_95_1.hightColor1.r, (arg_95_1.time_ - 0) / var_98_6), Mathf.Lerp(iter_98_6.color.g, arg_95_1.hightColor1.g, (arg_95_1.time_ - 0) / var_98_6), (Mathf.Lerp(iter_98_6.color.b, arg_95_1.hightColor1.b, (arg_95_1.time_ - 0) / var_98_6)))
							else
								local var_98_7 = Mathf.Lerp(iter_98_6.color.r, 1, (arg_95_1.time_ - 0) / var_98_6)

								iter_98_6.color = Color.New(var_98_7, var_98_7, var_98_7)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_6 and arg_95_1.time_ < 0 + var_98_6 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.actorSpriteComps1061 then
				for iter_98_7, iter_98_8 in pairs(arg_95_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_98_8 then
						iter_98_8.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_95_1.var_.actorSpriteComps1061 = nil
			end

			local var_98_8 = 0
			local var_98_9 = 0.7

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_10 = arg_95_1:GetWordFromCfg(410182023)
				local var_98_11 = arg_95_1:FormatText(var_98_10.content)

				arg_95_1.text_.text = var_98_11

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_13 = 28 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_11) / 28)

				if (28 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_11) / 28)) > 0 and var_98_9 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_8
					end
				end

				arg_95_1.text_.text = var_98_11
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182023", "story_v_out_410182.awb") ~= 0 then
					local var_98_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182023", "story_v_out_410182.awb") / 1000

					if var_98_14 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_8
					end

					if var_98_10.prefab_name ~= "" and arg_95_1.actors_[var_98_10.prefab_name] ~= nil then
						local var_98_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_10.prefab_name].transform, "story_v_out_410182", "410182023", "story_v_out_410182.awb")

						arg_95_1:RecordAudio("410182023", var_98_15)
						arg_95_1:RecordAudio("410182023", var_98_15)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_410182", "410182023", "story_v_out_410182.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_410182", "410182023", "story_v_out_410182.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_9, arg_95_1.talkMaxDuration)

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_8) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_8 + var_98_16 and arg_95_1.time_ < var_98_8 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play410182024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 410182024
		arg_99_1.duration_ = 11.97

		local var_99_0 = {
			ja = 11.733,
			CriLanguages = 11.966,
			zh = 11.966
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play410182025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1061 = arg_99_1.actors_["1061"].transform.localPosition
				arg_99_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1061", 4)

				for iter_102_0 = 0, arg_99_1.actors_["1061"].transform.childCount - 1 do
					local var_102_0 = arg_99_1.actors_["1061"].transform:GetChild(iter_102_0)

					if var_102_0.name == "" or not string.find(var_102_0.name, "split") then
						var_102_0.gameObject:SetActive(true)
					else
						var_102_0.gameObject:SetActive(false)
					end
				end
			end

			local var_102_1 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_1 then
				arg_99_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_99_1.time_ - 0) / var_102_1)
			end

			if arg_99_1.time_ >= 0 + var_102_1 and arg_99_1.time_ < 0 + var_102_1 + arg_102_0 then
				arg_99_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_102_2 = arg_99_1.actors_["1061"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.actorSpriteComps1061 == nil then
				arg_99_1.var_.actorSpriteComps1061 = var_102_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_3 = 0.034

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_3 and not isNil(var_102_2) then
				if arg_99_1.var_.actorSpriteComps1061 then
					for iter_102_1, iter_102_2 in pairs(arg_99_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_102_2 then
							if arg_99_1.isInRecall_ then
								iter_102_2.color = Color.New(Mathf.Lerp(iter_102_2.color.r, arg_99_1.hightColor1.r, (arg_99_1.time_ - 0) / var_102_3), Mathf.Lerp(iter_102_2.color.g, arg_99_1.hightColor1.g, (arg_99_1.time_ - 0) / var_102_3), (Mathf.Lerp(iter_102_2.color.b, arg_99_1.hightColor1.b, (arg_99_1.time_ - 0) / var_102_3)))
							else
								local var_102_4 = Mathf.Lerp(iter_102_2.color.r, 1, (arg_99_1.time_ - 0) / var_102_3)

								iter_102_2.color = Color.New(var_102_4, var_102_4, var_102_4)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_3 and arg_99_1.time_ < 0 + var_102_3 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.actorSpriteComps1061 then
				for iter_102_3, iter_102_4 in pairs(arg_99_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_102_4 then
						iter_102_4.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_99_1.var_.actorSpriteComps1061 = nil
			end

			local var_102_5 = 0
			local var_102_6 = 1.475

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_7 = arg_99_1:GetWordFromCfg(410182024)
				local var_102_8 = arg_99_1:FormatText(var_102_7.content)

				arg_99_1.text_.text = var_102_8

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_10 = 59 <= 0 and var_102_6 or var_102_6 * (utf8.len(var_102_8) / 59)

				if (59 <= 0 and var_102_6 or var_102_6 * (utf8.len(var_102_8) / 59)) > 0 and var_102_6 < var_102_10 then
					arg_99_1.talkMaxDuration = var_102_10

					if var_102_10 + var_102_5 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_5
					end
				end

				arg_99_1.text_.text = var_102_8
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182024", "story_v_out_410182.awb") ~= 0 then
					local var_102_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182024", "story_v_out_410182.awb") / 1000

					if var_102_11 + var_102_5 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_5
					end

					if var_102_7.prefab_name ~= "" and arg_99_1.actors_[var_102_7.prefab_name] ~= nil then
						local var_102_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_7.prefab_name].transform, "story_v_out_410182", "410182024", "story_v_out_410182.awb")

						arg_99_1:RecordAudio("410182024", var_102_12)
						arg_99_1:RecordAudio("410182024", var_102_12)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_410182", "410182024", "story_v_out_410182.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_410182", "410182024", "story_v_out_410182.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_13 = math.max(var_102_6, arg_99_1.talkMaxDuration)

			if var_102_5 <= arg_99_1.time_ and arg_99_1.time_ < var_102_5 + var_102_13 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_5) / var_102_13

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_5 + var_102_13 and arg_99_1.time_ < var_102_5 + var_102_13 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play410182025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410182025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play410182026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1061"]) and arg_103_1.var_.actorSpriteComps1061 == nil then
				arg_103_1.var_.actorSpriteComps1061 = arg_103_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_0 = 0.034

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1061"]) then
				if arg_103_1.var_.actorSpriteComps1061 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								iter_106_1.color = Color.New(Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor2.r, (arg_103_1.time_ - 0) / var_106_0), Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor2.g, (arg_103_1.time_ - 0) / var_106_0), (Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor2.b, (arg_103_1.time_ - 0) / var_106_0)))
							else
								local var_106_1 = Mathf.Lerp(iter_106_1.color.r, 0.5, (arg_103_1.time_ - 0) / var_106_0)

								iter_106_1.color = Color.New(var_106_1, var_106_1, var_106_1)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1061"]) and arg_103_1.var_.actorSpriteComps1061 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_106_3 then
						iter_106_3.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_103_1.var_.actorSpriteComps1061 = nil
			end

			local var_106_2 = 0
			local var_106_3 = 1.45

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_4 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(410182025).content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_6 = 58 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_4) / 58)

				if (58 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_4) / 58)) > 0 and var_106_3 < var_106_6 then
					arg_103_1.talkMaxDuration = var_106_6

					if var_106_6 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_3, arg_103_1.talkMaxDuration)

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_2) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_2 + var_106_7 and arg_103_1.time_ < var_106_2 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play410182026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410182026
		arg_107_1.duration_ = 16.17

		local var_107_0 = {
			ja = 16.166,
			CriLanguages = 2.566,
			zh = 10.2
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play410182027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10059 = arg_107_1.actors_["10059"].transform.localPosition
				arg_107_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10059", 2)

				for iter_110_0 = 0, arg_107_1.actors_["10059"].transform.childCount - 1 do
					local var_110_0 = arg_107_1.actors_["10059"].transform:GetChild(iter_110_0)

					if var_110_0.name == "" or not string.find(var_110_0.name, "split") then
						var_110_0.gameObject:SetActive(true)
					else
						var_110_0.gameObject:SetActive(false)
					end
				end
			end

			local var_110_1 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 then
				arg_107_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_107_1.time_ - 0) / var_110_1)
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 then
				arg_107_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_110_2 = arg_107_1.actors_["10059"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps10059 == nil then
				arg_107_1.var_.actorSpriteComps10059 = var_110_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_3 = 0.034

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 and not isNil(var_110_2) then
				if arg_107_1.var_.actorSpriteComps10059 then
					for iter_110_1, iter_110_2 in pairs(arg_107_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_110_2 then
							if arg_107_1.isInRecall_ then
								iter_110_2.color = Color.New(Mathf.Lerp(iter_110_2.color.r, arg_107_1.hightColor1.r, (arg_107_1.time_ - 0) / var_110_3), Mathf.Lerp(iter_110_2.color.g, arg_107_1.hightColor1.g, (arg_107_1.time_ - 0) / var_110_3), (Mathf.Lerp(iter_110_2.color.b, arg_107_1.hightColor1.b, (arg_107_1.time_ - 0) / var_110_3)))
							else
								local var_110_4 = Mathf.Lerp(iter_110_2.color.r, 1, (arg_107_1.time_ - 0) / var_110_3)

								iter_110_2.color = Color.New(var_110_4, var_110_4, var_110_4)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps10059 then
				for iter_110_3, iter_110_4 in pairs(arg_107_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_110_4 then
						iter_110_4.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps10059 = nil
			end

			local var_110_5 = 0
			local var_110_6 = 1.075

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_7 = arg_107_1:GetWordFromCfg(410182026)
				local var_110_8 = arg_107_1:FormatText(var_110_7.content)

				arg_107_1.text_.text = var_110_8

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_10 = 43 <= 0 and var_110_6 or var_110_6 * (utf8.len(var_110_8) / 43)

				if (43 <= 0 and var_110_6 or var_110_6 * (utf8.len(var_110_8) / 43)) > 0 and var_110_6 < var_110_10 then
					arg_107_1.talkMaxDuration = var_110_10

					if var_110_10 + var_110_5 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_5
					end
				end

				arg_107_1.text_.text = var_110_8
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182026", "story_v_out_410182.awb") ~= 0 then
					local var_110_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182026", "story_v_out_410182.awb") / 1000

					if var_110_11 + var_110_5 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_11 + var_110_5
					end

					if var_110_7.prefab_name ~= "" and arg_107_1.actors_[var_110_7.prefab_name] ~= nil then
						local var_110_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_7.prefab_name].transform, "story_v_out_410182", "410182026", "story_v_out_410182.awb")

						arg_107_1:RecordAudio("410182026", var_110_12)
						arg_107_1:RecordAudio("410182026", var_110_12)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_410182", "410182026", "story_v_out_410182.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_410182", "410182026", "story_v_out_410182.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_13 = math.max(var_110_6, arg_107_1.talkMaxDuration)

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_13 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_5) / var_110_13

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_5 + var_110_13 and arg_107_1.time_ < var_110_5 + var_110_13 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play410182027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410182027
		arg_111_1.duration_ = 6.43

		local var_111_0 = {
			ja = 6.433,
			CriLanguages = 2.933,
			zh = 2.933
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play410182028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1061 = arg_111_1.actors_["1061"].transform.localPosition
				arg_111_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1061", 4)

				for iter_114_0 = 0, arg_111_1.actors_["1061"].transform.childCount - 1 do
					local var_114_0 = arg_111_1.actors_["1061"].transform:GetChild(iter_114_0)

					if var_114_0.name == "split_5" or not string.find(var_114_0.name, "split") then
						var_114_0.gameObject:SetActive(true)
					else
						var_114_0.gameObject:SetActive(false)
					end
				end
			end

			local var_114_1 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_111_1.time_ - 0) / var_114_1)
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_114_2 = arg_111_1.actors_["1061"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps1061 == nil then
				arg_111_1.var_.actorSpriteComps1061 = var_114_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_3 = 0.034

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.actorSpriteComps1061 then
					for iter_114_1, iter_114_2 in pairs(arg_111_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_114_2 then
							if arg_111_1.isInRecall_ then
								iter_114_2.color = Color.New(Mathf.Lerp(iter_114_2.color.r, arg_111_1.hightColor1.r, (arg_111_1.time_ - 0) / var_114_3), Mathf.Lerp(iter_114_2.color.g, arg_111_1.hightColor1.g, (arg_111_1.time_ - 0) / var_114_3), (Mathf.Lerp(iter_114_2.color.b, arg_111_1.hightColor1.b, (arg_111_1.time_ - 0) / var_114_3)))
							else
								local var_114_4 = Mathf.Lerp(iter_114_2.color.r, 1, (arg_111_1.time_ - 0) / var_114_3)

								iter_114_2.color = Color.New(var_114_4, var_114_4, var_114_4)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps1061 then
				for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_114_4 then
						iter_114_4.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps1061 = nil
			end

			local var_114_5 = arg_111_1.actors_["10059"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps10059 == nil then
				arg_111_1.var_.actorSpriteComps10059 = var_114_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_6 = 0.034

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_6 and not isNil(var_114_5) then
				if arg_111_1.var_.actorSpriteComps10059 then
					for iter_114_5, iter_114_6 in pairs(arg_111_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_114_6 then
							if arg_111_1.isInRecall_ then
								iter_114_6.color = Color.New(Mathf.Lerp(iter_114_6.color.r, arg_111_1.hightColor2.r, (arg_111_1.time_ - 0) / var_114_6), Mathf.Lerp(iter_114_6.color.g, arg_111_1.hightColor2.g, (arg_111_1.time_ - 0) / var_114_6), (Mathf.Lerp(iter_114_6.color.b, arg_111_1.hightColor2.b, (arg_111_1.time_ - 0) / var_114_6)))
							else
								local var_114_7 = Mathf.Lerp(iter_114_6.color.r, 0.5, (arg_111_1.time_ - 0) / var_114_6)

								iter_114_6.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_6 and arg_111_1.time_ < 0 + var_114_6 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps10059 then
				for iter_114_7, iter_114_8 in pairs(arg_111_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_114_8 then
						iter_114_8.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps10059 = nil
			end

			local var_114_8 = 0
			local var_114_9 = 0.375

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_10 = arg_111_1:GetWordFromCfg(410182027)
				local var_114_11 = arg_111_1:FormatText(var_114_10.content)

				arg_111_1.text_.text = var_114_11

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_13 = 15 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 15)

				if (15 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 15)) > 0 and var_114_9 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_8
					end
				end

				arg_111_1.text_.text = var_114_11
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182027", "story_v_out_410182.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182027", "story_v_out_410182.awb") / 1000

					if var_114_14 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_8
					end

					if var_114_10.prefab_name ~= "" and arg_111_1.actors_[var_114_10.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_10.prefab_name].transform, "story_v_out_410182", "410182027", "story_v_out_410182.awb")

						arg_111_1:RecordAudio("410182027", var_114_15)
						arg_111_1:RecordAudio("410182027", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_410182", "410182027", "story_v_out_410182.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_410182", "410182027", "story_v_out_410182.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_9, arg_111_1.talkMaxDuration)

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_8) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_8 + var_114_16 and arg_111_1.time_ < var_114_8 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play410182028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410182028
		arg_115_1.duration_ = 13.87

		local var_115_0 = {
			ja = 13.866,
			CriLanguages = 10.166,
			zh = 8.366
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play410182029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10059 = arg_115_1.actors_["10059"].transform.localPosition
				arg_115_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10059", 2)

				for iter_118_0 = 0, arg_115_1.actors_["10059"].transform.childCount - 1 do
					local var_118_0 = arg_115_1.actors_["10059"].transform:GetChild(iter_118_0)

					if var_118_0.name == "" or not string.find(var_118_0.name, "split") then
						var_118_0.gameObject:SetActive(true)
					else
						var_118_0.gameObject:SetActive(false)
					end
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_115_1.time_ - 0) / var_118_1)
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_118_2 = arg_115_1.actors_["10059"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps10059 == nil then
				arg_115_1.var_.actorSpriteComps10059 = var_118_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_3 = 0.034

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.actorSpriteComps10059 then
					for iter_118_1, iter_118_2 in pairs(arg_115_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_118_2 then
							if arg_115_1.isInRecall_ then
								iter_118_2.color = Color.New(Mathf.Lerp(iter_118_2.color.r, arg_115_1.hightColor1.r, (arg_115_1.time_ - 0) / var_118_3), Mathf.Lerp(iter_118_2.color.g, arg_115_1.hightColor1.g, (arg_115_1.time_ - 0) / var_118_3), (Mathf.Lerp(iter_118_2.color.b, arg_115_1.hightColor1.b, (arg_115_1.time_ - 0) / var_118_3)))
							else
								local var_118_4 = Mathf.Lerp(iter_118_2.color.r, 1, (arg_115_1.time_ - 0) / var_118_3)

								iter_118_2.color = Color.New(var_118_4, var_118_4, var_118_4)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps10059 then
				for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_118_4 then
						iter_118_4.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps10059 = nil
			end

			local var_118_5 = arg_115_1.actors_["1061"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.actorSpriteComps1061 == nil then
				arg_115_1.var_.actorSpriteComps1061 = var_118_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_6 = 0.034

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_6 and not isNil(var_118_5) then
				if arg_115_1.var_.actorSpriteComps1061 then
					for iter_118_5, iter_118_6 in pairs(arg_115_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_118_6 then
							if arg_115_1.isInRecall_ then
								iter_118_6.color = Color.New(Mathf.Lerp(iter_118_6.color.r, arg_115_1.hightColor2.r, (arg_115_1.time_ - 0) / var_118_6), Mathf.Lerp(iter_118_6.color.g, arg_115_1.hightColor2.g, (arg_115_1.time_ - 0) / var_118_6), (Mathf.Lerp(iter_118_6.color.b, arg_115_1.hightColor2.b, (arg_115_1.time_ - 0) / var_118_6)))
							else
								local var_118_7 = Mathf.Lerp(iter_118_6.color.r, 0.5, (arg_115_1.time_ - 0) / var_118_6)

								iter_118_6.color = Color.New(var_118_7, var_118_7, var_118_7)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.actorSpriteComps1061 then
				for iter_118_7, iter_118_8 in pairs(arg_115_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_118_8 then
						iter_118_8.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps1061 = nil
			end

			local var_118_8 = 0
			local var_118_9 = 0.95

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_10 = arg_115_1:GetWordFromCfg(410182028)
				local var_118_11 = arg_115_1:FormatText(var_118_10.content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 38 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 38)

				if (38 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 38)) > 0 and var_118_9 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182028", "story_v_out_410182.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182028", "story_v_out_410182.awb") / 1000

					if var_118_14 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_8
					end

					if var_118_10.prefab_name ~= "" and arg_115_1.actors_[var_118_10.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_10.prefab_name].transform, "story_v_out_410182", "410182028", "story_v_out_410182.awb")

						arg_115_1:RecordAudio("410182028", var_118_15)
						arg_115_1:RecordAudio("410182028", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_410182", "410182028", "story_v_out_410182.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_410182", "410182028", "story_v_out_410182.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_16 = math.max(var_118_9, arg_115_1.talkMaxDuration)

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_8) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_8 + var_118_16 and arg_115_1.time_ < var_118_8 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play410182029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410182029
		arg_119_1.duration_ = 7

		local var_119_0 = {
			ja = 5.1,
			CriLanguages = 7,
			zh = 7
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play410182030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1061 = arg_119_1.actors_["1061"].transform.localPosition
				arg_119_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1061", 4)

				for iter_122_0 = 0, arg_119_1.actors_["1061"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["1061"].transform:GetChild(iter_122_0)

					if var_122_0.name == "split_5" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_122_2 = arg_119_1.actors_["1061"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps1061 == nil then
				arg_119_1.var_.actorSpriteComps1061 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 0.034

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps1061 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_122_2 then
							if arg_119_1.isInRecall_ then
								iter_122_2.color = Color.New(Mathf.Lerp(iter_122_2.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_3), Mathf.Lerp(iter_122_2.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_3), (Mathf.Lerp(iter_122_2.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_3)))
							else
								local var_122_4 = Mathf.Lerp(iter_122_2.color.r, 1, (arg_119_1.time_ - 0) / var_122_3)

								iter_122_2.color = Color.New(var_122_4, var_122_4, var_122_4)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps1061 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_122_4 then
						iter_122_4.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps1061 = nil
			end

			local var_122_5 = arg_119_1.actors_["10059"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.actorSpriteComps10059 == nil then
				arg_119_1.var_.actorSpriteComps10059 = var_122_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_6 = 0.034

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_6 and not isNil(var_122_5) then
				if arg_119_1.var_.actorSpriteComps10059 then
					for iter_122_5, iter_122_6 in pairs(arg_119_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_122_6 then
							if arg_119_1.isInRecall_ then
								iter_122_6.color = Color.New(Mathf.Lerp(iter_122_6.color.r, arg_119_1.hightColor2.r, (arg_119_1.time_ - 0) / var_122_6), Mathf.Lerp(iter_122_6.color.g, arg_119_1.hightColor2.g, (arg_119_1.time_ - 0) / var_122_6), (Mathf.Lerp(iter_122_6.color.b, arg_119_1.hightColor2.b, (arg_119_1.time_ - 0) / var_122_6)))
							else
								local var_122_7 = Mathf.Lerp(iter_122_6.color.r, 0.5, (arg_119_1.time_ - 0) / var_122_6)

								iter_122_6.color = Color.New(var_122_7, var_122_7, var_122_7)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_6 and arg_119_1.time_ < 0 + var_122_6 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.actorSpriteComps10059 then
				for iter_122_7, iter_122_8 in pairs(arg_119_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_122_8 then
						iter_122_8.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_119_1.var_.actorSpriteComps10059 = nil
			end

			local var_122_8 = 0
			local var_122_9 = 0.95

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_10 = arg_119_1:GetWordFromCfg(410182029)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 38 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 38)

				if (38 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 38)) > 0 and var_122_9 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182029", "story_v_out_410182.awb") ~= 0 then
					local var_122_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182029", "story_v_out_410182.awb") / 1000

					if var_122_14 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_8
					end

					if var_122_10.prefab_name ~= "" and arg_119_1.actors_[var_122_10.prefab_name] ~= nil then
						local var_122_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_10.prefab_name].transform, "story_v_out_410182", "410182029", "story_v_out_410182.awb")

						arg_119_1:RecordAudio("410182029", var_122_15)
						arg_119_1:RecordAudio("410182029", var_122_15)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_410182", "410182029", "story_v_out_410182.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_410182", "410182029", "story_v_out_410182.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_16 = math.max(var_122_9, arg_119_1.talkMaxDuration)

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_16 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_8) / var_122_16

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_8 + var_122_16 and arg_119_1.time_ < var_122_8 + var_122_16 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play410182030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410182030
		arg_123_1.duration_ = 8.33

		local var_123_0 = {
			ja = 1.966,
			CriLanguages = 8.333,
			zh = 1.366
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play410182031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10059 = arg_123_1.actors_["10059"].transform.localPosition
				arg_123_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10059", 2)

				for iter_126_0 = 0, arg_123_1.actors_["10059"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["10059"].transform:GetChild(iter_126_0)

					if var_126_0.name == "" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_126_2 = arg_123_1.actors_["10059"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10059 == nil then
				arg_123_1.var_.actorSpriteComps10059 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps10059 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_126_2 then
							if arg_123_1.isInRecall_ then
								iter_126_2.color = Color.New(Mathf.Lerp(iter_126_2.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_3), Mathf.Lerp(iter_126_2.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_3), (Mathf.Lerp(iter_126_2.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_3)))
							else
								local var_126_4 = Mathf.Lerp(iter_126_2.color.r, 1, (arg_123_1.time_ - 0) / var_126_3)

								iter_126_2.color = Color.New(var_126_4, var_126_4, var_126_4)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10059 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_126_4 then
						iter_126_4.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps10059 = nil
			end

			local var_126_5 = arg_123_1.actors_["1061"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps1061 == nil then
				arg_123_1.var_.actorSpriteComps1061 = var_126_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_6 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 and not isNil(var_126_5) then
				if arg_123_1.var_.actorSpriteComps1061 then
					for iter_126_5, iter_126_6 in pairs(arg_123_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_126_6 then
							if arg_123_1.isInRecall_ then
								iter_126_6.color = Color.New(Mathf.Lerp(iter_126_6.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_6), Mathf.Lerp(iter_126_6.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_6), (Mathf.Lerp(iter_126_6.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_6)))
							else
								local var_126_7 = Mathf.Lerp(iter_126_6.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_6)

								iter_126_6.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps1061 then
				for iter_126_7, iter_126_8 in pairs(arg_123_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_126_8 then
						iter_126_8.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps1061 = nil
			end

			local var_126_8 = 0
			local var_126_9 = 0.15

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(410182030)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 6 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 6)

				if (6 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 6)) > 0 and var_126_9 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182030", "story_v_out_410182.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182030", "story_v_out_410182.awb") / 1000

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_410182", "410182030", "story_v_out_410182.awb")

						arg_123_1:RecordAudio("410182030", var_126_15)
						arg_123_1:RecordAudio("410182030", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_410182", "410182030", "story_v_out_410182.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_410182", "410182030", "story_v_out_410182.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_16 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_16

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_16 and arg_123_1.time_ < var_126_8 + var_126_16 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play410182031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410182031
		arg_127_1.duration_ = 10.13

		local var_127_0 = {
			ja = 9.333,
			CriLanguages = 1.4,
			zh = 10.133
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play410182032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10059 = arg_127_1.actors_["10059"].transform.localPosition
				arg_127_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10059", 2)

				for iter_130_0 = 0, arg_127_1.actors_["10059"].transform.childCount - 1 do
					local var_130_0 = arg_127_1.actors_["10059"].transform:GetChild(iter_130_0)

					if var_130_0.name == "" or not string.find(var_130_0.name, "split") then
						var_130_0.gameObject:SetActive(true)
					else
						var_130_0.gameObject:SetActive(false)
					end
				end
			end

			local var_130_1 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 then
				arg_127_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_127_1.time_ - 0) / var_130_1)
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 then
				arg_127_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_130_2 = arg_127_1.actors_["10059"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps10059 == nil then
				arg_127_1.var_.actorSpriteComps10059 = var_130_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_3 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.actorSpriteComps10059 then
					for iter_130_1, iter_130_2 in pairs(arg_127_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_130_2 then
							if arg_127_1.isInRecall_ then
								iter_130_2.color = Color.New(Mathf.Lerp(iter_130_2.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_3), Mathf.Lerp(iter_130_2.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_3), (Mathf.Lerp(iter_130_2.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_3)))
							else
								local var_130_4 = Mathf.Lerp(iter_130_2.color.r, 1, (arg_127_1.time_ - 0) / var_130_3)

								iter_130_2.color = Color.New(var_130_4, var_130_4, var_130_4)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps10059 then
				for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_130_4 then
						iter_130_4.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps10059 = nil
			end

			local var_130_5 = 0
			local var_130_6 = 1.1

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_7 = arg_127_1:GetWordFromCfg(410182031)
				local var_130_8 = arg_127_1:FormatText(var_130_7.content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 44 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 44)

				if (44 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 44)) > 0 and var_130_6 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182031", "story_v_out_410182.awb") ~= 0 then
					local var_130_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182031", "story_v_out_410182.awb") / 1000

					if var_130_11 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_5
					end

					if var_130_7.prefab_name ~= "" and arg_127_1.actors_[var_130_7.prefab_name] ~= nil then
						local var_130_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_7.prefab_name].transform, "story_v_out_410182", "410182031", "story_v_out_410182.awb")

						arg_127_1:RecordAudio("410182031", var_130_12)
						arg_127_1:RecordAudio("410182031", var_130_12)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_410182", "410182031", "story_v_out_410182.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_410182", "410182031", "story_v_out_410182.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_13 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_13 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_13

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_13 and arg_127_1.time_ < var_130_5 + var_130_13 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play410182032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410182032
		arg_131_1.duration_ = 17.07

		local var_131_0 = {
			ja = 17.066,
			CriLanguages = 6.9,
			zh = 6.9
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play410182033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1061 = arg_131_1.actors_["1061"].transform.localPosition
				arg_131_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1061", 4)

				for iter_134_0 = 0, arg_131_1.actors_["1061"].transform.childCount - 1 do
					local var_134_0 = arg_131_1.actors_["1061"].transform:GetChild(iter_134_0)

					if var_134_0.name == "split_5" or not string.find(var_134_0.name, "split") then
						var_134_0.gameObject:SetActive(true)
					else
						var_134_0.gameObject:SetActive(false)
					end
				end
			end

			local var_134_1 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_1 then
				arg_131_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_131_1.time_ - 0) / var_134_1)
			end

			if arg_131_1.time_ >= 0 + var_134_1 and arg_131_1.time_ < 0 + var_134_1 + arg_134_0 then
				arg_131_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_134_2 = arg_131_1.actors_["10059"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps10059 == nil then
				arg_131_1.var_.actorSpriteComps10059 = var_134_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_3 = 0.034

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.actorSpriteComps10059 then
					for iter_134_1, iter_134_2 in pairs(arg_131_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_134_2 then
							if arg_131_1.isInRecall_ then
								iter_134_2.color = Color.New(Mathf.Lerp(iter_134_2.color.r, arg_131_1.hightColor2.r, (arg_131_1.time_ - 0) / var_134_3), Mathf.Lerp(iter_134_2.color.g, arg_131_1.hightColor2.g, (arg_131_1.time_ - 0) / var_134_3), (Mathf.Lerp(iter_134_2.color.b, arg_131_1.hightColor2.b, (arg_131_1.time_ - 0) / var_134_3)))
							else
								local var_134_4 = Mathf.Lerp(iter_134_2.color.r, 0.5, (arg_131_1.time_ - 0) / var_134_3)

								iter_134_2.color = Color.New(var_134_4, var_134_4, var_134_4)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps10059 then
				for iter_134_3, iter_134_4 in pairs(arg_131_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_134_4 then
						iter_134_4.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_131_1.var_.actorSpriteComps10059 = nil
			end

			local var_134_5 = arg_131_1.actors_["1061"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.actorSpriteComps1061 == nil then
				arg_131_1.var_.actorSpriteComps1061 = var_134_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_6 = 0.034

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_6 and not isNil(var_134_5) then
				if arg_131_1.var_.actorSpriteComps1061 then
					for iter_134_5, iter_134_6 in pairs(arg_131_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_134_6 then
							if arg_131_1.isInRecall_ then
								iter_134_6.color = Color.New(Mathf.Lerp(iter_134_6.color.r, arg_131_1.hightColor1.r, (arg_131_1.time_ - 0) / var_134_6), Mathf.Lerp(iter_134_6.color.g, arg_131_1.hightColor1.g, (arg_131_1.time_ - 0) / var_134_6), (Mathf.Lerp(iter_134_6.color.b, arg_131_1.hightColor1.b, (arg_131_1.time_ - 0) / var_134_6)))
							else
								local var_134_7 = Mathf.Lerp(iter_134_6.color.r, 1, (arg_131_1.time_ - 0) / var_134_6)

								iter_134_6.color = Color.New(var_134_7, var_134_7, var_134_7)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_6 and arg_131_1.time_ < 0 + var_134_6 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.actorSpriteComps1061 then
				for iter_134_7, iter_134_8 in pairs(arg_131_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_134_8 then
						iter_134_8.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps1061 = nil
			end

			local var_134_8 = 0
			local var_134_9 = 0.875

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_10 = arg_131_1:GetWordFromCfg(410182032)
				local var_134_11 = arg_131_1:FormatText(var_134_10.content)

				arg_131_1.text_.text = var_134_11

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_13 = 35 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 35)

				if (35 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 35)) > 0 and var_134_9 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_8
					end
				end

				arg_131_1.text_.text = var_134_11
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182032", "story_v_out_410182.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182032", "story_v_out_410182.awb") / 1000

					if var_134_14 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_8
					end

					if var_134_10.prefab_name ~= "" and arg_131_1.actors_[var_134_10.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_10.prefab_name].transform, "story_v_out_410182", "410182032", "story_v_out_410182.awb")

						arg_131_1:RecordAudio("410182032", var_134_15)
						arg_131_1:RecordAudio("410182032", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_410182", "410182032", "story_v_out_410182.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_410182", "410182032", "story_v_out_410182.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_9, arg_131_1.talkMaxDuration)

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_8) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_8 + var_134_16 and arg_131_1.time_ < var_134_8 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play410182033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410182033
		arg_135_1.duration_ = 10.1

		local var_135_0 = {
			ja = 6.833,
			CriLanguages = 10.1,
			zh = 8.033
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play410182034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10059 = arg_135_1.actors_["10059"].transform.localPosition
				arg_135_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10059", 2)

				for iter_138_0 = 0, arg_135_1.actors_["10059"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["10059"].transform:GetChild(iter_138_0)

					if var_138_0.name == "" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_138_2 = arg_135_1.actors_["10059"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10059 == nil then
				arg_135_1.var_.actorSpriteComps10059 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 0.034

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps10059 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								iter_138_2.color = Color.New(Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_3), Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_3), (Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_3)))
							else
								local var_138_4 = Mathf.Lerp(iter_138_2.color.r, 1, (arg_135_1.time_ - 0) / var_138_3)

								iter_138_2.color = Color.New(var_138_4, var_138_4, var_138_4)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10059 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_138_4 then
						iter_138_4.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10059 = nil
			end

			local var_138_5 = arg_135_1.actors_["1061"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps1061 == nil then
				arg_135_1.var_.actorSpriteComps1061 = var_138_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_6 = 0.034

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 and not isNil(var_138_5) then
				if arg_135_1.var_.actorSpriteComps1061 then
					for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_138_6 then
							if arg_135_1.isInRecall_ then
								iter_138_6.color = Color.New(Mathf.Lerp(iter_138_6.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_6), Mathf.Lerp(iter_138_6.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_6), (Mathf.Lerp(iter_138_6.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_6)))
							else
								local var_138_7 = Mathf.Lerp(iter_138_6.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_6)

								iter_138_6.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps1061 then
				for iter_138_7, iter_138_8 in pairs(arg_135_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_138_8 then
						iter_138_8.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps1061 = nil
			end

			local var_138_8 = 0
			local var_138_9 = 0.85

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_10 = arg_135_1:GetWordFromCfg(410182033)
				local var_138_11 = arg_135_1:FormatText(var_138_10.content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 34 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 34)

				if (34 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 34)) > 0 and var_138_9 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182033", "story_v_out_410182.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182033", "story_v_out_410182.awb") / 1000

					if var_138_14 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_8
					end

					if var_138_10.prefab_name ~= "" and arg_135_1.actors_[var_138_10.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_10.prefab_name].transform, "story_v_out_410182", "410182033", "story_v_out_410182.awb")

						arg_135_1:RecordAudio("410182033", var_138_15)
						arg_135_1:RecordAudio("410182033", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_410182", "410182033", "story_v_out_410182.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_410182", "410182033", "story_v_out_410182.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_16 and arg_135_1.time_ < var_138_8 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play410182034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410182034
		arg_139_1.duration_ = 10.83

		local var_139_0 = {
			ja = 9.4,
			CriLanguages = 8,
			zh = 10.833
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play410182035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10059 = arg_139_1.actors_["10059"].transform.localPosition
				arg_139_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10059", 2)

				for iter_142_0 = 0, arg_139_1.actors_["10059"].transform.childCount - 1 do
					local var_142_0 = arg_139_1.actors_["10059"].transform:GetChild(iter_142_0)

					if var_142_0.name == "" or not string.find(var_142_0.name, "split") then
						var_142_0.gameObject:SetActive(true)
					else
						var_142_0.gameObject:SetActive(false)
					end
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_139_1.time_ - 0) / var_142_1)
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_142_2 = arg_139_1.actors_["10059"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps10059 == nil then
				arg_139_1.var_.actorSpriteComps10059 = var_142_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_3 = 0.034

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.actorSpriteComps10059 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_142_2 then
							if arg_139_1.isInRecall_ then
								iter_142_2.color = Color.New(Mathf.Lerp(iter_142_2.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_3), Mathf.Lerp(iter_142_2.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_3), (Mathf.Lerp(iter_142_2.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_3)))
							else
								local var_142_4 = Mathf.Lerp(iter_142_2.color.r, 1, (arg_139_1.time_ - 0) / var_142_3)

								iter_142_2.color = Color.New(var_142_4, var_142_4, var_142_4)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps10059 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_142_4 then
						iter_142_4.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps10059 = nil
			end

			local var_142_5 = 0
			local var_142_6 = 1

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_7 = arg_139_1:GetWordFromCfg(410182034)
				local var_142_8 = arg_139_1:FormatText(var_142_7.content)

				arg_139_1.text_.text = var_142_8

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_10 = 40 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 40)

				if (40 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 40)) > 0 and var_142_6 < var_142_10 then
					arg_139_1.talkMaxDuration = var_142_10

					if var_142_10 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_5
					end
				end

				arg_139_1.text_.text = var_142_8
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182034", "story_v_out_410182.awb") ~= 0 then
					local var_142_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182034", "story_v_out_410182.awb") / 1000

					if var_142_11 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_5
					end

					if var_142_7.prefab_name ~= "" and arg_139_1.actors_[var_142_7.prefab_name] ~= nil then
						local var_142_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_7.prefab_name].transform, "story_v_out_410182", "410182034", "story_v_out_410182.awb")

						arg_139_1:RecordAudio("410182034", var_142_12)
						arg_139_1:RecordAudio("410182034", var_142_12)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_410182", "410182034", "story_v_out_410182.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_410182", "410182034", "story_v_out_410182.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_13 = math.max(var_142_6, arg_139_1.talkMaxDuration)

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_13 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_5) / var_142_13

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_5 + var_142_13 and arg_139_1.time_ < var_142_5 + var_142_13 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play410182035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 410182035
		arg_143_1.duration_ = 12.17

		local var_143_0 = {
			ja = 12.166,
			CriLanguages = 10.066,
			zh = 10.066
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play410182036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1061 = arg_143_1.actors_["1061"].transform.localPosition
				arg_143_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1061", 4)

				for iter_146_0 = 0, arg_143_1.actors_["1061"].transform.childCount - 1 do
					local var_146_0 = arg_143_1.actors_["1061"].transform:GetChild(iter_146_0)

					if var_146_0.name == "split_5" or not string.find(var_146_0.name, "split") then
						var_146_0.gameObject:SetActive(true)
					else
						var_146_0.gameObject:SetActive(false)
					end
				end
			end

			local var_146_1 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 then
				arg_143_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_143_1.time_ - 0) / var_146_1)
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 then
				arg_143_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_146_2 = arg_143_1.actors_["1061"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps1061 == nil then
				arg_143_1.var_.actorSpriteComps1061 = var_146_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_3 = 0.034

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_3 and not isNil(var_146_2) then
				if arg_143_1.var_.actorSpriteComps1061 then
					for iter_146_1, iter_146_2 in pairs(arg_143_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_146_2 then
							if arg_143_1.isInRecall_ then
								iter_146_2.color = Color.New(Mathf.Lerp(iter_146_2.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_3), Mathf.Lerp(iter_146_2.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_3), (Mathf.Lerp(iter_146_2.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_3)))
							else
								local var_146_4 = Mathf.Lerp(iter_146_2.color.r, 1, (arg_143_1.time_ - 0) / var_146_3)

								iter_146_2.color = Color.New(var_146_4, var_146_4, var_146_4)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_3 and arg_143_1.time_ < 0 + var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps1061 then
				for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_146_4 then
						iter_146_4.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps1061 = nil
			end

			local var_146_5 = arg_143_1.actors_["10059"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.actorSpriteComps10059 == nil then
				arg_143_1.var_.actorSpriteComps10059 = var_146_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_6 = 0.034

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_6 and not isNil(var_146_5) then
				if arg_143_1.var_.actorSpriteComps10059 then
					for iter_146_5, iter_146_6 in pairs(arg_143_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_146_6 then
							if arg_143_1.isInRecall_ then
								iter_146_6.color = Color.New(Mathf.Lerp(iter_146_6.color.r, arg_143_1.hightColor2.r, (arg_143_1.time_ - 0) / var_146_6), Mathf.Lerp(iter_146_6.color.g, arg_143_1.hightColor2.g, (arg_143_1.time_ - 0) / var_146_6), (Mathf.Lerp(iter_146_6.color.b, arg_143_1.hightColor2.b, (arg_143_1.time_ - 0) / var_146_6)))
							else
								local var_146_7 = Mathf.Lerp(iter_146_6.color.r, 0.5, (arg_143_1.time_ - 0) / var_146_6)

								iter_146_6.color = Color.New(var_146_7, var_146_7, var_146_7)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_6 and arg_143_1.time_ < 0 + var_146_6 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.actorSpriteComps10059 then
				for iter_146_7, iter_146_8 in pairs(arg_143_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_146_8 then
						iter_146_8.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps10059 = nil
			end

			local var_146_8 = 0
			local var_146_9 = 1.1

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_10 = arg_143_1:GetWordFromCfg(410182035)
				local var_146_11 = arg_143_1:FormatText(var_146_10.content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 44 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 44)

				if (44 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 44)) > 0 and var_146_9 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_8
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182035", "story_v_out_410182.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182035", "story_v_out_410182.awb") / 1000

					if var_146_14 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_8
					end

					if var_146_10.prefab_name ~= "" and arg_143_1.actors_[var_146_10.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_10.prefab_name].transform, "story_v_out_410182", "410182035", "story_v_out_410182.awb")

						arg_143_1:RecordAudio("410182035", var_146_15)
						arg_143_1:RecordAudio("410182035", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_410182", "410182035", "story_v_out_410182.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_410182", "410182035", "story_v_out_410182.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_9, arg_143_1.talkMaxDuration)

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_8) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_8 + var_146_16 and arg_143_1.time_ < var_146_8 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play410182036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 410182036
		arg_147_1.duration_ = 11.67

		local var_147_0 = {
			ja = 11.666,
			CriLanguages = 7.233,
			zh = 7.233
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play410182037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1061 = arg_147_1.actors_["1061"].transform.localPosition
				arg_147_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1061", 4)

				for iter_150_0 = 0, arg_147_1.actors_["1061"].transform.childCount - 1 do
					local var_150_0 = arg_147_1.actors_["1061"].transform:GetChild(iter_150_0)

					if var_150_0.name == "split_5" or not string.find(var_150_0.name, "split") then
						var_150_0.gameObject:SetActive(true)
					else
						var_150_0.gameObject:SetActive(false)
					end
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_147_1.time_ - 0) / var_150_1)
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_150_2 = arg_147_1.actors_["1061"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps1061 == nil then
				arg_147_1.var_.actorSpriteComps1061 = var_150_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_3 = 0.034

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.actorSpriteComps1061 then
					for iter_150_1, iter_150_2 in pairs(arg_147_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_150_2 then
							if arg_147_1.isInRecall_ then
								iter_150_2.color = Color.New(Mathf.Lerp(iter_150_2.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_3), Mathf.Lerp(iter_150_2.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_3), (Mathf.Lerp(iter_150_2.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_3)))
							else
								local var_150_4 = Mathf.Lerp(iter_150_2.color.r, 1, (arg_147_1.time_ - 0) / var_150_3)

								iter_150_2.color = Color.New(var_150_4, var_150_4, var_150_4)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps1061 then
				for iter_150_3, iter_150_4 in pairs(arg_147_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_150_4 then
						iter_150_4.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps1061 = nil
			end

			local var_150_5 = 0
			local var_150_6 = 0.85

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_7 = arg_147_1:GetWordFromCfg(410182036)
				local var_150_8 = arg_147_1:FormatText(var_150_7.content)

				arg_147_1.text_.text = var_150_8

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 34 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 34)

				if (34 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 34)) > 0 and var_150_6 < var_150_10 then
					arg_147_1.talkMaxDuration = var_150_10

					if var_150_10 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_5
					end
				end

				arg_147_1.text_.text = var_150_8
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182036", "story_v_out_410182.awb") ~= 0 then
					local var_150_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182036", "story_v_out_410182.awb") / 1000

					if var_150_11 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_5
					end

					if var_150_7.prefab_name ~= "" and arg_147_1.actors_[var_150_7.prefab_name] ~= nil then
						local var_150_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_7.prefab_name].transform, "story_v_out_410182", "410182036", "story_v_out_410182.awb")

						arg_147_1:RecordAudio("410182036", var_150_12)
						arg_147_1:RecordAudio("410182036", var_150_12)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_410182", "410182036", "story_v_out_410182.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_410182", "410182036", "story_v_out_410182.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_13 = math.max(var_150_6, arg_147_1.talkMaxDuration)

			if var_150_5 <= arg_147_1.time_ and arg_147_1.time_ < var_150_5 + var_150_13 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_5) / var_150_13

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_5 + var_150_13 and arg_147_1.time_ < var_150_5 + var_150_13 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play410182037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 410182037
		arg_151_1.duration_ = 10.8

		local var_151_0 = {
			ja = 4.333,
			CriLanguages = 10.8,
			zh = 1.7
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
				arg_151_0:Play410182038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10059 = arg_151_1.actors_["10059"].transform.localPosition
				arg_151_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10059", 2)

				for iter_154_0 = 0, arg_151_1.actors_["10059"].transform.childCount - 1 do
					local var_154_0 = arg_151_1.actors_["10059"].transform:GetChild(iter_154_0)

					if var_154_0.name == "" or not string.find(var_154_0.name, "split") then
						var_154_0.gameObject:SetActive(true)
					else
						var_154_0.gameObject:SetActive(false)
					end
				end
			end

			local var_154_1 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_1 then
				arg_151_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_151_1.time_ - 0) / var_154_1)
			end

			if arg_151_1.time_ >= 0 + var_154_1 and arg_151_1.time_ < 0 + var_154_1 + arg_154_0 then
				arg_151_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_154_2 = arg_151_1.actors_["10059"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps10059 == nil then
				arg_151_1.var_.actorSpriteComps10059 = var_154_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_3 = 0.034

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.actorSpriteComps10059 then
					for iter_154_1, iter_154_2 in pairs(arg_151_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_154_2 then
							if arg_151_1.isInRecall_ then
								iter_154_2.color = Color.New(Mathf.Lerp(iter_154_2.color.r, arg_151_1.hightColor1.r, (arg_151_1.time_ - 0) / var_154_3), Mathf.Lerp(iter_154_2.color.g, arg_151_1.hightColor1.g, (arg_151_1.time_ - 0) / var_154_3), (Mathf.Lerp(iter_154_2.color.b, arg_151_1.hightColor1.b, (arg_151_1.time_ - 0) / var_154_3)))
							else
								local var_154_4 = Mathf.Lerp(iter_154_2.color.r, 1, (arg_151_1.time_ - 0) / var_154_3)

								iter_154_2.color = Color.New(var_154_4, var_154_4, var_154_4)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps10059 then
				for iter_154_3, iter_154_4 in pairs(arg_151_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_154_4 then
						iter_154_4.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps10059 = nil
			end

			local var_154_5 = arg_151_1.actors_["1061"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_5) and arg_151_1.var_.actorSpriteComps1061 == nil then
				arg_151_1.var_.actorSpriteComps1061 = var_154_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_6 = 0.034

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_6 and not isNil(var_154_5) then
				if arg_151_1.var_.actorSpriteComps1061 then
					for iter_154_5, iter_154_6 in pairs(arg_151_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_154_6 then
							if arg_151_1.isInRecall_ then
								iter_154_6.color = Color.New(Mathf.Lerp(iter_154_6.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_6), Mathf.Lerp(iter_154_6.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_6), (Mathf.Lerp(iter_154_6.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_6)))
							else
								local var_154_7 = Mathf.Lerp(iter_154_6.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_6)

								iter_154_6.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_6 and arg_151_1.time_ < 0 + var_154_6 + arg_154_0 and not isNil(var_154_5) and arg_151_1.var_.actorSpriteComps1061 then
				for iter_154_7, iter_154_8 in pairs(arg_151_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_154_8 then
						iter_154_8.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps1061 = nil
			end

			local var_154_8 = 0
			local var_154_9 = 0.225

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_10 = arg_151_1:GetWordFromCfg(410182037)
				local var_154_11 = arg_151_1:FormatText(var_154_10.content)

				arg_151_1.text_.text = var_154_11

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 9 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 9)

				if (9 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 9)) > 0 and var_154_9 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_11
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182037", "story_v_out_410182.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182037", "story_v_out_410182.awb") / 1000

					if var_154_14 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_8
					end

					if var_154_10.prefab_name ~= "" and arg_151_1.actors_[var_154_10.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_10.prefab_name].transform, "story_v_out_410182", "410182037", "story_v_out_410182.awb")

						arg_151_1:RecordAudio("410182037", var_154_15)
						arg_151_1:RecordAudio("410182037", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_410182", "410182037", "story_v_out_410182.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_410182", "410182037", "story_v_out_410182.awb")
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
				actorName = "10059",
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
	Play410182038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 410182038
		arg_155_1.duration_ = 3.5

		local var_155_0 = {
			ja = 3.5,
			CriLanguages = 2.5,
			zh = 2.5
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
				arg_155_0:Play410182039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1061 = arg_155_1.actors_["1061"].transform.localPosition
				arg_155_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1061", 4)

				for iter_158_0 = 0, arg_155_1.actors_["1061"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["1061"].transform:GetChild(iter_158_0)

					if var_158_0.name == "split_2" or not string.find(var_158_0.name, "split") then
						var_158_0.gameObject:SetActive(true)
					else
						var_158_0.gameObject:SetActive(false)
					end
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_155_1.time_ - 0) / var_158_1)
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_158_2 = arg_155_1.actors_["10059"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10059 == nil then
				arg_155_1.var_.actorSpriteComps10059 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 0.034

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps10059 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								iter_158_2.color = Color.New(Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor2.r, (arg_155_1.time_ - 0) / var_158_3), Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor2.g, (arg_155_1.time_ - 0) / var_158_3), (Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor2.b, (arg_155_1.time_ - 0) / var_158_3)))
							else
								local var_158_4 = Mathf.Lerp(iter_158_2.color.r, 0.5, (arg_155_1.time_ - 0) / var_158_3)

								iter_158_2.color = Color.New(var_158_4, var_158_4, var_158_4)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10059 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_158_4 then
						iter_158_4.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_155_1.var_.actorSpriteComps10059 = nil
			end

			local var_158_5 = arg_155_1.actors_["1061"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.actorSpriteComps1061 == nil then
				arg_155_1.var_.actorSpriteComps1061 = var_158_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_6 = 0.034

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_6 and not isNil(var_158_5) then
				if arg_155_1.var_.actorSpriteComps1061 then
					for iter_158_5, iter_158_6 in pairs(arg_155_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_158_6 then
							if arg_155_1.isInRecall_ then
								iter_158_6.color = Color.New(Mathf.Lerp(iter_158_6.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_6), Mathf.Lerp(iter_158_6.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_6), (Mathf.Lerp(iter_158_6.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_6)))
							else
								local var_158_7 = Mathf.Lerp(iter_158_6.color.r, 1, (arg_155_1.time_ - 0) / var_158_6)

								iter_158_6.color = Color.New(var_158_7, var_158_7, var_158_7)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_6 and arg_155_1.time_ < 0 + var_158_6 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.actorSpriteComps1061 then
				for iter_158_7, iter_158_8 in pairs(arg_155_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_158_8 then
						iter_158_8.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps1061 = nil
			end

			local var_158_8 = 0
			local var_158_9 = 0.175

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_10 = arg_155_1:GetWordFromCfg(410182038)
				local var_158_11 = arg_155_1:FormatText(var_158_10.content)

				arg_155_1.text_.text = var_158_11

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_13 = 7 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 7)

				if (7 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 7)) > 0 and var_158_9 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_8
					end
				end

				arg_155_1.text_.text = var_158_11
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182038", "story_v_out_410182.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182038", "story_v_out_410182.awb") / 1000

					if var_158_14 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_8
					end

					if var_158_10.prefab_name ~= "" and arg_155_1.actors_[var_158_10.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_10.prefab_name].transform, "story_v_out_410182", "410182038", "story_v_out_410182.awb")

						arg_155_1:RecordAudio("410182038", var_158_15)
						arg_155_1:RecordAudio("410182038", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_410182", "410182038", "story_v_out_410182.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_410182", "410182038", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 410182039
		arg_159_1.duration_ = 1.67

		local var_159_0 = {
			ja = 1.566,
			CriLanguages = 1.666,
			zh = 1.5
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play410182040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10059 = arg_159_1.actors_["10059"].transform.localPosition
				arg_159_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10059", 2)

				for iter_162_0 = 0, arg_159_1.actors_["10059"].transform.childCount - 1 do
					local var_162_0 = arg_159_1.actors_["10059"].transform:GetChild(iter_162_0)

					if var_162_0.name == "" or not string.find(var_162_0.name, "split") then
						var_162_0.gameObject:SetActive(true)
					else
						var_162_0.gameObject:SetActive(false)
					end
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_159_1.time_ - 0) / var_162_1)
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_162_2 = arg_159_1.actors_["10059"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps10059 == nil then
				arg_159_1.var_.actorSpriteComps10059 = var_162_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_3 = 0.034

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_3 and not isNil(var_162_2) then
				if arg_159_1.var_.actorSpriteComps10059 then
					for iter_162_1, iter_162_2 in pairs(arg_159_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_162_2 then
							if arg_159_1.isInRecall_ then
								iter_162_2.color = Color.New(Mathf.Lerp(iter_162_2.color.r, arg_159_1.hightColor1.r, (arg_159_1.time_ - 0) / var_162_3), Mathf.Lerp(iter_162_2.color.g, arg_159_1.hightColor1.g, (arg_159_1.time_ - 0) / var_162_3), (Mathf.Lerp(iter_162_2.color.b, arg_159_1.hightColor1.b, (arg_159_1.time_ - 0) / var_162_3)))
							else
								local var_162_4 = Mathf.Lerp(iter_162_2.color.r, 1, (arg_159_1.time_ - 0) / var_162_3)

								iter_162_2.color = Color.New(var_162_4, var_162_4, var_162_4)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_3 and arg_159_1.time_ < 0 + var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps10059 then
				for iter_162_3, iter_162_4 in pairs(arg_159_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_162_4 then
						iter_162_4.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps10059 = nil
			end

			local var_162_5 = arg_159_1.actors_["1061"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.actorSpriteComps1061 == nil then
				arg_159_1.var_.actorSpriteComps1061 = var_162_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_6 = 0.034

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_6 and not isNil(var_162_5) then
				if arg_159_1.var_.actorSpriteComps1061 then
					for iter_162_5, iter_162_6 in pairs(arg_159_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_162_6 then
							if arg_159_1.isInRecall_ then
								iter_162_6.color = Color.New(Mathf.Lerp(iter_162_6.color.r, arg_159_1.hightColor2.r, (arg_159_1.time_ - 0) / var_162_6), Mathf.Lerp(iter_162_6.color.g, arg_159_1.hightColor2.g, (arg_159_1.time_ - 0) / var_162_6), (Mathf.Lerp(iter_162_6.color.b, arg_159_1.hightColor2.b, (arg_159_1.time_ - 0) / var_162_6)))
							else
								local var_162_7 = Mathf.Lerp(iter_162_6.color.r, 0.5, (arg_159_1.time_ - 0) / var_162_6)

								iter_162_6.color = Color.New(var_162_7, var_162_7, var_162_7)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_6 and arg_159_1.time_ < 0 + var_162_6 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.actorSpriteComps1061 then
				for iter_162_7, iter_162_8 in pairs(arg_159_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_162_8 then
						iter_162_8.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps1061 = nil
			end

			local var_162_8 = 0
			local var_162_9 = 0.125

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(410182039)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 5 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 5)

				if (5 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 5)) > 0 and var_162_9 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182039", "story_v_out_410182.awb") ~= 0 then
					local var_162_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182039", "story_v_out_410182.awb") / 1000

					if var_162_14 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_8
					end

					if var_162_10.prefab_name ~= "" and arg_159_1.actors_[var_162_10.prefab_name] ~= nil then
						local var_162_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_10.prefab_name].transform, "story_v_out_410182", "410182039", "story_v_out_410182.awb")

						arg_159_1:RecordAudio("410182039", var_162_15)
						arg_159_1:RecordAudio("410182039", var_162_15)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_410182", "410182039", "story_v_out_410182.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_410182", "410182039", "story_v_out_410182.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_16 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_16 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_16

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_16 and arg_159_1.time_ < var_162_8 + var_162_16 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play410182040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 410182040
		arg_163_1.duration_ = 5.27

		local var_163_0 = {
			ja = 5.266,
			CriLanguages = 4.533,
			zh = 4.533
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
				arg_163_0:Play410182041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1061 = arg_163_1.actors_["1061"].transform.localPosition
				arg_163_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1061", 4)

				for iter_166_0 = 0, arg_163_1.actors_["1061"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["1061"].transform:GetChild(iter_166_0)

					if var_166_0.name == "" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_166_2 = arg_163_1.actors_["10059"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10059 == nil then
				arg_163_1.var_.actorSpriteComps10059 = var_166_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_3 = 0.034

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.actorSpriteComps10059 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								iter_166_2.color = Color.New(Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor2.r, (arg_163_1.time_ - 0) / var_166_3), Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor2.g, (arg_163_1.time_ - 0) / var_166_3), (Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor2.b, (arg_163_1.time_ - 0) / var_166_3)))
							else
								local var_166_4 = Mathf.Lerp(iter_166_2.color.r, 0.5, (arg_163_1.time_ - 0) / var_166_3)

								iter_166_2.color = Color.New(var_166_4, var_166_4, var_166_4)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10059 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_166_4 then
						iter_166_4.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps10059 = nil
			end

			local var_166_5 = arg_163_1.actors_["1061"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.actorSpriteComps1061 == nil then
				arg_163_1.var_.actorSpriteComps1061 = var_166_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_6 = 0.034

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_6 and not isNil(var_166_5) then
				if arg_163_1.var_.actorSpriteComps1061 then
					for iter_166_5, iter_166_6 in pairs(arg_163_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_166_6 then
							if arg_163_1.isInRecall_ then
								iter_166_6.color = Color.New(Mathf.Lerp(iter_166_6.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_6), Mathf.Lerp(iter_166_6.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_6), (Mathf.Lerp(iter_166_6.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_6)))
							else
								local var_166_7 = Mathf.Lerp(iter_166_6.color.r, 1, (arg_163_1.time_ - 0) / var_166_6)

								iter_166_6.color = Color.New(var_166_7, var_166_7, var_166_7)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_6 and arg_163_1.time_ < 0 + var_166_6 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.actorSpriteComps1061 then
				for iter_166_7, iter_166_8 in pairs(arg_163_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_166_8 then
						iter_166_8.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps1061 = nil
			end

			local var_166_8 = 0
			local var_166_9 = 0.575

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(410182040)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 23 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 23)

				if (23 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 23)) > 0 and var_166_9 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182040", "story_v_out_410182.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182040", "story_v_out_410182.awb") / 1000

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end

					if var_166_10.prefab_name ~= "" and arg_163_1.actors_[var_166_10.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_10.prefab_name].transform, "story_v_out_410182", "410182040", "story_v_out_410182.awb")

						arg_163_1:RecordAudio("410182040", var_166_15)
						arg_163_1:RecordAudio("410182040", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_410182", "410182040", "story_v_out_410182.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_410182", "410182040", "story_v_out_410182.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_16 and arg_163_1.time_ < var_166_8 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 410182041
		arg_167_1.duration_ = 1.5

		local var_167_0 = {
			ja = 1.4,
			CriLanguages = 1.5,
			zh = 1.366
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
				arg_167_0:Play410182042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10059 = arg_167_1.actors_["10059"].transform.localPosition
				arg_167_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10059", 2)

				for iter_170_0 = 0, arg_167_1.actors_["10059"].transform.childCount - 1 do
					local var_170_0 = arg_167_1.actors_["10059"].transform:GetChild(iter_170_0)

					if var_170_0.name == "" or not string.find(var_170_0.name, "split") then
						var_170_0.gameObject:SetActive(true)
					else
						var_170_0.gameObject:SetActive(false)
					end
				end
			end

			local var_170_1 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				arg_167_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_167_1.time_ - 0) / var_170_1)
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 then
				arg_167_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_170_2 = arg_167_1.actors_["10059"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10059 == nil then
				arg_167_1.var_.actorSpriteComps10059 = var_170_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_3 = 0.034

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.actorSpriteComps10059 then
					for iter_170_1, iter_170_2 in pairs(arg_167_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_170_2 then
							if arg_167_1.isInRecall_ then
								iter_170_2.color = Color.New(Mathf.Lerp(iter_170_2.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_3), Mathf.Lerp(iter_170_2.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_3), (Mathf.Lerp(iter_170_2.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_3)))
							else
								local var_170_4 = Mathf.Lerp(iter_170_2.color.r, 1, (arg_167_1.time_ - 0) / var_170_3)

								iter_170_2.color = Color.New(var_170_4, var_170_4, var_170_4)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10059 then
				for iter_170_3, iter_170_4 in pairs(arg_167_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_170_4 then
						iter_170_4.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps10059 = nil
			end

			local var_170_5 = arg_167_1.actors_["1061"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.actorSpriteComps1061 == nil then
				arg_167_1.var_.actorSpriteComps1061 = var_170_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_6 = 0.034

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 and not isNil(var_170_5) then
				if arg_167_1.var_.actorSpriteComps1061 then
					for iter_170_5, iter_170_6 in pairs(arg_167_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_170_6 then
							if arg_167_1.isInRecall_ then
								iter_170_6.color = Color.New(Mathf.Lerp(iter_170_6.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_6), Mathf.Lerp(iter_170_6.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_6), (Mathf.Lerp(iter_170_6.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_6)))
							else
								local var_170_7 = Mathf.Lerp(iter_170_6.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_6)

								iter_170_6.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.actorSpriteComps1061 then
				for iter_170_7, iter_170_8 in pairs(arg_167_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_170_8 then
						iter_170_8.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps1061 = nil
			end

			local var_170_8 = 0
			local var_170_9 = 0.125

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(410182041)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 5 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 5)

				if (5 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 5)) > 0 and var_170_9 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182041", "story_v_out_410182.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182041", "story_v_out_410182.awb") / 1000

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_410182", "410182041", "story_v_out_410182.awb")

						arg_167_1:RecordAudio("410182041", var_170_15)
						arg_167_1:RecordAudio("410182041", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_410182", "410182041", "story_v_out_410182.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_410182", "410182041", "story_v_out_410182.awb")
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
				actorName = "10059",
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
	Play410182042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 410182042
		arg_171_1.duration_ = 11.33

		local var_171_0 = {
			ja = 11.333,
			CriLanguages = 6.8,
			zh = 6.8
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
				arg_171_0:Play410182043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1061 = arg_171_1.actors_["1061"].transform.localPosition
				arg_171_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1061", 4)

				for iter_174_0 = 0, arg_171_1.actors_["1061"].transform.childCount - 1 do
					local var_174_0 = arg_171_1.actors_["1061"].transform:GetChild(iter_174_0)

					if var_174_0.name == "" or not string.find(var_174_0.name, "split") then
						var_174_0.gameObject:SetActive(true)
					else
						var_174_0.gameObject:SetActive(false)
					end
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_171_1.time_ - 0) / var_174_1)
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_174_2 = arg_171_1.actors_["10059"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10059 == nil then
				arg_171_1.var_.actorSpriteComps10059 = var_174_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_3 = 0.034

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.actorSpriteComps10059 then
					for iter_174_1, iter_174_2 in pairs(arg_171_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_174_2 then
							if arg_171_1.isInRecall_ then
								iter_174_2.color = Color.New(Mathf.Lerp(iter_174_2.color.r, arg_171_1.hightColor2.r, (arg_171_1.time_ - 0) / var_174_3), Mathf.Lerp(iter_174_2.color.g, arg_171_1.hightColor2.g, (arg_171_1.time_ - 0) / var_174_3), (Mathf.Lerp(iter_174_2.color.b, arg_171_1.hightColor2.b, (arg_171_1.time_ - 0) / var_174_3)))
							else
								local var_174_4 = Mathf.Lerp(iter_174_2.color.r, 0.5, (arg_171_1.time_ - 0) / var_174_3)

								iter_174_2.color = Color.New(var_174_4, var_174_4, var_174_4)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10059 then
				for iter_174_3, iter_174_4 in pairs(arg_171_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_174_4 then
						iter_174_4.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps10059 = nil
			end

			local var_174_5 = arg_171_1.actors_["1061"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.actorSpriteComps1061 == nil then
				arg_171_1.var_.actorSpriteComps1061 = var_174_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_6 = 0.034

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_6 and not isNil(var_174_5) then
				if arg_171_1.var_.actorSpriteComps1061 then
					for iter_174_5, iter_174_6 in pairs(arg_171_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_174_6 then
							if arg_171_1.isInRecall_ then
								iter_174_6.color = Color.New(Mathf.Lerp(iter_174_6.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_6), Mathf.Lerp(iter_174_6.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_6), (Mathf.Lerp(iter_174_6.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_6)))
							else
								local var_174_7 = Mathf.Lerp(iter_174_6.color.r, 1, (arg_171_1.time_ - 0) / var_174_6)

								iter_174_6.color = Color.New(var_174_7, var_174_7, var_174_7)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_6 and arg_171_1.time_ < 0 + var_174_6 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.actorSpriteComps1061 then
				for iter_174_7, iter_174_8 in pairs(arg_171_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_174_8 then
						iter_174_8.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps1061 = nil
			end

			local var_174_8 = 0
			local var_174_9 = 0.85

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(410182042)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 34 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 34)

				if (34 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 34)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182042", "story_v_out_410182.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182042", "story_v_out_410182.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_410182", "410182042", "story_v_out_410182.awb")

						arg_171_1:RecordAudio("410182042", var_174_15)
						arg_171_1:RecordAudio("410182042", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_410182", "410182042", "story_v_out_410182.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_410182", "410182042", "story_v_out_410182.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_16 and arg_171_1.time_ < var_174_8 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play410182043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 410182043
		arg_175_1.duration_ = 11.53

		local var_175_0 = {
			ja = 11.533,
			CriLanguages = 9.566,
			zh = 9.566
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
				arg_175_0:Play410182044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1061 = arg_175_1.actors_["1061"].transform.localPosition
				arg_175_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1061", 4)

				for iter_178_0 = 0, arg_175_1.actors_["1061"].transform.childCount - 1 do
					local var_178_0 = arg_175_1.actors_["1061"].transform:GetChild(iter_178_0)

					if var_178_0.name == "" or not string.find(var_178_0.name, "split") then
						var_178_0.gameObject:SetActive(true)
					else
						var_178_0.gameObject:SetActive(false)
					end
				end
			end

			local var_178_1 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_1 then
				arg_175_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_175_1.time_ - 0) / var_178_1)
			end

			if arg_175_1.time_ >= 0 + var_178_1 and arg_175_1.time_ < 0 + var_178_1 + arg_178_0 then
				arg_175_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_178_2 = arg_175_1.actors_["1061"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1061 == nil then
				arg_175_1.var_.actorSpriteComps1061 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 0.034

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps1061 then
					for iter_178_1, iter_178_2 in pairs(arg_175_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_178_2 then
							if arg_175_1.isInRecall_ then
								iter_178_2.color = Color.New(Mathf.Lerp(iter_178_2.color.r, arg_175_1.hightColor1.r, (arg_175_1.time_ - 0) / var_178_3), Mathf.Lerp(iter_178_2.color.g, arg_175_1.hightColor1.g, (arg_175_1.time_ - 0) / var_178_3), (Mathf.Lerp(iter_178_2.color.b, arg_175_1.hightColor1.b, (arg_175_1.time_ - 0) / var_178_3)))
							else
								local var_178_4 = Mathf.Lerp(iter_178_2.color.r, 1, (arg_175_1.time_ - 0) / var_178_3)

								iter_178_2.color = Color.New(var_178_4, var_178_4, var_178_4)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1061 then
				for iter_178_3, iter_178_4 in pairs(arg_175_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_178_4 then
						iter_178_4.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps1061 = nil
			end

			local var_178_5 = 0
			local var_178_6 = 1.2

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_7 = arg_175_1:GetWordFromCfg(410182043)
				local var_178_8 = arg_175_1:FormatText(var_178_7.content)

				arg_175_1.text_.text = var_178_8

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_10 = 48 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 48)

				if (48 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 48)) > 0 and var_178_6 < var_178_10 then
					arg_175_1.talkMaxDuration = var_178_10

					if var_178_10 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_5
					end
				end

				arg_175_1.text_.text = var_178_8
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182043", "story_v_out_410182.awb") ~= 0 then
					local var_178_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182043", "story_v_out_410182.awb") / 1000

					if var_178_11 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_5
					end

					if var_178_7.prefab_name ~= "" and arg_175_1.actors_[var_178_7.prefab_name] ~= nil then
						local var_178_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_7.prefab_name].transform, "story_v_out_410182", "410182043", "story_v_out_410182.awb")

						arg_175_1:RecordAudio("410182043", var_178_12)
						arg_175_1:RecordAudio("410182043", var_178_12)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_410182", "410182043", "story_v_out_410182.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_410182", "410182043", "story_v_out_410182.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_13 = math.max(var_178_6, arg_175_1.talkMaxDuration)

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_13 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_5) / var_178_13

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_5 + var_178_13 and arg_175_1.time_ < var_178_5 + var_178_13 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 410182044
		arg_179_1.duration_ = 4.1

		local var_179_0 = {
			ja = 4.1,
			CriLanguages = 1.4,
			zh = 2.433
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
				arg_179_0:Play410182045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10059 = arg_179_1.actors_["10059"].transform.localPosition
				arg_179_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10059", 2)

				for iter_182_0 = 0, arg_179_1.actors_["10059"].transform.childCount - 1 do
					local var_182_0 = arg_179_1.actors_["10059"].transform:GetChild(iter_182_0)

					if var_182_0.name == "" or not string.find(var_182_0.name, "split") then
						var_182_0.gameObject:SetActive(true)
					else
						var_182_0.gameObject:SetActive(false)
					end
				end
			end

			local var_182_1 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 then
				arg_179_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10059, Vector3.New(-390, -530, 35), (arg_179_1.time_ - 0) / var_182_1)
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["10059"].transform.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_182_2 = arg_179_1.actors_["10059"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps10059 == nil then
				arg_179_1.var_.actorSpriteComps10059 = var_182_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_3 = 0.034

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.actorSpriteComps10059 then
					for iter_182_1, iter_182_2 in pairs(arg_179_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_182_2 then
							if arg_179_1.isInRecall_ then
								iter_182_2.color = Color.New(Mathf.Lerp(iter_182_2.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_3), Mathf.Lerp(iter_182_2.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_3), (Mathf.Lerp(iter_182_2.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_3)))
							else
								local var_182_4 = Mathf.Lerp(iter_182_2.color.r, 1, (arg_179_1.time_ - 0) / var_182_3)

								iter_182_2.color = Color.New(var_182_4, var_182_4, var_182_4)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps10059 then
				for iter_182_3, iter_182_4 in pairs(arg_179_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_182_4 then
						iter_182_4.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps10059 = nil
			end

			local var_182_5 = arg_179_1.actors_["1061"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.actorSpriteComps1061 == nil then
				arg_179_1.var_.actorSpriteComps1061 = var_182_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_6 = 0.034

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_6 and not isNil(var_182_5) then
				if arg_179_1.var_.actorSpriteComps1061 then
					for iter_182_5, iter_182_6 in pairs(arg_179_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_182_6 then
							if arg_179_1.isInRecall_ then
								iter_182_6.color = Color.New(Mathf.Lerp(iter_182_6.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_6), Mathf.Lerp(iter_182_6.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_6), (Mathf.Lerp(iter_182_6.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_6)))
							else
								local var_182_7 = Mathf.Lerp(iter_182_6.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_6)

								iter_182_6.color = Color.New(var_182_7, var_182_7, var_182_7)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_6 and arg_179_1.time_ < 0 + var_182_6 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.actorSpriteComps1061 then
				for iter_182_7, iter_182_8 in pairs(arg_179_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_182_8 then
						iter_182_8.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps1061 = nil
			end

			local var_182_8 = 0
			local var_182_9 = 0.3

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(410182044)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 12 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 12)

				if (12 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 12)) > 0 and var_182_9 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182044", "story_v_out_410182.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_410182", "410182044", "story_v_out_410182.awb") / 1000

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end

					if var_182_10.prefab_name ~= "" and arg_179_1.actors_[var_182_10.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_10.prefab_name].transform, "story_v_out_410182", "410182044", "story_v_out_410182.awb")

						arg_179_1:RecordAudio("410182044", var_182_15)
						arg_179_1:RecordAudio("410182044", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_410182", "410182044", "story_v_out_410182.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_410182", "410182044", "story_v_out_410182.awb")
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
				actorName = "10059",
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
	Play410182045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 410182045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play410182046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["10059"]) and arg_183_1.var_.actorSpriteComps10059 == nil then
				arg_183_1.var_.actorSpriteComps10059 = arg_183_1.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_0 = 0.034

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["10059"]) then
				if arg_183_1.var_.actorSpriteComps10059 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								iter_186_1.color = Color.New(Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_0), Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_0), (Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_0)))
							else
								local var_186_1 = Mathf.Lerp(iter_186_1.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_0)

								iter_186_1.color = Color.New(var_186_1, var_186_1, var_186_1)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["10059"]) and arg_183_1.var_.actorSpriteComps10059 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_186_3 then
						iter_186_3.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps10059 = nil
			end

			local var_186_2 = 0
			local var_186_3 = 0.475

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_2 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_4 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(410182045).content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_6 = 19 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_4) / 19)

				if (19 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_4) / 19)) > 0 and var_186_3 < var_186_6 then
					arg_183_1.talkMaxDuration = var_186_6

					if var_186_6 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_2
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_3, arg_183_1.talkMaxDuration)

			if var_186_2 <= arg_183_1.time_ and arg_183_1.time_ < var_186_2 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_2) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_2 + var_186_7 and arg_183_1.time_ < var_186_2 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play410182046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 410182046
		arg_187_1.duration_ = 3.23

		local var_187_0 = {
			ja = 2.866,
			CriLanguages = 3.233,
			zh = 3.233
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
				arg_187_0:Play410182047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1061 = arg_187_1.actors_["1061"].transform.localPosition
				arg_187_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1061", 4)

				for iter_190_0 = 0, arg_187_1.actors_["1061"].transform.childCount - 1 do
					local var_190_0 = arg_187_1.actors_["1061"].transform:GetChild(iter_190_0)

					if var_190_0.name == "" or not string.find(var_190_0.name, "split") then
						var_190_0.gameObject:SetActive(true)
					else
						var_190_0.gameObject:SetActive(false)
					end
				end
			end

			local var_190_1 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 then
				arg_187_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_187_1.time_ - 0) / var_190_1)
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 then
				arg_187_1.actors_["1061"].transform.localPosition = Vector3.New(390, -490, 18)
			end

			local var_190_2 = arg_187_1.actors_["1061"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.actorSpriteComps1061 == nil then
				arg_187_1.var_.actorSpriteComps1061 = var_190_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_3 = 0.034

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 and not isNil(var_190_2) then
				if arg_187_1.var_.actorSpriteComps1061 then
					for iter_190_1, iter_190_2 in pairs(arg_187_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_190_2 then
							if arg_187_1.isInRecall_ then
								iter_190_2.color = Color.New(Mathf.Lerp(iter_190_2.color.r, arg_187_1.hightColor1.r, (arg_187_1.time_ - 0) / var_190_3), Mathf.Lerp(iter_190_2.color.g, arg_187_1.hightColor1.g, (arg_187_1.time_ - 0) / var_190_3), (Mathf.Lerp(iter_190_2.color.b, arg_187_1.hightColor1.b, (arg_187_1.time_ - 0) / var_190_3)))
							else
								local var_190_4 = Mathf.Lerp(iter_190_2.color.r, 1, (arg_187_1.time_ - 0) / var_190_3)

								iter_190_2.color = Color.New(var_190_4, var_190_4, var_190_4)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.actorSpriteComps1061 then
				for iter_190_3, iter_190_4 in pairs(arg_187_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_190_4 then
						iter_190_4.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_187_1.var_.actorSpriteComps1061 = nil
			end

			local var_190_5 = 0
			local var_190_6 = 0.3

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_7 = arg_187_1:GetWordFromCfg(410182046)
				local var_190_8 = arg_187_1:FormatText(var_190_7.content)

				arg_187_1.text_.text = var_190_8

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_10 = 12 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_8) / 12)

				if (12 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_8) / 12)) > 0 and var_190_6 < var_190_10 then
					arg_187_1.talkMaxDuration = var_190_10

					if var_190_10 + var_190_5 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_5
					end
				end

				arg_187_1.text_.text = var_190_8
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182046", "story_v_out_410182.awb") ~= 0 then
					local var_190_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182046", "story_v_out_410182.awb") / 1000

					if var_190_11 + var_190_5 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_11 + var_190_5
					end

					if var_190_7.prefab_name ~= "" and arg_187_1.actors_[var_190_7.prefab_name] ~= nil then
						local var_190_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_7.prefab_name].transform, "story_v_out_410182", "410182046", "story_v_out_410182.awb")

						arg_187_1:RecordAudio("410182046", var_190_12)
						arg_187_1:RecordAudio("410182046", var_190_12)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_410182", "410182046", "story_v_out_410182.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_410182", "410182046", "story_v_out_410182.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_13 = math.max(var_190_6, arg_187_1.talkMaxDuration)

			if var_190_5 <= arg_187_1.time_ and arg_187_1.time_ < var_190_5 + var_190_13 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_5) / var_190_13

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_5 + var_190_13 and arg_187_1.time_ < var_190_5 + var_190_13 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 410182047
		arg_191_1.duration_ = 9

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play410182048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if arg_191_1.bgs_.ST64a == nil then
				local var_194_0 = Object.Instantiate(arg_191_1.paintGo_)

				var_194_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST64a")
				var_194_0.name = "ST64a"
				var_194_0.transform.parent = arg_191_1.stage_.transform
				var_194_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.bgs_.ST64a = var_194_0
			end

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= 2 + arg_194_0 then
				local var_194_1 = arg_191_1.bgs_.ST64a

				arg_191_1.bgs_.ST64a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_194_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_2 = var_194_1:GetComponent("SpriteRenderer")

				if var_194_2 and var_194_2.sprite then
					local var_194_3 = 2 * (var_194_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_194_1.transform.localScale = Vector3.New(var_194_3 / var_194_2.sprite.bounds.size.y < var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x and var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x or var_194_3 / var_194_2.sprite.bounds.size.y, var_194_3 / var_194_2.sprite.bounds.size.y < var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x and var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x or var_194_3 / var_194_2.sprite.bounds.size.y, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "ST64a" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_4 = 0

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_5 = 2

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_5 then
				local var_194_6 = Color.New(0, 0, 0)

				var_194_6.a = Mathf.Lerp(0, 1, (arg_191_1.time_ - var_194_4) / var_194_5)
				arg_191_1.mask_.color = var_194_6
			end

			if arg_191_1.time_ >= var_194_4 + var_194_5 and arg_191_1.time_ < var_194_4 + var_194_5 + arg_194_0 then
				local var_194_7 = Color.New(0, 0, 0)

				var_194_7.a = 1
				arg_191_1.mask_.color = var_194_7
			end

			local var_194_8 = 2

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_9 = 2

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_9 then
				local var_194_10 = Color.New(0, 0, 0)

				var_194_10.a = Mathf.Lerp(1, 0, (arg_191_1.time_ - var_194_8) / var_194_9)
				arg_191_1.mask_.color = var_194_10
			end

			if arg_191_1.time_ >= var_194_8 + var_194_9 and arg_191_1.time_ < var_194_8 + var_194_9 + arg_194_0 then
				local var_194_11 = Color.New(0, 0, 0)

				arg_191_1.mask_.enabled = false
				var_194_11.a = 0
				arg_191_1.mask_.color = var_194_11
			end

			local var_194_12 = arg_191_1.actors_["10059"].transform

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= 2 + arg_194_0 then
				arg_191_1.var_.moveOldPos10059 = var_194_12.localPosition
				var_194_12.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10059", 7)

				for iter_194_2 = 0, var_194_12.childCount - 1 do
					local var_194_13 = var_194_12:GetChild(iter_194_2)

					if var_194_13.name == "" or not string.find(var_194_13.name, "split") then
						var_194_13.gameObject:SetActive(true)
					else
						var_194_13.gameObject:SetActive(false)
					end
				end
			end

			local var_194_14 = 0.001

			if 2 <= arg_191_1.time_ and arg_191_1.time_ < 2 + var_194_14 then
				var_194_12.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_191_1.time_ - 2) / var_194_14)
			end

			if arg_191_1.time_ >= 2 + var_194_14 and arg_191_1.time_ < 2 + var_194_14 + arg_194_0 then
				var_194_12.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_194_15 = arg_191_1.actors_["1061"].transform

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= 2 + arg_194_0 then
				arg_191_1.var_.moveOldPos1061 = var_194_15.localPosition
				var_194_15.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("1061", 7)

				for iter_194_3 = 0, var_194_15.childCount - 1 do
					local var_194_16 = var_194_15:GetChild(iter_194_3)

					if var_194_16.name == "" or not string.find(var_194_16.name, "split") then
						var_194_16.gameObject:SetActive(true)
					else
						var_194_16.gameObject:SetActive(false)
					end
				end
			end

			local var_194_17 = 0.001

			if 2 <= arg_191_1.time_ and arg_191_1.time_ < 2 + var_194_17 then
				var_194_15.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_191_1.time_ - 2) / var_194_17)
			end

			if arg_191_1.time_ >= 2 + var_194_17 and arg_191_1.time_ < 2 + var_194_17 + arg_194_0 then
				var_194_15.localPosition = Vector3.New(0, -2000, 18)
			end

			if arg_191_1.frameCnt_ <= 1 then
				arg_191_1.dialog_:SetActive(false)
			end

			local var_194_18 = 4
			local var_194_19 = 0.975

			if 4 < arg_191_1.time_ and arg_191_1.time_ <= var_194_18 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				arg_191_1.dialog_:SetActive(true)

				arg_191_1.dialogCg_.alpha = 0

				local var_194_20 = LeanTween.value(arg_191_1.dialog_, 0, 1, 0.3)

				var_194_20:setOnUpdate(LuaHelper.FloatAction(function(arg_195_0)
					arg_191_1.dialogCg_.alpha = arg_195_0
				end))
				var_194_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_191_1.dialog_)
					var_194_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_191_1.duration_ = arg_191_1.duration_ + 0.3

				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_21 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(410182047).content)

				arg_191_1.text_.text = var_194_21

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_23 = 39 <= 0 and var_194_19 or var_194_19 * (utf8.len(var_194_21) / 39)

				if (39 <= 0 and var_194_19 or var_194_19 * (utf8.len(var_194_21) / 39)) > 0 and var_194_19 < var_194_23 then
					arg_191_1.talkMaxDuration = var_194_23
					var_194_18 = var_194_18 + 0.3

					if var_194_23 + var_194_18 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_23 + var_194_18
					end
				end

				arg_191_1.text_.text = var_194_21
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_24 = var_194_18 + 0.3
			local var_194_25 = math.max(var_194_19, arg_191_1.talkMaxDuration)

			if var_194_18 + 0.3 <= arg_191_1.time_ and arg_191_1.time_ < var_194_24 + var_194_25 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_24) / var_194_25

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_24 + var_194_25 and arg_191_1.time_ < var_194_24 + var_194_25 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play410182048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410182048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play410182049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 1.15

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(410182048).content)

				arg_197_1.text_.text = var_200_1

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_3 = 46 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 46)

				if (46 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 46)) > 0 and var_200_0 < var_200_3 then
					arg_197_1.talkMaxDuration = var_200_3

					if var_200_3 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_3 + 0
					end
				end

				arg_197_1.text_.text = var_200_1
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_4 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_4

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play410182049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410182049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play410182050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.725

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(410182049).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 69 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 69)

				if (69 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 69)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play410182050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410182050
		arg_205_1.duration_ = 4.13

		local var_205_0 = {
			ja = 4.133,
			CriLanguages = 2.466,
			zh = 2.466
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
				arg_205_0:Play410182051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1061 = arg_205_1.actors_["1061"].transform.localPosition
				arg_205_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1061", 3)

				for iter_208_0 = 0, arg_205_1.actors_["1061"].transform.childCount - 1 do
					local var_208_0 = arg_205_1.actors_["1061"].transform:GetChild(iter_208_0)

					if var_208_0.name == "split_7" or not string.find(var_208_0.name, "split") then
						var_208_0.gameObject:SetActive(true)
					else
						var_208_0.gameObject:SetActive(false)
					end
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_205_1.time_ - 0) / var_208_1)
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_208_2 = arg_205_1.actors_["1061"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps1061 == nil then
				arg_205_1.var_.actorSpriteComps1061 = var_208_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_3 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.actorSpriteComps1061 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								iter_208_2.color = Color.New(Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 0) / var_208_3), Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 0) / var_208_3), (Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 0) / var_208_3)))
							else
								local var_208_4 = Mathf.Lerp(iter_208_2.color.r, 1, (arg_205_1.time_ - 0) / var_208_3)

								iter_208_2.color = Color.New(var_208_4, var_208_4, var_208_4)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps1061 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_208_4 then
						iter_208_4.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps1061 = nil
			end

			local var_208_5 = 0
			local var_208_6 = 0.175

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_7 = arg_205_1:GetWordFromCfg(410182050)
				local var_208_8 = arg_205_1:FormatText(var_208_7.content)

				arg_205_1.text_.text = var_208_8

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_10 = 7 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_8) / 7)

				if (7 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_8) / 7)) > 0 and var_208_6 < var_208_10 then
					arg_205_1.talkMaxDuration = var_208_10

					if var_208_10 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_5
					end
				end

				arg_205_1.text_.text = var_208_8
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182050", "story_v_out_410182.awb") ~= 0 then
					local var_208_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182050", "story_v_out_410182.awb") / 1000

					if var_208_11 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_11 + var_208_5
					end

					if var_208_7.prefab_name ~= "" and arg_205_1.actors_[var_208_7.prefab_name] ~= nil then
						local var_208_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_7.prefab_name].transform, "story_v_out_410182", "410182050", "story_v_out_410182.awb")

						arg_205_1:RecordAudio("410182050", var_208_12)
						arg_205_1:RecordAudio("410182050", var_208_12)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410182", "410182050", "story_v_out_410182.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410182", "410182050", "story_v_out_410182.awb")
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

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play410182051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410182051
		arg_209_1.duration_ = 14.5

		local var_209_0 = {
			ja = 14.5,
			CriLanguages = 6.233,
			zh = 6.233
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
				arg_209_0:Play410182052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1061"]) and arg_209_1.var_.actorSpriteComps1061 == nil then
				arg_209_1.var_.actorSpriteComps1061 = arg_209_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_0 = 0.034

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1061"]) then
				if arg_209_1.var_.actorSpriteComps1061 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								iter_212_1.color = Color.New(Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_0), Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_0), (Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_0)))
							else
								local var_212_1 = Mathf.Lerp(iter_212_1.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_0)

								iter_212_1.color = Color.New(var_212_1, var_212_1, var_212_1)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1061"]) and arg_209_1.var_.actorSpriteComps1061 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps1061 = nil
			end

			local var_212_2 = 0
			local var_212_3 = 0.725

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[609].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_4 = arg_209_1:GetWordFromCfg(410182051)
				local var_212_5 = arg_209_1:FormatText(var_212_4.content)

				arg_209_1.text_.text = var_212_5

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_7 = 29 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 29)

				if (29 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 29)) > 0 and var_212_3 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_2
					end
				end

				arg_209_1.text_.text = var_212_5
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182051", "story_v_out_410182.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_410182", "410182051", "story_v_out_410182.awb") / 1000

					if var_212_8 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_2
					end

					if var_212_4.prefab_name ~= "" and arg_209_1.actors_[var_212_4.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_4.prefab_name].transform, "story_v_out_410182", "410182051", "story_v_out_410182.awb")

						arg_209_1:RecordAudio("410182051", var_212_9)
						arg_209_1:RecordAudio("410182051", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_410182", "410182051", "story_v_out_410182.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_410182", "410182051", "story_v_out_410182.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_3, arg_209_1.talkMaxDuration)

			if var_212_2 <= arg_209_1.time_ and arg_209_1.time_ < var_212_2 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_2) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_2 + var_212_10 and arg_209_1.time_ < var_212_2 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play410182052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410182052
		arg_213_1.duration_ = 10.8

		local var_213_0 = {
			ja = 10.8,
			CriLanguages = 5.666,
			zh = 5.666
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
				arg_213_0:Play410182053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1061 = arg_213_1.actors_["1061"].transform.localPosition
				arg_213_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1061", 3)

				for iter_216_0 = 0, arg_213_1.actors_["1061"].transform.childCount - 1 do
					local var_216_0 = arg_213_1.actors_["1061"].transform:GetChild(iter_216_0)

					if var_216_0.name == "" or not string.find(var_216_0.name, "split") then
						var_216_0.gameObject:SetActive(true)
					else
						var_216_0.gameObject:SetActive(false)
					end
				end
			end

			local var_216_1 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_1 then
				arg_213_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_213_1.time_ - 0) / var_216_1)
			end

			if arg_213_1.time_ >= 0 + var_216_1 and arg_213_1.time_ < 0 + var_216_1 + arg_216_0 then
				arg_213_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_216_2 = arg_213_1.actors_["1061"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps1061 == nil then
				arg_213_1.var_.actorSpriteComps1061 = var_216_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_3 = 0.034

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.actorSpriteComps1061 then
					for iter_216_1, iter_216_2 in pairs(arg_213_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_216_2 then
							if arg_213_1.isInRecall_ then
								iter_216_2.color = Color.New(Mathf.Lerp(iter_216_2.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_3), Mathf.Lerp(iter_216_2.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_3), (Mathf.Lerp(iter_216_2.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_3)))
							else
								local var_216_4 = Mathf.Lerp(iter_216_2.color.r, 1, (arg_213_1.time_ - 0) / var_216_3)

								iter_216_2.color = Color.New(var_216_4, var_216_4, var_216_4)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps1061 then
				for iter_216_3, iter_216_4 in pairs(arg_213_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_216_4 then
						iter_216_4.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps1061 = nil
			end

			local var_216_5 = 0
			local var_216_6 = 0.575

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:GetWordFromCfg(410182052)
				local var_216_8 = arg_213_1:FormatText(var_216_7.content)

				arg_213_1.text_.text = var_216_8

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_10 = 23 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 23)

				if (23 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 23)) > 0 and var_216_6 < var_216_10 then
					arg_213_1.talkMaxDuration = var_216_10

					if var_216_10 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_8
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182052", "story_v_out_410182.awb") ~= 0 then
					local var_216_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182052", "story_v_out_410182.awb") / 1000

					if var_216_11 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_5
					end

					if var_216_7.prefab_name ~= "" and arg_213_1.actors_[var_216_7.prefab_name] ~= nil then
						local var_216_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_7.prefab_name].transform, "story_v_out_410182", "410182052", "story_v_out_410182.awb")

						arg_213_1:RecordAudio("410182052", var_216_12)
						arg_213_1:RecordAudio("410182052", var_216_12)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_410182", "410182052", "story_v_out_410182.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_410182", "410182052", "story_v_out_410182.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_13 = math.max(var_216_6, arg_213_1.talkMaxDuration)

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_13 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_5) / var_216_13

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_5 + var_216_13 and arg_213_1.time_ < var_216_5 + var_216_13 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410182053
		arg_217_1.duration_ = 11.37

		local var_217_0 = {
			ja = 11.366,
			CriLanguages = 8.133,
			zh = 8.133
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
				arg_217_0:Play410182054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1061 = arg_217_1.actors_["1061"].transform.localPosition
				arg_217_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1061", 3)

				for iter_220_0 = 0, arg_217_1.actors_["1061"].transform.childCount - 1 do
					local var_220_0 = arg_217_1.actors_["1061"].transform:GetChild(iter_220_0)

					if var_220_0.name == "" or not string.find(var_220_0.name, "split") then
						var_220_0.gameObject:SetActive(true)
					else
						var_220_0.gameObject:SetActive(false)
					end
				end
			end

			local var_220_1 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 then
				arg_217_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_217_1.time_ - 0) / var_220_1)
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 then
				arg_217_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_220_2 = arg_217_1.actors_["1061"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps1061 == nil then
				arg_217_1.var_.actorSpriteComps1061 = var_220_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_3 = 0.034

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_3 and not isNil(var_220_2) then
				if arg_217_1.var_.actorSpriteComps1061 then
					for iter_220_1, iter_220_2 in pairs(arg_217_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_220_2 then
							if arg_217_1.isInRecall_ then
								iter_220_2.color = Color.New(Mathf.Lerp(iter_220_2.color.r, arg_217_1.hightColor1.r, (arg_217_1.time_ - 0) / var_220_3), Mathf.Lerp(iter_220_2.color.g, arg_217_1.hightColor1.g, (arg_217_1.time_ - 0) / var_220_3), (Mathf.Lerp(iter_220_2.color.b, arg_217_1.hightColor1.b, (arg_217_1.time_ - 0) / var_220_3)))
							else
								local var_220_4 = Mathf.Lerp(iter_220_2.color.r, 1, (arg_217_1.time_ - 0) / var_220_3)

								iter_220_2.color = Color.New(var_220_4, var_220_4, var_220_4)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_3 and arg_217_1.time_ < 0 + var_220_3 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps1061 then
				for iter_220_3, iter_220_4 in pairs(arg_217_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_220_4 then
						iter_220_4.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_217_1.var_.actorSpriteComps1061 = nil
			end

			local var_220_5 = 0
			local var_220_6 = 0.925

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_7 = arg_217_1:GetWordFromCfg(410182053)
				local var_220_8 = arg_217_1:FormatText(var_220_7.content)

				arg_217_1.text_.text = var_220_8

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_10 = 37 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 37)

				if (37 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 37)) > 0 and var_220_6 < var_220_10 then
					arg_217_1.talkMaxDuration = var_220_10

					if var_220_10 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_5
					end
				end

				arg_217_1.text_.text = var_220_8
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182053", "story_v_out_410182.awb") ~= 0 then
					local var_220_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182053", "story_v_out_410182.awb") / 1000

					if var_220_11 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_5
					end

					if var_220_7.prefab_name ~= "" and arg_217_1.actors_[var_220_7.prefab_name] ~= nil then
						local var_220_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_7.prefab_name].transform, "story_v_out_410182", "410182053", "story_v_out_410182.awb")

						arg_217_1:RecordAudio("410182053", var_220_12)
						arg_217_1:RecordAudio("410182053", var_220_12)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_410182", "410182053", "story_v_out_410182.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_410182", "410182053", "story_v_out_410182.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_13 = math.max(var_220_6, arg_217_1.talkMaxDuration)

			if var_220_5 <= arg_217_1.time_ and arg_217_1.time_ < var_220_5 + var_220_13 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_5) / var_220_13

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_5 + var_220_13 and arg_217_1.time_ < var_220_5 + var_220_13 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410182054
		arg_221_1.duration_ = 12.53

		local var_221_0 = {
			ja = 12.533,
			CriLanguages = 4.3,
			zh = 4.3
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
				arg_221_0:Play410182055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1061"]) and arg_221_1.var_.actorSpriteComps1061 == nil then
				arg_221_1.var_.actorSpriteComps1061 = arg_221_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_0 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1061"]) then
				if arg_221_1.var_.actorSpriteComps1061 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1061"]) and arg_221_1.var_.actorSpriteComps1061 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_224_3 then
						iter_224_3.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps1061 = nil
			end

			local var_224_2 = 0
			local var_224_3 = 0.45

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[609].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_4 = arg_221_1:GetWordFromCfg(410182054)
				local var_224_5 = arg_221_1:FormatText(var_224_4.content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 18 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 18)

				if (18 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 18)) > 0 and var_224_3 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182054", "story_v_out_410182.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_410182", "410182054", "story_v_out_410182.awb") / 1000

					if var_224_8 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_2
					end

					if var_224_4.prefab_name ~= "" and arg_221_1.actors_[var_224_4.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_4.prefab_name].transform, "story_v_out_410182", "410182054", "story_v_out_410182.awb")

						arg_221_1:RecordAudio("410182054", var_224_9)
						arg_221_1:RecordAudio("410182054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410182", "410182054", "story_v_out_410182.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410182", "410182054", "story_v_out_410182.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_10 and arg_221_1.time_ < var_224_2 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play410182055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410182055
		arg_225_1.duration_ = 8.9

		local var_225_0 = {
			ja = 8.9,
			CriLanguages = 4.233,
			zh = 4.233
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
				arg_225_0:Play410182056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.425

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[608].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_a")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:GetWordFromCfg(410182055)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 17 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 17)

				if (17 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 17)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182055", "story_v_out_410182.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_410182", "410182055", "story_v_out_410182.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_410182", "410182055", "story_v_out_410182.awb")

						arg_225_1:RecordAudio("410182055", var_228_6)
						arg_225_1:RecordAudio("410182055", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_410182", "410182055", "story_v_out_410182.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_410182", "410182055", "story_v_out_410182.awb")
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
	Play410182056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410182056
		arg_229_1.duration_ = 12.2

		local var_229_0 = {
			ja = 12.2,
			CriLanguages = 7.333,
			zh = 7.333
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
				arg_229_0:Play410182057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.825

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[609].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:GetWordFromCfg(410182056)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 33 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 33)

				if (33 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 33)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182056", "story_v_out_410182.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_410182", "410182056", "story_v_out_410182.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_410182", "410182056", "story_v_out_410182.awb")

						arg_229_1:RecordAudio("410182056", var_232_6)
						arg_229_1:RecordAudio("410182056", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_410182", "410182056", "story_v_out_410182.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_410182", "410182056", "story_v_out_410182.awb")
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
	Play410182057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410182057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play410182058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.825

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(410182057).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 33 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 33)

				if (33 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 33)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play410182058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410182058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play410182059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1061 = arg_237_1.actors_["1061"].transform.localPosition
				arg_237_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1061", 7)

				for iter_240_0 = 0, arg_237_1.actors_["1061"].transform.childCount - 1 do
					local var_240_0 = arg_237_1.actors_["1061"].transform:GetChild(iter_240_0)

					if var_240_0.name == "split_7" or not string.find(var_240_0.name, "split") then
						var_240_0.gameObject:SetActive(true)
					else
						var_240_0.gameObject:SetActive(false)
					end
				end
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				arg_237_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_237_1.time_ - 0) / var_240_1)
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				arg_237_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_240_2 = manager.ui.mainCamera.transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.shakeOldPos = var_240_2.localPosition
			end

			local var_240_3 = 0.5

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 then
				local var_240_4, var_240_5 = math.modf((arg_237_1.time_ - 0) / 0.066)

				var_240_2.localPosition = Vector3.New(var_240_5 * 0.13, var_240_5 * 0.13, var_240_5 * 0.13) + arg_237_1.var_.shakeOldPos
			end

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 then
				var_240_2.localPosition = arg_237_1.var_.shakeOldPos
			end

			local var_240_6 = 0

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.allBtn_.enabled = false
			end

			if arg_237_1.time_ >= var_240_6 + 0.5 and arg_237_1.time_ < var_240_6 + 0.5 + arg_240_0 then
				arg_237_1.allBtn_.enabled = true
			end

			local var_240_7 = 0
			local var_240_8 = 1.075

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_7 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_9 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(410182058).content)

				arg_237_1.text_.text = var_240_9

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 43 <= 0 and var_240_8 or var_240_8 * (utf8.len(var_240_9) / 43)

				if (43 <= 0 and var_240_8 or var_240_8 * (utf8.len(var_240_9) / 43)) > 0 and var_240_8 < var_240_11 then
					arg_237_1.talkMaxDuration = var_240_11

					if var_240_11 + var_240_7 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_11 + var_240_7
					end
				end

				arg_237_1.text_.text = var_240_9
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_8, arg_237_1.talkMaxDuration)

			if var_240_7 <= arg_237_1.time_ and arg_237_1.time_ < var_240_7 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_7) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_7 + var_240_12 and arg_237_1.time_ < var_240_7 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410182059
		arg_241_1.duration_ = 3.47

		local var_241_0 = {
			ja = 3.466,
			CriLanguages = 2.6,
			zh = 2.6
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
				arg_241_0:Play410182060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.2

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[608].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_a")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_1 = arg_241_1:GetWordFromCfg(410182059)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 8 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 8)

				if (8 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 8)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182059", "story_v_out_410182.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_410182", "410182059", "story_v_out_410182.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_410182", "410182059", "story_v_out_410182.awb")

						arg_241_1:RecordAudio("410182059", var_244_6)
						arg_241_1:RecordAudio("410182059", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_410182", "410182059", "story_v_out_410182.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_410182", "410182059", "story_v_out_410182.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play410182060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410182060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play410182061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 1.05

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(410182060).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 42 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 42)

				if (42 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 42)) > 0 and var_248_0 < var_248_3 then
					arg_245_1.talkMaxDuration = var_248_3

					if var_248_3 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_3 + 0
					end
				end

				arg_245_1.text_.text = var_248_1
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_4 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_4

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play410182061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410182061
		arg_249_1.duration_ = 11.53

		local var_249_0 = {
			ja = 11.533,
			CriLanguages = 5.666,
			zh = 5.666
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
				arg_249_0:Play410182062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1061 = arg_249_1.actors_["1061"].transform.localPosition
				arg_249_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1061", 3)

				for iter_252_0 = 0, arg_249_1.actors_["1061"].transform.childCount - 1 do
					local var_252_0 = arg_249_1.actors_["1061"].transform:GetChild(iter_252_0)

					if var_252_0.name == "" or not string.find(var_252_0.name, "split") then
						var_252_0.gameObject:SetActive(true)
					else
						var_252_0.gameObject:SetActive(false)
					end
				end
			end

			local var_252_1 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 then
				arg_249_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_249_1.time_ - 0) / var_252_1)
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 then
				arg_249_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_252_2 = arg_249_1.actors_["1061"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps1061 == nil then
				arg_249_1.var_.actorSpriteComps1061 = var_252_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_3 = 0.034

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 and not isNil(var_252_2) then
				if arg_249_1.var_.actorSpriteComps1061 then
					for iter_252_1, iter_252_2 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_252_2 then
							if arg_249_1.isInRecall_ then
								iter_252_2.color = Color.New(Mathf.Lerp(iter_252_2.color.r, arg_249_1.hightColor1.r, (arg_249_1.time_ - 0) / var_252_3), Mathf.Lerp(iter_252_2.color.g, arg_249_1.hightColor1.g, (arg_249_1.time_ - 0) / var_252_3), (Mathf.Lerp(iter_252_2.color.b, arg_249_1.hightColor1.b, (arg_249_1.time_ - 0) / var_252_3)))
							else
								local var_252_4 = Mathf.Lerp(iter_252_2.color.r, 1, (arg_249_1.time_ - 0) / var_252_3)

								iter_252_2.color = Color.New(var_252_4, var_252_4, var_252_4)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps1061 then
				for iter_252_3, iter_252_4 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_252_4 then
						iter_252_4.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps1061 = nil
			end

			local var_252_5 = 0
			local var_252_6 = 0.575

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_7 = arg_249_1:GetWordFromCfg(410182061)
				local var_252_8 = arg_249_1:FormatText(var_252_7.content)

				arg_249_1.text_.text = var_252_8

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_10 = 23 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 23)

				if (23 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 23)) > 0 and var_252_6 < var_252_10 then
					arg_249_1.talkMaxDuration = var_252_10

					if var_252_10 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_5
					end
				end

				arg_249_1.text_.text = var_252_8
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182061", "story_v_out_410182.awb") ~= 0 then
					local var_252_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182061", "story_v_out_410182.awb") / 1000

					if var_252_11 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_5
					end

					if var_252_7.prefab_name ~= "" and arg_249_1.actors_[var_252_7.prefab_name] ~= nil then
						local var_252_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_7.prefab_name].transform, "story_v_out_410182", "410182061", "story_v_out_410182.awb")

						arg_249_1:RecordAudio("410182061", var_252_12)
						arg_249_1:RecordAudio("410182061", var_252_12)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410182", "410182061", "story_v_out_410182.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410182", "410182061", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410182062
		arg_253_1.duration_ = 14.8

		local var_253_0 = {
			ja = 14.8,
			CriLanguages = 11.1,
			zh = 11.1
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
				arg_253_0:Play410182063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1061 = arg_253_1.actors_["1061"].transform.localPosition
				arg_253_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1061", 3)

				for iter_256_0 = 0, arg_253_1.actors_["1061"].transform.childCount - 1 do
					local var_256_0 = arg_253_1.actors_["1061"].transform:GetChild(iter_256_0)

					if var_256_0.name == "" or not string.find(var_256_0.name, "split") then
						var_256_0.gameObject:SetActive(true)
					else
						var_256_0.gameObject:SetActive(false)
					end
				end
			end

			local var_256_1 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_1 then
				arg_253_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_253_1.time_ - 0) / var_256_1)
			end

			if arg_253_1.time_ >= 0 + var_256_1 and arg_253_1.time_ < 0 + var_256_1 + arg_256_0 then
				arg_253_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_256_2 = arg_253_1.actors_["1061"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1061 == nil then
				arg_253_1.var_.actorSpriteComps1061 = var_256_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_3 = 0.034

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.actorSpriteComps1061 then
					for iter_256_1, iter_256_2 in pairs(arg_253_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_256_2 then
							if arg_253_1.isInRecall_ then
								iter_256_2.color = Color.New(Mathf.Lerp(iter_256_2.color.r, arg_253_1.hightColor1.r, (arg_253_1.time_ - 0) / var_256_3), Mathf.Lerp(iter_256_2.color.g, arg_253_1.hightColor1.g, (arg_253_1.time_ - 0) / var_256_3), (Mathf.Lerp(iter_256_2.color.b, arg_253_1.hightColor1.b, (arg_253_1.time_ - 0) / var_256_3)))
							else
								local var_256_4 = Mathf.Lerp(iter_256_2.color.r, 1, (arg_253_1.time_ - 0) / var_256_3)

								iter_256_2.color = Color.New(var_256_4, var_256_4, var_256_4)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1061 then
				for iter_256_3, iter_256_4 in pairs(arg_253_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_256_4 then
						iter_256_4.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_253_1.var_.actorSpriteComps1061 = nil
			end

			local var_256_5 = 0
			local var_256_6 = 1.225

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_7 = arg_253_1:GetWordFromCfg(410182062)
				local var_256_8 = arg_253_1:FormatText(var_256_7.content)

				arg_253_1.text_.text = var_256_8

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_10 = 49 <= 0 and var_256_6 or var_256_6 * (utf8.len(var_256_8) / 49)

				if (49 <= 0 and var_256_6 or var_256_6 * (utf8.len(var_256_8) / 49)) > 0 and var_256_6 < var_256_10 then
					arg_253_1.talkMaxDuration = var_256_10

					if var_256_10 + var_256_5 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_5
					end
				end

				arg_253_1.text_.text = var_256_8
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182062", "story_v_out_410182.awb") ~= 0 then
					local var_256_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182062", "story_v_out_410182.awb") / 1000

					if var_256_11 + var_256_5 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_11 + var_256_5
					end

					if var_256_7.prefab_name ~= "" and arg_253_1.actors_[var_256_7.prefab_name] ~= nil then
						local var_256_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_7.prefab_name].transform, "story_v_out_410182", "410182062", "story_v_out_410182.awb")

						arg_253_1:RecordAudio("410182062", var_256_12)
						arg_253_1:RecordAudio("410182062", var_256_12)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_410182", "410182062", "story_v_out_410182.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_410182", "410182062", "story_v_out_410182.awb")
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

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410182063
		arg_257_1.duration_ = 16.4

		local var_257_0 = {
			ja = 16.4,
			CriLanguages = 10.666,
			zh = 10.666
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
				arg_257_0:Play410182064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1061 = arg_257_1.actors_["1061"].transform.localPosition
				arg_257_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1061", 3)

				for iter_260_0 = 0, arg_257_1.actors_["1061"].transform.childCount - 1 do
					local var_260_0 = arg_257_1.actors_["1061"].transform:GetChild(iter_260_0)

					if var_260_0.name == "" or not string.find(var_260_0.name, "split") then
						var_260_0.gameObject:SetActive(true)
					else
						var_260_0.gameObject:SetActive(false)
					end
				end
			end

			local var_260_1 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_1 then
				arg_257_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_257_1.time_ - 0) / var_260_1)
			end

			if arg_257_1.time_ >= 0 + var_260_1 and arg_257_1.time_ < 0 + var_260_1 + arg_260_0 then
				arg_257_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_260_2 = arg_257_1.actors_["1061"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps1061 == nil then
				arg_257_1.var_.actorSpriteComps1061 = var_260_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_3 = 0.034

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.actorSpriteComps1061 then
					for iter_260_1, iter_260_2 in pairs(arg_257_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_260_2 then
							if arg_257_1.isInRecall_ then
								iter_260_2.color = Color.New(Mathf.Lerp(iter_260_2.color.r, arg_257_1.hightColor1.r, (arg_257_1.time_ - 0) / var_260_3), Mathf.Lerp(iter_260_2.color.g, arg_257_1.hightColor1.g, (arg_257_1.time_ - 0) / var_260_3), (Mathf.Lerp(iter_260_2.color.b, arg_257_1.hightColor1.b, (arg_257_1.time_ - 0) / var_260_3)))
							else
								local var_260_4 = Mathf.Lerp(iter_260_2.color.r, 1, (arg_257_1.time_ - 0) / var_260_3)

								iter_260_2.color = Color.New(var_260_4, var_260_4, var_260_4)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps1061 then
				for iter_260_3, iter_260_4 in pairs(arg_257_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_260_4 then
						iter_260_4.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_257_1.var_.actorSpriteComps1061 = nil
			end

			local var_260_5 = 0
			local var_260_6 = 1.2

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_7 = arg_257_1:GetWordFromCfg(410182063)
				local var_260_8 = arg_257_1:FormatText(var_260_7.content)

				arg_257_1.text_.text = var_260_8

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_10 = 49 <= 0 and var_260_6 or var_260_6 * (utf8.len(var_260_8) / 49)

				if (49 <= 0 and var_260_6 or var_260_6 * (utf8.len(var_260_8) / 49)) > 0 and var_260_6 < var_260_10 then
					arg_257_1.talkMaxDuration = var_260_10

					if var_260_10 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_5
					end
				end

				arg_257_1.text_.text = var_260_8
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182063", "story_v_out_410182.awb") ~= 0 then
					local var_260_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182063", "story_v_out_410182.awb") / 1000

					if var_260_11 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_11 + var_260_5
					end

					if var_260_7.prefab_name ~= "" and arg_257_1.actors_[var_260_7.prefab_name] ~= nil then
						local var_260_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_7.prefab_name].transform, "story_v_out_410182", "410182063", "story_v_out_410182.awb")

						arg_257_1:RecordAudio("410182063", var_260_12)
						arg_257_1:RecordAudio("410182063", var_260_12)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_410182", "410182063", "story_v_out_410182.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_410182", "410182063", "story_v_out_410182.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_13 = math.max(var_260_6, arg_257_1.talkMaxDuration)

			if var_260_5 <= arg_257_1.time_ and arg_257_1.time_ < var_260_5 + var_260_13 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_5) / var_260_13

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_5 + var_260_13 and arg_257_1.time_ < var_260_5 + var_260_13 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410182064
		arg_261_1.duration_ = 7.47

		local var_261_0 = {
			ja = 6.066,
			CriLanguages = 7.466,
			zh = 7.466
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
				arg_261_0:Play410182065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1061 = arg_261_1.actors_["1061"].transform.localPosition
				arg_261_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1061", 3)

				for iter_264_0 = 0, arg_261_1.actors_["1061"].transform.childCount - 1 do
					local var_264_0 = arg_261_1.actors_["1061"].transform:GetChild(iter_264_0)

					if var_264_0.name == "" or not string.find(var_264_0.name, "split") then
						var_264_0.gameObject:SetActive(true)
					else
						var_264_0.gameObject:SetActive(false)
					end
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_261_1.time_ - 0) / var_264_1)
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_264_2 = arg_261_1.actors_["1061"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps1061 == nil then
				arg_261_1.var_.actorSpriteComps1061 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 0.034

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps1061 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								iter_264_2.color = Color.New(Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor1.r, (arg_261_1.time_ - 0) / var_264_3), Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor1.g, (arg_261_1.time_ - 0) / var_264_3), (Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor1.b, (arg_261_1.time_ - 0) / var_264_3)))
							else
								local var_264_4 = Mathf.Lerp(iter_264_2.color.r, 1, (arg_261_1.time_ - 0) / var_264_3)

								iter_264_2.color = Color.New(var_264_4, var_264_4, var_264_4)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps1061 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_264_4 then
						iter_264_4.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps1061 = nil
			end

			local var_264_5 = 0
			local var_264_6 = 0.925

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_7 = arg_261_1:GetWordFromCfg(410182064)
				local var_264_8 = arg_261_1:FormatText(var_264_7.content)

				arg_261_1.text_.text = var_264_8

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_10 = 37 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 37)

				if (37 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 37)) > 0 and var_264_6 < var_264_10 then
					arg_261_1.talkMaxDuration = var_264_10

					if var_264_10 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_5
					end
				end

				arg_261_1.text_.text = var_264_8
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182064", "story_v_out_410182.awb") ~= 0 then
					local var_264_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182064", "story_v_out_410182.awb") / 1000

					if var_264_11 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_5
					end

					if var_264_7.prefab_name ~= "" and arg_261_1.actors_[var_264_7.prefab_name] ~= nil then
						local var_264_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_7.prefab_name].transform, "story_v_out_410182", "410182064", "story_v_out_410182.awb")

						arg_261_1:RecordAudio("410182064", var_264_12)
						arg_261_1:RecordAudio("410182064", var_264_12)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410182", "410182064", "story_v_out_410182.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410182", "410182064", "story_v_out_410182.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_13 = math.max(var_264_6, arg_261_1.talkMaxDuration)

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_13 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_5) / var_264_13

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_5 + var_264_13 and arg_261_1.time_ < var_264_5 + var_264_13 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410182065
		arg_265_1.duration_ = 5.93

		local var_265_0 = {
			ja = 5.933,
			CriLanguages = 5.733,
			zh = 5.733
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
				arg_265_0:Play410182066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1061 = arg_265_1.actors_["1061"].transform.localPosition
				arg_265_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1061", 3)

				for iter_268_0 = 0, arg_265_1.actors_["1061"].transform.childCount - 1 do
					local var_268_0 = arg_265_1.actors_["1061"].transform:GetChild(iter_268_0)

					if var_268_0.name == "" or not string.find(var_268_0.name, "split") then
						var_268_0.gameObject:SetActive(true)
					else
						var_268_0.gameObject:SetActive(false)
					end
				end
			end

			local var_268_1 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				arg_265_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_265_1.time_ - 0) / var_268_1)
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				arg_265_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_268_2 = arg_265_1.actors_["1061"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps1061 == nil then
				arg_265_1.var_.actorSpriteComps1061 = var_268_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_3 = 0.034

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.actorSpriteComps1061 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_268_2 then
							if arg_265_1.isInRecall_ then
								iter_268_2.color = Color.New(Mathf.Lerp(iter_268_2.color.r, arg_265_1.hightColor1.r, (arg_265_1.time_ - 0) / var_268_3), Mathf.Lerp(iter_268_2.color.g, arg_265_1.hightColor1.g, (arg_265_1.time_ - 0) / var_268_3), (Mathf.Lerp(iter_268_2.color.b, arg_265_1.hightColor1.b, (arg_265_1.time_ - 0) / var_268_3)))
							else
								local var_268_4 = Mathf.Lerp(iter_268_2.color.r, 1, (arg_265_1.time_ - 0) / var_268_3)

								iter_268_2.color = Color.New(var_268_4, var_268_4, var_268_4)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps1061 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_268_4 then
						iter_268_4.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_265_1.var_.actorSpriteComps1061 = nil
			end

			local var_268_5 = 0
			local var_268_6 = 0.5

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_7 = arg_265_1:GetWordFromCfg(410182065)
				local var_268_8 = arg_265_1:FormatText(var_268_7.content)

				arg_265_1.text_.text = var_268_8

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_10 = 20 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 20)

				if (20 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 20)) > 0 and var_268_6 < var_268_10 then
					arg_265_1.talkMaxDuration = var_268_10

					if var_268_10 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_5
					end
				end

				arg_265_1.text_.text = var_268_8
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182065", "story_v_out_410182.awb") ~= 0 then
					local var_268_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182065", "story_v_out_410182.awb") / 1000

					if var_268_11 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_11 + var_268_5
					end

					if var_268_7.prefab_name ~= "" and arg_265_1.actors_[var_268_7.prefab_name] ~= nil then
						local var_268_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_7.prefab_name].transform, "story_v_out_410182", "410182065", "story_v_out_410182.awb")

						arg_265_1:RecordAudio("410182065", var_268_12)
						arg_265_1:RecordAudio("410182065", var_268_12)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_410182", "410182065", "story_v_out_410182.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_410182", "410182065", "story_v_out_410182.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_13 = math.max(var_268_6, arg_265_1.talkMaxDuration)

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_13 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_5) / var_268_13

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_5 + var_268_13 and arg_265_1.time_ < var_268_5 + var_268_13 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410182066
		arg_269_1.duration_ = 8.93

		local var_269_0 = {
			ja = 8.933,
			CriLanguages = 2.5,
			zh = 2.5
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play410182067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1061"]) and arg_269_1.var_.actorSpriteComps1061 == nil then
				arg_269_1.var_.actorSpriteComps1061 = arg_269_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_0 = 0.034

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1061"]) then
				if arg_269_1.var_.actorSpriteComps1061 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1061"]) and arg_269_1.var_.actorSpriteComps1061 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_272_3 then
						iter_272_3.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_269_1.var_.actorSpriteComps1061 = nil
			end

			local var_272_2 = 0
			local var_272_3 = 0.35

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_2 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[609].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_4 = arg_269_1:GetWordFromCfg(410182066)
				local var_272_5 = arg_269_1:FormatText(var_272_4.content)

				arg_269_1.text_.text = var_272_5

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_7 = 14 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 14)

				if (14 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 14)) > 0 and var_272_3 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_2
					end
				end

				arg_269_1.text_.text = var_272_5
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182066", "story_v_out_410182.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_410182", "410182066", "story_v_out_410182.awb") / 1000

					if var_272_8 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_2
					end

					if var_272_4.prefab_name ~= "" and arg_269_1.actors_[var_272_4.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_4.prefab_name].transform, "story_v_out_410182", "410182066", "story_v_out_410182.awb")

						arg_269_1:RecordAudio("410182066", var_272_9)
						arg_269_1:RecordAudio("410182066", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410182", "410182066", "story_v_out_410182.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410182", "410182066", "story_v_out_410182.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_3, arg_269_1.talkMaxDuration)

			if var_272_2 <= arg_269_1.time_ and arg_269_1.time_ < var_272_2 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_2) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_2 + var_272_10 and arg_269_1.time_ < var_272_2 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play410182067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410182067
		arg_273_1.duration_ = 5.47

		local var_273_0 = {
			ja = 5.466,
			CriLanguages = 2.766,
			zh = 2.766
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
				arg_273_0:Play410182068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1061 = arg_273_1.actors_["1061"].transform.localPosition
				arg_273_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1061", 3)

				for iter_276_0 = 0, arg_273_1.actors_["1061"].transform.childCount - 1 do
					local var_276_0 = arg_273_1.actors_["1061"].transform:GetChild(iter_276_0)

					if var_276_0.name == "" or not string.find(var_276_0.name, "split") then
						var_276_0.gameObject:SetActive(true)
					else
						var_276_0.gameObject:SetActive(false)
					end
				end
			end

			local var_276_1 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_1 then
				arg_273_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_273_1.time_ - 0) / var_276_1)
			end

			if arg_273_1.time_ >= 0 + var_276_1 and arg_273_1.time_ < 0 + var_276_1 + arg_276_0 then
				arg_273_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_276_2 = arg_273_1.actors_["1061"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps1061 == nil then
				arg_273_1.var_.actorSpriteComps1061 = var_276_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_3 = 0.034

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.actorSpriteComps1061 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								iter_276_2.color = Color.New(Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor1.r, (arg_273_1.time_ - 0) / var_276_3), Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor1.g, (arg_273_1.time_ - 0) / var_276_3), (Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor1.b, (arg_273_1.time_ - 0) / var_276_3)))
							else
								local var_276_4 = Mathf.Lerp(iter_276_2.color.r, 1, (arg_273_1.time_ - 0) / var_276_3)

								iter_276_2.color = Color.New(var_276_4, var_276_4, var_276_4)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps1061 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_276_4 then
						iter_276_4.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_273_1.var_.actorSpriteComps1061 = nil
			end

			local var_276_5 = 0
			local var_276_6 = 0.225

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_7 = arg_273_1:GetWordFromCfg(410182067)
				local var_276_8 = arg_273_1:FormatText(var_276_7.content)

				arg_273_1.text_.text = var_276_8

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_10 = 9 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 9)

				if (9 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 9)) > 0 and var_276_6 < var_276_10 then
					arg_273_1.talkMaxDuration = var_276_10

					if var_276_10 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_5
					end
				end

				arg_273_1.text_.text = var_276_8
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182067", "story_v_out_410182.awb") ~= 0 then
					local var_276_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182067", "story_v_out_410182.awb") / 1000

					if var_276_11 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_5
					end

					if var_276_7.prefab_name ~= "" and arg_273_1.actors_[var_276_7.prefab_name] ~= nil then
						local var_276_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_7.prefab_name].transform, "story_v_out_410182", "410182067", "story_v_out_410182.awb")

						arg_273_1:RecordAudio("410182067", var_276_12)
						arg_273_1:RecordAudio("410182067", var_276_12)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410182", "410182067", "story_v_out_410182.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410182", "410182067", "story_v_out_410182.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_13 = math.max(var_276_6, arg_273_1.talkMaxDuration)

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_13 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_5) / var_276_13

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_5 + var_276_13 and arg_273_1.time_ < var_276_5 + var_276_13 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410182068
		arg_277_1.duration_ = 13.53

		local var_277_0 = {
			ja = 13.533,
			CriLanguages = 10.533,
			zh = 10.533
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
				arg_277_0:Play410182069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1061 = arg_277_1.actors_["1061"].transform.localPosition
				arg_277_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1061", 3)

				for iter_280_0 = 0, arg_277_1.actors_["1061"].transform.childCount - 1 do
					local var_280_0 = arg_277_1.actors_["1061"].transform:GetChild(iter_280_0)

					if var_280_0.name == "" or not string.find(var_280_0.name, "split") then
						var_280_0.gameObject:SetActive(true)
					else
						var_280_0.gameObject:SetActive(false)
					end
				end
			end

			local var_280_1 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_1 then
				arg_277_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_277_1.time_ - 0) / var_280_1)
			end

			if arg_277_1.time_ >= 0 + var_280_1 and arg_277_1.time_ < 0 + var_280_1 + arg_280_0 then
				arg_277_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_280_2 = arg_277_1.actors_["1061"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps1061 == nil then
				arg_277_1.var_.actorSpriteComps1061 = var_280_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_3 = 0.034

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.actorSpriteComps1061 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_280_2 then
							if arg_277_1.isInRecall_ then
								iter_280_2.color = Color.New(Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor1.r, (arg_277_1.time_ - 0) / var_280_3), Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor1.g, (arg_277_1.time_ - 0) / var_280_3), (Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor1.b, (arg_277_1.time_ - 0) / var_280_3)))
							else
								local var_280_4 = Mathf.Lerp(iter_280_2.color.r, 1, (arg_277_1.time_ - 0) / var_280_3)

								iter_280_2.color = Color.New(var_280_4, var_280_4, var_280_4)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps1061 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_280_4 then
						iter_280_4.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps1061 = nil
			end

			local var_280_5 = 0
			local var_280_6 = 1.225

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
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

				local var_280_7 = arg_277_1:GetWordFromCfg(410182068)
				local var_280_8 = arg_277_1:FormatText(var_280_7.content)

				arg_277_1.text_.text = var_280_8

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_10 = 49 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 49)

				if (49 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 49)) > 0 and var_280_6 < var_280_10 then
					arg_277_1.talkMaxDuration = var_280_10

					if var_280_10 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_5
					end
				end

				arg_277_1.text_.text = var_280_8
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182068", "story_v_out_410182.awb") ~= 0 then
					local var_280_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182068", "story_v_out_410182.awb") / 1000

					if var_280_11 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_5
					end

					if var_280_7.prefab_name ~= "" and arg_277_1.actors_[var_280_7.prefab_name] ~= nil then
						local var_280_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_7.prefab_name].transform, "story_v_out_410182", "410182068", "story_v_out_410182.awb")

						arg_277_1:RecordAudio("410182068", var_280_12)
						arg_277_1:RecordAudio("410182068", var_280_12)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_410182", "410182068", "story_v_out_410182.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_410182", "410182068", "story_v_out_410182.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_13 = math.max(var_280_6, arg_277_1.talkMaxDuration)

			if var_280_5 <= arg_277_1.time_ and arg_277_1.time_ < var_280_5 + var_280_13 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_5) / var_280_13

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_5 + var_280_13 and arg_277_1.time_ < var_280_5 + var_280_13 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410182069
		arg_281_1.duration_ = 3.8

		local var_281_0 = {
			ja = 3.8,
			CriLanguages = 3.6,
			zh = 3.6
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
				arg_281_0:Play410182070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1061"]) and arg_281_1.var_.actorSpriteComps1061 == nil then
				arg_281_1.var_.actorSpriteComps1061 = arg_281_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_0 = 0.034

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1061"]) then
				if arg_281_1.var_.actorSpriteComps1061 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_284_1 then
							if arg_281_1.isInRecall_ then
								iter_284_1.color = Color.New(Mathf.Lerp(iter_284_1.color.r, arg_281_1.hightColor2.r, (arg_281_1.time_ - 0) / var_284_0), Mathf.Lerp(iter_284_1.color.g, arg_281_1.hightColor2.g, (arg_281_1.time_ - 0) / var_284_0), (Mathf.Lerp(iter_284_1.color.b, arg_281_1.hightColor2.b, (arg_281_1.time_ - 0) / var_284_0)))
							else
								local var_284_1 = Mathf.Lerp(iter_284_1.color.r, 0.5, (arg_281_1.time_ - 0) / var_284_0)

								iter_284_1.color = Color.New(var_284_1, var_284_1, var_284_1)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1061"]) and arg_281_1.var_.actorSpriteComps1061 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_284_3 then
						iter_284_3.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_281_1.var_.actorSpriteComps1061 = nil
			end

			local var_284_2 = 0
			local var_284_3 = 0.075

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[609].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_4 = arg_281_1:GetWordFromCfg(410182069)
				local var_284_5 = arg_281_1:FormatText(var_284_4.content)

				arg_281_1.text_.text = var_284_5

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 3 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 3)

				if (3 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 3)) > 0 and var_284_3 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_5
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182069", "story_v_out_410182.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_410182", "410182069", "story_v_out_410182.awb") / 1000

					if var_284_8 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_2
					end

					if var_284_4.prefab_name ~= "" and arg_281_1.actors_[var_284_4.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_4.prefab_name].transform, "story_v_out_410182", "410182069", "story_v_out_410182.awb")

						arg_281_1:RecordAudio("410182069", var_284_9)
						arg_281_1:RecordAudio("410182069", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410182", "410182069", "story_v_out_410182.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410182", "410182069", "story_v_out_410182.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_10 and arg_281_1.time_ < var_284_2 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play410182070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410182070
		arg_285_1.duration_ = 11.3

		local var_285_0 = {
			ja = 11.3,
			CriLanguages = 8.2,
			zh = 8.2
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
				arg_285_0:Play410182071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1061 = arg_285_1.actors_["1061"].transform.localPosition
				arg_285_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1061", 3)

				for iter_288_0 = 0, arg_285_1.actors_["1061"].transform.childCount - 1 do
					local var_288_0 = arg_285_1.actors_["1061"].transform:GetChild(iter_288_0)

					if var_288_0.name == "" or not string.find(var_288_0.name, "split") then
						var_288_0.gameObject:SetActive(true)
					else
						var_288_0.gameObject:SetActive(false)
					end
				end
			end

			local var_288_1 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_1 then
				arg_285_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_285_1.time_ - 0) / var_288_1)
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 then
				arg_285_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_288_2 = arg_285_1.actors_["1061"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps1061 == nil then
				arg_285_1.var_.actorSpriteComps1061 = var_288_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_3 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.actorSpriteComps1061 then
					for iter_288_1, iter_288_2 in pairs(arg_285_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_288_2 then
							if arg_285_1.isInRecall_ then
								iter_288_2.color = Color.New(Mathf.Lerp(iter_288_2.color.r, arg_285_1.hightColor1.r, (arg_285_1.time_ - 0) / var_288_3), Mathf.Lerp(iter_288_2.color.g, arg_285_1.hightColor1.g, (arg_285_1.time_ - 0) / var_288_3), (Mathf.Lerp(iter_288_2.color.b, arg_285_1.hightColor1.b, (arg_285_1.time_ - 0) / var_288_3)))
							else
								local var_288_4 = Mathf.Lerp(iter_288_2.color.r, 1, (arg_285_1.time_ - 0) / var_288_3)

								iter_288_2.color = Color.New(var_288_4, var_288_4, var_288_4)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps1061 then
				for iter_288_3, iter_288_4 in pairs(arg_285_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_288_4 then
						iter_288_4.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps1061 = nil
			end

			local var_288_5 = 0
			local var_288_6 = 1.025

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
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

				local var_288_7 = arg_285_1:GetWordFromCfg(410182070)
				local var_288_8 = arg_285_1:FormatText(var_288_7.content)

				arg_285_1.text_.text = var_288_8

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_10 = 41 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 41)

				if (41 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 41)) > 0 and var_288_6 < var_288_10 then
					arg_285_1.talkMaxDuration = var_288_10

					if var_288_10 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_5
					end
				end

				arg_285_1.text_.text = var_288_8
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182070", "story_v_out_410182.awb") ~= 0 then
					local var_288_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182070", "story_v_out_410182.awb") / 1000

					if var_288_11 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_5
					end

					if var_288_7.prefab_name ~= "" and arg_285_1.actors_[var_288_7.prefab_name] ~= nil then
						local var_288_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_7.prefab_name].transform, "story_v_out_410182", "410182070", "story_v_out_410182.awb")

						arg_285_1:RecordAudio("410182070", var_288_12)
						arg_285_1:RecordAudio("410182070", var_288_12)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410182", "410182070", "story_v_out_410182.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410182", "410182070", "story_v_out_410182.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_13 = math.max(var_288_6, arg_285_1.talkMaxDuration)

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_13 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_5) / var_288_13

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_5 + var_288_13 and arg_285_1.time_ < var_288_5 + var_288_13 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410182071
		arg_289_1.duration_ = 11.4

		local var_289_0 = {
			ja = 10.5,
			CriLanguages = 11.4,
			zh = 11.4
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
				arg_289_0:Play410182072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1061 = arg_289_1.actors_["1061"].transform.localPosition
				arg_289_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1061", 3)

				for iter_292_0 = 0, arg_289_1.actors_["1061"].transform.childCount - 1 do
					local var_292_0 = arg_289_1.actors_["1061"].transform:GetChild(iter_292_0)

					if var_292_0.name == "" or not string.find(var_292_0.name, "split") then
						var_292_0.gameObject:SetActive(true)
					else
						var_292_0.gameObject:SetActive(false)
					end
				end
			end

			local var_292_1 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_1 then
				arg_289_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_289_1.time_ - 0) / var_292_1)
			end

			if arg_289_1.time_ >= 0 + var_292_1 and arg_289_1.time_ < 0 + var_292_1 + arg_292_0 then
				arg_289_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_292_2 = arg_289_1.actors_["1061"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps1061 == nil then
				arg_289_1.var_.actorSpriteComps1061 = var_292_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_3 = 0.034

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.actorSpriteComps1061 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps1061 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_292_4 then
						iter_292_4.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_289_1.var_.actorSpriteComps1061 = nil
			end

			local var_292_5 = 0
			local var_292_6 = 1.35

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
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

				local var_292_7 = arg_289_1:GetWordFromCfg(410182071)
				local var_292_8 = arg_289_1:FormatText(var_292_7.content)

				arg_289_1.text_.text = var_292_8

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_10 = 54 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_8) / 54)

				if (54 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_8) / 54)) > 0 and var_292_6 < var_292_10 then
					arg_289_1.talkMaxDuration = var_292_10

					if var_292_10 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_5
					end
				end

				arg_289_1.text_.text = var_292_8
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182071", "story_v_out_410182.awb") ~= 0 then
					local var_292_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182071", "story_v_out_410182.awb") / 1000

					if var_292_11 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_11 + var_292_5
					end

					if var_292_7.prefab_name ~= "" and arg_289_1.actors_[var_292_7.prefab_name] ~= nil then
						local var_292_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_7.prefab_name].transform, "story_v_out_410182", "410182071", "story_v_out_410182.awb")

						arg_289_1:RecordAudio("410182071", var_292_12)
						arg_289_1:RecordAudio("410182071", var_292_12)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_410182", "410182071", "story_v_out_410182.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_410182", "410182071", "story_v_out_410182.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_13 = math.max(var_292_6, arg_289_1.talkMaxDuration)

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_13 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_5) / var_292_13

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_5 + var_292_13 and arg_289_1.time_ < var_292_5 + var_292_13 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410182072
		arg_293_1.duration_ = 9.57

		local var_293_0 = {
			ja = 9.566,
			CriLanguages = 9.5,
			zh = 9.5
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
				arg_293_0:Play410182073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1061 = arg_293_1.actors_["1061"].transform.localPosition
				arg_293_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1061", 3)

				for iter_296_0 = 0, arg_293_1.actors_["1061"].transform.childCount - 1 do
					local var_296_0 = arg_293_1.actors_["1061"].transform:GetChild(iter_296_0)

					if var_296_0.name == "" or not string.find(var_296_0.name, "split") then
						var_296_0.gameObject:SetActive(true)
					else
						var_296_0.gameObject:SetActive(false)
					end
				end
			end

			local var_296_1 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_1 then
				arg_293_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_293_1.time_ - 0) / var_296_1)
			end

			if arg_293_1.time_ >= 0 + var_296_1 and arg_293_1.time_ < 0 + var_296_1 + arg_296_0 then
				arg_293_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_296_2 = arg_293_1.actors_["1061"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps1061 == nil then
				arg_293_1.var_.actorSpriteComps1061 = var_296_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_3 = 0.034

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 and not isNil(var_296_2) then
				if arg_293_1.var_.actorSpriteComps1061 then
					for iter_296_1, iter_296_2 in pairs(arg_293_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_296_2 then
							if arg_293_1.isInRecall_ then
								iter_296_2.color = Color.New(Mathf.Lerp(iter_296_2.color.r, arg_293_1.hightColor1.r, (arg_293_1.time_ - 0) / var_296_3), Mathf.Lerp(iter_296_2.color.g, arg_293_1.hightColor1.g, (arg_293_1.time_ - 0) / var_296_3), (Mathf.Lerp(iter_296_2.color.b, arg_293_1.hightColor1.b, (arg_293_1.time_ - 0) / var_296_3)))
							else
								local var_296_4 = Mathf.Lerp(iter_296_2.color.r, 1, (arg_293_1.time_ - 0) / var_296_3)

								iter_296_2.color = Color.New(var_296_4, var_296_4, var_296_4)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps1061 then
				for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_296_4 then
						iter_296_4.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_293_1.var_.actorSpriteComps1061 = nil
			end

			local var_296_5 = 0
			local var_296_6 = 1.125

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_7 = arg_293_1:GetWordFromCfg(410182072)
				local var_296_8 = arg_293_1:FormatText(var_296_7.content)

				arg_293_1.text_.text = var_296_8

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_10 = 45 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 45)

				if (45 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 45)) > 0 and var_296_6 < var_296_10 then
					arg_293_1.talkMaxDuration = var_296_10

					if var_296_10 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_5
					end
				end

				arg_293_1.text_.text = var_296_8
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182072", "story_v_out_410182.awb") ~= 0 then
					local var_296_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182072", "story_v_out_410182.awb") / 1000

					if var_296_11 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_5
					end

					if var_296_7.prefab_name ~= "" and arg_293_1.actors_[var_296_7.prefab_name] ~= nil then
						local var_296_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_7.prefab_name].transform, "story_v_out_410182", "410182072", "story_v_out_410182.awb")

						arg_293_1:RecordAudio("410182072", var_296_12)
						arg_293_1:RecordAudio("410182072", var_296_12)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410182", "410182072", "story_v_out_410182.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410182", "410182072", "story_v_out_410182.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_13 = math.max(var_296_6, arg_293_1.talkMaxDuration)

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_13 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_5) / var_296_13

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_5 + var_296_13 and arg_293_1.time_ < var_296_5 + var_296_13 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410182073
		arg_297_1.duration_ = 10.47

		local var_297_0 = {
			ja = 10.466,
			CriLanguages = 8.6,
			zh = 8.6
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
				arg_297_0:Play410182074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1061 = arg_297_1.actors_["1061"].transform.localPosition
				arg_297_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1061", 3)

				for iter_300_0 = 0, arg_297_1.actors_["1061"].transform.childCount - 1 do
					local var_300_0 = arg_297_1.actors_["1061"].transform:GetChild(iter_300_0)

					if var_300_0.name == "split_5" or not string.find(var_300_0.name, "split") then
						var_300_0.gameObject:SetActive(true)
					else
						var_300_0.gameObject:SetActive(false)
					end
				end
			end

			local var_300_1 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_1 then
				arg_297_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_297_1.time_ - 0) / var_300_1)
			end

			if arg_297_1.time_ >= 0 + var_300_1 and arg_297_1.time_ < 0 + var_300_1 + arg_300_0 then
				arg_297_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_300_2 = arg_297_1.actors_["1061"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps1061 == nil then
				arg_297_1.var_.actorSpriteComps1061 = var_300_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_3 = 0.034

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 and not isNil(var_300_2) then
				if arg_297_1.var_.actorSpriteComps1061 then
					for iter_300_1, iter_300_2 in pairs(arg_297_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_300_2 then
							if arg_297_1.isInRecall_ then
								iter_300_2.color = Color.New(Mathf.Lerp(iter_300_2.color.r, arg_297_1.hightColor1.r, (arg_297_1.time_ - 0) / var_300_3), Mathf.Lerp(iter_300_2.color.g, arg_297_1.hightColor1.g, (arg_297_1.time_ - 0) / var_300_3), (Mathf.Lerp(iter_300_2.color.b, arg_297_1.hightColor1.b, (arg_297_1.time_ - 0) / var_300_3)))
							else
								local var_300_4 = Mathf.Lerp(iter_300_2.color.r, 1, (arg_297_1.time_ - 0) / var_300_3)

								iter_300_2.color = Color.New(var_300_4, var_300_4, var_300_4)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps1061 then
				for iter_300_3, iter_300_4 in pairs(arg_297_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_300_4 then
						iter_300_4.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_297_1.var_.actorSpriteComps1061 = nil
			end

			local var_300_5 = 0
			local var_300_6 = 0.975

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_7 = arg_297_1:GetWordFromCfg(410182073)
				local var_300_8 = arg_297_1:FormatText(var_300_7.content)

				arg_297_1.text_.text = var_300_8

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_10 = 39 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_8) / 39)

				if (39 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_8) / 39)) > 0 and var_300_6 < var_300_10 then
					arg_297_1.talkMaxDuration = var_300_10

					if var_300_10 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_5
					end
				end

				arg_297_1.text_.text = var_300_8
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182073", "story_v_out_410182.awb") ~= 0 then
					local var_300_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182073", "story_v_out_410182.awb") / 1000

					if var_300_11 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_5
					end

					if var_300_7.prefab_name ~= "" and arg_297_1.actors_[var_300_7.prefab_name] ~= nil then
						local var_300_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_7.prefab_name].transform, "story_v_out_410182", "410182073", "story_v_out_410182.awb")

						arg_297_1:RecordAudio("410182073", var_300_12)
						arg_297_1:RecordAudio("410182073", var_300_12)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_410182", "410182073", "story_v_out_410182.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_410182", "410182073", "story_v_out_410182.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_13 = math.max(var_300_6, arg_297_1.talkMaxDuration)

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_13 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_5) / var_300_13

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_5 + var_300_13 and arg_297_1.time_ < var_300_5 + var_300_13 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410182074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play410182075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1061"]) and arg_301_1.var_.actorSpriteComps1061 == nil then
				arg_301_1.var_.actorSpriteComps1061 = arg_301_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_0 = 0.034

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1061"]) then
				if arg_301_1.var_.actorSpriteComps1061 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_304_1 then
							if arg_301_1.isInRecall_ then
								iter_304_1.color = Color.New(Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor2.r, (arg_301_1.time_ - 0) / var_304_0), Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor2.g, (arg_301_1.time_ - 0) / var_304_0), (Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor2.b, (arg_301_1.time_ - 0) / var_304_0)))
							else
								local var_304_1 = Mathf.Lerp(iter_304_1.color.r, 0.5, (arg_301_1.time_ - 0) / var_304_0)

								iter_304_1.color = Color.New(var_304_1, var_304_1, var_304_1)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1061"]) and arg_301_1.var_.actorSpriteComps1061 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_304_3 then
						iter_304_3.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_301_1.var_.actorSpriteComps1061 = nil
			end

			local var_304_2 = 0
			local var_304_3 = 1.475

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_4 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(410182074).content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_6 = 59 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_4) / 59)

				if (59 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_4) / 59)) > 0 and var_304_3 < var_304_6 then
					arg_301_1.talkMaxDuration = var_304_6

					if var_304_6 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_2
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_3, arg_301_1.talkMaxDuration)

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_2) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_2 + var_304_7 and arg_301_1.time_ < var_304_2 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play410182075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410182075
		arg_305_1.duration_ = 14

		local var_305_0 = {
			ja = 14,
			CriLanguages = 8.2,
			zh = 8.2
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
				arg_305_0:Play410182076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 1.1

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[609].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:GetWordFromCfg(410182075)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 44 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 44)

				if (44 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 44)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182075", "story_v_out_410182.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_out_410182", "410182075", "story_v_out_410182.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_out_410182", "410182075", "story_v_out_410182.awb")

						arg_305_1:RecordAudio("410182075", var_308_6)
						arg_305_1:RecordAudio("410182075", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_410182", "410182075", "story_v_out_410182.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_410182", "410182075", "story_v_out_410182.awb")
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
	Play410182076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 410182076
		arg_309_1.duration_ = 4.73

		local var_309_0 = {
			ja = 4.733,
			CriLanguages = 3.133,
			zh = 3.133
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
				arg_309_0:Play410182077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.475

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[609].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:GetWordFromCfg(410182076)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 19 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 19)

				if (19 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 19)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182076", "story_v_out_410182.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_out_410182", "410182076", "story_v_out_410182.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_out_410182", "410182076", "story_v_out_410182.awb")

						arg_309_1:RecordAudio("410182076", var_312_6)
						arg_309_1:RecordAudio("410182076", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_410182", "410182076", "story_v_out_410182.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_410182", "410182076", "story_v_out_410182.awb")
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
	Play410182077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 410182077
		arg_313_1.duration_ = 5.33

		local var_313_0 = {
			ja = 5.333,
			CriLanguages = 2.766,
			zh = 2.766
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
				arg_313_0:Play410182078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1061 = arg_313_1.actors_["1061"].transform.localPosition
				arg_313_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1061", 3)

				for iter_316_0 = 0, arg_313_1.actors_["1061"].transform.childCount - 1 do
					local var_316_0 = arg_313_1.actors_["1061"].transform:GetChild(iter_316_0)

					if var_316_0.name == "split_5" or not string.find(var_316_0.name, "split") then
						var_316_0.gameObject:SetActive(true)
					else
						var_316_0.gameObject:SetActive(false)
					end
				end
			end

			local var_316_1 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_1 then
				arg_313_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_313_1.time_ - 0) / var_316_1)
			end

			if arg_313_1.time_ >= 0 + var_316_1 and arg_313_1.time_ < 0 + var_316_1 + arg_316_0 then
				arg_313_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_316_2 = arg_313_1.actors_["1061"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.actorSpriteComps1061 == nil then
				arg_313_1.var_.actorSpriteComps1061 = var_316_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_3 = 0.034

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_3 and not isNil(var_316_2) then
				if arg_313_1.var_.actorSpriteComps1061 then
					for iter_316_1, iter_316_2 in pairs(arg_313_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_313_1.time_ >= 0 + var_316_3 and arg_313_1.time_ < 0 + var_316_3 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.actorSpriteComps1061 then
				for iter_316_3, iter_316_4 in pairs(arg_313_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_316_4 then
						iter_316_4.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_313_1.var_.actorSpriteComps1061 = nil
			end

			local var_316_5 = 0
			local var_316_6 = 0.3

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_7 = arg_313_1:GetWordFromCfg(410182077)
				local var_316_8 = arg_313_1:FormatText(var_316_7.content)

				arg_313_1.text_.text = var_316_8

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_10 = 12 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 12)

				if (12 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 12)) > 0 and var_316_6 < var_316_10 then
					arg_313_1.talkMaxDuration = var_316_10

					if var_316_10 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_5
					end
				end

				arg_313_1.text_.text = var_316_8
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182077", "story_v_out_410182.awb") ~= 0 then
					local var_316_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182077", "story_v_out_410182.awb") / 1000

					if var_316_11 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_11 + var_316_5
					end

					if var_316_7.prefab_name ~= "" and arg_313_1.actors_[var_316_7.prefab_name] ~= nil then
						local var_316_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_7.prefab_name].transform, "story_v_out_410182", "410182077", "story_v_out_410182.awb")

						arg_313_1:RecordAudio("410182077", var_316_12)
						arg_313_1:RecordAudio("410182077", var_316_12)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_410182", "410182077", "story_v_out_410182.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_410182", "410182077", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 410182078
		arg_317_1.duration_ = 2.07

		local var_317_0 = {
			ja = 2.066,
			CriLanguages = 1.433,
			zh = 1.433
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
				arg_317_0:Play410182079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1061"]) and arg_317_1.var_.actorSpriteComps1061 == nil then
				arg_317_1.var_.actorSpriteComps1061 = arg_317_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_0 = 0.034

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1061"]) then
				if arg_317_1.var_.actorSpriteComps1061 then
					for iter_320_0, iter_320_1 in pairs(arg_317_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_320_1 then
							if arg_317_1.isInRecall_ then
								iter_320_1.color = Color.New(Mathf.Lerp(iter_320_1.color.r, arg_317_1.hightColor2.r, (arg_317_1.time_ - 0) / var_320_0), Mathf.Lerp(iter_320_1.color.g, arg_317_1.hightColor2.g, (arg_317_1.time_ - 0) / var_320_0), (Mathf.Lerp(iter_320_1.color.b, arg_317_1.hightColor2.b, (arg_317_1.time_ - 0) / var_320_0)))
							else
								local var_320_1 = Mathf.Lerp(iter_320_1.color.r, 0.5, (arg_317_1.time_ - 0) / var_320_0)

								iter_320_1.color = Color.New(var_320_1, var_320_1, var_320_1)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1061"]) and arg_317_1.var_.actorSpriteComps1061 then
				for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_320_3 then
						iter_320_3.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_317_1.var_.actorSpriteComps1061 = nil
			end

			local var_320_2 = 0
			local var_320_3 = 0.15

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[609].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_4 = arg_317_1:GetWordFromCfg(410182078)
				local var_320_5 = arg_317_1:FormatText(var_320_4.content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 6 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 6)

				if (6 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 6)) > 0 and var_320_3 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_2
					end
				end

				arg_317_1.text_.text = var_320_5
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182078", "story_v_out_410182.awb") ~= 0 then
					local var_320_8 = manager.audio:GetVoiceLength("story_v_out_410182", "410182078", "story_v_out_410182.awb") / 1000

					if var_320_8 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_8 + var_320_2
					end

					if var_320_4.prefab_name ~= "" and arg_317_1.actors_[var_320_4.prefab_name] ~= nil then
						local var_320_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_4.prefab_name].transform, "story_v_out_410182", "410182078", "story_v_out_410182.awb")

						arg_317_1:RecordAudio("410182078", var_320_9)
						arg_317_1:RecordAudio("410182078", var_320_9)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_410182", "410182078", "story_v_out_410182.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_410182", "410182078", "story_v_out_410182.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_10 = math.max(var_320_3, arg_317_1.talkMaxDuration)

			if var_320_2 <= arg_317_1.time_ and arg_317_1.time_ < var_320_2 + var_320_10 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_2) / var_320_10

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_2 + var_320_10 and arg_317_1.time_ < var_320_2 + var_320_10 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play410182079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 410182079
		arg_321_1.duration_ = 16.47

		local var_321_0 = {
			ja = 16.466,
			CriLanguages = 13.266,
			zh = 13.266
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
				arg_321_0:Play410182080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1061 = arg_321_1.actors_["1061"].transform.localPosition
				arg_321_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("1061", 3)

				for iter_324_0 = 0, arg_321_1.actors_["1061"].transform.childCount - 1 do
					local var_324_0 = arg_321_1.actors_["1061"].transform:GetChild(iter_324_0)

					if var_324_0.name == "split_5" or not string.find(var_324_0.name, "split") then
						var_324_0.gameObject:SetActive(true)
					else
						var_324_0.gameObject:SetActive(false)
					end
				end
			end

			local var_324_1 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_1 then
				arg_321_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_321_1.time_ - 0) / var_324_1)
			end

			if arg_321_1.time_ >= 0 + var_324_1 and arg_321_1.time_ < 0 + var_324_1 + arg_324_0 then
				arg_321_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_324_2 = arg_321_1.actors_["1061"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_2) and arg_321_1.var_.actorSpriteComps1061 == nil then
				arg_321_1.var_.actorSpriteComps1061 = var_324_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_3 = 0.034

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_3 and not isNil(var_324_2) then
				if arg_321_1.var_.actorSpriteComps1061 then
					for iter_324_1, iter_324_2 in pairs(arg_321_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_321_1.time_ >= 0 + var_324_3 and arg_321_1.time_ < 0 + var_324_3 + arg_324_0 and not isNil(var_324_2) and arg_321_1.var_.actorSpriteComps1061 then
				for iter_324_3, iter_324_4 in pairs(arg_321_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_324_4 then
						iter_324_4.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_321_1.var_.actorSpriteComps1061 = nil
			end

			local var_324_5 = 0
			local var_324_6 = 1.45

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_7 = arg_321_1:GetWordFromCfg(410182079)
				local var_324_8 = arg_321_1:FormatText(var_324_7.content)

				arg_321_1.text_.text = var_324_8

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_10 = 58 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 58)

				if (58 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 58)) > 0 and var_324_6 < var_324_10 then
					arg_321_1.talkMaxDuration = var_324_10

					if var_324_10 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_5
					end
				end

				arg_321_1.text_.text = var_324_8
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182079", "story_v_out_410182.awb") ~= 0 then
					local var_324_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182079", "story_v_out_410182.awb") / 1000

					if var_324_11 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_11 + var_324_5
					end

					if var_324_7.prefab_name ~= "" and arg_321_1.actors_[var_324_7.prefab_name] ~= nil then
						local var_324_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_7.prefab_name].transform, "story_v_out_410182", "410182079", "story_v_out_410182.awb")

						arg_321_1:RecordAudio("410182079", var_324_12)
						arg_321_1:RecordAudio("410182079", var_324_12)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_410182", "410182079", "story_v_out_410182.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_410182", "410182079", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 410182080
		arg_325_1.duration_ = 17.97

		local var_325_0 = {
			ja = 17.966,
			CriLanguages = 13.7,
			zh = 13.7
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
				arg_325_0:Play410182081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1061 = arg_325_1.actors_["1061"].transform.localPosition
				arg_325_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("1061", 3)

				for iter_328_0 = 0, arg_325_1.actors_["1061"].transform.childCount - 1 do
					local var_328_0 = arg_325_1.actors_["1061"].transform:GetChild(iter_328_0)

					if var_328_0.name == "split_5" or not string.find(var_328_0.name, "split") then
						var_328_0.gameObject:SetActive(true)
					else
						var_328_0.gameObject:SetActive(false)
					end
				end
			end

			local var_328_1 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_1 then
				arg_325_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_325_1.time_ - 0) / var_328_1)
			end

			if arg_325_1.time_ >= 0 + var_328_1 and arg_325_1.time_ < 0 + var_328_1 + arg_328_0 then
				arg_325_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_328_2 = arg_325_1.actors_["1061"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.actorSpriteComps1061 == nil then
				arg_325_1.var_.actorSpriteComps1061 = var_328_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_3 = 0.034

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_3 and not isNil(var_328_2) then
				if arg_325_1.var_.actorSpriteComps1061 then
					for iter_328_1, iter_328_2 in pairs(arg_325_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_325_1.time_ >= 0 + var_328_3 and arg_325_1.time_ < 0 + var_328_3 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.actorSpriteComps1061 then
				for iter_328_3, iter_328_4 in pairs(arg_325_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_328_4 then
						iter_328_4.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_325_1.var_.actorSpriteComps1061 = nil
			end

			local var_328_5 = 0
			local var_328_6 = 1.675

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_7 = arg_325_1:GetWordFromCfg(410182080)
				local var_328_8 = arg_325_1:FormatText(var_328_7.content)

				arg_325_1.text_.text = var_328_8

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_10 = 69 <= 0 and var_328_6 or var_328_6 * (utf8.len(var_328_8) / 69)

				if (69 <= 0 and var_328_6 or var_328_6 * (utf8.len(var_328_8) / 69)) > 0 and var_328_6 < var_328_10 then
					arg_325_1.talkMaxDuration = var_328_10

					if var_328_10 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_5
					end
				end

				arg_325_1.text_.text = var_328_8
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182080", "story_v_out_410182.awb") ~= 0 then
					local var_328_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182080", "story_v_out_410182.awb") / 1000

					if var_328_11 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_11 + var_328_5
					end

					if var_328_7.prefab_name ~= "" and arg_325_1.actors_[var_328_7.prefab_name] ~= nil then
						local var_328_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_7.prefab_name].transform, "story_v_out_410182", "410182080", "story_v_out_410182.awb")

						arg_325_1:RecordAudio("410182080", var_328_12)
						arg_325_1:RecordAudio("410182080", var_328_12)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_410182", "410182080", "story_v_out_410182.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_410182", "410182080", "story_v_out_410182.awb")
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

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 410182081
		arg_329_1.duration_ = 18.87

		local var_329_0 = {
			ja = 18.866,
			CriLanguages = 12.366,
			zh = 12.366
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
				arg_329_0:Play410182082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1061 = arg_329_1.actors_["1061"].transform.localPosition
				arg_329_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1061", 3)

				for iter_332_0 = 0, arg_329_1.actors_["1061"].transform.childCount - 1 do
					local var_332_0 = arg_329_1.actors_["1061"].transform:GetChild(iter_332_0)

					if var_332_0.name == "split_5" or not string.find(var_332_0.name, "split") then
						var_332_0.gameObject:SetActive(true)
					else
						var_332_0.gameObject:SetActive(false)
					end
				end
			end

			local var_332_1 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_1 then
				arg_329_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_329_1.time_ - 0) / var_332_1)
			end

			if arg_329_1.time_ >= 0 + var_332_1 and arg_329_1.time_ < 0 + var_332_1 + arg_332_0 then
				arg_329_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_332_2 = arg_329_1.actors_["1061"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.actorSpriteComps1061 == nil then
				arg_329_1.var_.actorSpriteComps1061 = var_332_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_3 = 0.034

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_3 and not isNil(var_332_2) then
				if arg_329_1.var_.actorSpriteComps1061 then
					for iter_332_1, iter_332_2 in pairs(arg_329_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_332_2 then
							if arg_329_1.isInRecall_ then
								iter_332_2.color = Color.New(Mathf.Lerp(iter_332_2.color.r, arg_329_1.hightColor1.r, (arg_329_1.time_ - 0) / var_332_3), Mathf.Lerp(iter_332_2.color.g, arg_329_1.hightColor1.g, (arg_329_1.time_ - 0) / var_332_3), (Mathf.Lerp(iter_332_2.color.b, arg_329_1.hightColor1.b, (arg_329_1.time_ - 0) / var_332_3)))
							else
								local var_332_4 = Mathf.Lerp(iter_332_2.color.r, 1, (arg_329_1.time_ - 0) / var_332_3)

								iter_332_2.color = Color.New(var_332_4, var_332_4, var_332_4)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= 0 + var_332_3 and arg_329_1.time_ < 0 + var_332_3 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.actorSpriteComps1061 then
				for iter_332_3, iter_332_4 in pairs(arg_329_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_332_4 then
						iter_332_4.color = arg_329_1.isInRecall_ and (arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_329_1.var_.actorSpriteComps1061 = nil
			end

			local var_332_5 = 0
			local var_332_6 = 1.425

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_5 + arg_332_0 then
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

				local var_332_7 = arg_329_1:GetWordFromCfg(410182081)
				local var_332_8 = arg_329_1:FormatText(var_332_7.content)

				arg_329_1.text_.text = var_332_8

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_10 = 57 <= 0 and var_332_6 or var_332_6 * (utf8.len(var_332_8) / 57)

				if (57 <= 0 and var_332_6 or var_332_6 * (utf8.len(var_332_8) / 57)) > 0 and var_332_6 < var_332_10 then
					arg_329_1.talkMaxDuration = var_332_10

					if var_332_10 + var_332_5 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_5
					end
				end

				arg_329_1.text_.text = var_332_8
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182081", "story_v_out_410182.awb") ~= 0 then
					local var_332_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182081", "story_v_out_410182.awb") / 1000

					if var_332_11 + var_332_5 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_11 + var_332_5
					end

					if var_332_7.prefab_name ~= "" and arg_329_1.actors_[var_332_7.prefab_name] ~= nil then
						local var_332_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_7.prefab_name].transform, "story_v_out_410182", "410182081", "story_v_out_410182.awb")

						arg_329_1:RecordAudio("410182081", var_332_12)
						arg_329_1:RecordAudio("410182081", var_332_12)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_410182", "410182081", "story_v_out_410182.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_410182", "410182081", "story_v_out_410182.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_13 = math.max(var_332_6, arg_329_1.talkMaxDuration)

			if var_332_5 <= arg_329_1.time_ and arg_329_1.time_ < var_332_5 + var_332_13 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_5) / var_332_13

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_5 + var_332_13 and arg_329_1.time_ < var_332_5 + var_332_13 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 410182082
		arg_333_1.duration_ = 13.63

		local var_333_0 = {
			ja = 13.633,
			CriLanguages = 8.033,
			zh = 8.033
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
				arg_333_0:Play410182083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1061 = arg_333_1.actors_["1061"].transform.localPosition
				arg_333_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("1061", 3)

				for iter_336_0 = 0, arg_333_1.actors_["1061"].transform.childCount - 1 do
					local var_336_0 = arg_333_1.actors_["1061"].transform:GetChild(iter_336_0)

					if var_336_0.name == "split_5" or not string.find(var_336_0.name, "split") then
						var_336_0.gameObject:SetActive(true)
					else
						var_336_0.gameObject:SetActive(false)
					end
				end
			end

			local var_336_1 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_1 then
				arg_333_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_333_1.time_ - 0) / var_336_1)
			end

			if arg_333_1.time_ >= 0 + var_336_1 and arg_333_1.time_ < 0 + var_336_1 + arg_336_0 then
				arg_333_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_336_2 = arg_333_1.actors_["1061"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.actorSpriteComps1061 == nil then
				arg_333_1.var_.actorSpriteComps1061 = var_336_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_3 = 0.034

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_3 and not isNil(var_336_2) then
				if arg_333_1.var_.actorSpriteComps1061 then
					for iter_336_1, iter_336_2 in pairs(arg_333_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_336_2 then
							if arg_333_1.isInRecall_ then
								iter_336_2.color = Color.New(Mathf.Lerp(iter_336_2.color.r, arg_333_1.hightColor1.r, (arg_333_1.time_ - 0) / var_336_3), Mathf.Lerp(iter_336_2.color.g, arg_333_1.hightColor1.g, (arg_333_1.time_ - 0) / var_336_3), (Mathf.Lerp(iter_336_2.color.b, arg_333_1.hightColor1.b, (arg_333_1.time_ - 0) / var_336_3)))
							else
								local var_336_4 = Mathf.Lerp(iter_336_2.color.r, 1, (arg_333_1.time_ - 0) / var_336_3)

								iter_336_2.color = Color.New(var_336_4, var_336_4, var_336_4)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_3 and arg_333_1.time_ < 0 + var_336_3 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.actorSpriteComps1061 then
				for iter_336_3, iter_336_4 in pairs(arg_333_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_336_4 then
						iter_336_4.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_333_1.var_.actorSpriteComps1061 = nil
			end

			local var_336_5 = 0
			local var_336_6 = 0.7

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_7 = arg_333_1:GetWordFromCfg(410182082)
				local var_336_8 = arg_333_1:FormatText(var_336_7.content)

				arg_333_1.text_.text = var_336_8

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_10 = 28 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 28)

				if (28 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 28)) > 0 and var_336_6 < var_336_10 then
					arg_333_1.talkMaxDuration = var_336_10

					if var_336_10 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_5
					end
				end

				arg_333_1.text_.text = var_336_8
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182082", "story_v_out_410182.awb") ~= 0 then
					local var_336_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182082", "story_v_out_410182.awb") / 1000

					if var_336_11 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_11 + var_336_5
					end

					if var_336_7.prefab_name ~= "" and arg_333_1.actors_[var_336_7.prefab_name] ~= nil then
						local var_336_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_7.prefab_name].transform, "story_v_out_410182", "410182082", "story_v_out_410182.awb")

						arg_333_1:RecordAudio("410182082", var_336_12)
						arg_333_1:RecordAudio("410182082", var_336_12)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_410182", "410182082", "story_v_out_410182.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_410182", "410182082", "story_v_out_410182.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_13 = math.max(var_336_6, arg_333_1.talkMaxDuration)

			if var_336_5 <= arg_333_1.time_ and arg_333_1.time_ < var_336_5 + var_336_13 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_5) / var_336_13

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_5 + var_336_13 and arg_333_1.time_ < var_336_5 + var_336_13 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 410182083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play410182084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_table", "")
			end

			local var_340_1 = arg_337_1.actors_["1061"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.actorSpriteComps1061 == nil then
				arg_337_1.var_.actorSpriteComps1061 = var_340_1:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_2 = 0.034

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 and not isNil(var_340_1) then
				if arg_337_1.var_.actorSpriteComps1061 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_340_1 then
							if arg_337_1.isInRecall_ then
								iter_340_1.color = Color.New(Mathf.Lerp(iter_340_1.color.r, arg_337_1.hightColor2.r, (arg_337_1.time_ - 0) / var_340_2), Mathf.Lerp(iter_340_1.color.g, arg_337_1.hightColor2.g, (arg_337_1.time_ - 0) / var_340_2), (Mathf.Lerp(iter_340_1.color.b, arg_337_1.hightColor2.b, (arg_337_1.time_ - 0) / var_340_2)))
							else
								local var_340_3 = Mathf.Lerp(iter_340_1.color.r, 0.5, (arg_337_1.time_ - 0) / var_340_2)

								iter_340_1.color = Color.New(var_340_3, var_340_3, var_340_3)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.actorSpriteComps1061 then
				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_340_3 then
						iter_340_3.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_337_1.var_.actorSpriteComps1061 = nil
			end

			local var_340_4 = 0
			local var_340_5 = 1.075

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_6 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(410182083).content)

				arg_337_1.text_.text = var_340_6

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_8 = 43 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_6) / 43)

				if (43 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_6) / 43)) > 0 and var_340_5 < var_340_8 then
					arg_337_1.talkMaxDuration = var_340_8

					if var_340_8 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_6
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_9 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_9 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_9

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_9 and arg_337_1.time_ < var_340_4 + var_340_9 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play410182084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 410182084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play410182085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos10061 = arg_341_1.actors_["10061"].transform.localPosition
				arg_341_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10061", 2)

				for iter_344_0 = 0, arg_341_1.actors_["10061"].transform.childCount - 1 do
					local var_344_0 = arg_341_1.actors_["10061"].transform:GetChild(iter_344_0)

					if var_344_0.name == "" or not string.find(var_344_0.name, "split") then
						var_344_0.gameObject:SetActive(true)
					else
						var_344_0.gameObject:SetActive(false)
					end
				end
			end

			local var_344_1 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_1 then
				arg_341_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10061, Vector3.New(-390, -517.5, -100), (arg_341_1.time_ - 0) / var_344_1)
			end

			if arg_341_1.time_ >= 0 + var_344_1 and arg_341_1.time_ < 0 + var_344_1 + arg_344_0 then
				arg_341_1.actors_["10061"].transform.localPosition = Vector3.New(-390, -517.5, -100)
			end

			local var_344_2 = arg_341_1.actors_["1061"].transform

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1061 = var_344_2.localPosition
				var_344_2.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("1061", 4)

				for iter_344_1 = 0, var_344_2.childCount - 1 do
					local var_344_3 = var_344_2:GetChild(iter_344_1)

					if var_344_3.name == "" or not string.find(var_344_3.name, "split") then
						var_344_3.gameObject:SetActive(true)
					else
						var_344_3.gameObject:SetActive(false)
					end
				end
			end

			local var_344_4 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_4 then
				var_344_2.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1061, Vector3.New(390, -490, 18), (arg_341_1.time_ - 0) / var_344_4)
			end

			if arg_341_1.time_ >= 0 + var_344_4 and arg_341_1.time_ < 0 + var_344_4 + arg_344_0 then
				var_344_2.localPosition = Vector3.New(390, -490, 18)
			end

			local var_344_5 = arg_341_1.actors_["10061"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_5) and arg_341_1.var_.actorSpriteComps10061 == nil then
				arg_341_1.var_.actorSpriteComps10061 = var_344_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_6 = 0.034

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_6 and not isNil(var_344_5) then
				if arg_341_1.var_.actorSpriteComps10061 then
					for iter_344_2, iter_344_3 in pairs(arg_341_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_344_3 then
							if arg_341_1.isInRecall_ then
								iter_344_3.color = Color.New(Mathf.Lerp(iter_344_3.color.r, arg_341_1.hightColor2.r, (arg_341_1.time_ - 0) / var_344_6), Mathf.Lerp(iter_344_3.color.g, arg_341_1.hightColor2.g, (arg_341_1.time_ - 0) / var_344_6), (Mathf.Lerp(iter_344_3.color.b, arg_341_1.hightColor2.b, (arg_341_1.time_ - 0) / var_344_6)))
							else
								local var_344_7 = Mathf.Lerp(iter_344_3.color.r, 0.5, (arg_341_1.time_ - 0) / var_344_6)

								iter_344_3.color = Color.New(var_344_7, var_344_7, var_344_7)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_6 and arg_341_1.time_ < 0 + var_344_6 + arg_344_0 and not isNil(var_344_5) and arg_341_1.var_.actorSpriteComps10061 then
				for iter_344_4, iter_344_5 in pairs(arg_341_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_344_5 then
						iter_344_5.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_341_1.var_.actorSpriteComps10061 = nil
			end

			local var_344_8 = arg_341_1.actors_["1061"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_8) and arg_341_1.var_.actorSpriteComps1061 == nil then
				arg_341_1.var_.actorSpriteComps1061 = var_344_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_9 = 0.034

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_9 and not isNil(var_344_8) then
				if arg_341_1.var_.actorSpriteComps1061 then
					for iter_344_6, iter_344_7 in pairs(arg_341_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_344_7 then
							if arg_341_1.isInRecall_ then
								iter_344_7.color = Color.New(Mathf.Lerp(iter_344_7.color.r, arg_341_1.hightColor2.r, (arg_341_1.time_ - 0) / var_344_9), Mathf.Lerp(iter_344_7.color.g, arg_341_1.hightColor2.g, (arg_341_1.time_ - 0) / var_344_9), (Mathf.Lerp(iter_344_7.color.b, arg_341_1.hightColor2.b, (arg_341_1.time_ - 0) / var_344_9)))
							else
								local var_344_10 = Mathf.Lerp(iter_344_7.color.r, 0.5, (arg_341_1.time_ - 0) / var_344_9)

								iter_344_7.color = Color.New(var_344_10, var_344_10, var_344_10)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_9 and arg_341_1.time_ < 0 + var_344_9 + arg_344_0 and not isNil(var_344_8) and arg_341_1.var_.actorSpriteComps1061 then
				for iter_344_8, iter_344_9 in pairs(arg_341_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_344_9 then
						iter_344_9.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_341_1.var_.actorSpriteComps1061 = nil
			end

			local var_344_11 = 0
			local var_344_12 = 1.2

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_11 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_13 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(410182084).content)

				arg_341_1.text_.text = var_344_13

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_15 = 48 <= 0 and var_344_12 or var_344_12 * (utf8.len(var_344_13) / 48)

				if (48 <= 0 and var_344_12 or var_344_12 * (utf8.len(var_344_13) / 48)) > 0 and var_344_12 < var_344_15 then
					arg_341_1.talkMaxDuration = var_344_15

					if var_344_15 + var_344_11 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_15 + var_344_11
					end
				end

				arg_341_1.text_.text = var_344_13
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_16 = math.max(var_344_12, arg_341_1.talkMaxDuration)

			if var_344_11 <= arg_341_1.time_ and arg_341_1.time_ < var_344_11 + var_344_16 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_11) / var_344_16

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_11 + var_344_16 and arg_341_1.time_ < var_344_11 + var_344_16 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410182085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 410182085
		arg_345_1.duration_ = 3.67

		local var_345_0 = {
			ja = 3.666,
			CriLanguages = 3.266,
			zh = 3.266
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
				arg_345_0:Play410182086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos10061 = arg_345_1.actors_["10061"].transform.localPosition
				arg_345_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("10061", 2)

				for iter_348_0 = 0, arg_345_1.actors_["10061"].transform.childCount - 1 do
					local var_348_0 = arg_345_1.actors_["10061"].transform:GetChild(iter_348_0)

					if var_348_0.name == "" or not string.find(var_348_0.name, "split") then
						var_348_0.gameObject:SetActive(true)
					else
						var_348_0.gameObject:SetActive(false)
					end
				end
			end

			local var_348_1 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_1 then
				arg_345_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10061, Vector3.New(-390, -517.5, -100), (arg_345_1.time_ - 0) / var_348_1)
			end

			if arg_345_1.time_ >= 0 + var_348_1 and arg_345_1.time_ < 0 + var_348_1 + arg_348_0 then
				arg_345_1.actors_["10061"].transform.localPosition = Vector3.New(-390, -517.5, -100)
			end

			local var_348_2 = arg_345_1.actors_["10061"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.actorSpriteComps10061 == nil then
				arg_345_1.var_.actorSpriteComps10061 = var_348_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_3 = 0.034

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_3 and not isNil(var_348_2) then
				if arg_345_1.var_.actorSpriteComps10061 then
					for iter_348_1, iter_348_2 in pairs(arg_345_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_348_2 then
							if arg_345_1.isInRecall_ then
								iter_348_2.color = Color.New(Mathf.Lerp(iter_348_2.color.r, arg_345_1.hightColor1.r, (arg_345_1.time_ - 0) / var_348_3), Mathf.Lerp(iter_348_2.color.g, arg_345_1.hightColor1.g, (arg_345_1.time_ - 0) / var_348_3), (Mathf.Lerp(iter_348_2.color.b, arg_345_1.hightColor1.b, (arg_345_1.time_ - 0) / var_348_3)))
							else
								local var_348_4 = Mathf.Lerp(iter_348_2.color.r, 1, (arg_345_1.time_ - 0) / var_348_3)

								iter_348_2.color = Color.New(var_348_4, var_348_4, var_348_4)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 0 + var_348_3 and arg_345_1.time_ < 0 + var_348_3 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.actorSpriteComps10061 then
				for iter_348_3, iter_348_4 in pairs(arg_345_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_348_4 then
						iter_348_4.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_345_1.var_.actorSpriteComps10061 = nil
			end

			local var_348_5 = 0
			local var_348_6 = 0.1

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_5 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_7 = arg_345_1:GetWordFromCfg(410182085)
				local var_348_8 = arg_345_1:FormatText(var_348_7.content)

				arg_345_1.text_.text = var_348_8

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_10 = 4 <= 0 and var_348_6 or var_348_6 * (utf8.len(var_348_8) / 4)

				if (4 <= 0 and var_348_6 or var_348_6 * (utf8.len(var_348_8) / 4)) > 0 and var_348_6 < var_348_10 then
					arg_345_1.talkMaxDuration = var_348_10

					if var_348_10 + var_348_5 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_5
					end
				end

				arg_345_1.text_.text = var_348_8
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182085", "story_v_out_410182.awb") ~= 0 then
					local var_348_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182085", "story_v_out_410182.awb") / 1000

					if var_348_11 + var_348_5 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_11 + var_348_5
					end

					if var_348_7.prefab_name ~= "" and arg_345_1.actors_[var_348_7.prefab_name] ~= nil then
						local var_348_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_7.prefab_name].transform, "story_v_out_410182", "410182085", "story_v_out_410182.awb")

						arg_345_1:RecordAudio("410182085", var_348_12)
						arg_345_1:RecordAudio("410182085", var_348_12)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_410182", "410182085", "story_v_out_410182.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_410182", "410182085", "story_v_out_410182.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_13 = math.max(var_348_6, arg_345_1.talkMaxDuration)

			if var_348_5 <= arg_345_1.time_ and arg_345_1.time_ < var_348_5 + var_348_13 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_5) / var_348_13

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_5 + var_348_13 and arg_345_1.time_ < var_348_5 + var_348_13 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play410182086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 410182086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play410182087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["10061"]) and arg_349_1.var_.actorSpriteComps10061 == nil then
				arg_349_1.var_.actorSpriteComps10061 = arg_349_1.actors_["10061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_0 = 0.034

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["10061"]) then
				if arg_349_1.var_.actorSpriteComps10061 then
					for iter_352_0, iter_352_1 in pairs(arg_349_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_352_1 then
							if arg_349_1.isInRecall_ then
								iter_352_1.color = Color.New(Mathf.Lerp(iter_352_1.color.r, arg_349_1.hightColor2.r, (arg_349_1.time_ - 0) / var_352_0), Mathf.Lerp(iter_352_1.color.g, arg_349_1.hightColor2.g, (arg_349_1.time_ - 0) / var_352_0), (Mathf.Lerp(iter_352_1.color.b, arg_349_1.hightColor2.b, (arg_349_1.time_ - 0) / var_352_0)))
							else
								local var_352_1 = Mathf.Lerp(iter_352_1.color.r, 0.5, (arg_349_1.time_ - 0) / var_352_0)

								iter_352_1.color = Color.New(var_352_1, var_352_1, var_352_1)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["10061"]) and arg_349_1.var_.actorSpriteComps10061 then
				for iter_352_2, iter_352_3 in pairs(arg_349_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_352_3 then
						iter_352_3.color = arg_349_1.isInRecall_ and (arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_349_1.var_.actorSpriteComps10061 = nil
			end

			local var_352_2 = 0
			local var_352_3 = 1.275

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_2 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_4 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(410182086).content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_6 = 51 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_4) / 51)

				if (51 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_4) / 51)) > 0 and var_352_3 < var_352_6 then
					arg_349_1.talkMaxDuration = var_352_6

					if var_352_6 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_6 + var_352_2
					end
				end

				arg_349_1.text_.text = var_352_4
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_3, arg_349_1.talkMaxDuration)

			if var_352_2 <= arg_349_1.time_ and arg_349_1.time_ < var_352_2 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_2) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_2 + var_352_7 and arg_349_1.time_ < var_352_2 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play410182087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 410182087
		arg_353_1.duration_ = 3.73

		local var_353_0 = {
			ja = 3.633,
			CriLanguages = 3.733,
			zh = 3.733
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
			arg_353_1.auto_ = false
		end

		function arg_353_1.playNext_(arg_355_0)
			arg_353_1.onStoryFinished_()
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos10061 = arg_353_1.actors_["10061"].transform.localPosition
				arg_353_1.actors_["10061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("10061", 2)

				for iter_356_0 = 0, arg_353_1.actors_["10061"].transform.childCount - 1 do
					local var_356_0 = arg_353_1.actors_["10061"].transform:GetChild(iter_356_0)

					if var_356_0.name == "" or not string.find(var_356_0.name, "split") then
						var_356_0.gameObject:SetActive(true)
					else
						var_356_0.gameObject:SetActive(false)
					end
				end
			end

			local var_356_1 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_1 then
				arg_353_1.actors_["10061"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10061, Vector3.New(-390, -517.5, -100), (arg_353_1.time_ - 0) / var_356_1)
			end

			if arg_353_1.time_ >= 0 + var_356_1 and arg_353_1.time_ < 0 + var_356_1 + arg_356_0 then
				arg_353_1.actors_["10061"].transform.localPosition = Vector3.New(-390, -517.5, -100)
			end

			local var_356_2 = arg_353_1.actors_["10061"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps10061 == nil then
				arg_353_1.var_.actorSpriteComps10061 = var_356_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_3 = 0.034

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_3 and not isNil(var_356_2) then
				if arg_353_1.var_.actorSpriteComps10061 then
					for iter_356_1, iter_356_2 in pairs(arg_353_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_356_2 then
							if arg_353_1.isInRecall_ then
								iter_356_2.color = Color.New(Mathf.Lerp(iter_356_2.color.r, arg_353_1.hightColor1.r, (arg_353_1.time_ - 0) / var_356_3), Mathf.Lerp(iter_356_2.color.g, arg_353_1.hightColor1.g, (arg_353_1.time_ - 0) / var_356_3), (Mathf.Lerp(iter_356_2.color.b, arg_353_1.hightColor1.b, (arg_353_1.time_ - 0) / var_356_3)))
							else
								local var_356_4 = Mathf.Lerp(iter_356_2.color.r, 1, (arg_353_1.time_ - 0) / var_356_3)

								iter_356_2.color = Color.New(var_356_4, var_356_4, var_356_4)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_3 and arg_353_1.time_ < 0 + var_356_3 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps10061 then
				for iter_356_3, iter_356_4 in pairs(arg_353_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_356_4 then
						iter_356_4.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_353_1.var_.actorSpriteComps10061 = nil
			end

			local var_356_5 = 0
			local var_356_6 = 0.2

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_5 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_7 = arg_353_1:GetWordFromCfg(410182087)
				local var_356_8 = arg_353_1:FormatText(var_356_7.content)

				arg_353_1.text_.text = var_356_8

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_10 = 8 <= 0 and var_356_6 or var_356_6 * (utf8.len(var_356_8) / 8)

				if (8 <= 0 and var_356_6 or var_356_6 * (utf8.len(var_356_8) / 8)) > 0 and var_356_6 < var_356_10 then
					arg_353_1.talkMaxDuration = var_356_10

					if var_356_10 + var_356_5 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_5
					end
				end

				arg_353_1.text_.text = var_356_8
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182087", "story_v_out_410182.awb") ~= 0 then
					local var_356_11 = manager.audio:GetVoiceLength("story_v_out_410182", "410182087", "story_v_out_410182.awb") / 1000

					if var_356_11 + var_356_5 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_11 + var_356_5
					end

					if var_356_7.prefab_name ~= "" and arg_353_1.actors_[var_356_7.prefab_name] ~= nil then
						local var_356_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_7.prefab_name].transform, "story_v_out_410182", "410182087", "story_v_out_410182.awb")

						arg_353_1:RecordAudio("410182087", var_356_12)
						arg_353_1:RecordAudio("410182087", var_356_12)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_410182", "410182087", "story_v_out_410182.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_410182", "410182087", "story_v_out_410182.awb")
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

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L04g",
		"TextureConfig/Background/ST63",
		"TextureConfig/Background/ST64a"
	},
	voices = {
		"story_v_out_410182.awb"
	}
}
