return {
	Play410152001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410152001
		arg_1_1.duration_ = 6.2

		local var_1_0 = {
			ja = 6.2,
			CriLanguages = 3.7,
			zh = 3.7
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
				arg_1_0:Play410152002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L01f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L01f")
				var_4_0.name = "L01f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L01f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L01f

				arg_1_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L01f" then
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

			local var_4_8 = "1061"

			if arg_1_1.actors_["1061"] == nil then
				local var_4_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

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

			local var_4_11 = arg_1_1.actors_["1061"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1061 = var_4_11.localPosition
				var_4_11.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1061", 3)

				for iter_4_4 = 0, var_4_11.childCount - 1 do
					local var_4_12 = var_4_11:GetChild(iter_4_4)

					if var_4_12.name == "" or not string.find(var_4_12.name, "split") then
						var_4_12.gameObject:SetActive(true)
					else
						var_4_12.gameObject:SetActive(false)
					end
				end
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_1_1.time_ - 2) / var_4_13)
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, -490, 18)
			end

			local var_4_14 = arg_1_1.actors_["1061"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps1061 == nil then
				arg_1_1.var_.actorSpriteComps1061 = var_4_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_15 = 0.034

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.actorSpriteComps1061 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor2.r, (arg_1_1.time_ - 2) / var_4_15), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor2.g, (arg_1_1.time_ - 2) / var_4_15), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor2.b, (arg_1_1.time_ - 2) / var_4_15)))
							else
								local var_4_16 = Mathf.Lerp(iter_4_6.color.r, 0.5, (arg_1_1.time_ - 2) / var_4_15)

								iter_4_6.color = Color.New(var_4_16, var_4_16, var_4_16)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps1061 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_1_1.var_.actorSpriteComps1061 = nil
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

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
			local var_4_24 = 0.225

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_26 = arg_1_1:GetWordFromCfg(410152001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 9 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 9)

				if (9 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 9)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152001", "story_v_out_410152.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_410152", "410152001", "story_v_out_410152.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_410152", "410152001", "story_v_out_410152.awb")

						arg_1_1:RecordAudio("410152001", var_4_31)
						arg_1_1:RecordAudio("410152001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410152", "410152001", "story_v_out_410152.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410152", "410152001", "story_v_out_410152.awb")
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
				actorName = "1061",
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
	Play410152002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410152002
		arg_9_1.duration_ = 4.8

		local var_9_0 = {
			ja = 4.8,
			CriLanguages = 2.466,
			zh = 2.466
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
				arg_9_0:Play410152003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.2

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[588].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(410152002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 8 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 8)

				if (8 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 8)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152002", "story_v_out_410152.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_410152", "410152002", "story_v_out_410152.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_410152", "410152002", "story_v_out_410152.awb")

						arg_9_1:RecordAudio("410152002", var_12_6)
						arg_9_1:RecordAudio("410152002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410152", "410152002", "story_v_out_410152.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410152", "410152002", "story_v_out_410152.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play410152003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410152003
		arg_13_1.duration_ = 5.8

		local var_13_0 = {
			ja = 5.8,
			CriLanguages = 4.166,
			zh = 4.166
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
				arg_13_0:Play410152004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.325

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(410152003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 13 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 13)

				if (13 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 13)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152003", "story_v_out_410152.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_410152", "410152003", "story_v_out_410152.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_410152", "410152003", "story_v_out_410152.awb")

						arg_13_1:RecordAudio("410152003", var_16_6)
						arg_13_1:RecordAudio("410152003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410152", "410152003", "story_v_out_410152.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410152", "410152003", "story_v_out_410152.awb")
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
	Play410152004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410152004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play410152005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.2

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(410152004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 48 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 48)

				if (48 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 48)) > 0 and var_20_0 < var_20_3 then
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
	Play410152005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410152005
		arg_21_1.duration_ = 5.83

		local var_21_0 = {
			ja = 5.833,
			CriLanguages = 4.233,
			zh = 4.233
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
				arg_21_0:Play410152006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.475

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(410152005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 21 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 21)

				if (21 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 21)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152005", "story_v_out_410152.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_410152", "410152005", "story_v_out_410152.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_410152", "410152005", "story_v_out_410152.awb")

						arg_21_1:RecordAudio("410152005", var_24_6)
						arg_21_1:RecordAudio("410152005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410152", "410152005", "story_v_out_410152.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410152", "410152005", "story_v_out_410152.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play410152006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410152006
		arg_25_1.duration_ = 7.87

		local var_25_0 = {
			ja = 7.866,
			CriLanguages = 6.7,
			zh = 6.7
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
				arg_25_0:Play410152007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1061 = arg_25_1.actors_["1061"].transform.localPosition
				arg_25_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1061", 3)

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
				arg_25_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
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

			local var_28_5 = 0
			local var_28_6 = 0.75

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
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

				local var_28_7 = arg_25_1:GetWordFromCfg(410152006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 30 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 30)

				if (30 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 30)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152006", "story_v_out_410152.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_410152", "410152006", "story_v_out_410152.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_410152", "410152006", "story_v_out_410152.awb")

						arg_25_1:RecordAudio("410152006", var_28_12)
						arg_25_1:RecordAudio("410152006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410152", "410152006", "story_v_out_410152.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410152", "410152006", "story_v_out_410152.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_13 and arg_25_1.time_ < var_28_5 + var_28_13 + arg_28_0 then
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
	Play410152007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410152007
		arg_29_1.duration_ = 6.5

		local var_29_0 = {
			ja = 6.5,
			CriLanguages = 4.333,
			zh = 4.333
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
				arg_29_0:Play410152008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1061 = arg_29_1.actors_["1061"].transform.localPosition
				arg_29_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1061", 3)

				for iter_32_0 = 0, arg_29_1.actors_["1061"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["1061"].transform:GetChild(iter_32_0)

					if var_32_0.name == "split_5" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
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
			local var_32_6 = 0.475

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

				local var_32_7 = arg_29_1:GetWordFromCfg(410152007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 19 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 19)

				if (19 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 19)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152007", "story_v_out_410152.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_410152", "410152007", "story_v_out_410152.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_410152", "410152007", "story_v_out_410152.awb")

						arg_29_1:RecordAudio("410152007", var_32_12)
						arg_29_1:RecordAudio("410152007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410152", "410152007", "story_v_out_410152.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410152", "410152007", "story_v_out_410152.awb")
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
	Play410152008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410152008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play410152009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1061"]) and arg_33_1.var_.actorSpriteComps1061 == nil then
				arg_33_1.var_.actorSpriteComps1061 = arg_33_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1061"]) then
				if arg_33_1.var_.actorSpriteComps1061 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								iter_36_1.color = Color.New(Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_0), Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_0), (Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_0)))
							else
								local var_36_1 = Mathf.Lerp(iter_36_1.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_0)

								iter_36_1.color = Color.New(var_36_1, var_36_1, var_36_1)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1061"]) and arg_33_1.var_.actorSpriteComps1061 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps1061 = nil
			end

			local var_36_2 = 0
			local var_36_3 = 1.65

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(410152008).content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 66 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 66)

				if (66 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 66)) > 0 and var_36_3 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_7 and arg_33_1.time_ < var_36_2 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play410152009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410152009
		arg_37_1.duration_ = 6.27

		local var_37_0 = {
			ja = 6.266,
			CriLanguages = 5.3,
			zh = 5.3
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
				arg_37_0:Play410152010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.375

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[588].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(410152009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 25 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 25)

				if (25 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 25)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152009", "story_v_out_410152.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_410152", "410152009", "story_v_out_410152.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_410152", "410152009", "story_v_out_410152.awb")

						arg_37_1:RecordAudio("410152009", var_40_6)
						arg_37_1:RecordAudio("410152009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410152", "410152009", "story_v_out_410152.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410152", "410152009", "story_v_out_410152.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play410152010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410152010
		arg_41_1.duration_ = 17.27

		local var_41_0 = {
			ja = 17.266,
			CriLanguages = 7.466,
			zh = 7.466
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
				arg_41_0:Play410152011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1061 = arg_41_1.actors_["1061"].transform.localPosition
				arg_41_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1061", 3)

				for iter_44_0 = 0, arg_41_1.actors_["1061"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["1061"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
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

			local var_44_5 = 0
			local var_44_6 = 0.65

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
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

				local var_44_7 = arg_41_1:GetWordFromCfg(410152010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 26 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 26)

				if (26 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 26)) > 0 and var_44_6 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152010", "story_v_out_410152.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_410152", "410152010", "story_v_out_410152.awb") / 1000

					if var_44_11 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_5
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_410152", "410152010", "story_v_out_410152.awb")

						arg_41_1:RecordAudio("410152010", var_44_12)
						arg_41_1:RecordAudio("410152010", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410152", "410152010", "story_v_out_410152.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410152", "410152010", "story_v_out_410152.awb")
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
	Play410152011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410152011
		arg_45_1.duration_ = 7.1

		local var_45_0 = {
			ja = 7.1,
			CriLanguages = 6.6,
			zh = 6.6
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
				arg_45_0:Play410152012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1061 = arg_45_1.actors_["1061"].transform.localPosition
				arg_45_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1061", 3)

				for iter_48_0 = 0, arg_45_1.actors_["1061"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["1061"].transform:GetChild(iter_48_0)

					if var_48_0.name == "" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_48_2 = arg_45_1.actors_["1061"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps1061 == nil then
				arg_45_1.var_.actorSpriteComps1061 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps1061 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps1061 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_48_4 then
						iter_48_4.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps1061 = nil
			end

			local var_48_5 = 0
			local var_48_6 = 0.85

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(410152011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 34 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 34)

				if (34 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 34)) > 0 and var_48_6 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152011", "story_v_out_410152.awb") ~= 0 then
					local var_48_11 = manager.audio:GetVoiceLength("story_v_out_410152", "410152011", "story_v_out_410152.awb") / 1000

					if var_48_11 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_5
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_410152", "410152011", "story_v_out_410152.awb")

						arg_45_1:RecordAudio("410152011", var_48_12)
						arg_45_1:RecordAudio("410152011", var_48_12)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410152", "410152011", "story_v_out_410152.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410152", "410152011", "story_v_out_410152.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_13 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_13 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_13

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_13 and arg_45_1.time_ < var_48_5 + var_48_13 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play410152012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410152012
		arg_49_1.duration_ = 10.8

		local var_49_0 = {
			ja = 10.8,
			CriLanguages = 5.9,
			zh = 5.9
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
				arg_49_0:Play410152013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.bgs_.L02f == nil then
				local var_52_0 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L02f")
				var_52_0.name = "L02f"
				var_52_0.transform.parent = arg_49_1.stage_.transform
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_.L02f = var_52_0
			end

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 then
				local var_52_1 = arg_49_1.bgs_.L02f

				arg_49_1.bgs_.L02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_52_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_2 = var_52_1:GetComponent("SpriteRenderer")

				if var_52_2 and var_52_2.sprite then
					local var_52_3 = 2 * (var_52_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_52_1.transform.localScale = Vector3.New(var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "L02f" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_4 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_5 = 2

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_5 then
				local var_52_6 = Color.New(0, 0, 0)

				var_52_6.a = Mathf.Lerp(0, 1, (arg_49_1.time_ - var_52_4) / var_52_5)
				arg_49_1.mask_.color = var_52_6
			end

			if arg_49_1.time_ >= var_52_4 + var_52_5 and arg_49_1.time_ < var_52_4 + var_52_5 + arg_52_0 then
				local var_52_7 = Color.New(0, 0, 0)

				var_52_7.a = 1
				arg_49_1.mask_.color = var_52_7
			end

			local var_52_8 = 2

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_9 = 2

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 then
				local var_52_10 = Color.New(0, 0, 0)

				var_52_10.a = Mathf.Lerp(1, 0, (arg_49_1.time_ - var_52_8) / var_52_9)
				arg_49_1.mask_.color = var_52_10
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 then
				local var_52_11 = Color.New(0, 0, 0)

				arg_49_1.mask_.enabled = false
				var_52_11.a = 0
				arg_49_1.mask_.color = var_52_11
			end

			local var_52_12 = arg_49_1.actors_["1061"].transform

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 then
				arg_49_1.var_.moveOldPos1061 = var_52_12.localPosition
				var_52_12.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1061", 7)

				for iter_52_2 = 0, var_52_12.childCount - 1 do
					local var_52_13 = var_52_12:GetChild(iter_52_2)

					if var_52_13.name == "" or not string.find(var_52_13.name, "split") then
						var_52_13.gameObject:SetActive(true)
					else
						var_52_13.gameObject:SetActive(false)
					end
				end
			end

			local var_52_14 = 0.001

			if 2 <= arg_49_1.time_ and arg_49_1.time_ < 2 + var_52_14 then
				var_52_12.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_49_1.time_ - 2) / var_52_14)
			end

			if arg_49_1.time_ >= 2 + var_52_14 and arg_49_1.time_ < 2 + var_52_14 + arg_52_0 then
				var_52_12.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_52_15 = arg_49_1.actors_["1061"]

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= 4 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps1061 == nil then
				arg_49_1.var_.actorSpriteComps1061 = var_52_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_16 = 0.034

			if 4 <= arg_49_1.time_ and arg_49_1.time_ < 4 + var_52_16 and not isNil(var_52_15) then
				if arg_49_1.var_.actorSpriteComps1061 then
					for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_52_4 then
							if arg_49_1.isInRecall_ then
								iter_52_4.color = Color.New(Mathf.Lerp(iter_52_4.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 4) / var_52_16), Mathf.Lerp(iter_52_4.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 4) / var_52_16), (Mathf.Lerp(iter_52_4.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 4) / var_52_16)))
							else
								local var_52_17 = Mathf.Lerp(iter_52_4.color.r, 1, (arg_49_1.time_ - 4) / var_52_16)

								iter_52_4.color = Color.New(var_52_17, var_52_17, var_52_17)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 4 + var_52_16 and arg_49_1.time_ < 4 + var_52_16 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps1061 then
				for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_52_6 then
						iter_52_6.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps1061 = nil
			end

			local var_52_18 = arg_49_1.actors_["1061"].transform

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= 4 + arg_52_0 then
				arg_49_1.var_.moveOldPos1061 = var_52_18.localPosition
				var_52_18.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1061", 3)

				for iter_52_7 = 0, var_52_18.childCount - 1 do
					local var_52_19 = var_52_18:GetChild(iter_52_7)

					if var_52_19.name == "" or not string.find(var_52_19.name, "split") then
						var_52_19.gameObject:SetActive(true)
					else
						var_52_19.gameObject:SetActive(false)
					end
				end
			end

			local var_52_20 = 0.001

			if 4 <= arg_49_1.time_ and arg_49_1.time_ < 4 + var_52_20 then
				var_52_18.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_49_1.time_ - 4) / var_52_20)
			end

			if arg_49_1.time_ >= 4 + var_52_20 and arg_49_1.time_ < 4 + var_52_20 + arg_52_0 then
				var_52_18.localPosition = Vector3.New(0, -490, 18)
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_21 = 4
			local var_52_22 = 0.15

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_21 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_23 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_23:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_24 = arg_49_1:GetWordFromCfg(410152012)
				local var_52_25 = arg_49_1:FormatText(var_52_24.content)

				arg_49_1.text_.text = var_52_25

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_27 = 6 <= 0 and var_52_22 or var_52_22 * (utf8.len(var_52_25) / 6)

				if (6 <= 0 and var_52_22 or var_52_22 * (utf8.len(var_52_25) / 6)) > 0 and var_52_22 < var_52_27 then
					arg_49_1.talkMaxDuration = var_52_27
					var_52_21 = var_52_21 + 0.3

					if var_52_27 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_27 + var_52_21
					end
				end

				arg_49_1.text_.text = var_52_25
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152012", "story_v_out_410152.awb") ~= 0 then
					local var_52_28 = manager.audio:GetVoiceLength("story_v_out_410152", "410152012", "story_v_out_410152.awb") / 1000

					if var_52_28 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_28 + var_52_21
					end

					if var_52_24.prefab_name ~= "" and arg_49_1.actors_[var_52_24.prefab_name] ~= nil then
						local var_52_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_24.prefab_name].transform, "story_v_out_410152", "410152012", "story_v_out_410152.awb")

						arg_49_1:RecordAudio("410152012", var_52_29)
						arg_49_1:RecordAudio("410152012", var_52_29)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410152", "410152012", "story_v_out_410152.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410152", "410152012", "story_v_out_410152.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_30 = var_52_21 + 0.3
			local var_52_31 = math.max(var_52_22, arg_49_1.talkMaxDuration)

			if var_52_21 + 0.3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_30 + var_52_31 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_30) / var_52_31

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_30 + var_52_31 and arg_49_1.time_ < var_52_30 + var_52_31 + arg_52_0 then
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
				duration = 0.0339999999999998,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0339999999999998,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play410152013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 410152013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play410152014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1061"]) and arg_55_1.var_.actorSpriteComps1061 == nil then
				arg_55_1.var_.actorSpriteComps1061 = arg_55_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_0 = 0.034

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1061"]) then
				if arg_55_1.var_.actorSpriteComps1061 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								iter_58_1.color = Color.New(Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor2.r, (arg_55_1.time_ - 0) / var_58_0), Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor2.g, (arg_55_1.time_ - 0) / var_58_0), (Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor2.b, (arg_55_1.time_ - 0) / var_58_0)))
							else
								local var_58_1 = Mathf.Lerp(iter_58_1.color.r, 0.5, (arg_55_1.time_ - 0) / var_58_0)

								iter_58_1.color = Color.New(var_58_1, var_58_1, var_58_1)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1061"]) and arg_55_1.var_.actorSpriteComps1061 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_58_3 then
						iter_58_3.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_55_1.var_.actorSpriteComps1061 = nil
			end

			local var_58_2 = 0
			local var_58_3 = 1.525

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_2 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_4 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(410152013).content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_6 = 61 <= 0 and var_58_3 or var_58_3 * (utf8.len(var_58_4) / 61)

				if (61 <= 0 and var_58_3 or var_58_3 * (utf8.len(var_58_4) / 61)) > 0 and var_58_3 < var_58_6 then
					arg_55_1.talkMaxDuration = var_58_6

					if var_58_6 + var_58_2 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_2
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_3, arg_55_1.talkMaxDuration)

			if var_58_2 <= arg_55_1.time_ and arg_55_1.time_ < var_58_2 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_2) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_2 + var_58_7 and arg_55_1.time_ < var_58_2 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play410152014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 410152014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play410152015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 1.575

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(410152014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 63 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 63)

				if (63 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 63)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play410152015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 410152015
		arg_63_1.duration_ = 4.2

		local var_63_0 = {
			ja = 4.2,
			CriLanguages = 2.966,
			zh = 2.966
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play410152016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1061 = arg_63_1.actors_["1061"].transform.localPosition
				arg_63_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("1061", 3)

				for iter_66_0 = 0, arg_63_1.actors_["1061"].transform.childCount - 1 do
					local var_66_0 = arg_63_1.actors_["1061"].transform:GetChild(iter_66_0)

					if var_66_0.name == "split_5" or not string.find(var_66_0.name, "split") then
						var_66_0.gameObject:SetActive(true)
					else
						var_66_0.gameObject:SetActive(false)
					end
				end
			end

			local var_66_1 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_1 then
				arg_63_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_63_1.time_ - 0) / var_66_1)
			end

			if arg_63_1.time_ >= 0 + var_66_1 and arg_63_1.time_ < 0 + var_66_1 + arg_66_0 then
				arg_63_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_66_2 = arg_63_1.actors_["1061"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps1061 == nil then
				arg_63_1.var_.actorSpriteComps1061 = var_66_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_3 = 0.034

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.actorSpriteComps1061 then
					for iter_66_1, iter_66_2 in pairs(arg_63_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_66_2 then
							if arg_63_1.isInRecall_ then
								iter_66_2.color = Color.New(Mathf.Lerp(iter_66_2.color.r, arg_63_1.hightColor1.r, (arg_63_1.time_ - 0) / var_66_3), Mathf.Lerp(iter_66_2.color.g, arg_63_1.hightColor1.g, (arg_63_1.time_ - 0) / var_66_3), (Mathf.Lerp(iter_66_2.color.b, arg_63_1.hightColor1.b, (arg_63_1.time_ - 0) / var_66_3)))
							else
								local var_66_4 = Mathf.Lerp(iter_66_2.color.r, 1, (arg_63_1.time_ - 0) / var_66_3)

								iter_66_2.color = Color.New(var_66_4, var_66_4, var_66_4)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps1061 then
				for iter_66_3, iter_66_4 in pairs(arg_63_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_66_4 then
						iter_66_4.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_63_1.var_.actorSpriteComps1061 = nil
			end

			local var_66_5 = 0
			local var_66_6 = 0.375

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_7 = arg_63_1:GetWordFromCfg(410152015)
				local var_66_8 = arg_63_1:FormatText(var_66_7.content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 15 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 15)

				if (15 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 15)) > 0 and var_66_6 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_5
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152015", "story_v_out_410152.awb") ~= 0 then
					local var_66_11 = manager.audio:GetVoiceLength("story_v_out_410152", "410152015", "story_v_out_410152.awb") / 1000

					if var_66_11 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_5
					end

					if var_66_7.prefab_name ~= "" and arg_63_1.actors_[var_66_7.prefab_name] ~= nil then
						local var_66_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_7.prefab_name].transform, "story_v_out_410152", "410152015", "story_v_out_410152.awb")

						arg_63_1:RecordAudio("410152015", var_66_12)
						arg_63_1:RecordAudio("410152015", var_66_12)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_410152", "410152015", "story_v_out_410152.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_410152", "410152015", "story_v_out_410152.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_13 = math.max(var_66_6, arg_63_1.talkMaxDuration)

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_13 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_5) / var_66_13

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_5 + var_66_13 and arg_63_1.time_ < var_66_5 + var_66_13 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play410152016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 410152016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play410152017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1061"]) and arg_67_1.var_.actorSpriteComps1061 == nil then
				arg_67_1.var_.actorSpriteComps1061 = arg_67_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_0 = 0.034

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1061"]) then
				if arg_67_1.var_.actorSpriteComps1061 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_70_1 then
							if arg_67_1.isInRecall_ then
								iter_70_1.color = Color.New(Mathf.Lerp(iter_70_1.color.r, arg_67_1.hightColor2.r, (arg_67_1.time_ - 0) / var_70_0), Mathf.Lerp(iter_70_1.color.g, arg_67_1.hightColor2.g, (arg_67_1.time_ - 0) / var_70_0), (Mathf.Lerp(iter_70_1.color.b, arg_67_1.hightColor2.b, (arg_67_1.time_ - 0) / var_70_0)))
							else
								local var_70_1 = Mathf.Lerp(iter_70_1.color.r, 0.5, (arg_67_1.time_ - 0) / var_70_0)

								iter_70_1.color = Color.New(var_70_1, var_70_1, var_70_1)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1061"]) and arg_67_1.var_.actorSpriteComps1061 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_70_3 then
						iter_70_3.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_67_1.var_.actorSpriteComps1061 = nil
			end

			local var_70_2 = 0
			local var_70_3 = 1.025

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(410152016).content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_6 = 41 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_4) / 41)

				if (41 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_4) / 41)) > 0 and var_70_3 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_3, arg_67_1.talkMaxDuration)

			if var_70_2 <= arg_67_1.time_ and arg_67_1.time_ < var_70_2 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_2) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_2 + var_70_7 and arg_67_1.time_ < var_70_2 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play410152017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 410152017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play410152018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 1.45

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(410152017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 58 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 58)

				if (58 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 58)) > 0 and var_74_0 < var_74_3 then
					arg_71_1.talkMaxDuration = var_74_3

					if var_74_3 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_3 + 0
					end
				end

				arg_71_1.text_.text = var_74_1
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_4 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_4

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play410152018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 410152018
		arg_75_1.duration_ = 7.73

		local var_75_0 = {
			ja = 7.733,
			CriLanguages = 3.733,
			zh = 3.733
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play410152019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1061 = arg_75_1.actors_["1061"].transform.localPosition
				arg_75_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1061", 3)

				for iter_78_0 = 0, arg_75_1.actors_["1061"].transform.childCount - 1 do
					local var_78_0 = arg_75_1.actors_["1061"].transform:GetChild(iter_78_0)

					if var_78_0.name == "split_2" or not string.find(var_78_0.name, "split") then
						var_78_0.gameObject:SetActive(true)
					else
						var_78_0.gameObject:SetActive(false)
					end
				end
			end

			local var_78_1 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 then
				arg_75_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_75_1.time_ - 0) / var_78_1)
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 then
				arg_75_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_78_2 = arg_75_1.actors_["1061"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps1061 == nil then
				arg_75_1.var_.actorSpriteComps1061 = var_78_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_3 = 0.034

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.actorSpriteComps1061 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_78_2 then
							if arg_75_1.isInRecall_ then
								iter_78_2.color = Color.New(Mathf.Lerp(iter_78_2.color.r, arg_75_1.hightColor1.r, (arg_75_1.time_ - 0) / var_78_3), Mathf.Lerp(iter_78_2.color.g, arg_75_1.hightColor1.g, (arg_75_1.time_ - 0) / var_78_3), (Mathf.Lerp(iter_78_2.color.b, arg_75_1.hightColor1.b, (arg_75_1.time_ - 0) / var_78_3)))
							else
								local var_78_4 = Mathf.Lerp(iter_78_2.color.r, 1, (arg_75_1.time_ - 0) / var_78_3)

								iter_78_2.color = Color.New(var_78_4, var_78_4, var_78_4)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps1061 then
				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_78_4 then
						iter_78_4.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_75_1.var_.actorSpriteComps1061 = nil
			end

			local var_78_5 = 0
			local var_78_6 = 0.45

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_7 = arg_75_1:GetWordFromCfg(410152018)
				local var_78_8 = arg_75_1:FormatText(var_78_7.content)

				arg_75_1.text_.text = var_78_8

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 18 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 18)

				if (18 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 18)) > 0 and var_78_6 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_5
					end
				end

				arg_75_1.text_.text = var_78_8
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152018", "story_v_out_410152.awb") ~= 0 then
					local var_78_11 = manager.audio:GetVoiceLength("story_v_out_410152", "410152018", "story_v_out_410152.awb") / 1000

					if var_78_11 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_5
					end

					if var_78_7.prefab_name ~= "" and arg_75_1.actors_[var_78_7.prefab_name] ~= nil then
						local var_78_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_7.prefab_name].transform, "story_v_out_410152", "410152018", "story_v_out_410152.awb")

						arg_75_1:RecordAudio("410152018", var_78_12)
						arg_75_1:RecordAudio("410152018", var_78_12)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_410152", "410152018", "story_v_out_410152.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_410152", "410152018", "story_v_out_410152.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_13 = math.max(var_78_6, arg_75_1.talkMaxDuration)

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_13 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_5) / var_78_13

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_5 + var_78_13 and arg_75_1.time_ < var_78_5 + var_78_13 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play410152019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 410152019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play410152020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1061"]) and arg_79_1.var_.actorSpriteComps1061 == nil then
				arg_79_1.var_.actorSpriteComps1061 = arg_79_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_0 = 0.034

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1061"]) then
				if arg_79_1.var_.actorSpriteComps1061 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								iter_82_1.color = Color.New(Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor2.r, (arg_79_1.time_ - 0) / var_82_0), Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor2.g, (arg_79_1.time_ - 0) / var_82_0), (Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor2.b, (arg_79_1.time_ - 0) / var_82_0)))
							else
								local var_82_1 = Mathf.Lerp(iter_82_1.color.r, 0.5, (arg_79_1.time_ - 0) / var_82_0)

								iter_82_1.color = Color.New(var_82_1, var_82_1, var_82_1)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1061"]) and arg_79_1.var_.actorSpriteComps1061 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps1061 = nil
			end

			local var_82_2 = 0
			local var_82_3 = 1.1

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(410152019).content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_6 = 44 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_4) / 44)

				if (44 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_4) / 44)) > 0 and var_82_3 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_7 and arg_79_1.time_ < var_82_2 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play410152020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410152020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play410152021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_129", "se_story_129_information_loop", "")
			end

			local var_86_1 = 0
			local var_86_2 = 0.9

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(410152020).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 36 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 36)

				if (36 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 36)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play410152021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 410152021
		arg_87_1.duration_ = 9

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play410152022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.bgs_.STblack == nil then
				local var_90_0 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_90_0.name = "STblack"
				var_90_0.transform.parent = arg_87_1.stage_.transform
				var_90_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_.STblack = var_90_0
			end

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= 2 + arg_90_0 then
				local var_90_1 = arg_87_1.bgs_.STblack

				arg_87_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_90_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_2 = var_90_1:GetComponent("SpriteRenderer")

				if var_90_2 and var_90_2.sprite then
					local var_90_3 = 2 * (var_90_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_90_1.transform.localScale = Vector3.New(var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "STblack" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_4 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_5 = 2

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_5 then
				local var_90_6 = Color.New(0, 0, 0)

				var_90_6.a = Mathf.Lerp(0, 1, (arg_87_1.time_ - var_90_4) / var_90_5)
				arg_87_1.mask_.color = var_90_6
			end

			if arg_87_1.time_ >= var_90_4 + var_90_5 and arg_87_1.time_ < var_90_4 + var_90_5 + arg_90_0 then
				local var_90_7 = Color.New(0, 0, 0)

				var_90_7.a = 1
				arg_87_1.mask_.color = var_90_7
			end

			local var_90_8 = 2

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_9 = 2

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_9 then
				local var_90_10 = Color.New(0, 0, 0)

				var_90_10.a = Mathf.Lerp(1, 0, (arg_87_1.time_ - var_90_8) / var_90_9)
				arg_87_1.mask_.color = var_90_10
			end

			if arg_87_1.time_ >= var_90_8 + var_90_9 and arg_87_1.time_ < var_90_8 + var_90_9 + arg_90_0 then
				local var_90_11 = Color.New(0, 0, 0)

				arg_87_1.mask_.enabled = false
				var_90_11.a = 0
				arg_87_1.mask_.color = var_90_11
			end

			local var_90_12 = arg_87_1.actors_["1061"].transform

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= 2 + arg_90_0 then
				arg_87_1.var_.moveOldPos1061 = var_90_12.localPosition
				var_90_12.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1061", 7)

				for iter_90_2 = 0, var_90_12.childCount - 1 do
					local var_90_13 = var_90_12:GetChild(iter_90_2)

					if var_90_13.name == "" or not string.find(var_90_13.name, "split") then
						var_90_13.gameObject:SetActive(true)
					else
						var_90_13.gameObject:SetActive(false)
					end
				end
			end

			local var_90_14 = 0.001

			if 2 <= arg_87_1.time_ and arg_87_1.time_ < 2 + var_90_14 then
				var_90_12.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_87_1.time_ - 2) / var_90_14)
			end

			if arg_87_1.time_ >= 2 + var_90_14 and arg_87_1.time_ < 2 + var_90_14 + arg_90_0 then
				var_90_12.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_90_15 = arg_87_1.actors_["1061"]

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= 2 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.actorSpriteComps1061 == nil then
				arg_87_1.var_.actorSpriteComps1061 = var_90_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_16 = 0.034

			if 2 <= arg_87_1.time_ and arg_87_1.time_ < 2 + var_90_16 and not isNil(var_90_15) then
				if arg_87_1.var_.actorSpriteComps1061 then
					for iter_90_3, iter_90_4 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_90_4 then
							if arg_87_1.isInRecall_ then
								iter_90_4.color = Color.New(Mathf.Lerp(iter_90_4.color.r, arg_87_1.hightColor2.r, (arg_87_1.time_ - 2) / var_90_16), Mathf.Lerp(iter_90_4.color.g, arg_87_1.hightColor2.g, (arg_87_1.time_ - 2) / var_90_16), (Mathf.Lerp(iter_90_4.color.b, arg_87_1.hightColor2.b, (arg_87_1.time_ - 2) / var_90_16)))
							else
								local var_90_17 = Mathf.Lerp(iter_90_4.color.r, 0.5, (arg_87_1.time_ - 2) / var_90_16)

								iter_90_4.color = Color.New(var_90_17, var_90_17, var_90_17)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 2 + var_90_16 and arg_87_1.time_ < 2 + var_90_16 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.actorSpriteComps1061 then
				for iter_90_5, iter_90_6 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_90_6 then
						iter_90_6.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_87_1.var_.actorSpriteComps1061 = nil
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_18 = 4
			local var_90_19 = 0.225

			if 4 < arg_87_1.time_ and arg_87_1.time_ <= var_90_18 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_20 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_20:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_21 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(410152021).content)

				arg_87_1.text_.text = var_90_21

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_23 = 9 <= 0 and var_90_19 or var_90_19 * (utf8.len(var_90_21) / 9)

				if (9 <= 0 and var_90_19 or var_90_19 * (utf8.len(var_90_21) / 9)) > 0 and var_90_19 < var_90_23 then
					arg_87_1.talkMaxDuration = var_90_23
					var_90_18 = var_90_18 + 0.3

					if var_90_23 + var_90_18 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_23 + var_90_18
					end
				end

				arg_87_1.text_.text = var_90_21
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_24 = var_90_18 + 0.3
			local var_90_25 = math.max(var_90_19, arg_87_1.talkMaxDuration)

			if var_90_18 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_24 + var_90_25 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_24) / var_90_25

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_24 + var_90_25 and arg_87_1.time_ < var_90_24 + var_90_25 + arg_90_0 then
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
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play410152022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410152022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play410152023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.7

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(410152022).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 28 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 28)

				if (28 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 28)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play410152023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410152023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play410152024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.925

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(410152023).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 37 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 37)

				if (37 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 37)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play410152024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410152024
		arg_101_1.duration_ = 11.37

		local var_101_0 = {
			ja = 11.366,
			CriLanguages = 10.499999999999,
			zh = 10.499999999999
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
				arg_101_0:Play410152025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_9000

			if arg_101_1.bgs_.LZ0202 == nil then
				local var_104_0 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "LZ0202")
				var_104_0.name = "LZ0202"
				var_104_0.transform.parent = arg_101_1.stage_.transform
				var_104_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_.LZ0202 = var_104_0
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				local var_104_1 = arg_101_1.bgs_.LZ0202

				arg_101_1.bgs_.LZ0202.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_104_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_2 = var_104_1:GetComponent("SpriteRenderer")

				if var_104_2 and var_104_2.sprite then
					local var_104_3 = 2 * (var_104_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_104_1.transform.localScale = Vector3.New(var_104_3 / var_104_2.sprite.bounds.size.y < var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x and var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x or var_104_3 / var_104_2.sprite.bounds.size.y, var_104_3 / var_104_2.sprite.bounds.size.y < var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x and var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x or var_104_3 / var_104_2.sprite.bounds.size.y, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "LZ0202" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_4 = 0

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_5 = 2

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_5 then
				local var_104_6 = Color.New(0, 0, 0)

				var_104_6.a = Mathf.Lerp(1, 0, (arg_101_1.time_ - var_104_4) / var_104_5)
				arg_101_1.mask_.color = var_104_6
			end

			if arg_101_1.time_ >= var_104_4 + var_104_5 and arg_101_1.time_ < var_104_4 + var_104_5 + arg_104_0 then
				local var_104_7 = Color.New(0, 0, 0)

				arg_101_1.mask_.enabled = false
				var_104_7.a = 0
				arg_101_1.mask_.color = var_104_7
			end

			local var_104_8 = arg_101_1.bgs_.LZ0202.transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPosLZ0202 = var_104_8.localPosition
			end

			local var_104_9 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_9 then
				var_104_8.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPosLZ0202, Vector3.New(-1, 0, 5), (arg_101_1.time_ - 0) / var_104_9)
			end

			if arg_101_1.time_ >= 0 + var_104_9 and arg_101_1.time_ < 0 + var_104_9 + arg_104_0 then
				var_104_8.localPosition = Vector3.New(-1, 0, 5)
			end

			local var_104_10 = arg_101_1.bgs_.LZ0202.transform

			if 0.034 < arg_101_1.time_ and arg_101_1.time_ <= 0.034 + arg_104_0 then
				arg_101_1.var_.moveOldPosLZ0202 = var_104_10.localPosition
			end

			local var_104_11 = 8.068

			if 0.034 <= arg_101_1.time_ and arg_101_1.time_ < 0.034 + var_104_11 then
				var_104_10.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPosLZ0202, Vector3.New(0, 0, 5.5), (arg_101_1.time_ - 0.034) / var_104_11)
			end

			if arg_101_1.time_ >= 0.034 + var_104_11 and arg_101_1.time_ < 0.034 + var_104_11 + arg_104_0 then
				var_104_10.localPosition = Vector3.New(0, 0, 5.5)
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				local var_104_12 = arg_101_1.var_.effectshujukongjian1

				if not arg_101_1.var_.effectshujukongjian1 then
					var_104_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_scence_pingmu_niuqu"), manager.ui.mainCamera.transform)
					var_104_12.name = "shujukongjian1"
					arg_101_1.var_.effectshujukongjian1 = var_104_12
				else
					var_104_12.transform:SetParent(var_104_9000)
				end

				var_104_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_104_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.5 < arg_101_1.time_ and arg_101_1.time_ <= 0.5 + arg_104_0 then
				if arg_101_1.var_.effectshujukongjian1 then
					Object.Destroy(arg_101_1.var_.effectshujukongjian1)

					arg_101_1.var_.effectshujukongjian1 = nil
				end
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_15 = 2.00000000000001
			local var_104_16 = 0.375

			if 2.00000000000001 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_17 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_17:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(410152024)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_21 = 15 <= 0 and var_104_16 or var_104_16 * (utf8.len(var_104_19) / 15)

				if (15 <= 0 and var_104_16 or var_104_16 * (utf8.len(var_104_19) / 15)) > 0 and var_104_16 < var_104_21 then
					arg_101_1.talkMaxDuration = var_104_21
					var_104_15 = var_104_15 + 0.3

					if var_104_21 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_21 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_19
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152024", "story_v_out_410152.awb") ~= 0 then
					local var_104_22 = manager.audio:GetVoiceLength("story_v_out_410152", "410152024", "story_v_out_410152.awb") / 1000

					if var_104_22 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_out_410152", "410152024", "story_v_out_410152.awb")

						arg_101_1:RecordAudio("410152024", var_104_23)
						arg_101_1:RecordAudio("410152024", var_104_23)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_410152", "410152024", "story_v_out_410152.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_410152", "410152024", "story_v_out_410152.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_24 = var_104_15 + 0.3
			local var_104_25 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 + 0.3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_24 + var_104_25 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_24) / var_104_25

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_24 + var_104_25 and arg_101_1.time_ < var_104_24 + var_104_25 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "LZ0202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LZ0202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 8.068,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play410152025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410152025
		arg_107_1.duration_ = 5.2

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play410152026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPosLZ0202 = arg_107_1.bgs_.LZ0202.transform.localPosition
			end

			local var_110_0 = 5

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.bgs_.LZ0202.transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPosLZ0202, Vector3.New(0, 0.9, 9), (arg_107_1.time_ - 0) / var_110_0)
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.bgs_.LZ0202.transform.localPosition = Vector3.New(0, 0.9, 9)
			end

			local var_110_1 = 0
			local var_110_2 = 1.425

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(410152025).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 57 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 57)

				if (57 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 57)) > 0 and var_110_2 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_6 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_6

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_6 and arg_107_1.time_ < var_110_1 + var_110_6 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "LZ0202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play410152026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410152026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play410152027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 1

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(410152026).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 40 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 40)

				if (40 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 40)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play410152027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410152027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play410152028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 1.05

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(410152027).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 42 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 42)

				if (42 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 42)) > 0 and var_118_0 < var_118_3 then
					arg_115_1.talkMaxDuration = var_118_3

					if var_118_3 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_3 + 0
					end
				end

				arg_115_1.text_.text = var_118_1
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_4 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_4

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play410152028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410152028
		arg_119_1.duration_ = 6.67

		local var_119_0 = {
			ja = 6.666,
			CriLanguages = 2.133,
			zh = 2.133
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
				arg_119_0:Play410152029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.25

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
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

				local var_122_1 = arg_119_1:GetWordFromCfg(410152028)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 10 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 10)

				if (10 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 10)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152028", "story_v_out_410152.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_410152", "410152028", "story_v_out_410152.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_410152", "410152028", "story_v_out_410152.awb")

						arg_119_1:RecordAudio("410152028", var_122_6)
						arg_119_1:RecordAudio("410152028", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_410152", "410152028", "story_v_out_410152.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_410152", "410152028", "story_v_out_410152.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play410152029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410152029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play410152030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 1.475

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(410152029).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 59 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 59)

				if (59 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 59)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play410152030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410152030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play410152031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 1.8

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(410152030).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 72 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 72)

				if (72 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 72)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play410152031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410152031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play410152032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 1.25

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(410152031).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 50 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 50)

				if (50 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 50)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play410152032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410152032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play410152033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:AudioAction("stop", "effect", "se_story_129", "se_story_129_information_loop", "")
			end

			local var_138_1 = 0
			local var_138_2 = 0.55

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(410152032).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 22 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 22)

				if (22 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 22)) > 0 and var_138_2 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_6 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_6 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_6

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_6 and arg_135_1.time_ < var_138_1 + var_138_6 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play410152033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410152033
		arg_139_1.duration_ = 12.03

		local var_139_0 = {
			ja = 12.033,
			CriLanguages = 8.5,
			zh = 8.5
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
				arg_139_0:Play410152034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 2 < arg_139_1.time_ and arg_139_1.time_ <= 2 + arg_142_0 then
				local var_142_0 = arg_139_1.bgs_.L02f

				arg_139_1.bgs_.L02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_142_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_142_1 = var_142_0:GetComponent("SpriteRenderer")

				if var_142_1 and var_142_1.sprite then
					local var_142_2 = 2 * (var_142_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_142_0.transform.localScale = Vector3.New(var_142_2 / var_142_1.sprite.bounds.size.y < var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x and var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x or var_142_2 / var_142_1.sprite.bounds.size.y, var_142_2 / var_142_1.sprite.bounds.size.y < var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x and var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x or var_142_2 / var_142_1.sprite.bounds.size.y, 0)
				end

				for iter_142_0, iter_142_1 in pairs(arg_139_1.bgs_) do
					if iter_142_0 ~= "L02f" then
						iter_142_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_142_3 = 0

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_3 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_4 = 2

			if var_142_3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_3 + var_142_4 then
				local var_142_5 = Color.New(0, 0, 0)

				var_142_5.a = Mathf.Lerp(0, 1, (arg_139_1.time_ - var_142_3) / var_142_4)
				arg_139_1.mask_.color = var_142_5
			end

			if arg_139_1.time_ >= var_142_3 + var_142_4 and arg_139_1.time_ < var_142_3 + var_142_4 + arg_142_0 then
				local var_142_6 = Color.New(0, 0, 0)

				var_142_6.a = 1
				arg_139_1.mask_.color = var_142_6
			end

			local var_142_7 = 2

			if 2 < arg_139_1.time_ and arg_139_1.time_ <= var_142_7 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_8 = 2

			if var_142_7 <= arg_139_1.time_ and arg_139_1.time_ < var_142_7 + var_142_8 then
				local var_142_9 = Color.New(0, 0, 0)

				var_142_9.a = Mathf.Lerp(1, 0, (arg_139_1.time_ - var_142_7) / var_142_8)
				arg_139_1.mask_.color = var_142_9
			end

			if arg_139_1.time_ >= var_142_7 + var_142_8 and arg_139_1.time_ < var_142_7 + var_142_8 + arg_142_0 then
				local var_142_10 = Color.New(0, 0, 0)

				arg_139_1.mask_.enabled = false
				var_142_10.a = 0
				arg_139_1.mask_.color = var_142_10
			end

			local var_142_11 = arg_139_1.actors_["1061"].transform

			if 4 < arg_139_1.time_ and arg_139_1.time_ <= 4 + arg_142_0 then
				arg_139_1.var_.moveOldPos1061 = var_142_11.localPosition
				var_142_11.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1061", 3)

				for iter_142_2 = 0, var_142_11.childCount - 1 do
					local var_142_12 = var_142_11:GetChild(iter_142_2)

					if var_142_12.name == "split_5" or not string.find(var_142_12.name, "split") then
						var_142_12.gameObject:SetActive(true)
					else
						var_142_12.gameObject:SetActive(false)
					end
				end
			end

			local var_142_13 = 0.001

			if 4 <= arg_139_1.time_ and arg_139_1.time_ < 4 + var_142_13 then
				var_142_11.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_139_1.time_ - 4) / var_142_13)
			end

			if arg_139_1.time_ >= 4 + var_142_13 and arg_139_1.time_ < 4 + var_142_13 + arg_142_0 then
				var_142_11.localPosition = Vector3.New(0, -490, 18)
			end

			local var_142_14 = arg_139_1.actors_["1061"]

			if 4 < arg_139_1.time_ and arg_139_1.time_ <= 4 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.actorSpriteComps1061 == nil then
				arg_139_1.var_.actorSpriteComps1061 = var_142_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_15 = 0.0339999999999998

			if 4 <= arg_139_1.time_ and arg_139_1.time_ < 4 + var_142_15 and not isNil(var_142_14) then
				if arg_139_1.var_.actorSpriteComps1061 then
					for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_142_4 then
							if arg_139_1.isInRecall_ then
								iter_142_4.color = Color.New(Mathf.Lerp(iter_142_4.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 4) / var_142_15), Mathf.Lerp(iter_142_4.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 4) / var_142_15), (Mathf.Lerp(iter_142_4.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 4) / var_142_15)))
							else
								local var_142_16 = Mathf.Lerp(iter_142_4.color.r, 1, (arg_139_1.time_ - 4) / var_142_15)

								iter_142_4.color = Color.New(var_142_16, var_142_16, var_142_16)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 4 + var_142_15 and arg_139_1.time_ < 4 + var_142_15 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.actorSpriteComps1061 then
				for iter_142_5, iter_142_6 in pairs(arg_139_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_142_6 then
						iter_142_6.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps1061 = nil
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_17 = 4
			local var_142_18 = 0.575

			if 4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_17 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_19 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_19:setOnUpdate(LuaHelper.FloatAction(function(arg_143_0)
					arg_139_1.dialogCg_.alpha = arg_143_0
				end))
				var_142_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_20 = arg_139_1:GetWordFromCfg(410152033)
				local var_142_21 = arg_139_1:FormatText(var_142_20.content)

				arg_139_1.text_.text = var_142_21

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_23 = 23 <= 0 and var_142_18 or var_142_18 * (utf8.len(var_142_21) / 23)

				if (23 <= 0 and var_142_18 or var_142_18 * (utf8.len(var_142_21) / 23)) > 0 and var_142_18 < var_142_23 then
					arg_139_1.talkMaxDuration = var_142_23
					var_142_17 = var_142_17 + 0.3

					if var_142_23 + var_142_17 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_17
					end
				end

				arg_139_1.text_.text = var_142_21
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152033", "story_v_out_410152.awb") ~= 0 then
					local var_142_24 = manager.audio:GetVoiceLength("story_v_out_410152", "410152033", "story_v_out_410152.awb") / 1000

					if var_142_24 + var_142_17 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_24 + var_142_17
					end

					if var_142_20.prefab_name ~= "" and arg_139_1.actors_[var_142_20.prefab_name] ~= nil then
						local var_142_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_20.prefab_name].transform, "story_v_out_410152", "410152033", "story_v_out_410152.awb")

						arg_139_1:RecordAudio("410152033", var_142_25)
						arg_139_1:RecordAudio("410152033", var_142_25)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_410152", "410152033", "story_v_out_410152.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_410152", "410152033", "story_v_out_410152.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_26 = var_142_17 + 0.3
			local var_142_27 = math.max(var_142_18, arg_139_1.talkMaxDuration)

			if var_142_17 + 0.3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_26 + var_142_27 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_26) / var_142_27

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_26 + var_142_27 and arg_139_1.time_ < var_142_26 + var_142_27 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play410152034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410152034
		arg_145_1.duration_ = 2.2

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play410152035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1061"]) and arg_145_1.var_.actorSpriteComps1061 == nil then
				arg_145_1.var_.actorSpriteComps1061 = arg_145_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_0 = 0.034

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1061"]) then
				if arg_145_1.var_.actorSpriteComps1061 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								iter_148_1.color = Color.New(Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor2.r, (arg_145_1.time_ - 0) / var_148_0), Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor2.g, (arg_145_1.time_ - 0) / var_148_0), (Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor2.b, (arg_145_1.time_ - 0) / var_148_0)))
							else
								local var_148_1 = Mathf.Lerp(iter_148_1.color.r, 0.5, (arg_145_1.time_ - 0) / var_148_0)

								iter_148_1.color = Color.New(var_148_1, var_148_1, var_148_1)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1061"]) and arg_145_1.var_.actorSpriteComps1061 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_148_3 then
						iter_148_3.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_145_1.var_.actorSpriteComps1061 = nil
			end

			local var_148_2 = 0
			local var_148_3 = 0.15

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2038")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_4 = arg_145_1:GetWordFromCfg(410152034)
				local var_148_5 = arg_145_1:FormatText(var_148_4.content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 6 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 6)

				if (6 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 6)) > 0 and var_148_3 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152034", "story_v_out_410152.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_410152", "410152034", "story_v_out_410152.awb") / 1000

					if var_148_8 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_2
					end

					if var_148_4.prefab_name ~= "" and arg_145_1.actors_[var_148_4.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_4.prefab_name].transform, "story_v_out_410152", "410152034", "story_v_out_410152.awb")

						arg_145_1:RecordAudio("410152034", var_148_9)
						arg_145_1:RecordAudio("410152034", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_410152", "410152034", "story_v_out_410152.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_410152", "410152034", "story_v_out_410152.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_3, arg_145_1.talkMaxDuration)

			if var_148_2 <= arg_145_1.time_ and arg_145_1.time_ < var_148_2 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_2) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_2 + var_148_10 and arg_145_1.time_ < var_148_2 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play410152035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410152035
		arg_149_1.duration_ = 3.87

		local var_149_0 = {
			ja = 3.033,
			CriLanguages = 3.866,
			zh = 3.866
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
				arg_149_0:Play410152036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1061 = arg_149_1.actors_["1061"].transform.localPosition
				arg_149_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("1061", 3)

				for iter_152_0 = 0, arg_149_1.actors_["1061"].transform.childCount - 1 do
					local var_152_0 = arg_149_1.actors_["1061"].transform:GetChild(iter_152_0)

					if var_152_0.name == "split_5" or not string.find(var_152_0.name, "split") then
						var_152_0.gameObject:SetActive(true)
					else
						var_152_0.gameObject:SetActive(false)
					end
				end
			end

			local var_152_1 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 then
				arg_149_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_149_1.time_ - 0) / var_152_1)
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 then
				arg_149_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_152_2 = arg_149_1.actors_["1061"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps1061 == nil then
				arg_149_1.var_.actorSpriteComps1061 = var_152_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_3 = 0.034

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.actorSpriteComps1061 then
					for iter_152_1, iter_152_2 in pairs(arg_149_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps1061 then
				for iter_152_3, iter_152_4 in pairs(arg_149_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_152_4 then
						iter_152_4.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps1061 = nil
			end

			local var_152_5 = 0
			local var_152_6 = 0.15

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_7 = arg_149_1:GetWordFromCfg(410152035)
				local var_152_8 = arg_149_1:FormatText(var_152_7.content)

				arg_149_1.text_.text = var_152_8

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_10 = 6 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 6)

				if (6 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 6)) > 0 and var_152_6 < var_152_10 then
					arg_149_1.talkMaxDuration = var_152_10

					if var_152_10 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_5
					end
				end

				arg_149_1.text_.text = var_152_8
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152035", "story_v_out_410152.awb") ~= 0 then
					local var_152_11 = manager.audio:GetVoiceLength("story_v_out_410152", "410152035", "story_v_out_410152.awb") / 1000

					if var_152_11 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_5
					end

					if var_152_7.prefab_name ~= "" and arg_149_1.actors_[var_152_7.prefab_name] ~= nil then
						local var_152_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_7.prefab_name].transform, "story_v_out_410152", "410152035", "story_v_out_410152.awb")

						arg_149_1:RecordAudio("410152035", var_152_12)
						arg_149_1:RecordAudio("410152035", var_152_12)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_410152", "410152035", "story_v_out_410152.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_410152", "410152035", "story_v_out_410152.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_13 = math.max(var_152_6, arg_149_1.talkMaxDuration)

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_13 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_5) / var_152_13

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_5 + var_152_13 and arg_149_1.time_ < var_152_5 + var_152_13 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
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

		arg_149_1:InitPlayNodeList()
	end,
	Play410152036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410152036
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play410152037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1061 = arg_153_1.actors_["1061"].transform.localPosition
				arg_153_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1061", 7)

				for iter_156_0 = 0, arg_153_1.actors_["1061"].transform.childCount - 1 do
					local var_156_0 = arg_153_1.actors_["1061"].transform:GetChild(iter_156_0)

					if var_156_0.name == "split_5" or not string.find(var_156_0.name, "split") then
						var_156_0.gameObject:SetActive(true)
					else
						var_156_0.gameObject:SetActive(false)
					end
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_153_1.time_ - 0) / var_156_1)
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_156_2 = arg_153_1.actors_["1061"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1061 == nil then
				arg_153_1.var_.actorSpriteComps1061 = var_156_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_3 = 0.034

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.actorSpriteComps1061 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								iter_156_2.color = Color.New(Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor2.r, (arg_153_1.time_ - 0) / var_156_3), Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor2.g, (arg_153_1.time_ - 0) / var_156_3), (Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor2.b, (arg_153_1.time_ - 0) / var_156_3)))
							else
								local var_156_4 = Mathf.Lerp(iter_156_2.color.r, 0.5, (arg_153_1.time_ - 0) / var_156_3)

								iter_156_2.color = Color.New(var_156_4, var_156_4, var_156_4)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1061 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_156_4 then
						iter_156_4.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_153_1.var_.actorSpriteComps1061 = nil
			end

			local var_156_5 = 0
			local var_156_6 = 1.575

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_7 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(410152036).content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 63 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_7) / 63)

				if (63 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_7) / 63)) > 0 and var_156_6 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_6, arg_153_1.talkMaxDuration)

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_5) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_5 + var_156_10 and arg_153_1.time_ < var_156_5 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play410152037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410152037
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play410152038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 1.1

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(410152037).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 44 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 44)

				if (44 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 44)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play410152038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410152038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play410152039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.1

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(410152038).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 44 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 44)

				if (44 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 44)) > 0 and var_164_0 < var_164_3 then
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
	Play410152039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410152039
		arg_165_1.duration_ = 3.8

		local var_165_0 = {
			ja = 3.8,
			CriLanguages = 1.666,
			zh = 1.666
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
				arg_165_0:Play410152040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1061 = arg_165_1.actors_["1061"].transform.localPosition
				arg_165_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1061", 3)

				for iter_168_0 = 0, arg_165_1.actors_["1061"].transform.childCount - 1 do
					local var_168_0 = arg_165_1.actors_["1061"].transform:GetChild(iter_168_0)

					if var_168_0.name == "split_5" or not string.find(var_168_0.name, "split") then
						var_168_0.gameObject:SetActive(true)
					else
						var_168_0.gameObject:SetActive(false)
					end
				end
			end

			local var_168_1 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_1 then
				arg_165_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_165_1.time_ - 0) / var_168_1)
			end

			if arg_165_1.time_ >= 0 + var_168_1 and arg_165_1.time_ < 0 + var_168_1 + arg_168_0 then
				arg_165_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_168_2 = arg_165_1.actors_["1061"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1061 == nil then
				arg_165_1.var_.actorSpriteComps1061 = var_168_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_3 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.actorSpriteComps1061 then
					for iter_168_1, iter_168_2 in pairs(arg_165_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_168_2 then
							if arg_165_1.isInRecall_ then
								iter_168_2.color = Color.New(Mathf.Lerp(iter_168_2.color.r, arg_165_1.hightColor1.r, (arg_165_1.time_ - 0) / var_168_3), Mathf.Lerp(iter_168_2.color.g, arg_165_1.hightColor1.g, (arg_165_1.time_ - 0) / var_168_3), (Mathf.Lerp(iter_168_2.color.b, arg_165_1.hightColor1.b, (arg_165_1.time_ - 0) / var_168_3)))
							else
								local var_168_4 = Mathf.Lerp(iter_168_2.color.r, 1, (arg_165_1.time_ - 0) / var_168_3)

								iter_168_2.color = Color.New(var_168_4, var_168_4, var_168_4)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1061 then
				for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_168_4 then
						iter_168_4.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps1061 = nil
			end

			local var_168_5 = 0
			local var_168_6 = 0.25

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_7 = arg_165_1:GetWordFromCfg(410152039)
				local var_168_8 = arg_165_1:FormatText(var_168_7.content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 10 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 10)

				if (10 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 10)) > 0 and var_168_6 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152039", "story_v_out_410152.awb") ~= 0 then
					local var_168_11 = manager.audio:GetVoiceLength("story_v_out_410152", "410152039", "story_v_out_410152.awb") / 1000

					if var_168_11 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_5
					end

					if var_168_7.prefab_name ~= "" and arg_165_1.actors_[var_168_7.prefab_name] ~= nil then
						local var_168_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_7.prefab_name].transform, "story_v_out_410152", "410152039", "story_v_out_410152.awb")

						arg_165_1:RecordAudio("410152039", var_168_12)
						arg_165_1:RecordAudio("410152039", var_168_12)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_410152", "410152039", "story_v_out_410152.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_410152", "410152039", "story_v_out_410152.awb")
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
				actorName = "1061",
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
	Play410152040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410152040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play410152041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1061"]) and arg_169_1.var_.actorSpriteComps1061 == nil then
				arg_169_1.var_.actorSpriteComps1061 = arg_169_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_0 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1061"]) then
				if arg_169_1.var_.actorSpriteComps1061 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1061"]) and arg_169_1.var_.actorSpriteComps1061 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_172_3 then
						iter_172_3.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps1061 = nil
			end

			local var_172_2 = 0
			local var_172_3 = 0.975

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_4 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(410152040).content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_6 = 39 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_4) / 39)

				if (39 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_4) / 39)) > 0 and var_172_3 < var_172_6 then
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
	Play410152041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410152041
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play410152042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 1.35

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(410152041).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 54 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 54)

				if (54 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 54)) > 0 and var_176_0 < var_176_3 then
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
	Play410152042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410152042
		arg_177_1.duration_ = 3.03

		local var_177_0 = {
			ja = 3.033,
			CriLanguages = 1.8,
			zh = 1.8
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
				arg_177_0:Play410152043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1061 = arg_177_1.actors_["1061"].transform.localPosition
				arg_177_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1061", 3)

				for iter_180_0 = 0, arg_177_1.actors_["1061"].transform.childCount - 1 do
					local var_180_0 = arg_177_1.actors_["1061"].transform:GetChild(iter_180_0)

					if var_180_0.name == "" or not string.find(var_180_0.name, "split") then
						var_180_0.gameObject:SetActive(true)
					else
						var_180_0.gameObject:SetActive(false)
					end
				end
			end

			local var_180_1 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 then
				arg_177_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_177_1.time_ - 0) / var_180_1)
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 then
				arg_177_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_180_2 = arg_177_1.actors_["1061"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps1061 == nil then
				arg_177_1.var_.actorSpriteComps1061 = var_180_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_3 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.actorSpriteComps1061 then
					for iter_180_1, iter_180_2 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_180_2 then
							if arg_177_1.isInRecall_ then
								iter_180_2.color = Color.New(Mathf.Lerp(iter_180_2.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_3), Mathf.Lerp(iter_180_2.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_3), (Mathf.Lerp(iter_180_2.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_3)))
							else
								local var_180_4 = Mathf.Lerp(iter_180_2.color.r, 1, (arg_177_1.time_ - 0) / var_180_3)

								iter_180_2.color = Color.New(var_180_4, var_180_4, var_180_4)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps1061 then
				for iter_180_3, iter_180_4 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_180_4 then
						iter_180_4.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps1061 = nil
			end

			local var_180_5 = 0
			local var_180_6 = 0.125

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_7 = arg_177_1:GetWordFromCfg(410152042)
				local var_180_8 = arg_177_1:FormatText(var_180_7.content)

				arg_177_1.text_.text = var_180_8

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 5 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 5)

				if (5 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 5)) > 0 and var_180_6 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_8
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152042", "story_v_out_410152.awb") ~= 0 then
					local var_180_11 = manager.audio:GetVoiceLength("story_v_out_410152", "410152042", "story_v_out_410152.awb") / 1000

					if var_180_11 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_5
					end

					if var_180_7.prefab_name ~= "" and arg_177_1.actors_[var_180_7.prefab_name] ~= nil then
						local var_180_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_7.prefab_name].transform, "story_v_out_410152", "410152042", "story_v_out_410152.awb")

						arg_177_1:RecordAudio("410152042", var_180_12)
						arg_177_1:RecordAudio("410152042", var_180_12)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_410152", "410152042", "story_v_out_410152.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_410152", "410152042", "story_v_out_410152.awb")
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
				actorName = "1061",
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
	Play410152043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410152043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play410152044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1061"]) and arg_181_1.var_.actorSpriteComps1061 == nil then
				arg_181_1.var_.actorSpriteComps1061 = arg_181_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_0 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1061"]) then
				if arg_181_1.var_.actorSpriteComps1061 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								iter_184_1.color = Color.New(Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_0), Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_0), (Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_0)))
							else
								local var_184_1 = Mathf.Lerp(iter_184_1.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_0)

								iter_184_1.color = Color.New(var_184_1, var_184_1, var_184_1)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1061"]) and arg_181_1.var_.actorSpriteComps1061 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_184_3 then
						iter_184_3.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps1061 = nil
			end

			local var_184_2 = 0
			local var_184_3 = 1.175

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_4 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(410152043).content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_6 = 47 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_4) / 47)

				if (47 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_4) / 47)) > 0 and var_184_3 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_7 and arg_181_1.time_ < var_184_2 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play410152044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410152044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play410152045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.3

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(410152044).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 52 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 52)

				if (52 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 52)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play410152045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410152045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play410152046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 1.55

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(410152045).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 62 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 62)

				if (62 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 62)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play410152046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410152046
		arg_193_1.duration_ = 5.9

		local var_193_0 = {
			ja = 5.9,
			CriLanguages = 5.833,
			zh = 5.833
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
				arg_193_0:Play410152047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if arg_193_1.actors_["10062"] == nil then
				local var_196_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10062")

				if not isNil(var_196_0) then
					local var_196_1 = Object.Instantiate(var_196_0, arg_193_1.canvasGo_.transform)

					var_196_1.transform:SetSiblingIndex(1)

					var_196_1.name = "10062"
					var_196_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_193_1.actors_["10062"] = var_196_1

					if arg_193_1.isInRecall_ then
						for iter_196_0, iter_196_1 in ipairs((var_196_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_196_1.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_196_2 = arg_193_1.actors_["10062"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10062 = var_196_2.localPosition
				var_196_2.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10062", 3)

				for iter_196_2 = 0, var_196_2.childCount - 1 do
					local var_196_3 = var_196_2:GetChild(iter_196_2)

					if var_196_3.name == "" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				var_196_2.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_193_1.time_ - 0) / var_196_4)
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				var_196_2.localPosition = Vector3.New(0, -390, -290)
			end

			local var_196_5 = arg_193_1.actors_["1061"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1061 = var_196_5.localPosition
				var_196_5.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1061", 7)

				for iter_196_3 = 0, var_196_5.childCount - 1 do
					local var_196_6 = var_196_5:GetChild(iter_196_3)

					if var_196_6.name == "" or not string.find(var_196_6.name, "split") then
						var_196_6.gameObject:SetActive(true)
					else
						var_196_6.gameObject:SetActive(false)
					end
				end
			end

			local var_196_7 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				var_196_5.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_193_1.time_ - 0) / var_196_7)
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				var_196_5.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_196_8 = arg_193_1.actors_["10062"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10062 == nil then
				arg_193_1.var_.actorSpriteComps10062 = var_196_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_9 and not isNil(var_196_8) then
				if arg_193_1.var_.actorSpriteComps10062 then
					for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_196_5 then
							if arg_193_1.isInRecall_ then
								iter_196_5.color = Color.New(Mathf.Lerp(iter_196_5.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_9), Mathf.Lerp(iter_196_5.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_9), (Mathf.Lerp(iter_196_5.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_9)))
							else
								local var_196_10 = Mathf.Lerp(iter_196_5.color.r, 1, (arg_193_1.time_ - 0) / var_196_9)

								iter_196_5.color = Color.New(var_196_10, var_196_10, var_196_10)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_9 and arg_193_1.time_ < 0 + var_196_9 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10062 then
				for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_196_7 then
						iter_196_7.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps10062 = nil
			end

			local var_196_11 = arg_193_1.actors_["1061"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_11) and arg_193_1.var_.actorSpriteComps1061 == nil then
				arg_193_1.var_.actorSpriteComps1061 = var_196_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_12 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_12 and not isNil(var_196_11) then
				if arg_193_1.var_.actorSpriteComps1061 then
					for iter_196_8, iter_196_9 in pairs(arg_193_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_196_9 then
							if arg_193_1.isInRecall_ then
								iter_196_9.color = Color.New(Mathf.Lerp(iter_196_9.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_12), Mathf.Lerp(iter_196_9.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_12), (Mathf.Lerp(iter_196_9.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_12)))
							else
								local var_196_13 = Mathf.Lerp(iter_196_9.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_12)

								iter_196_9.color = Color.New(var_196_13, var_196_13, var_196_13)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_12 and arg_193_1.time_ < 0 + var_196_12 + arg_196_0 and not isNil(var_196_11) and arg_193_1.var_.actorSpriteComps1061 then
				for iter_196_10, iter_196_11 in pairs(arg_193_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_196_11 then
						iter_196_11.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps1061 = nil
			end

			local var_196_14 = 0
			local var_196_15 = 0.425

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_16 = arg_193_1:GetWordFromCfg(410152046)
				local var_196_17 = arg_193_1:FormatText(var_196_16.content)

				arg_193_1.text_.text = var_196_17

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_19 = 17 <= 0 and var_196_15 or var_196_15 * (utf8.len(var_196_17) / 17)

				if (17 <= 0 and var_196_15 or var_196_15 * (utf8.len(var_196_17) / 17)) > 0 and var_196_15 < var_196_19 then
					arg_193_1.talkMaxDuration = var_196_19

					if var_196_19 + var_196_14 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_19 + var_196_14
					end
				end

				arg_193_1.text_.text = var_196_17
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410152", "410152046", "story_v_out_410152.awb") ~= 0 then
					local var_196_20 = manager.audio:GetVoiceLength("story_v_out_410152", "410152046", "story_v_out_410152.awb") / 1000

					if var_196_20 + var_196_14 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_20 + var_196_14
					end

					if var_196_16.prefab_name ~= "" and arg_193_1.actors_[var_196_16.prefab_name] ~= nil then
						local var_196_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_16.prefab_name].transform, "story_v_out_410152", "410152046", "story_v_out_410152.awb")

						arg_193_1:RecordAudio("410152046", var_196_21)
						arg_193_1:RecordAudio("410152046", var_196_21)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410152", "410152046", "story_v_out_410152.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410152", "410152046", "story_v_out_410152.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_22 = math.max(var_196_15, arg_193_1.talkMaxDuration)

			if var_196_14 <= arg_193_1.time_ and arg_193_1.time_ < var_196_14 + var_196_22 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_14) / var_196_22

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_14 + var_196_22 and arg_193_1.time_ < var_196_14 + var_196_22 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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

		arg_193_1:InitPlayNodeList()
	end,
	Play410152047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410152047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play410152048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1061 = arg_197_1.actors_["1061"].transform.localPosition
				arg_197_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1061", 7)

				for iter_200_0 = 0, arg_197_1.actors_["1061"].transform.childCount - 1 do
					local var_200_0 = arg_197_1.actors_["1061"].transform:GetChild(iter_200_0)

					if var_200_0.name == "" or not string.find(var_200_0.name, "split") then
						var_200_0.gameObject:SetActive(true)
					else
						var_200_0.gameObject:SetActive(false)
					end
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_197_1.time_ - 0) / var_200_1)
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_200_2 = arg_197_1.actors_["1061"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps1061 == nil then
				arg_197_1.var_.actorSpriteComps1061 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps1061 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								iter_200_2.color = Color.New(Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_3), Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_3), (Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_3)))
							else
								local var_200_4 = Mathf.Lerp(iter_200_2.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_3)

								iter_200_2.color = Color.New(var_200_4, var_200_4, var_200_4)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps1061 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_200_4 then
						iter_200_4.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps1061 = nil
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_hit", "")
			end

			local var_200_6 = arg_197_1.actors_["10062"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10062 = var_200_6.localPosition
				var_200_6.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10062", 7)

				for iter_200_5 = 0, var_200_6.childCount - 1 do
					local var_200_7 = var_200_6:GetChild(iter_200_5)

					if var_200_7.name == "" or not string.find(var_200_7.name, "split") then
						var_200_7.gameObject:SetActive(true)
					else
						var_200_7.gameObject:SetActive(false)
					end
				end
			end

			local var_200_8 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_8 then
				var_200_6.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_197_1.time_ - 0) / var_200_8)
			end

			if arg_197_1.time_ >= 0 + var_200_8 and arg_197_1.time_ < 0 + var_200_8 + arg_200_0 then
				var_200_6.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_200_9 = arg_197_1.actors_["10062"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.actorSpriteComps10062 == nil then
				arg_197_1.var_.actorSpriteComps10062 = var_200_9:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_10 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_10 and not isNil(var_200_9) then
				if arg_197_1.var_.actorSpriteComps10062 then
					for iter_200_6, iter_200_7 in pairs(arg_197_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_200_7 then
							if arg_197_1.isInRecall_ then
								iter_200_7.color = Color.New(Mathf.Lerp(iter_200_7.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_10), Mathf.Lerp(iter_200_7.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_10), (Mathf.Lerp(iter_200_7.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_10)))
							else
								local var_200_11 = Mathf.Lerp(iter_200_7.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_10)

								iter_200_7.color = Color.New(var_200_11, var_200_11, var_200_11)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_10 and arg_197_1.time_ < 0 + var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.actorSpriteComps10062 then
				for iter_200_8, iter_200_9 in pairs(arg_197_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_200_9 then
						iter_200_9.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps10062 = nil
			end

			local var_200_12 = manager.ui.mainCamera.transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.shakeOldPos = var_200_12.localPosition
			end

			local var_200_13 = 1

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_13 then
				local var_200_14, var_200_15 = math.modf((arg_197_1.time_ - 0) / 0.066)

				var_200_12.localPosition = Vector3.New(var_200_15 * 0.13, var_200_15 * 0.13, var_200_15 * 0.13) + arg_197_1.var_.shakeOldPos
			end

			if arg_197_1.time_ >= 0 + var_200_13 and arg_197_1.time_ < 0 + var_200_13 + arg_200_0 then
				var_200_12.localPosition = arg_197_1.var_.shakeOldPos
			end

			local var_200_16 = 0
			local var_200_17 = 1.2

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_18 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(410152047).content)

				arg_197_1.text_.text = var_200_18

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_20 = 48 <= 0 and var_200_17 or var_200_17 * (utf8.len(var_200_18) / 48)

				if (48 <= 0 and var_200_17 or var_200_17 * (utf8.len(var_200_18) / 48)) > 0 and var_200_17 < var_200_20 then
					arg_197_1.talkMaxDuration = var_200_20

					if var_200_20 + var_200_16 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_20 + var_200_16
					end
				end

				arg_197_1.text_.text = var_200_18
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_21 = math.max(var_200_17, arg_197_1.talkMaxDuration)

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_21 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_16) / var_200_21

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_16 + var_200_21 and arg_197_1.time_ < var_200_16 + var_200_21 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play410152048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410152048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play410152049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.4

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

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(410152048).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 56 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 56)

				if (56 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 56)) > 0 and var_204_0 < var_204_3 then
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
	Play410152049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410152049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play410152050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1061 = arg_205_1.actors_["1061"].transform.localPosition
				arg_205_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1061", 7)

				for iter_208_0 = 0, arg_205_1.actors_["1061"].transform.childCount - 1 do
					local var_208_0 = arg_205_1.actors_["1061"].transform:GetChild(iter_208_0)

					if var_208_0.name == "" or not string.find(var_208_0.name, "split") then
						var_208_0.gameObject:SetActive(true)
					else
						var_208_0.gameObject:SetActive(false)
					end
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_205_1.time_ - 0) / var_208_1)
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
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
								iter_208_2.color = Color.New(Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 0) / var_208_3), Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 0) / var_208_3), (Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 0) / var_208_3)))
							else
								local var_208_4 = Mathf.Lerp(iter_208_2.color.r, 0.5, (arg_205_1.time_ - 0) / var_208_3)

								iter_208_2.color = Color.New(var_208_4, var_208_4, var_208_4)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps1061 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_208_4 then
						iter_208_4.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps1061 = nil
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:AudioAction("play", "effect", "se_story_129", "se_story_129_break", "")
			end

			local var_208_6 = 0

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_7 = 1

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_7 then
				local var_208_8 = Color.New(1, 1, 1)

				var_208_8.a = Mathf.Lerp(1, 0, (arg_205_1.time_ - var_208_6) / var_208_7)
				arg_205_1.mask_.color = var_208_8
			end

			if arg_205_1.time_ >= var_208_6 + var_208_7 and arg_205_1.time_ < var_208_6 + var_208_7 + arg_208_0 then
				local var_208_9 = Color.New(1, 1, 1)

				arg_205_1.mask_.enabled = false
				var_208_9.a = 0
				arg_205_1.mask_.color = var_208_9
			end

			local var_208_10 = manager.ui.mainCamera.transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.shakeOldPos = var_208_10.localPosition
			end

			local var_208_11 = 1.5

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_11 then
				local var_208_12, var_208_13 = math.modf((arg_205_1.time_ - 0) / 0.066)

				var_208_10.localPosition = Vector3.New(var_208_13 * 0.13, var_208_13 * 0.13, var_208_13 * 0.13) + arg_205_1.var_.shakeOldPos
			end

			if arg_205_1.time_ >= 0 + var_208_11 and arg_205_1.time_ < 0 + var_208_11 + arg_208_0 then
				var_208_10.localPosition = arg_205_1.var_.shakeOldPos
			end

			local var_208_14 = 0
			local var_208_15 = 1.075

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_14 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_16 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(410152049).content)

				arg_205_1.text_.text = var_208_16

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_18 = 43 <= 0 and var_208_15 or var_208_15 * (utf8.len(var_208_16) / 43)

				if (43 <= 0 and var_208_15 or var_208_15 * (utf8.len(var_208_16) / 43)) > 0 and var_208_15 < var_208_18 then
					arg_205_1.talkMaxDuration = var_208_18

					if var_208_18 + var_208_14 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_18 + var_208_14
					end
				end

				arg_205_1.text_.text = var_208_16
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_19 = math.max(var_208_15, arg_205_1.talkMaxDuration)

			if var_208_14 <= arg_205_1.time_ and arg_205_1.time_ < var_208_14 + var_208_19 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_14) / var_208_19

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_14 + var_208_19 and arg_205_1.time_ < var_208_14 + var_208_19 + arg_208_0 then
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
	Play410152050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410152050
		arg_209_1.duration_ = 6

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
			arg_209_1.auto_ = false
		end

		function arg_209_1.playNext_(arg_211_0)
			arg_209_1.onStoryFinished_()
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_0 = 1

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				local var_212_1 = Color.New(0, 0, 0)

				var_212_1.a = Mathf.Lerp(0, 1, (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.mask_.color = var_212_1
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				local var_212_2 = Color.New(0, 0, 0)

				var_212_2.a = 1
				arg_209_1.mask_.color = var_212_2
			end

			local var_212_3 = 1

			if 1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_3 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_4 = 0.2

			if var_212_3 <= arg_209_1.time_ and arg_209_1.time_ < var_212_3 + var_212_4 then
				local var_212_5 = Color.New(0, 0, 0)

				var_212_5.a = Mathf.Lerp(1, 0, (arg_209_1.time_ - var_212_3) / var_212_4)
				arg_209_1.mask_.color = var_212_5
			end

			if arg_209_1.time_ >= var_212_3 + var_212_4 and arg_209_1.time_ < var_212_3 + var_212_4 + arg_212_0 then
				local var_212_6 = Color.New(0, 0, 0)

				arg_209_1.mask_.enabled = false
				var_212_6.a = 0
				arg_209_1.mask_.color = var_212_6
			end

			if 1 < arg_209_1.time_ and arg_209_1.time_ <= 1 + arg_212_0 then
				local var_212_7 = arg_209_1.bgs_.STblack

				arg_209_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_212_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_8 = var_212_7:GetComponent("SpriteRenderer")

				if var_212_8 and var_212_8.sprite then
					local var_212_9 = 2 * (var_212_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_212_7.transform.localScale = Vector3.New(var_212_9 / var_212_8.sprite.bounds.size.y < var_212_9 * manager.ui.mainCameraCom_.aspect / var_212_8.sprite.bounds.size.x and var_212_9 * manager.ui.mainCameraCom_.aspect / var_212_8.sprite.bounds.size.x or var_212_9 / var_212_8.sprite.bounds.size.y, var_212_9 / var_212_8.sprite.bounds.size.y < var_212_9 * manager.ui.mainCameraCom_.aspect / var_212_8.sprite.bounds.size.x and var_212_9 * manager.ui.mainCameraCom_.aspect / var_212_8.sprite.bounds.size.x or var_212_9 / var_212_8.sprite.bounds.size.y, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "STblack" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_10 = 1
			local var_212_11 = 0.975

			if 1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_12 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_12:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_13 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(410152050).content)

				arg_209_1.text_.text = var_212_13

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_15 = 39 <= 0 and var_212_11 or var_212_11 * (utf8.len(var_212_13) / 39)

				if (39 <= 0 and var_212_11 or var_212_11 * (utf8.len(var_212_13) / 39)) > 0 and var_212_11 < var_212_15 then
					arg_209_1.talkMaxDuration = var_212_15
					var_212_10 = var_212_10 + 0.3

					if var_212_15 + var_212_10 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_15 + var_212_10
					end
				end

				arg_209_1.text_.text = var_212_13
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = var_212_10 + 0.3
			local var_212_17 = math.max(var_212_11, arg_209_1.talkMaxDuration)

			if var_212_10 + 0.3 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_16) / var_212_17

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/L02f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/LZ0202"
	},
	voices = {
		"story_v_out_410152.awb"
	}
}
